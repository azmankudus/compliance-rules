#!/bin/bash
# scripts/compliance_runner.sh
# Universal Pure Bash compliance runner based on YAML ruleset
# Handles execution, API lifecycle hooks, formatted logging, and remediation.

set -euo pipefail

# -----------------------------------------------------------------------------
# Default Variables & Initialization
# -----------------------------------------------------------------------------
SCRIPT_NAME=$(basename "$0" .sh)
START_TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
DEFAULT_LOG_FILE="${SCRIPT_NAME}_${START_TIMESTAMP}.log"

# Global Config
LOG_FILE="$DEFAULT_LOG_FILE"
API_URL=""
API_TOKEN=""
YAML_FILE=""
TARGET_RULE=""
REMEDIATE_MODE="none" # none, prompt, auto
DRY_RUN="false"
SCAN_ID=$(uuidgen 2>/dev/null || date +%s)
HOSTNAME=$(hostname 2>/dev/null || echo "unknown")

# Counters
TOTAL_RULES=0
PASS_COUNT=0
FAIL_COUNT=0

# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------

print_usage() {
    echo "Usage: $0 <path_to_rules.yaml> [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --rule <id>          Run only a specific rule ID"
    echo "  --log-file <path>    Override default log file (${DEFAULT_LOG_FILE})"
    echo "  --api-url <url>      Webhook URL for sending JSON telemetry"
    echo "  --api-token <token>  Bearer token for API authorization"
    echo "  --remediate          Prompt before applying remediation for failed rules"
    echo "  --auto-remediate     Automatically apply remediation for failed rules"
    echo "  --dry-run            Parse and print what would run, without executing"
    echo "  -h, --help           Show this help message"
}

# Unified Logging and Dispatch Function
# Format: %d{yyyy-MM-dd'T'HH:mm:ss.SSSXXX}|%thread|%-5level|%logger{1}|%msg%n
log_event() {
    local level="$1"
    local event_type="$2"
    local msg="$3"
    local json_msg="${4:-}"
    
    local timestamp
    timestamp=$(date +"%Y-%m-%dT%H:%M:%S.%3N%z")
    local thread_name="main"
    local logger_name="runner"
    
    # Pad level to exactly 5 characters
    local formatted_level
    formatted_level=$(printf "%-5s" "$level")
    
    # Construct standard log string
    local log_string="${timestamp}|${thread_name}|${formatted_level}|${logger_name}|${msg}"
    
    # 1. Console Output
    if [[ "$level" == "ERROR" ]]; then
        echo -e "\033[31m${log_string}\033[0m" >&2
    elif [[ "$level" == "WARN " ]]; then
        echo -e "\033[33m${log_string}\033[0m"
    elif [[ "$level" == "DEBUG" && "$DRY_RUN" == "true" ]]; then
        echo -e "\033[90m${log_string}\033[0m"
    elif [[ "$level" != "DEBUG" ]]; then
        echo "$log_string"
    fi
    
    # 2. File Output
    if [[ -n "$LOG_FILE" ]]; then
        echo "$log_string" >> "$LOG_FILE"
    fi
    
    # 3. API Hook
    if [[ -n "$API_URL" && "$DRY_RUN" != "true" ]]; then
        if [[ -z "$json_msg" ]]; then
            json_msg="{\"message\": \"$msg\"}"
        fi
        
        local api_payload="{"
        api_payload+="\"scan_id\": \"$SCAN_ID\","
        api_payload+="\"hostname\": \"$HOSTNAME\","
        api_payload+="\"timestamp\": \"$timestamp\","
        api_payload+="\"thread\": \"$thread_name\","
        api_payload+="\"level\": \"${level%% }\","
        api_payload+="\"logger\": \"$logger_name\","
        api_payload+="\"event_type\": \"$event_type\","
        api_payload+="\"msg\": $json_msg"
        api_payload+="}"
        
        local auth_header=""
        if [[ -n "$API_TOKEN" ]]; then
            auth_header="Authorization: Bearer $API_TOKEN"
        fi
        
        # Fire and forget
        if [[ -n "$auth_header" ]]; then
            curl -s -X POST -H "Content-Type: application/json" -H "$auth_header" -d "$api_payload" "$API_URL" >/dev/null 2>&1 &
        else
            curl -s -X POST -H "Content-Type: application/json" -d "$api_payload" "$API_URL" >/dev/null 2>&1 &
        fi
    fi
}

# -----------------------------------------------------------------------------
# Parameter Parsing
# -----------------------------------------------------------------------------

if [ "$#" -eq 0 ]; then
    print_usage
    exit 1
