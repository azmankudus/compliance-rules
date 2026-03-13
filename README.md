<div align="center">

# Compliance Rules

<img src="https://img.shields.io/badge/Security-Hardening-critical?style=for-the-badge&logo=shield&logoColor=white&color=dc3545" alt="Security Hardening"/>
<img src="https://img.shields.io/badge/YAML-Format-informational?style=for-the-badge&logo=yaml&logoColor=white&color=17a2b8" alt="YAML Format"/>
<img src="https://img.shields.io/badge/Open_Source-Yes-success?style=for-the-badge&logo=opensourceinitiative&logoColor=white&color=28a745" alt="Open Source"/>

<br/><br/>

<img src="https://img.shields.io/badge/CIS-Benchmarks-success?style=flat-square&logo=centerforinternetsecurity&logoColor=white" alt="CIS Benchmarks"/>
<img src="https://img.shields.io/badge/DISA-STIG-critical?style=flat-square&logo=usdepartmentofdefense&logoColor=white" alt="DISA STIG"/>
<img src="https://img.shields.io/badge/RHEL-7|8|9|10-orange?style=flat-square&logo=redhat&logoColor=white" alt="RHEL"/>
<img src="https://img.shields.io/badge/Windows_Server-2016|2019|2022|2025-blue?style=flat-square&logo=windows&logoColor=white" alt="Windows Server"/>
<img src="https://img.shields.io/badge/Oracle_Solaris-11.4-red?style=flat-square&logo=oracle&logoColor=white" alt="Oracle Solaris"/>
<img src="https://img.shields.io/badge/Oracle_WebLogic-12c|14c|15c-red?style=flat-square&logo=oracle&logoColor=white" alt="Oracle WebLogic"/>
<img src="https://img.shields.io/badge/Python-3.6+-blue?style=flat-square&logo=python&logoColor=white" alt="Python 3.6+"/>

<br/><br/>

