<p align="center">
  <img src="https://img.shields.io/badge/Compliance-Rules-blue?style=flat-square" alt="Compliance Rules" />
  <img src="https://img.shields.io/badge/CIS-Benchmarks-green?style=flat-square" alt="CIS" />
  <img src="https://img.shields.io/badge/DISA-STIG-red?style=flat-square" alt="STIG" />
  <img src="https://img.shields.io/badge/RHEL-9-orange?style=flat-square" alt="RHEL" />
</p>

<h1 align="center">🔍 Compliance Rules</h1>

<p align="center">
  <em>Automated security hardening rules based on CIS Benchmarks and DISA STIGs for enterprise software systems</em>
</p>

<p align="center">
  <a href="https://opencode.ai"><img src="https://img.shields.io/badge/Built%20with-OpenCode-9cf?style=flat-square&logo=data:image/svg+xml;base64,PHN2ZyB4oPHVuZ2F0dW5vdWQvT0eXBlbnQSBzZXJpbwZXJ5ldGFdWU" alt="OpenCode" /></a>
  <a href="https://github.com/azmankudus/compliance-rules"><img src="https://img.shields.io/github/stars/azmankudus/compliance-rules?style=social" alt="GitHub Stars" /></a>
</p>

---

## 📋 Overview

This repository contains machine-readable compliance rules in **YAML format**, designed for automated security assessment and remediation. Rules are structured according to the [JSON Schema](docs/schema.json) and sourced from official compliance bodies.

## 📂 Folder Structure

```
compliance-rules/
├── docs/
│   ├── schema.json              # JSON Schema for compliance rules
│   └── schema.yaml              # YAML Schema (original)
├── <vendor_abbr>/
│   └── <product_abbr>-<product_version>/
│       ├── <compliance_body>/
│       │   └── <vendor_abbr>-<product_abbr>-<product_version>-<compliance_body>-<compliance_level>-<compliance_version>.yaml
└── README.md
```

## 📄 File Naming Convention

```
<vendor_abbr>-<product_abbr>-<product_version>-<compliance_body>-<compliance_level>-<compliance_version>.yaml
```

| Component | Description | Examples |
|-----------|-------------|---------|
| `vendor_abbr` | Vendor abbreviation | `rh` (Red Hat), `ms` (Microsoft) |
| `product_abbr` | Product abbreviation | `rhel` (RHEL), `ws` (Windows Server) |
| `product_version` | Product version | `9`, `2022`, `8` |
| `compliance_body` | Compliance framework | `cis`, `stig`, `nist` |
| `compliance_level` | Profile/Category level | See below |
| `compliance_version` | Benchmark version | `v2.0.0`, `v2r7` |

### Compliance Levels by Framework

| Framework | Level Format | Examples |
|-----------|-------------|---------|
| **CIS** | `level<1-2>-<type>` | `level1-server`, `level2-workstation` |
| **STIG** | `cat<1-3>` | `cat1`, `cat2`, `cat3` |
| **NIST** | `impact-<level>` | `impact-high`, `impact-moderate` |

## 📊 Available Compliance Rules

### Red Hat Enterprise Linux 9

#### CIS Benchmarks

| Document | Level | Profile | Description |
|----------|------|---------|-------------|
| [Level 1 Server](rh/rhel-9/cis/rh-rhel-9-cis-level1-server-v2.0.0.yaml) | `🟢 Baseline` | Server | Practical security for servers |
| [Level 2 Server](rh/rhel-9/cis/rh-rhel-9-cis-level2-server-v2.0.0.yaml) | `🟡 Enhanced` | Server | Additional hardening for servers |
| [Level 1 Workstation](rh/rhel-9/cis/rh-rhel-9-cis-level1-workstation-v2.0.0.yaml) | `🟢 Baseline` | Workstation | Practical security for desktops |
| [Level 2 Workstation](rh/rhel-9/cis/rh-rhel-9-cis-level2-workstation-v2.0.0.yaml) | `🟡 Enhanced` | Workstation | Additional hardening for desktops |

#### DISA STIG