fi

YAML_FILE="$1"
shift

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --rule) TARGET_RULE="$2"; shift ;;
        --log-file) LOG_FILE="$2"; shift ;;
        --api-url) API_URL="$2"; shift ;;
        --api-token) API_TOKEN="$2"; shift ;;
        --remediate) REMEDIATE_MODE="prompt" ;;
        --auto-remediate) REMEDIATE_MODE="auto" ;;
        --dry-run) DRY_RUN="true" ;;
        -h|--help) print_usage; exit 0 ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if [ ! -f "$YAML_FILE" ]; then
    echo "Error: File '$YAML_FILE' not found."
    exit 1
fi

# -----------------------------------------------------------------------------
# Execution
# -----------------------------------------------------------------------------

# Quick count of rules for telemetry
TOTAL_RULES=$(grep -c '^[[:space:]]*- rule_id:' "$YAML_FILE" || echo 0)

log_event "INFO " "before_all" "Initializing scan with $TOTAL_RULES total rules from $YAML_FILE" "{\"total_rules\": $TOTAL_RULES, \"yaml_file\": \"$YAML_FILE\"}"

if [[ "$DRY_RUN" == "true" ]]; then
    log_event "WARN " "status" "DRY RUN MODE ENABLED. No commands will be executed."
fi

# AWK State Machine to extract YAML natively
# Outputs: RULE_ID \t CHECK_CMD \t REMEDIATION_CMD \t RULE_NAME
while IFS=$'\t' read -r RULE_ID CHECK_CMD REM_CMD RULE_NAME; do
    
    # Skip if specific rule requested and this isn't it
    if [[ -n "$TARGET_RULE" && "$RULE_ID" != "$TARGET_RULE" ]]; then
        continue
    fi
    
    # 1. BEFORE EACH
    log_event "INFO " "before_each" "Evaluating $RULE_ID: $RULE_NAME" "{\"rule_id\": \"$RULE_ID\", \"rule_name\": \"$RULE_NAME\"}"
    log_event "DEBUG" "command" "Check Command: $CHECK_CMD" "{\"rule_id\": \"$RULE_ID\", \"command\": \"$CHECK_CMD\"}"
    
    # 2. RUN EACH
    START_TIME=$(date +%s%3N)
    EXIT_CODE=0
    
    if [[ "$DRY_RUN" != "true" ]]; then
        set +e
        eval "$CHECK_CMD" > /dev/null 2>&1
        EXIT_CODE=$?
        set -e
    else
        # Simulate pass in dry-run to show remediation skipping, or just assume pass
        EXIT_CODE=0
    fi
    
    END_TIME=$(date +%s%3N)
    DURATION=$((END_TIME - START_TIME))
    
    # 3. AFTER EACH
    if [ $EXIT_CODE -eq 0 ]; then
        STATUS="PASS"
        PASS_COUNT=$((PASS_COUNT + 1))
        log_event "INFO " "after_each" "[$STATUS] $RULE_ID" "{\"rule_id\": \"$RULE_ID\", \"status\": \"$STATUS\", \"duration_ms\": $DURATION}"
    else
        STATUS="FAIL"
        FAIL_COUNT=$((FAIL_COUNT + 1))
        log_event "ERROR" "after_each" "[$STATUS] $RULE_ID" "{\"rule_id\": \"$RULE_ID\", \"status\": \"$STATUS\", \"duration_ms\": $DURATION}"
        
        # 4. REMEDIATION FLOW
        if [[ "$REMEDIATE_MODE" != "none" && "$DRY_RUN" != "true" ]]; then
            if [[ -z "$REM_CMD" ]]; then
                log_event "WARN " "remediation" "No remediation command found for $RULE_ID. Skipping." "{\"rule_id\": \"$RULE_ID\", \"action\": \"skip_no_command\"}"
            else
                DO_REM="no"
                
                if [[ "$REMEDIATE_MODE" == "auto" ]]; then
                    DO_REM="yes"
                    log_event "INFO " "remediation" "Auto-remediating $RULE_ID" "{\"rule_id\": \"$RULE_ID\", \"action\": \"auto_execute\"}"
                elif [[ "$REMEDIATE_MODE" == "prompt" ]]; then
                    # We must read directly from /dev/tty because stdin is bound to the pipe from awk
                    echo -e "\n\033[33m--- Remediation Required: $RULE_ID ---\033[0m" > /dev/tty
                    echo -e "\033[90mCommand:\033[0m $REM_CMD" > /dev/tty
                    read -p "Execute remediation? [y/N]: " -u 0 < /dev/tty user_choice
                    if [[ "$user_choice" =~ ^[Yy]$ ]]; then
                        DO_REM="yes"
                        log_event "INFO " "remediation" "User approved remediation for $RULE_ID" "{\"rule_id\": \"$RULE_ID\", \"action\": \"user_approved\"}"
                    else
                        log_event "WARN " "remediation" "User declined remediation for $RULE_ID" "{\"rule_id\": \"$RULE_ID\", \"action\": \"user_declined\"}"
                    fi
                fi
                
                if [[ "$DO_REM" == "yes" ]]; then
                    log_event "DEBUG" "run_remediation" "Executing remediation command" "{\"rule_id\": \"$RULE_ID\"}"
                    set +e
                    eval "$REM_CMD" > /dev/null 2>&1
                    REM_EXIT=$?
                    set -e
                    
                    if [ $REM_EXIT -eq 0 ]; then
                        log_event "INFO " "remediation_result" "Remediation SUCCESS for $RULE_ID" "{\"rule_id\": \"$RULE_ID\", \"status\": \"SUCCESS\"}"
                    else
                        log_event "ERROR" "remediation_result" "Remediation FAIL for $RULE_ID (Exit $REM_EXIT)" "{\"rule_id\": \"$RULE_ID\", \"status\": \"FAIL\"}"
                    fi
                fi
            fi
        fi
    fi
    
