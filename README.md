# Compliance Rules

Automated security hardening rules based on CIS Benchmarks and DISA STIGs for enterprise software systems.

## Overview

This repository contains machine-readable compliance rules in JSON format, designed for automated security assessment and remediation. Rules are structured according to the [JSON Schema](docs/schema.json) and sourced from official compliance bodies.

## Schema

The compliance rules follow the schema defined in [`docs/schema.json`](docs/schema.json), which includes:

- **Metadata**: Framework, version, platform, and compatibility information
- **Assessment**: Severity, automation level, detection steps, and check commands
- **Remediation**: Step-by-step fixes, rollback support, and service impact
- **Context**: Rationale, impact analysis, and references

### Key Features

- Reusable `$defs` for common types (timestamps, versions, severity levels)
- Format constraints (date-time, semantic versioning patterns)
- Dual rule format support (nested and flat structures)
- Testing status and automation level indicators

## Available Compliance Rules

### Red Hat Enterprise Linux 9

| Document | Framework | Version | Profile | Description |
|----------|-----------|---------|---------|-------------|
| [CIS Level 1 Server](rules/linux/rhel9/cis/rhel9-cis-level1-server-v2.0.0.json) | CIS | 2.0.0 | Level 1 | Baseline security for servers |
| [CIS Level 2 Server](rules/linux/rhel9/cis/rhel9-cis-level2-server-v2.0.0.json) | CIS | 2.0.0 | Level 2 | Enhanced security for servers |
| [CIS Level 1 Workstation](rules/linux/rhel9/cis/rhel9-cis-level1-workstation-v2.0.0.json) | CIS | 2.0.0 | Level 1 | Baseline security for workstations |
| [CIS Level 2 Workstation](rules/linux/rhel9/cis/rhel9-cis-level2-workstation-v2.0.0.json) | CIS | 2.0.0 | Level 2 | Enhanced security for workstations |
| [DISA STIG](rules/linux/rhel9/stig/rhel9-stig-v2r7.json) | STIG | V2R7 | All MAC | DISA Security Technical Implementation Guide |

## Rule Structure

```json
{
  "rule_id": "CIS-1.1.2.1",
  "rule_name": "Ensure /tmp is configured",
  "rule_description": "The /tmp directory should be on a separate partition",
  "category": "Filesystem",
  "subcategory": "Partitioning",
  "testing_status": "verified",
  "assessment": {
    "severity": "Medium",
    "is_auto": true,
    "automation_level": "Full",
    "check_command": "mount | grep ' /tmp '"
  },
  "remediation": {
    "remediation_step": "Configure /tmp in /etc/fstab with nodev,nosuid,noexec",
    "reboot_required": true,
    "rollback_supported": false
  },
  "tags": ["filesystem", "partitioning", "tmp"]
}
```

## Supported Compliance Frameworks

- **CIS (Center for Internet Security)**: Industry best practices with Level 1 (baseline) and Level 2 (enhanced) profiles
- **DISA STIG (Defense Information Systems Agency)**: U.S. Department of Defense security requirements
- **NIST 800-53**: Security and privacy controls (planned)
- **PCI-DSS**: Payment Card Industry standards (planned)

## Usage

### Validation

Validate rules against the schema:

```bash
# Using Python
python3 -c "import json; json.load(open('rules/linux/rhel9/cis/rhel9-cis-level1-server-v2.0.0.json'))"

# Using ajv-cli
npx ajv validate -s docs/schema.json -d rules/linux/rhel9/cis/*.json
```

### Integration

These rules can be integrated with:

- **OpenSCAP / SCAP Workbench**: Convert to XCCDF/OVAL format
- **Ansible**: Generate playbooks for automated remediation
- **Terraform/Puppet/Chef**: Infrastructure as code compliance
- **Custom scanners**: Build assessment tools using the structured JSON

## Directory Structure

```
compliance-rules/
├── docs/
│   └── schema.json          # JSON Schema for compliance rules
├── rules/
│   └── linux/
│       └── rhel9/
│           ├── cis/         # CIS Benchmark rules
│           │   ├── rhel9-cis-level1-server-v2.0.0.json
│           │   ├── rhel9-cis-level2-server-v2.0.0.json
│           │   ├── rhel9-cis-level1-workstation-v2.0.0.json
│           │   └── rhel9-cis-level2-workstation-v2.0.0.json
│           └── stig/        # DISA STIG rules
│               └── rhel9-stig-v2r7.json
└── README.md
```

## Sources

- **CIS Benchmarks**: https://www.cisecurity.org/benchmark/red_hat_linux
- **DISA STIGs**: https://www.stigviewer.com/stigs/red_hat_enterprise_linux_9
- **ComplianceAsCode**: https://github.com/ComplianceAsCode/content

## Contributing

1. Follow the schema defined in `docs/schema.json`
2. Source rules from official compliance bodies
3. Include proper metadata and references
4. Test validation before submitting

## License

See [LICENSE](LICENSE) file for details.
