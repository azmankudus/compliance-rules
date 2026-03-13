# Compliance Rules Creation Guidelines

## Pre-Creation Checklist

Before creating any compliance rules:

- [ ] Identify exact product name and version
- [ ] Identify framework (CIS, STIG, or Vendor Docs)
- [ ] Identify profile/level needed
- [ ] Search official sources in priority order
- [ ] Verify latest version is being used
- [ ] Have source document open for reference

## Rule Creation Process

### Step 1: Determine File Path and Name

**Directory Structure:**
```
rules/<vendor>/<product>-<version>/
```

**File Naming:**
```
<vendor>-<product>-<version>-<framework>-<type>-<doc-version>[-additional-info].yaml
```

**Examples:**
| Product | Framework | Type | Path |
|---------|-----------|------|------|
| RHEL 10 | CIS | Level 1 Server | `rules/redhat/rhel-10/redhat-rhel-10-cis-level1-v1.0.1-server.yaml` |
| RHEL 9 | STIG | CAT I | `rules/redhat/rhel-9/redhat-rhel-9-stig-cat1-v2r7.yaml` |
| RHEL 10 | Red Hat | Security | `rules/redhat/rhel-10/redhat-rhel-10-redhat-security-1.0.0.yaml` |
| WS 2022 | CIS | Level 1 DC | `rules/microsoft/windowsserver-2022/microsoft-windowsserver-2022-cis-level1-v3.0.0-dc.yaml` |
| Solaris 11.4 | STIG | CAT I x86 | `rules/oracle/solaris-11.4/oracle-solaris-114-stig-cat1-v1r0-x86.yaml` |
| WebLogic 12c | Oracle | Security | `rules/oracle/weblogic-12c/oracle-weblogic-12c-oracle-security-1.0.0.yaml` |

### Step 2: Information Gathering

1. **For STIG Rules:**
   ```
   1. Check local cache: docs/stig-yyyyMMdd.json
   2. Go to https://www.cyber.mil/stigs/downloads/
   3. Search for product (e.g., "RHEL 9")
   4. Download latest ZIP
   5. Extract XCCDF file
   6. Parse rules by category
   ```

2. **For CIS Rules:**
   ```
   1. Check local cache: docs/cis-yyyyMMdd.json
   2. Go to https://www.cisecurity.org/benchmark/
   3. Find product benchmark
   4. Download PDF/XLS (requires membership)
   5. Extract rules by section
   ```

3. **For Vendor Documentation Rules:**
   ```
   1. Go to vendor documentation site
   2. Find security hardening guide
   3. Extract security recommendations
   4. Structure as compliance rules
   ```

### Step 3: Rule Extraction

Extract from source document:

| Field | STIG Source | CIS Source | Vendor Docs |
|-------|-------------|------------|-------------|
| rule_id | STIG ID (e.g., RHEL-09-211010) | Section number (e.g., 1.1.1.1) | Custom (e.g., RH-FIPS-001) |
| legacy_ids | V-ID, SV-ID | N/A | N/A |
| rule_name | Title | Title | Section title |
| rule_description | Description | Description | Description |
| severity | CAT I/II/III | Profile scoring | Based on impact |
| check_command | Check content | Audit section | Verification steps |
| remediation_step | Fix text | Remediation section | Configuration steps |

### Step 4: Rule ID Formatting

**STIG IDs:**
- Format: `STIG-<number>` (e.g., `STIG-211010`)
- Extract number from end of STIG ID
- Prefix with `STIG-`

**CIS IDs:**
- Format: `CIS-<section>` (e.g., `CIS-1.1.1.1`)
- Use section number directly
- Prefix with `CIS-`

**Vendor Documentation IDs:**
- Format: `<VENDOR>-<CATEGORY>-<NUMBER>` (e.g., `RH-FIPS-001`)
- Use vendor prefix
- Category abbreviation
- Sequential number

### Step 5: Category Assignment

Choose appropriate category:

**Linux Categories:**
- Filesystem - Mount points, partitions
- Access Control - Permissions, sudo
- Logging and Auditing - Logs, auditd
- Network Configuration - Firewall, network
- Services - System services
- SSH Configuration - SSH settings
- User Accounts - User management
- System Configuration - General settings
- Cryptography - FIPS, crypto policies
- Integrity Checking - AIDE, Keylime
- Application Control - fapolicyd
- Device Control - USBGuard
- Compliance - OpenSCAP
- Disk Encryption - NBDE, LUKS
- Authentication - PKCS#11, smart cards

