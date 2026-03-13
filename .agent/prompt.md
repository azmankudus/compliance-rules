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
  source: <Source URL>
  created: "<ISO8601 Timestamp>"
  modified: "<ISO8601 Timestamp>"
  compatible_platforms:
    - <Platform 1>
    - <Platform 2>

compliance_info:
  framework: <CIS|STIG|NIST>
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

## File Naming Template

### Pattern
```
rules/<vendor>/<product>-<version>/<vendor>-<product>-<version>-<framework>-<type>-<doc-version>[-additional-info].yaml
```

### Naming Examples by Framework

#### CIS Benchmark Files
```
# RHEL Server
rules/redhat/rhel-10/redhat-rhel-10-cis-level1-v1.0.1-server.yaml
rules/redhat/rhel-10/redhat-rhel-10-cis-level2-v1.0.1-server.yaml

# RHEL Workstation
rules/redhat/rhel-10/redhat-rhel-10-cis-level1-v1.0.1-workstation.yaml
rules/redhat/rhel-10/redhat-rhel-10-cis-level2-v1.0.1-workstation.yaml

# Windows Server Domain Controller
rules/microsoft/windowsserver-2022/microsoft-windowsserver-2022-cis-level1-v3.0.0-dc.yaml
rules/microsoft/windowsserver-2022/microsoft-windowsserver-2022-cis-level2-v3.0.0-dc.yaml

# Windows Server Member Server
rules/microsoft/windowsserver-2022/microsoft-windowsserver-2022-cis-level1-v3.0.0-ms.yaml
rules/microsoft/windowsserver-2022/microsoft-windowsserver-2022-cis-level2-v3.0.0-ms.yaml
```

#### STIG Files
```
# RHEL STIG
rules/redhat/rhel-9/redhat-rhel-9-stig-cat1-v2r7.yaml
rules/redhat/rhel-9/redhat-rhel-9-stig-cat2-v2r7.yaml
rules/redhat/rhel-9/redhat-rhel-9-stig-cat3-v2r7.yaml

# Windows Server STIG
rules/microsoft/windowsserver-2022/microsoft-windowsserver-2022-stig-cat1-v2r3.yaml
rules/microsoft/windowsserver-2022/microsoft-windowsserver-2022-stig-cat2-v2r3.yaml
rules/microsoft/windowsserver-2022/microsoft-windowsserver-2022-stig-cat3-v2r3.yaml

# Solaris STIG with architecture
rules/oracle/solaris-11.4/oracle-solaris-114-stig-cat1-v1r0-x86.yaml
rules/oracle/solaris-11.4/oracle-solaris-114-stig-cat1-v1r0-sparc.yaml

# WebLogic STIG
rules/oracle/weblogic-12c/oracle-weblogic-12c-stig-cat1-v2r2.yaml
```

#### Vendor Documentation Files
```
# Red Hat official documentation
rules/redhat/rhel-10/redhat-rhel-10-redhat-security-1.0.0.yaml
rules/redhat/rhel-9/redhat-rhel-9-redhat-security-1.0.0.yaml

# Oracle official documentation
rules/oracle/weblogic-12c/oracle-weblogic-12c-oracle-security-1.0.0.yaml
rules/oracle/weblogic-14c/oracle-weblogic-14c-oracle-security-1.0.0.yaml
rules/oracle/http-server-12c/oracle-httpserver-12c-oracle-security-1.0.0.yaml
```

## Task Prompts

### Create New Rules Prompt

```
Create compliance rules for:
- Product: <product>
- Version: <version>
- Framework: <CIS|STIG|Vendor>
- Profile: <level/category>

Instructions:
1. Search official sources in priority order
2. Verify you have the LATEST version
3. Extract all rules for the specified profile
4. Format according to the output structure
5. Include all required fields
6. Validate against schema
7. Use correct file naming convention
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

### Create Vendor Documentation Rules Prompt

```
Create security hardening rules from vendor documentation:
- Vendor: <redhat|microsoft|oracle>
- Product: <product>
- Version: <version>
- Documentation URL: <url>

Instructions:
1. Fetch official documentation from vendor site
2. Extract security recommendations
3. Structure as compliance rules
4. Use appropriate rule IDs (e.g., RH-FIPS-001)
5. Set framework based on vendor (redhat, oracle, microsoft)
6. Include source URL in metadata
7. Validate against schema
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

### Vendor Docs to Internal
| Vendor Rating | Internal Severity |
|---------------|-------------------|
| Critical/Required | High |
| Recommended | Medium |
| Optional | Low |

## Category Examples

### Linux Categories
- Filesystem
- Access Control
- Logging and Auditing
- Network Configuration
- Services
- SSH Configuration
- User Accounts
- System Configuration
- Cryptography
- Integrity Checking
- Application Control
- Device Control
- Compliance
- Disk Encryption
- Authentication

### Windows Categories
- System Configuration
- Account Policies
- Audit Policies
- Security Options
- Services
- Registry Settings
- User Rights

### Application Categories
- Authentication
- Encryption
- Auditing
- Network Security
- Session Management
- Configuration
- Application Security

## Common Check Commands

### Linux
- File permissions: `stat -c '%a %n' <file>`
- Service status: `systemctl is-enabled <service>`
- Configuration: `grep <pattern> <config_file>`
- Kernel modules: `modprobe -n -v <module>`
- FIPS mode: `cat /proc/sys/crypto/fips_enabled`
- Crypto policy: `update-crypto-policies --show`
- AIDE status: `rpm -q aide && test -f /var/lib/aide/aide.db.gz`

### Windows
- Registry: `Get-ItemProperty -Path "<regpath>"`
- Service: `Get-Service -Name <service>`
- GPO: `Get-GPOReport -Name "<policy>"`

### Applications
- Config files: Check XML/YAML/JSON configs
- WLST scripts: WebLogic specific commands
- API calls: REST/CLI verification

## Rule ID Patterns

### CIS Rules
```
CIS-<section>.<subsection>.<control>
Examples: CIS-1.1.1.1, CIS-2.2.1, CIS-5.1.1
```

### STIG Rules
```
STIG-<number>
Examples: STIG-211010, STIG-211011, STIG-257777
```

### Vendor Documentation Rules
```
<VENDOR>-<CATEGORY>-<NUMBER>
Examples: RH-FIPS-001, RH-CRYPTO-001, RH-AIDE-001
         ORA-AUTH-001, ORA-SSL-001
```
