# Compliance Rules Creation Guidelines

## Pre-Creation Checklist

Before creating any compliance rules:

- [ ] Identify exact product name and version
- [ ] Identify framework (CIS or STIG)
- [ ] Identify profile/level needed
- [ ] Search official sources in priority order
- [ ] Verify latest version is being used
- [ ] Have source document open for reference

## Rule Creation Process

### Step 1: Information Gathering

1. **For STIG Rules:**
   ```
   1. Go to https://www.cyber.mil/stigs/downloads/
   2. Search for product (e.g., "RHEL 9")
   3. Download latest ZIP
   4. Extract XCCDF file
   5. Parse rules by category
   ```

2. **For CIS Rules:**
   ```
   1. Go to https://www.cisecurity.org/benchmark/
   2. Find product benchmark
   3. Download PDF/XLS (requires membership)
   4. Extract rules by section
   ```

### Step 2: Rule Extraction

Extract from source document:

| Field | STIG Source | CIS Source |
|-------|-------------|------------|
| rule_id | STIG ID (e.g., RHEL-09-211010) | Section number (e.g., 1.1.1.1) |
| legacy_ids | V-ID, SV-ID | N/A |
| rule_name | Title | Title |
| rule_description | Description | Description |
| severity | CAT I/II/III | Profile scoring |
| check_command | Check content | Audit section |
| remediation_step | Fix text | Remediation section |

### Step 3: Rule ID Formatting

**STIG IDs:**
- Format: `STIG-<number>` (e.g., `STIG-211010`)
- Extract number from end of STIG ID
- Prefix with `STIG-`

**CIS IDs:**
- Format: `CIS-<section>` (e.g., `CIS-1.1.1.1`)
- Use section number directly
- Prefix with `CIS-`

### Step 4: Category Assignment

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

**Windows Categories:**
- System Configuration - General
- Account Policies - Password, lockout
- Audit Policies - Auditing settings
- Security Options - Security settings
- Services - Windows services
- Registry Settings - Registry configs
- User Rights - Privileges

### Step 5: Severity Mapping

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
5. **Don't mix frameworks** - Keep CIS and STIG rules in separate files

## Validation Commands

After creating rules, validate:

```bash
# Validate YAML syntax
python -c "import yaml; yaml.safe_load(open('file.yaml'))"

# Validate against schema
python -c "
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
- rule_id: STIG-211010
  legacy_ids:
    - V-257777
    - SV-257777r991589_rule
  rule_name: RHEL 9 must be a vendor-supported release
  rule_description: "An operating system release is considered 'supported' if the vendor continues to provide security patches for the product."
  category: System Updates
  subcategory: Vendor Support
  testing_status: verified
  assessment:
    severity: High
    is_auto: true
    automation_level: Full
    audit_type: config
    detection_step: "Verify that the version of RHEL 9 is vendor supported"
    check_command: "cat /etc/redhat-release"
    expected_value: "Red Hat Enterprise Linux release 9.x"
  remediation:
    remediation_step: "Upgrade to a supported version of RHEL 9."
    rollback_supported: false
    reboot_required: true
    service_impact: "System upgrade required"
    estimated_time: "30 minutes"
  context:
    rationale: "Running an unsupported OS version leaves the system vulnerable"
    impact: "Critical - No security patches available"
    false_positive_risk: "None"
  tags:
    - system
    - updates
    - vendor-support
```