**Windows Categories:**
- System Configuration - General
- Account Policies - Password, lockout
- Audit Policies - Auditing settings
- Security Options - Security settings
- Services - Windows services
- Registry Settings - Registry configs
- User Rights - Privileges

**Application Categories:**
- Authentication - User auth, passwords
- Encryption - SSL/TLS, certificates
- Auditing - Logging, monitoring
- Network Security - Ports, filtering
- Session Management - Timeouts, cookies
- Configuration - Server settings
- Application Security - EJB, REST, Web Services

### Step 6: Severity Mapping

**STIG Severity:**
```yaml
CAT I (High/Critical) -> severity: High
CAT II (Medium) -> severity: Medium
CAT III (Low) -> severity: Low
```

**CIS Severity:**
```yaml
Level 1 Scored -> severity: Medium
Level 2 Scored -> severity: High
Not Scored -> severity: Low
Informational -> severity: Informational
```

**Vendor Documentation Severity:**
```yaml
Critical/Required -> severity: High
Recommended -> severity: Medium
Optional -> severity: Low
```

## Required Fields Checklist

Every rule MUST have:

- [ ] `rule_id` - Unique identifier
- [ ] `rule_name` - Short descriptive name (max 200 chars)
- [ ] `rule_description` - Full description
- [ ] `category` - Primary category
- [ ] `assessment` object with:
  - [ ] `severity` - One of: Critical, High, Medium, Low, Informational
  - [ ] `is_auto` - true or false
  - [ ] `audit_type` - Type of audit
  - [ ] `detection_step` - How to detect
- [ ] `remediation` object with:
  - [ ] `remediation_step` - How to fix

## Optional Fields

Include when available:

- `subcategory` - Secondary category
- `testing_status` - untested, partial, verified
- `legacy_ids` - Array of old IDs
- `assessment.check_command` - Command to check
- `assessment.expected_value` - Expected result
- `assessment.automation_level` - Full, Partial, Manual
- `remediation.rollback_supported` - true/false
- `remediation.reboot_required` - true/false
- `remediation.service_impact` - Impact description
- `remediation.estimated_time` - Time estimate
- `context.rationale` - Why this rule exists
- `context.impact` - Business impact
- `context.false_positive_risk` - None, Low, Medium, High
- `context.references` - Array of references
- `tags` - Array of tags

## Common Mistakes to Avoid

1. **Don't fabricate check commands** - Only use commands from official source
2. **Don't guess severity** - Use severity from source document
3. **Don't skip required fields** - All required fields must be present
4. **Don't use outdated versions** - Always verify latest version
5. **Don't mix frameworks** - Keep CIS, STIG, and vendor rules in separate files
6. **Don't use abbreviations** - Use full vendor names (redhat, not rh)
7. **Don't put additional info in wrong place** - Always at the end after version

## Validation Commands

After creating rules, validate:

```bash
# Validate YAML syntax
python3 -c "import yaml; yaml.safe_load(open('file.yaml'))"

# Validate against schema
python3 -c "
import yaml, json
from jsonschema import validate
with open('docs/schema.json') as f:
    schema = json.load(f)
with open('file.yaml') as f:
    data = yaml.safe_load(f)
validate(instance=data, schema=schema)
print('Valid!')
"
```

## Example Complete Rule

```yaml
- rule_id: RH-FIPS-001
  rule_name: Install system with FIPS mode enabled
  rule_description: To enable cryptographic module self-checks mandated by FIPS 140-3, the system must be installed with FIPS mode enabled.
  category: Cryptography
  subcategory: FIPS Mode
  testing_status: untested
  assessment:
    severity: High
    is_auto: true
    automation_level: Full
    audit_type: config
    detection_step: Verify FIPS mode is enabled during system installation
    check_command: cat /proc/sys/crypto/fips_enabled
    expected_value: '1'
  remediation:
    remediation_step: |
      During RHEL installation:
      1. At boot menu, press 'e' (UEFI) or Tab (BIOS)
      2. Add 'fips=1' to kernel command line
      3. Continue installation
    rollback_supported: false
    reboot_required: true
    service_impact: System must be reinstalled to change FIPS mode
    estimated_time: 60+ minutes
  context:
    rationale: FIPS 140-3 compliance requires cryptographic module self-checks
    impact: Critical - Required for FIPS 140-3 certification
    false_positive_risk: None
  tags:
    - fips
    - cryptography
    - compliance
```
