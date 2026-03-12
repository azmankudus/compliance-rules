# Compliance Rules Project Context

## Project Overview
Machine-readable compliance rules in YAML format for automated security assessment and remediation.

## Directory Structure

```
compliance-rules/
├── docs/
│   ├── schema.json          # JSON Schema (authoritative)
│   └── schema.yaml          # YAML Schema
├── rules/                    # All compliance rules
│   └── <vendor>/            # rh, ms, ora
│       └── <product>-<version>/ # rhel-9, ws-2022
│           ├── cis/         # CIS Benchmark rules
│           └── stig/        # DISA STIG rules
└── .agent/                   # Agent configuration
```

## Vendor Abbreviations
| Vendor | Abbreviation |
|--------|--------------|
| Red Hat | `rh` |
| Microsoft | `ms` |
| Oracle | `ora` |

## File Naming Convention

### Format
```
<vendor>-<product>-<version>-<framework>-<level>-<benchmark-version>.yaml
```

### CIS Examples
- `rh-rhel-9-cis-level1-server-v2.0.0.yaml`
- `ms-ws-2022-cis-level1-dc-v3.0.0.yaml`
- `ms-ws-2022-cis-level1-ms-v3.0.0.yaml`

### STIG Examples
- `rh-rhel-9-stig-cat1-v2r7.yaml`
- `ms-ws-2022-stig-cat1-v2r3.yaml`

## Compliance Levels

### CIS Profiles
| Level | Suffix | Description |
|-------|--------|-------------|
| Level 1 Server | `level1-server` | Baseline security for servers |
| Level 2 Server | `level2-server` | Enhanced hardening for servers |
| Level 1 Workstation | `level1-workstation` | Baseline for workstations |
| Level 2 Workstation | `level2-workstation` | Enhanced for workstations |
| Level 1 DC | `level1-dc` | Domain Controller baseline |
| Level 1 MS | `level1-ms` | Member Server baseline |
| Level 2 DC | `level2-dc` | Domain Controller enhanced |
| Level 2 MS | `level2-ms` | Member Server enhanced |

### STIG Categories
| Category | Suffix | Severity |
|----------|--------|----------|
| CAT I | `cat1` | High - Critical |
| CAT II | `cat2` | Medium - Standard |
| CAT III | `cat3` | Low - Best Practice |

## Severity Values
- `Critical`
- `High`
- `Medium`
- `Low`
- `Informational`

## Testing Status Values
- `untested`
- `partial`
- `verified`