done < <(awk '
  # State Machine Variables:
  # in_assessment: tracking if we are inside an assessment block
  # in_remediation: tracking if we are inside a remediation block
  
  /^[ \t]*- rule_id:/ {
    # Print previous rule if valid
    if (rule_id != "" && cmd != "") {
      printf "%s\t%s\t%s\t%s\n", rule_id, cmd, rem_cmd, rule_name
    }
    # Reset for new rule
    rule_id = $3
    cmd = ""
    rem_cmd = ""
    rule_name = ""
    in_assessment = 0
    in_remediation = 0
  }
  
  /^[ \t]*rule_name:/ && !in_assessment && !in_remediation {
    sub(/^[ \t]*rule_name:[ \t]*/, "")
    sub(/^'\''/, ""); sub(/'\''$/, "")
    sub(/^"/, ""); sub(/"$/, "")
    rule_name = $0
  }
  
  /^[ \t]*assessment:/ {
    in_assessment = 1
    in_remediation = 0
  }
  
  /^[ \t]*remediation:/ {
    in_assessment = 0
    in_remediation = 1
  }
  
  # Check commands
  /^[ \t]*check_command:/ && in_assessment {
    sub(/^[ \t]*check_command:[ \t]*/, "")
    sub(/^'\''/, ""); sub(/'\''$/, "")
    sub(/^"/, ""); sub(/"$/, "")
    cmd = $0
  }
  
  /^[ \t]*detection_step:/ && in_assessment {
    if (cmd == "") {
      sub(/^[ \t]*detection_step:[ \t]*/, "")
      sub(/^'\''/, ""); sub(/'\''$/, "")
      sub(/^"/, ""); sub(/"$/, "")
      cmd = $0
    }
  }
  
  # Remediation commands
  /^[ \t]*remediation_step:/ && in_remediation {
    sub(/^[ \t]*remediation_step:[ \t]*/, "")
    sub(/^'\''/, ""); sub(/'\''$/, "")
    sub(/^"/, ""); sub(/"$/, "")
    rem_cmd = $0
  }
  
  /^[ \t]*remediation_script:/ && in_remediation {
    if (rem_cmd == "") {
      sub(/^[ \t]*remediation_script:[ \t]*/, "")
      sub(/^'\''/, ""); sub(/'\''$/, "")
      sub(/^"/, ""); sub(/"$/, "")
      rem_cmd = $0
    }
  }
  
  # Reset scope if leaving block (naive YAML scope handling)
  /^[ \t]*[a-zA-Z0-9_]+:[ \t]*$/ {
    if ($1 != "assessment:" && $1 != "remediation:") {
        in_assessment = 0
        in_remediation = 0
    }
  }

  END {
    if (rule_id != "" && cmd != "") {
      printf "%s\t%s\t%s\t%s\n", rule_id, cmd, rem_cmd, rule_name
    }
  }
' "$YAML_FILE")

# 5. AFTER ALL
log_event "INFO " "after_all" "Scan completed. Passed: $PASS_COUNT, Failed: $FAIL_COUNT" "{\"passed\": $PASS_COUNT, \"failed\": $FAIL_COUNT, \"status\": \"completed\"}"

exit 0