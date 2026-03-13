# Agent Instructions for Compliance Rules

This repository contains machine-readable compliance rules in YAML format for automated security assessment and remediation.

## Project Overview

- **Purpose**: Security hardening rules based on CIS Benchmarks, DISA STIGs, and vendor official documentation
- **Format**: YAML files validated against JSON Schema
- **Schema**: `docs/schema.json`

## Key Files

- `.agent/` - Agent configuration files (READ THESE FIRST)
- `docs/schema.json` - Authoritative schema definition
- `docs/schema.yaml` - YAML schema reference
- `scripts/download-stig-json.sh` - Download latest STIG catalog
- `scripts/download-cis-json.sh` - Download latest CIS catalog

## Directory Structure

```
rules/
├── redhat/                          # Red Hat vendor folder
│   ├── rhel-7/                      # RHEL 7 product
│   │   └── redhat-rhel-7-*.yaml     # All RHEL 7 rule files
│   ├── rhel-8/                      # RHEL 8 product
│   ├── rhel-9/                      # RHEL 9 product
│   └── rhel-10/                     # RHEL 10 product
├── microsoft/                       # Microsoft vendor folder
│   ├── windowsserver-2016/          # Windows Server 2016
│   ├── windowsserver-2019/          # Windows Server 2019
│   ├── windowsserver-2022/          # Windows Server 2022
│   └── windowsserver-2025/          # Windows Server 2025
└── oracle/                          # Oracle vendor folder
    ├── solaris-11.4/                # Solaris 11.4
    ├── weblogic-12c/                # WebLogic 12c
    ├── weblogic-14c/                # WebLogic 14c
    ├── weblogic-15c/                # WebLogic 15c
    └── http-server-12c/             # HTTP Server 12c
```

## File Naming Convention

```
rules/<vendor>/<product>-<version>/<vendor>-<product>-<version>-<framework>-<type>-<doc-version>[-additional-info].yaml
```

### Components

| Component | Description | Examples |
|-----------|-------------|----------|
| `<vendor>` | Full vendor name | `redhat`, `microsoft`, `oracle` |
| `<product>` | Product name (no spaces) | `rhel`, `windowsserver`, `solaris` |
| `<version>` | Product version | `10`, `2022`, `114`, `12c` |
| `<framework>` | Compliance source | `cis`, `stig`, `redhat`, `oracle` |
| `<type>` | Rule type/category | `level1`, `level2`, `cat1`, `cat2`, `cat3`, `security` |
| `<doc-version>` | Document version | `v1.0.0`, `v2r7`, `v3.0.0` |
| `[-additional-info]` | Optional suffix | `server`, `workstation`, `dc`, `ms`, `x86`, `sparc` |

### Examples

```
redhat-rhel-10-cis-level1-v1.0.1-server.yaml
redhat-rhel-10-cis-level1-v1.0.1-workstation.yaml
redhat-rhel-9-stig-cat1-v2r7.yaml
redhat-rhel-10-redhat-security-1.0.0.yaml
microsoft-windowsserver-2022-cis-level1-v3.0.0-dc.yaml
microsoft-windowsserver-2022-cis-level1-v3.0.0-ms.yaml
microsoft-windowsserver-2022-stig-cat1-v2r3.yaml
oracle-solaris-114-stig-cat1-v1r0-x86.yaml
oracle-solaris-114-stig-cat1-v1r0-sparc.yaml
oracle-weblogic-12c-oracle-security-1.0.0.yaml
```

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

## CIS Lookup Workflow

When searching for CIS benchmark information:

1. **Check local cache:** `docs/cis-yyyyMMdd.json`
2. **If cache outdated (date != today):** Run `./scripts/download-cis-json.sh`
3. **Search JSON:** Use `jq` to find relevant CIS benchmarks
4. **Download benchmark:** Get the PDF from location in JSON

Example:
```bash
# Refresh cache if needed
./scripts/download-cis-json.sh

# Search for product
cat docs/cis-*.json | jq '.benchmarks[] | select(.title | test("RHEL"; "i")) | {title, version, published}'

# Get download link for specific benchmark
cat docs/cis-*.json | jq '.benchmarks[] | select(.title | contains("Windows Server 2022")) | .documents[0].location'
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

## Vendor Documentation Sources

- **Red Hat:** https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/
- **Microsoft:** https://learn.microsoft.com/en-us/windows-server/
- **Oracle:** https://docs.oracle.com/en/middleware/

## Anti-Hallucination Rules

1. NEVER fabricate compliance rules
2. ALWAYS source from official benchmarks or vendor documentation
3. ALWAYS verify version is latest
4. IF information not found, state clearly
5. IF rule not in official source, do not create it

## Validation

After creating/editing rules, run validation:

```bash
python3 -c "
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
