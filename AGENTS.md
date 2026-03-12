# Agent Instructions for Compliance Rules

This repository contains machine-readable compliance rules in YAML format for automated security assessment and remediation.

## Project Overview

- **Purpose**: Security hardening rules based on CIS Benchmarks and DISA STIGs
- **Format**: YAML files validated against JSON Schema
- **Schema**: `docs/schema.json`

## Key Files

- `.agent/` - Agent configuration files (READ THESE FIRST)
- `docs/schema.json` - Authoritative schema definition
- `docs/schema.yaml` - YAML schema reference
- `scripts/download-stig-json.sh` - Download latest STIG catalog

## STIG Lookup Workflow

When searching for STIG information:

1. **Check local cache:** `docs/stig-yyyyMMdd.json`
2. **If cache outdated (date != today):** Run `./scripts/download-stig-json.sh`
3. **Search JSON:** Use `jq` to find relevant STIG entries
4. **Download STIG:** Get the ZIP file from URL in JSON

Example:
```bash
# Refresh cache if needed
./scripts/download-stig-json.sh

# Search for product (use FileName field)
cat docs/stig-*.json | jq '.returnValue[] | select(.FileName | test("WebLogic"; "i")) | {FileName, DownloadLink}'

# Get download link for specific STIG
cat docs/stig-*.json | jq -r '.returnValue[] | select(.FileName | contains("RHEL 9")) | .DownloadLink'
```

## Before Creating Rules

1. Read `.agent/context.md` for project structure
2. Read `.agent/sources.md` for information sources
3. Read `.agent/guidelines.md` for creation process
4. Use `.agent/prompt.md` for output templates

## STIG Search Sequence (MANDATORY ORDER)

1. **https://www.cyber.mil/stigs/downloads/** - PRIMARY (official DISA)
2. **https://www.stigviewer.com/stigs** - SECONDARY
3. **https://cyber.trackr.live/stig** - TERTIARY

## CIS Source

- **https://www.cisecurity.org/benchmark/** - Official CIS Benchmarks

## Anti-Hallucination Rules

1. NEVER fabricate compliance rules
2. ALWAYS source from official benchmarks
3. ALWAYS verify version is latest
4. IF information not found, state clearly
5. IF rule not in official source, do not create it

## File Naming Convention

```
<vendor>-<product>-<version>-<framework>-<level>-<benchmark-version>.yaml
```

### Examples
- `rh-rhel-9-cis-level1-server-v2.0.0.yaml`
- `rh-rhel-9-stig-cat1-v2r7.yaml`
- `ms-ws-2022-cis-level1-dc-v3.0.0.yaml`
- `ms-ws-2022-stig-cat1-v2r3.yaml`

## Validation

After creating/editing rules, run validation:

```bash
python -c "
import yaml, json
from jsonschema import validate
with open('docs/schema.json') as f: schema = json.load(f)
with open('YOUR_FILE.yaml') as f: data = yaml.safe_load(f)
validate(instance=data, schema=schema)
print('Valid!')
"
```

## Required Fields

Every rule must have:
- `rule_id`, `rule_name`, `rule_description`, `category`
- `assessment` with `severity`, `is_auto`, `audit_type`, `detection_step`
- `remediation` with `remediation_step`