| Document | Category | Severity | Rules | Description |
|----------|----------|----------|-------|-------------|
| [CAT I](rh/rhel-9/stig/rh-rhel-9-stig-cat1-v2r7.yaml) | 🔴 CAT I | High | 20 | Critical security controls |
| [CAT II](rh/rhel-9/stig/rh-rhel-9-stig-cat2-v2r7.yaml) | 🟡 CAT II | Medium | 414 | Standard security controls |
| [CAT III](rh/rhel-9/stig/rh-rhel-9-stig-cat3-v2r7.yaml) | 🟢 CAT III | Low | 16 | Low-risk security controls |

## 🏛️ Compliance Frameworks

| Framework | Full Name | Description |
|-----------|-----------|-------------|
| **CIS** | Center for Internet Security | Industry best practices with Level 1/2 profiles |
| **STIG** | DISA Security Technical Implementation Guide | U.S. Department of Defense requirements |
| **NIST** | National Institute of Standards and Technology | Security and privacy controls *(planned)* |
| **PCI-DSS** | Payment Card Industry Data Security Standard | Payment card security *(planned)* |

## 🚀 Quick Start

### Prerequisites

- Python 3.6+
- PyYAML library

### Installation

```bash
git clone https://github.com/azmankudus/compliance-rules.git
cd compliance-rules
pip install pyyaml
```

### Validate Rules
```bash
# Validate YAML syntax
python3 -c "import yaml; yaml.safe_load(open('rh/rhel-9/cis/rh-rhel-9-cis-level1-server-v2.0.0.yaml'))"

# Validate against schema
python3 << 'EOF'
import json, yaml
from jsonschema import validate

# Load schema
with open('docs/schema.json') as f:
    schema = json.load(f)

# Load and validate
with open('rh/rhel-9/cis/rh-rhel-9-cis-level1-server-v2.0.0.yaml') as f:
    data = yaml.safe_load(f)
    validate(instance=data, schema=schema)
    print("✅ Valid!")
EOF
```

## 📝 Rule Structure

```yaml
rule_id: CIS-1.1.2.1
rule_name: Ensure /tmp is configured
rule_description: The /tmp directory should be on a separate partition
category: Filesystem
subcategory: Partitioning
testing_status: verified
assessment:
  severity: Medium
  is_auto: true
  automation_level: Full
  audit_type: config
  detection_step: "Verify /tmp is a separate mount point"
  check_command: "mount | grep ' /tmp '"
  expected_value: "Separate mount point for /tmp"
remediation:
  remediation_step: "Configure /tmp in /etc/fstab with nodev,nosuid,noexec"
  rollback_supported: false
  reboot_required: true
  service_impact: "Requires filesystem reconfiguration"
  estimated_time: "30 minutes"
context:
  rationale: "Separate /tmp prevents resource exhaustion and allows restrictive mount options"
  impact: "Medium - Improves security and stability"
  false_positive_risk: None
tags:
  - filesystem
  - partitioning
  - tmp
```

## 🔗 Integration

These rules can be integrated with

| Tool | Usage |
|------|-------|
| **OpenSCAP / SCAP Workbench** | Convert to XCCDF/OVAL format |
| **Ansible** | Generate playbooks for automated remediation |
| **Terraform / Puppet / Chef** | Infrastructure as code compliance |
| **Custom scanners** | Build assessment tools using the structured YAML |

## 📈 Statistics

### Current Coverage

| Product | CIS Rules | STIG Rules | Total |
|---------|-----------|------------|-------|
| RHEL 9 | 180+ | 450 | 630+ |

### STIG Categories

| Category | Rules | Severity | Action Required |
|----------|-------|----------|-----------------|
| CAT I | 20 | 🔴 High | Immediate |
| CAT II | 414 | 🟡 Medium | Required |
| CAT III | 16 | 🟢 Low | Best Practice |

## 📚 Sources

| Framework | Source |
|-----------|--------|
| CIS | [CIS RHEL Benchmark](https://www.cisecurity.org/benchmark/red_hat_linux) |
| STIG | [DISA STIG Viewer](https://www.stigviewer.com/stigs/red_hat_enterprise_linux_9) |
| ComplianceAsCode | [GitHub Repository](https://github.com/ComplianceAsCode/content) |

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Follow the schema in `docs/schema.json`
4. Source rules from official compliance bodies
5. Test validation before submitting
6. Submit a pull request

## 📜 License

See [LICENSE](LICENSE) file for details.

---

<p align="center">
  <em>Built with ❤️ for security professionals</em>
</p>
