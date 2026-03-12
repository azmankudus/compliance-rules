# Compliance Rules Prompt Templates

## Output Structure Template

### File Header (REQUIRED)

```yaml
$schema: https://opencode.ai/schemas/hardening-rule-schema.json
$schema_version: "1.0.0"
$metadata:
  name: <Framework> for <Product> - <Profile>
  version: <Benchmark Version>
  description: <Description>
  platform: <Platform Name>
  benchmark: <Full Benchmark Name>
  author: <Author Name>
  created: "<ISO8601 Timestamp>"
  modified: "<ISO8601 Timestamp>"
  compatible_platforms:
    - <Platform 1>
    - <Platform 2>

compliance_info:
  framework: <CIS|STIG>
  version: <Benchmark Version>
  profile: <Profile Name>

profile:
  name: <Profile Name>
  description: <Profile Description>
  level: <1-5>

rules:
  # Rules array
```

### Rule Structure (REQUIRED Fields)

```yaml
  - rule_id: <UNIQUE-ID>
    legacy_ids:
      - <Legacy ID 1>
    rule_name: "<Short Name>"
    rule_description: "<Full Description>"
    category: "<Category>"
    subcategory: "<Subcategory>"
    testing_status: <untested|partial|verified>
    assessment:
      severity: <Critical|High|Medium|Low|Informational>
      is_auto: <true|false>
      automation_level: <Full|Partial|Manual>
      audit_type: <config|runtime|log>
      detection_step: "<Detection Steps>"
      check_command: "<Command>"
      expected_value: "<Expected Result>"
    remediation:
      remediation_step: "<Fix Steps>"
      rollback_supported: <true|false>
      reboot_required: <true|false>
      service_impact: "<Impact Description>"
      estimated_time: "<Time Estimate>"
    context:
      rationale: "<Why This Rule>"
      impact: "<Business Impact>"
      false_positive_risk: <None|Low|Medium|High>
    tags:
      - <tag1>
      - <tag2>
```

## Task Prompts

### Create New Rules Prompt

```
Create compliance rules for:
- Product: <product>
- Version: <version>
- Framework: <CIS|STIG>
- Profile: <level/category>

Instructions:
1. Search official sources in priority order
2. Verify you have the LATEST version
3. Extract all rules for the specified profile
4. Format according to the output structure
5. Include all required fields
6. Validate against schema
```

### Update Existing Rules Prompt

```
Update compliance rules in <file_path>:
1. Check official source for newer version
2. Compare existing rules with latest
3. Add new rules
4. Update modified rules
5. Update metadata version and modified date
6. Validate against schema
```

### Validate Rules Prompt

```
Validate compliance rules in <file_path>:
1. Check YAML syntax
2. Validate against docs/schema.json
3. Verify required fields present
4. Check rule_id uniqueness
5. Report any errors
```

## Severity Mapping

### STIG to Internal
| STIG Category | Internal Severity |
|---------------|-------------------|
| CAT I | High |
| CAT II | Medium |
| CAT III | Low |

### CIS to Internal
| CIS Level | Internal Severity |
|-----------|-------------------|
| Scored (Level 1) | Medium |
| Scored (Level 2) | High |
| Not Scored | Low |

## Category Examples

### Linux Categories
- Filesystem
- Access Control
- Logging and Auditing
- Network Configuration
- Services
- SSH Configuration
- User Accounts

### Windows Categories
- System Configuration
- Account Policies
- Audit Policies
- Security Options
- Services
- Registry Settings

### Application Categories
- Authentication
- Encryption
- Auditing
- Network Security
- Session Management
- Configuration

## Common Check Commands

### Linux
- File permissions: `stat -c '%a %n' <file>`
- Service status: `systemctl is-enabled <service>`
- Configuration: `grep <pattern> <config_file>`
- Kernel modules: `modprobe -n -v <module>`

### Windows
- Registry: `Get-ItemProperty -Path "<regpath>"`
- Service: `Get-Service -Name <service>`
- GPO: `Get-GPOReport -Name "<policy>"`

### Applications
- Config files: Check XML/YAML/JSON configs
- WLST scripts: WebLogic specific commands
- API calls: REST/CLI verification
