# Compliance Rules Agent Configuration

This directory contains agent configuration files to prevent hallucinations when creating compliance rules.

## Files

| File | Purpose |
|------|---------|
| `skill.md` | Agent skill definition and capabilities |
| `context.md` | Project context, structure, and conventions |
| `sources.md` | Official information sources and search sequences |
| `prompt.md` | Output structure templates and task prompts |
| `guidelines.md` | Detailed guidelines for rule creation |

## Usage

When an agent is tasked with creating compliance rules:

1. **Read Context**: Load `context.md` to understand project structure
2. **Follow Sources**: Use `sources.md` to find official information
3. **Use Templates**: Follow `prompt.md` for output structure
4. **Apply Guidelines**: Follow `guidelines.md` for rule creation

## Key Principles

1. **Source First** - Always source from official benchmarks or vendor documentation
2. **Latest Version** - Always use the most recent version
3. **Schema Compliance** - All rules must validate against schema
4. **No Hallucination** - Never fabricate compliance content

## Directory Structure

```
rules/
├── redhat/                          # Red Hat vendor folder
│   ├── rhel-7/                      # RHEL 7 product
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
<vendor>-<product>-<version>-<framework>-<type>-<doc-version>[-additional-info].yaml
```

### Examples
- `redhat-rhel-9-cis-level1-v2.0.0-server.yaml`
- `redhat-rhel-9-stig-cat1-v2r7.yaml`
- `microsoft-windowsserver-2022-cis-level1-v3.0.0-dc.yaml`
- `microsoft-windowsserver-2022-stig-cat1-v2r3.yaml`
- `oracle-solaris-114-stig-cat1-v1r0-sparc.yaml`

## STIG Search Sequence

1. https://www.cyber.mil/stigs/downloads/ (PRIMARY)
2. https://www.stigviewer.com/stigs (SECONDARY)
3. https://cyber.trackr.live/stig (TERTIARY)

## CIS Source

- https://www.cisecurity.org/benchmark/

## Vendor Documentation Sources

- **Red Hat:** https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/
- **Microsoft:** https://learn.microsoft.com/en-us/windows-server/
- **Oracle:** https://docs.oracle.com/en/middleware/

## Validation

All YAML files must validate against:
- `docs/schema.json` (authoritative)
- `docs/schema.yaml` (reference)