[![GitHub stars](https://img.shields.io/github/stars/azmankudus/compliance-rules?style=social)](https://github.com/azmankudus/compliance-rules/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/azmankudus/compliance-rules?style=social)](https://github.com/azmankudus/compliance-rules/network/members)
[![GitHub issues](https://img.shields.io/github/issues/azmankudus/compliance-rules)](https://github.com/azmankudus/compliance-rules/issues)
[![GitHub license](https://img.shields.io/github/license/azmankudus/compliance-rules)](https://github.com/azmankudus/compliance-rules/blob/main/LICENSE)

<br/>

**Automated security hardening rules based on CIS Benchmarks, DISA STIGs, and vendor documentation**

*Machine-readable • Standards-compliant • Production-ready*

<br/>

[Quick Start](#-quick-start) • [Available Rules](#-available-compliance-rules) • [Documentation](#-rule-structure) • [Contributing](#-contributing)

</div>

---

## Overview

This repository provides **machine-readable compliance rules** in YAML format, designed for automated security assessment and remediation of enterprise systems.

### Why Use This Repository?

- **Official Sources** - All rules sourced from CIS, DISA STIG, and vendor official documentation
- **Machine-Readable** - Structured YAML format for easy automation
- **Schema Validated** - JSON Schema validation for data integrity
- **Production Ready** - Tested and verified rules from real-world deployments
- **Extensible** - Easy to add new products and compliance frameworks
- **Open Source** - Free to use, modify, and distribute

---

## Features

| Security Hardening | Easy Integration |
|---------------------|------------------|
| CIS Benchmarks (Level 1 & 2) | YAML Format |
| DISA STIG (CAT I, II, III) | Schema Validation |
| Vendor Documentation | Tagging System |
| Automated Checks | Metadata Rich |

---

## Directory Structure

```
compliance-rules/
├── docs/
│   ├── schema.json              # JSON Schema definition
│   └── schema.yaml              # YAML Schema (reference)
│
├── rules/
│   ├── redhat/                  # Red Hat products
│   │   ├── rhel-7/              # RHEL 7
│   │   ├── rhel-8/              # RHEL 8
│   │   ├── rhel-9/              # RHEL 9
│   │   └── rhel-10/             # RHEL 10
│   │
│   ├── microsoft/               # Microsoft products
│   │   ├── windowsserver-2016/  # Windows Server 2016
│   │   ├── windowsserver-2019/  # Windows Server 2019
│   │   ├── windowsserver-2022/  # Windows Server 2022
│   │   └── windowsserver-2025/  # Windows Server 2025
│   │
│   └── oracle/                  # Oracle products
│       ├── solaris-11.4/        # Solaris 11.4
│       ├── weblogic-12c/        # WebLogic 12c
│       ├── weblogic-14c/        # WebLogic 14c
│       ├── weblogic-15c/        # WebLogic 15c
│       └── http-server-12c/     # HTTP Server 12c
│
├── scripts/                     # Utility scripts
│   ├── download-stig-json.sh    # Download STIG catalog
│   └── download-cis-json.sh     # Download CIS catalog
│
└── .agent/                      # Agent configuration
    ├── context.md               # Project context
    ├── sources.md               # Information sources
    ├── guidelines.md            # Creation guidelines
    └── prompt.md                # Output templates
```

---

## File Naming Convention

### Format

```
<vendor>-<product>-<version>-<framework>-<type>-<doc-version>[-additional-info].yaml
```

### Components

| Component | Description | Examples |
|-----------|-------------|----------|
| **vendor** | Full vendor name | `redhat`, `microsoft`, `oracle` |
| **product** | Product name (no spaces) | `rhel`, `windowsserver`, `solaris`, `weblogic` |
| **version** | Product version | `10`, `2022`, `114`, `12c` |
| **framework** | Compliance source | `cis`, `stig`, `redhat`, `oracle` |
| **type** | Rule category | `level1`, `level2`, `cat1`, `cat2`, `cat3`, `security` |
| **doc-version** | Document version | `v1.0.0`, `v2r7`, `v3.0.0` |
| **additional-info** | Optional suffix | `server`, `workstation`, `dc`, `ms`, `x86`, `sparc` |

### Examples

```bash
# CIS Benchmarks
redhat-rhel-10-cis-level1-v1.0.1-server.yaml
redhat-rhel-10-cis-level1-v1.0.1-workstation.yaml
microsoft-windowsserver-2022-cis-level1-v3.0.0-dc.yaml
microsoft-windowsserver-2022-cis-level1-v3.0.0-ms.yaml

# DISA STIG
redhat-rhel-9-stig-cat1-v2r7.yaml
microsoft-windowsserver-2022-stig-cat1-v2r3.yaml
oracle-solaris-114-stig-cat1-v1r0-x86.yaml
oracle-solaris-114-stig-cat1-v1r0-sparc.yaml

# Vendor Documentation
redhat-rhel-10-redhat-security-1.0.0.yaml
oracle-weblogic-12c-oracle-security-1.0.0.yaml
```

---

## Available Compliance Rules

### Red Hat Enterprise Linux

| Version | CIS | STIG | Vendor Docs | Total |
|---------|-----|------|-------------|-------|
| RHEL 7 | - | 3 files (CAT I/II/III) | 1 file | 4 |
| RHEL 8 | 4 files (L1/L2 Server/Workstation) | 3 files (CAT I/II/III) | 1 file | 8 |
| RHEL 9 | 4 files (L1/L2 Server/Workstation) | 3 files (CAT I/II/III) | 1 file | 8 |
| RHEL 10 | 4 files (L1/L2 Server/Workstation) | - | 1 file | 5 |

### Microsoft Windows Server

| Version | CIS | STIG | Total |
|---------|-----|------|-------|
| 2016 | 4 files (L1/L2 DC/MS) | - | 4 |
| 2019 | 4 files (L1/L2 DC/MS) | 3 files (CAT I/II/III) | 7 |
| 2022 | 4 files (L1/L2 DC/MS) | 3 files (CAT I/II/III) | 7 |
| 2025 | 4 files (L1/L2 DC/MS) | - | 4 |

### Oracle Products

| Product | STIG | Vendor Docs | Total |
|---------|------|-------------|-------|
| Solaris 11.4 | 6 files (CAT I/II/III x86/SPARC) | - | 6 |
| WebLogic 12c | 3 files (CAT I/II/III) | 1 file | 4 |
| WebLogic 14c | - | 1 file | 1 |
| WebLogic 15c | - | 1 file | 1 |
| HTTP Server 12c | - | 1 file | 1 |

---

## Quick Start

### Prerequisites

- Python 3.6+
- PyYAML and jsonschema packages

### Installation

```bash
# Clone the repository
git clone https://github.com/azmankudus/compliance-rules.git
cd compliance-rules

# Install dependencies
pip install pyyaml jsonschema
```

### Quick Examples

#### Load a Compliance File

```python
import yaml

with open('rules/redhat/rhel-10/redhat-rhel-10-cis-level1-v1.0.1-server.yaml') as f:
    rules = yaml.safe_load(f)
    
print(f"Framework: {rules['compliance_info']['framework']}")
print(f"Total Rules: {len(rules['rules'])}")
```

#### Validate Against Schema

```python
import json, yaml
from jsonschema import validate

with open('docs/schema.json') as f:
    schema = json.load(f)

with open('rules/redhat/rhel-10/redhat-rhel-10-cis-level1-v1.0.1-server.yaml') as f:
    data = yaml.safe_load(f)
    validate(instance=data, schema=schema)
    print("Valid!")
```

#### Filter Rules by Severity

```python
import yaml

with open('rules/redhat/rhel-9/redhat-rhel-9-stig-cat2-v2r7.yaml') as f:
    data = yaml.safe_load(f)

high_severity = [
    rule for rule in data['rules']
    if rule['assessment']['severity'] == 'High'
]

print(f"Found {len(high_severity)} high severity rules")
```

---

## Rule Structure

### Complete Rule Example

```yaml
rule_id: RH-FIPS-001
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

### Field Descriptions

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `rule_id` | string | Yes | Unique identifier |
| `rule_name` | string | Yes | Short human-readable name |
| `rule_description` | string | Yes | Detailed description |
| `category` | string | Yes | Primary category |
| `subcategory` | string | No | Secondary category |
| `testing_status` | enum | No | `untested`, `partial`, `verified` |
| `assessment` | object | Yes | Assessment configuration |
| `remediation` | object | Yes | Remediation steps |
| `context` | object | No | Additional context |
| `tags` | array | No | Tags for filtering |

<details>
<summary>View Assessment Fields</summary>

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `severity` | enum | Yes | `Critical`, `High`, `Medium`, `Low`, `Informational` |
| `is_auto` | boolean | Yes | Can be automated |
| `automation_level` | enum | No | `Full`, `Partial`, `Manual` |
| `audit_type` | string | Yes | Type of audit (config, runtime, log) |
| `detection_step` | string | Yes | Step-by-step detection |
| `check_command` | string | No | Command to check compliance |
| `expected_value` | string | No | Expected result |

</details>

<details>
<summary>View Remediation Fields</summary>

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `remediation_step` | string | Yes | Step-by-step fix |
| `rollback_supported` | boolean | No | Can be rolled back |
| `reboot_required` | boolean | No | Requires reboot |
| `service_impact` | string | No | Impact description |
| `estimated_time` | string | No | Time estimate |

</details>

---

## Integration

### Compatible Tools

| Tool | Use Case |
|------|----------|
| **OpenSCAP** | Convert to XCCDF/OVAL format |
| **Ansible** | Generate remediation playbooks |
| **Terraform** | Infrastructure as code compliance |
| **Puppet** | Configuration management |
| **Chef** | Infrastructure automation |
| **Custom Tools** | Build your own scanner |

### Ansible Playbook Generator Example

```python
import yaml

def generate_ansible_playbook(yaml_file, output_file):
    with open(yaml_file) as f:
        data = yaml.safe_load(f)
    
    tasks = []
    for rule in data['rules']:
        if rule['assessment']['is_auto']:
            tasks.append({
                'name': rule['rule_name'],
                'command': rule['assessment']['check_command'],
                'register': f"{rule['rule_id']}_result",
                'changed_when': False
            })
    
    playbook = [{'hosts': 'all', 'become': 'yes', 'tasks': tasks}]
    
    with open(output_file, 'w') as f:
        yaml.dump(playbook, f)

generate_ansible_playbook(
    'rules/redhat/rhel-10/redhat-rhel-10-cis-level1-v1.0.1-server.yaml',
    'compliance-scan.yml'
)
```

---

## Sources & References

### Official Benchmarks

| Framework | Source | URL |
|-----------|--------|-----|
| **CIS** | CIS Benchmarks | https://www.cisecurity.org/benchmark/ |
| **STIG** | DISA Cyber.mil | https://www.cyber.mil/stigs/downloads/ |
| **STIG** | STIG Viewer | https://www.stigviewer.com/stigs |
| **Red Hat** | Red Hat Documentation | https://docs.redhat.com/ |
| **Microsoft** | Microsoft Learn | https://learn.microsoft.com/ |
| **Oracle** | Oracle Documentation | https://docs.oracle.com/ |

---

## Contributing

We welcome contributions! Here's how you can help:

### Ways to Contribute

- **Report Bugs** - Found an issue? Let us know!
- **Suggest Features** - Have an idea? Share it!
- **Improve Docs** - Help us clarify
- **Submit Rules** - Add new compliance rules

### Contribution Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Follow the schema in `docs/schema.json`
4. Source rules from official compliance bodies or vendor documentation
5. Test validation before submitting
6. Commit your changes (`git commit -m 'Add amazing feature'`)
7. Push to the branch (`git push origin feature/amazing-feature`)
8. Open a Pull Request

### Contribution Guidelines

- All rules must be from official sources (CIS, DISA, vendor documentation)
- Follow the existing file naming convention
- Validate YAML syntax and schema compliance
- Include proper metadata and tags
- Test remediation steps

---

## License

This project is licensed under the terms specified in the [LICENSE](LICENSE) file.

### Disclaimer

The compliance rules in this repository are provided "as is" without warranty of any kind. Users should:

- Verify rules against official benchmark sources
- Test rules in non-production environments first
- Review and adapt rules for their specific environment
- Consult with compliance experts for critical systems

---

<div align="center">

### Star This Repository

If you find this project useful, please consider giving it a star!

[![Star](https://img.shields.io/github/stars/azmankudus/compliance-rules?style=social)](https://github.com/azmankudus/compliance-rules/stargazers)

<br/>

**Built with security professionals, for security professionals**

[Back to Top](#-compliance-rules)

</div>
