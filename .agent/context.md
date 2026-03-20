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
│   ├── redhat/              # Red Hat vendor (full name)
│   │   ├── rhel-7/          # RHEL 7
│   │   ├── rhel-8/          # RHEL 8
│   │   ├── rhel-9/          # RHEL 9
│   │   └── rhel-10/         # RHEL 10
│   ├── microsoft/           # Microsoft vendor (full name)
│   │   ├── windowsserver-2016/
│   │   ├── windowsserver-2019/
│   │   ├── windowsserver-2022/
│   │   └── windowsserver-2025/
│   ├── oracle/              # Oracle vendor (full name)
│   │   ├── solaris-11.4/
│   │   ├── weblogic-12c/
│   │   ├── weblogic-14c/
│   │   ├── weblogic-15c/
│   │   └── http-server-12c/
│   ├── elastic/             # Elastic vendor (full name)
│   │   └── elasticstack-8/  # Elastic Stack 8.x (ELK)
│   ├── kubernetes/          # Kubernetes platform
│   │   └── kubernetes-latest/
│   ├── docker/               # Docker platform
│   │   └── docker-latest/
│   └── podman/               # Podman platform
│       └── podman-latest/
├── scripts/                  # Utility scripts
│   ├── download-stig-json.sh # Script to download STIG JSON
│   ├── download-cis-json.sh  # Script to download CIS JSON
│   └── compliance_runner.sh  # Pure Bash compliance execution runner
└── .agent/                   # Agent configuration
```
compliance-rules/
├── docs/
│   ├── schema.json          # JSON Schema (authoritative)
│   └── schema.yaml          # YAML Schema
├── rules/                    # All compliance rules
│   ├── redhat/              # Red Hat vendor (full name)
│   │   ├── rhel-7/          # RHEL 7
│   │   ├── rhel-8/          # RHEL 8
│   │   ├── rhel-9/          # RHEL 9
│   │   └── rhel-10/         # RHEL 10
│   ├── microsoft/           # Microsoft vendor (full name)
│   │   ├── windowsserver-2016/
│   │   ├── windowsserver-2019/
│   │   ├── windowsserver-2022/
│   │   └── windowsserver-2025/
│   ├── oracle/              # Oracle vendor (full name)
│   │   ├── solaris-11.4/
│   │   ├── weblogic-12c/
│   │   ├── weblogic-14c/
│   │   ├── weblogic-15c/
│   │   └── http-server-12c/
│   ├── elastic/             # Elastic vendor (full name)
│   │   └── elasticstack-8/  # Elastic Stack 8.x (ELK)
│   ├── kubernetes/          # Kubernetes platform
│   │   └── kubernetes-latest/
│   ├── docker/              # Docker platform
│   │   └── docker-latest/
│   └── podman/              # Podman platform
│       └── podman-latest/
└── .agent/                   # Agent configuration
```
└── .agent/                   # Agent configuration
```

## Vendor Names (Full Names)

| Vendor | Directory Name | File Prefix |
|--------|----------------|-------------|
| Red Hat | `redhat` | `redhat-` |
| Microsoft | `microsoft` | `microsoft-` |
| Oracle | `oracle` | `oracle-` |
| Elastic | `elastic` | `elastic-` |
| Kubernetes | `kubernetes` | `kubernetes-` |
| Docker | `docker` | `docker-` |
| Podman | `podman` | `podman-` |

## Product Names (No Spaces)

| Product | Directory Name | File Component |
|---------|----------------|----------------|
| Red Hat Enterprise Linux | `rhel-<version>` | `rhel-<version>` |
| Windows Server | `windowsserver-<version>` | `windowsserver-<version>` |
| Solaris | `solaris-<version>` | `solaris-<version>` |
| WebLogic Server | `weblogic-<version>` | `weblogic-<version>` |
| HTTP Server | `http-server-<version>` | `httpserver-<version>` |
| Elastic Stack | `elasticstack-<version>` | `elasticstack-<version>` |

## File Naming Convention

### Format
```
<vendor>-<product>-<version>-<framework>-<type>-<doc-version>[-additional-info].yaml
```

### Key Rules
1. **Vendor/Product/Version** - Use full names without abbreviations
2. **Framework** - Source of compliance rules (cis, stig, redhat, oracle)
3. **Type** - Rule category (level1, level2, cat1, cat2, cat3, security)
4. **Doc Version** - Benchmark version (v1.0.0, v2r7, etc.)
5. **Additional Info** - ALWAYS at the end (server, workstation, dc, ms, x86, sparc)

### CIS Examples
```
redhat-rhel-10-cis-level1-v1.0.1-server.yaml
redhat-rhel-10-cis-level1-v1.0.1-workstation.yaml
redhat-rhel-10-cis-level2-v1.0.1-server.yaml
microsoft-windowsserver-2022-cis-level1-v3.0.0-dc.yaml
microsoft-windowsserver-2022-cis-level1-v3.0.0-ms.yaml
```

### STIG Examples
```
redhat-rhel-9-stig-cat1-v2r7.yaml
redhat-rhel-9-stig-cat2-v2r7.yaml
microsoft-windowsserver-2022-stig-cat1-v2r3.yaml
oracle-solaris-114-stig-cat1-v1r0-x86.yaml
oracle-solaris-114-stig-cat1-v1r0-sparc.yaml
oracle-weblogic-12c-stig-cat1-v2r2.yaml
```

### Vendor Documentation Examples
```
redhat-rhel-10-redhat-security-1.0.0.yaml
oracle-weblogic-12c-oracle-security-1.0.0.yaml
oracle-httpserver-12c-oracle-security-1.0.0.yaml
elastic-elasticstack-8-elastic-security-1.0.0.yaml
```

## Compliance Levels

### CIS Profiles
| Level | Type Suffix | Additional Info | Description |
|-------|-------------|-----------------|-------------|
| Level 1 Server | `level1` | `-server` | Baseline security for servers |
| Level 2 Server | `level2` | `-server` | Enhanced hardening for servers |
| Level 1 Workstation | `level1` | `-workstation` | Baseline for workstations |
| Level 2 Workstation | `level2` | `-workstation` | Enhanced for workstations |
| Level 1 DC | `level1` | `-dc` | Domain Controller baseline |
| Level 1 MS | `level1` | `-ms` | Member Server baseline |
| Level 2 DC | `level2` | `-dc` | Domain Controller enhanced |
| Level 2 MS | `level2` | `-ms` | Member Server enhanced |

### STIG Categories
| Category | Type Suffix | Severity |
|----------|-------------|----------|
| CAT I | `cat1` | High - Critical |
| CAT II | `cat2` | Medium - Standard |
| CAT III | `cat3` | Low - Best Practice |

### Vendor Security
| Source | Type Suffix | Description |
|--------|-------------|-------------|
| Red Hat Docs | `security` | Red Hat official security documentation |
| Oracle Docs | `security` | Oracle official security documentation |

## Additional Info Suffixes

| Suffix | Meaning | Example |
|--------|---------|---------|
| `server` | Server profile | `*-server.yaml` |
| `workstation` | Workstation profile | `*-workstation.yaml` |
| `dc` | Domain Controller | `*-dc.yaml` |
| `ms` | Member Server | `*-ms.yaml` |
| `x86` | x86 architecture | `*-x86.yaml` |
| `sparc` | SPARC architecture | `*-sparc.yaml` |

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

## Framework Sources

| Framework | Source | Used For |
|-----------|--------|----------|
| `cis` | CIS Benchmarks | All products |
| `stig` | DISA STIGs | All products |
| `redhat` | Red Hat Documentation | RHEL products |
| `oracle` | Oracle Documentation | Oracle products |
| `elastic` | Elastic Documentation | Elastic Stack |
| `kubernetes` | Kubernetes Documentation | Kubernetes |
| `docker` | Docker Documentation | Docker |
| `podman` | Podman Documentation | Podman |
