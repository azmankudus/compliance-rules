<div align="center">

# 🔒 Compliance Rules

<img src="https://img.shields.io/badge/Security-Hardening-critical?style=for-the-badge&logo=shield&logoColor=white&color=dc3545" alt="Security Hardening"/>
<img src="https://img.shields.io/badge/YAML-Format-informational?style=for-the-badge&logo=yaml&logoColor=white&color=17a2b8" alt="YAML Format"/>
<img src="https://img.shields.io/badge/Open_Source-Yes-success?style=for-the-badge&logo=opensourceinitiative&logoColor=white&color=28a745" alt="Open Source"/>

<br/><br/>

<img src="https://img.shields.io/badge/CIS-Benchmarks-success?style=flat-square&logo=centerforinternetsecurity&logoColor=white" alt="CIS Benchmarks"/>
<img src="https://img.shields.io/badge/DISA-STIG-critical?style=flat-square&logo=usdepartmentofdefense&logoColor=white" alt="DISA STIG"/>
<img src="https://img.shields.io/badge/RHEL-9-orange?style=flat-square&logo=redhat&logoColor=white" alt="RHEL 9"/>
<img src="https://img.shields.io/badge/RHEL-8-orange?style=flat-square&logo=redhat&logoColor=white" alt="RHEL 8"/>
<img src="https://img.shields.io/badge/RHEL-10-orange?style=flat-square&logo=redhat&logoColor=white" alt="RHEL 10"/>
<img src="https://img.shields.io/badge/Windows_Server-2016-blue?style=flat-square&logo=windows&logoColor=white" alt="Windows Server 2016"/>
<img src="https://img.shields.io/badge/Windows_Server-2019-blue?style=flat-square&logo=windows&logoColor=white" alt="Windows Server 2019"/>
<img src="https://img.shields.io/badge/Windows_Server-2022-blue?style=flat-square&logo=windows&logoColor=white" alt="Windows Server 2022"/>
<img src="https://img.shields.io/badge/Windows_Server-2025-blue?style=flat-square&logo=windows&logoColor=white" alt="Windows Server 2025"/>
<img src="https://img.shields.io/badge/Oracle_Solaris-11.4-red?style=flat-square&logo=oracle&logoColor=white" alt="Oracle Solaris 11.4"/>
<img src="https://img.shields.io/badge/Oracle_WebLogic-12c-red?style=flat-square&logo=oracle&logoColor=white" alt="Oracle WebLogic 12c"/>
<img src="https://img.shields.io/badge/Python-3.6+-blue?style=flat-square&logo=python&logoColor=white" alt="Python 3.6+"/>

<br/><br/>

[![GitHub stars](https://img.shields.io/github/stars/azmankudus/compliance-rules?style=social)](https://github.com/azmankudus/compliance-rules/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/azmankudus/compliance-rules?style=social)](https://github.com/azmankudus/compliance-rules/network/members)
[![GitHub issues](https://img.shields.io/github/issues/azmankudus/compliance-rules)](https://github.com/azmankudus/compliance-rules/issues)
[![GitHub license](https://img.shields.io/github/license/azmankudus/compliance-rules)](https://github.com/azmankudus/compliance-rules/blob/main/LICENSE)

<br/>

**Automated security hardening rules based on CIS Benchmarks and DISA STIGs**

*Machine-readable • Standards-compliant • Production-ready*

<br/>

[🚀 Quick Start](#-quick-start) • [📊 Available Rules](#-available-compliance-rules) • [📖 Documentation](#-rule-structure) • [🤝 Contributing](#-contributing)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Folder Structure](#-folder-structure)
- [File Naming Convention](#-file-naming-convention)
- [Available Compliance Rules](#-available-compliance-rules)
- [Quick Start](#-quick-start)
- [Rule Structure](#-rule-structure)
- [Integration](#-integration)
- [Statistics](#-statistics)
- [Sources](#-sources)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 Overview

This repository provides **machine-readable compliance rules** in YAML format, designed for automated security assessment and remediation of enterprise systems.

### Why Use This Repository?

✅ **Official Sources** - All rules sourced from CIS and DISA STIG official benchmarks  
✅ **Machine-Readable** - Structured YAML format for easy automation  
✅ **Schema Validated** - JSON Schema validation for data integrity  
✅ **Production Ready** - Tested and verified rules from real-world deployments  
✅ **Extensible** - Easy to add new products and compliance frameworks  
✅ **Open Source** - Free to use, modify, and distribute  

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🔐 Security Hardening

- **CIS Benchmarks** - Level 1 & 2 profiles
- **DISA STIG** - CAT I, II, III controls
- **Automated Checks** - Command-based detection
- **Remediation Steps** - Clear fix instructions

</td>
<td width="50%">

### 📦 Easy Integration

- **YAML Format** - Universal compatibility
- **Schema Validation** - Data integrity
- **Tagging System** - Easy filtering
- **Metadata Rich** - Comprehensive context

</td>
</tr>
</table>

---

## 📂 Folder Structure

```
compliance-rules/
├── 📄 docs/
│   ├── schema.json              # JSON Schema definition
│   └── schema.yaml              # YAML Schema (original)
│
├── 🏢 <vendor_abbr>/
│   └── 📦 <product_abbr>-<product_version>/
│       ├── 📋 <compliance_body>/
│       │   └── 📄 <vendor>-<product>-<version>-<body>-<level>-<version>.yaml
│       └── 📄 README.md
│
└── 📄 README.md
```

### Directory Breakdown

| Directory | Purpose | Example |
|-----------|---------|---------|
| `docs/` | Schema definitions | `schema.json`, `schema.yaml` |
| `rh/` | Red Hat products | Red Hat vendor |
| `rh/rhel-9/` | RHEL version 9 | Product version |
| `rh/rhel-9/cis/` | CIS framework | Compliance body |
| `rh/rhel-9/stig/` | STIG framework | Compliance body |

---

## 📝 File Naming Convention

### Format

```
<vendor>-<product>-<version>-<framework>-<level>-<benchmark-version>.yaml
```

### Components

| Component | Description | Examples |
|-----------|-------------|----------|
| **vendor** | Vendor abbreviation | `rh` (Red Hat), `ms` (Microsoft), `ora` (Oracle) |
| **product** | Product abbreviation | `rhel`, `ws` (Windows Server), `oel` (Oracle Linux) |
| **version** | Product version | `9`, `2022`, `8` |
| **framework** | Compliance framework | `cis`, `stig`, `nist`, `pci-dss` |
| **level** | Profile/Category | See [Compliance Levels](#compliance-levels) |
| **benchmark-version** | Benchmark version | `v2.0.0`, `v2r7` |

### Compliance Levels

#### CIS Benchmarks

| Level | Type | Description |
|-------|------|-------------|
| `level1-server` | 🟢 Baseline | Practical security for servers |
| `level2-server` | 🟡 Enhanced | Additional hardening for servers |
| `level1-workstation` | 🟢 Baseline | Practical security for workstations |
| `level2-workstation` | 🟡 Enhanced | Additional hardening for workstations |

#### DISA STIG

| Category | Severity | Description |
|----------|----------|-------------|
| `cat1` | 🔴 High | Critical - Immediate action required |
| `cat2` | 🟡 Medium | Standard - Action required |
| `cat3` | 🟢 Low | Best practice - Recommended |

### Examples

```bash
# CIS Level 1 Server for RHEL 9
rh-rhel-9-cis-level1-server-v2.0.0.yaml

# DISA STIG CAT I for RHEL 9
rh-rhel-9-stig-cat1-v2r7.yaml

# Future: Windows Server 2022
ms-ws-2022-cis-level1-member-v3.0.0.yaml
```

---

## 📊 Available Compliance Rules

### 🐧 Red Hat Enterprise Linux 9

#### CIS Benchmarks

| Document | Level | Profile | Rules | Description | Status |
|----------|------|---------|-------|-------------|--------|
| [Level 1 Server](rh/rhel-9/cis/rh-rhel-9-cis-level1-server-v2.0.0.yaml) | 🟢 Baseline | Server | 31 | Practical security for servers | ✅ Verified |
| [Level 2 Server](rh/rhel-9/cis/rh-rhel-9-cis-level2-server-v2.0.0.yaml) | 🟡 Enhanced | Server | 4 | Additional hardening | ✅ Verified |
| [Level 1 Workstation](rh/rhel-9/cis/rh-rhel-9-cis-level1-workstation-v2.0.0.yaml) | 🟢 Baseline | Workstation | 6 | Desktop security baseline | ✅ Verified |
| [Level 2 Workstation](rh/rhel-9/cis/rh-rhel-9-cis-level2-workstation-v2.0.0.yaml) | 🟡 Enhanced | Workstation | 3 | Enhanced desktop security | ✅ Verified |

#### DISA STIG

| Document | Category | Severity | Rules | Description | Status |
|----------|----------|----------|-------|-------------|--------|
| [CAT I](rh/rhel-9/stig/rh-rhel-9-stig-cat1-v2r7.yaml) | 🔴 CAT I | High | 20 | Critical controls - Immediate action | ✅ Verified |
| [CAT II](rh/rhel-9/stig/rh-rhel-9-stig-cat2-v2r7.yaml) | 🟡 CAT II | Medium | 414 | Standard controls - Required | ✅ Verified |
| [CAT III](rh/rhel-9/stig/rh-rhel-9-stig-cat3-v2r7.yaml) | 🟢 CAT III | Low | 16 | Best practices - Recommended | ✅ Verified |

<details>
<summary>📊 View Coverage Summary</summary>

| Framework | Product | Total Rules | High | Medium | Low |
|-----------|---------|-------------|------|--------|-----|
| CIS | RHEL 9 Server | 35 | 8 | 27 | 0 |
| CIS | RHEL 9 Workstation | 9 | 2 | 7 | 0 |
| STIG | RHEL 9 | 450 | 20 | 414 | 16 |
| CIS | RHEL 8 Server | 7 | 2 | 5 | 0 |
| CIS | RHEL 8 Workstation | 4 | 1 | 3 | 0 |
| STIG | RHEL 8 | 369 | 22 | 320 | 27 |
| CIS | RHEL 10 Server | 302 | 75 | 227 | 0 |
| CIS | RHEL 10 Workstation | 297 | 74 | 223 | 0 |
| CIS | WS 2016 DC | 311 | 77 | 234 | 0 |
| CIS | WS 2016 MS | 323 | 80 | 243 | 0 |
| CIS | WS 2019 DC | 420 | 105 | 315 | 0 |
| CIS | WS 2019 MS | 420 | 105 | 315 | 0 |
| STIG | WS 2019 | 275 | 34 | 227 | 14 |
| **Total** | | **3222** | **605** | **2552** | **57** |

</details>

---

### 🐧 Red Hat Enterprise Linux 8

#### CIS Benchmarks

| Document | Level | Profile | Rules | Description | Status |
|----------|------|---------|-------|-------------|--------|
| [Level 1 Server](rh/rhel-8/cis/rh-rhel-8-cis-level1-server-v4.0.0.yaml) | 🟢 Baseline | Server | 5 | Practical security for servers | ✅ Verified |
| [Level 2 Server](rh/rhel-8/cis/rh-rhel-8-cis-level2-server-v4.0.0.yaml) | 🟡 Enhanced | Server | 2 | Additional hardening | ✅ Verified |
| [Level 1 Workstation](rh/rhel-8/cis/rh-rhel-8-cis-level1-workstation-v4.0.0.yaml) | 🟢 Baseline | Workstation | 2 | Desktop security baseline | ✅ Verified |
| [Level 2 Workstation](rh/rhel-8/cis/rh-rhel-8-cis-level2-workstation-v4.0.0.yaml) | 🟡 Enhanced | Workstation | 2 | Enhanced desktop security | ✅ Verified |

#### DISA STIG

| Document | Category | Severity | Rules | Description | Status |
|----------|----------|----------|-------|-------------|--------|
| [CAT I](rh/rhel-8/stig/rh-rhel-8-stig-cat1-v2r2.yaml) | 🔴 CAT I | High | 22 | Critical controls - Immediate action | ✅ Verified |
| [CAT II](rh/rhel-8/stig/rh-rhel-8-stig-cat2-v2r2.yaml) | 🟡 CAT II | Medium | 320 | Standard controls - Required | ✅ Verified |
| [CAT III](rh/rhel-8/stig/rh-rhel-8-stig-cat3-v2r2.yaml) | 🟢 CAT III | Low | 27 | Best practices - Recommended | ✅ Verified |

<details>
<summary>📊 View Coverage Summary</summary>

| Framework | Product | Total Rules | High | Medium | Low |
|-----------|---------|-------------|------|--------|-----|
| CIS | RHEL 8 Server | 7 | 2 | 5 | 0 |
| CIS | RHEL 8 Workstation | 4 | 1 | 3 | 0 |
| STIG | RHEL 8 | 369 | 22 | 320 | 27 |
| **Total** | | **380** | **25** | **328** | **27** |

</details>

---

### 🐧 Red Hat Enterprise Linux 10

#### CIS Benchmarks

| Document | Level | Profile | Rules | Description | Status |
|----------|------|---------|-------|-------------|--------|
| [Level 1 Server](rh/rhel-10/cis/rh-rhel-10-cis-level1-server-v1.0.1.yaml) | 🟢 Baseline | Server | 225 | Practical security for servers | ✅ Verified |
| [Level 2 Server](rh/rhel-10/cis/rh-rhel-10-cis-level2-server-v1.0.1.yaml) | 🟡 Enhanced | Server | 77 | Additional hardening | ✅ Verified |
| [Level 1 Workstation](rh/rhel-10/cis/rh-rhel-10-cis-level1-workstation-v1.0.1.yaml) | 🟢 Baseline | Workstation | 219 | Desktop security baseline | ✅ Verified |
| [Level 2 Workstation](rh/rhel-10/cis/rh-rhel-10-cis-level2-workstation-v1.0.1.yaml) | 🟡 Enhanced | Workstation | 78 | Enhanced desktop security | ✅ Verified |

#### DISA STIG

> ⚠️ **Not Yet Available** - DISA STIG for RHEL 10 has not been released yet. This section will be updated when available.

<details>
<summary>📊 View Coverage Summary</summary>

| Framework | Product | Total Rules | High | Medium | Low |
|-----------|---------|-------------|------|--------|-----|
| CIS | RHEL 10 Server | 302 | 75 | 227 | 0 |
| CIS | RHEL 10 Workstation | 297 | 74 | 223 | 0 |
| STIG | RHEL 10 | - | - | - | - |
| **Total** | | **599** | **149** | **450** | **0** |

</details>

---

### 🪟 Windows Server 2016

#### CIS Benchmarks

| Document | Level | Profile | Rules | Description | Status |
|----------|------|---------|-------|-------------|--------|
| [Level 1 DC](ms/ws-2016/cis/ms-ws-2016-cis-level1-dc-v4.0.0.yaml) | 🟢 Baseline | Domain Controller | 256 | Baseline security for domain controllers | ✅ Verified |
| [Level 1 MS](ms/ws-2016/cis/ms-ws-2016-cis-level1-ms-v4.0.0.yaml) | 🟢 Baseline | Member Server | 264 | Baseline security for member servers | ✅ Verified |
| [Level 2 DC](ms/ws-2016/cis/ms-ws-2016-cis-level2-dc-v4.0.0.yaml) | 🟡 Enhanced | Domain Controller | 55 | Enhanced security for domain controllers | ✅ Verified |
| [Level 2 MS](ms/ws-2016/cis/ms-ws-2016-cis-level2-ms-v4.0.0.yaml) | 🟡 Enhanced | Member Server | 59 | Enhanced security for member servers | ✅ Verified |

#### DISA STIG

> ⚠️ **Not Available** - DISA STIG for Windows Server 2016 is no longer available from official sources (likely retired). Consider using Windows Server 2019 or 2022 STIGs.

<details>
<summary>📊 View Coverage Summary</summary>

| Framework | Product | Total Rules | High | Medium | Low |
|-----------|---------|-------------|------|--------|-----|
| CIS | WS 2016 DC | 311 | 77 | 234 | 0 |
| CIS | WS 2016 MS | 323 | 80 | 243 | 0 |
| STIG | WS 2016 | - | - | - | - |
| **Total** | | **634** | **157** | **477** | **0** |

</details>

---

### 🪟 Windows Server 2022

#### CIS Benchmarks

| Document | Level | Profile | Rules | Description | Status |
|----------|------|---------|-------|-------------|--------|
| [Level 1 DC](ms/ws-2022/cis/ms-ws-2022-cis-level1-dc-v3.0.0.yaml) | 🟢 Baseline | Domain Controller | 247 | Baseline security for domain controllers | ✅ Verified |
| [Level 1 MS](ms/ws-2022/cis/ms-ws-2022-cis-level1-ms-v3.0.0.yaml) | 🟢 Baseline | Member Server | 247 | Baseline security for member servers | ✅ Verified |
        [Level 2 DC](ms/ws-2022/cis/ms-ws-2022-cis-level2-dc-v3.0.0.yaml) | 🟡 Enhanced | Domain Controller | 198 | Enhanced security for domain controllers | ✅ Verified |
        [Level 2 MS](ms/ws-2022/cis/ms-ws-2022-cis-level2-ms-v3.0.0.yaml) | 🟡 Enhanced | Member Server | 198 | Enhanced security for member servers | ✅ Verified |

#### DISA STIG

| Document | Category | Severity | Rules | Description | Status |
|----------|----------|----------|-------|-------------|--------|
| [CAT I](ms/ws-2022/stig/ms-ws-2022-stig-cat1-v2r3.yaml) | 🔴 CAT I | High | 31 | Critical controls - Immediate action | ✅ Verified |
        [CAT II](ms/ws-2022/stig/ms-ws-2022-stig-cat2-v2r3.yaml) | 🟡 CAT II | Medium | 232 | Standard controls - Required | ✅ Verified |
        [CAT III](ms/ws-2022/stig/ms-ws-2022-stig-cat3-v2r3.yaml) | 🟢 CAT III | Low | 12 | Best practices - Recommended | ✅ Verified |

<details>
<summary>📊 View Coverage Summary</summary>

| Framework | Product | Total Rules | High | Medium | Low |
|-----------|---------|-------------|------|--------|-----|
| CIS | WS 2022 DC | 445 | 111 | 334 | 0 |
    CIS | WS 2022 MS | 445 | 111 | 334 | 0 |
    STIG | WS 2022 | 275 | 31 | 232 | 12 |
    **Total** |        **720** | **900** | **12** |

</details>

---

### 🪟 Windows Server 2025

#### CIS Benchmarks

| Document | Level | Profile | Rules | Description | Status |
|----------|------|---------|-------|-------------|--------|
| [Level 1 DC](ms/ws-2025/cis/ms-ws-2025-cis-level1-dc-v2.0.0.yaml) | 🟢 Baseline | Domain Controller | 247 | Baseline security for domain controllers | ✅ Verified |
| [Level 1 MS](ms/ws-2025/cis/ms-ws-2025-cis-level1-ms-v2.0.0.yaml) | 🟢 Baseline | Member Server | 247 | Baseline security for member servers | ✅ Verified |
| [Level 2 DC](ms/ws-2025/cis/ms-ws-2025-cis-level2-dc-v2.0.0.yaml) | 🟡 Enhanced | Domain Controller | 198 | Enhanced security for domain controllers | ✅ Verified |
| [Level 2 MS](ms/ws-2025/cis/ms-ws-2025-cis-level2-ms-v2.0.0.yaml) | 🟡 Enhanced | Member Server | 198 | Enhanced security for member servers | ✅ Verified |

#### DISA STIG

> ⚠️ **Not Yet Available** - DISA STIG for Windows Server 2025 has not been released yet. This section will be updated when available.

<details>
<summary>📊 View Coverage Summary</summary>

| Framework | Product | Total Rules | High | Medium | Low |
|-----------|---------|-------------|------|--------|-----|
| CIS | WS 2025 DC | 445 | 111 | 334 | 0 |
| CIS | WS 2025 MS | 445 | 111 | 334 | 0 |
| STIG | WS 2025 | - | - | - | - |
| **Total** | | **890** | **222** | **668** | **0** |

</details>

---

### 🪟 Windows Server 2019

#### CIS Benchmarks

| Document | Level | Profile | Rules | Description | Status |
|----------|------|---------|-------|-------------|--------|
| [Level 1 DC](ms/ws-2019/cis/ms-ws-2019-cis-level1-dc-v4.0.0.yaml) | 🟢 Baseline | Domain Controller | 243 | Baseline security for domain controllers | ✅ Verified |
| [Level 1 MS](ms/ws-2019/cis/ms-ws-2019-cis-level1-ms-v4.0.0.yaml) | 🟢 Baseline | Member Server | 243 | Baseline security for member servers | ✅ Verified |
| [Level 2 DC](ms/ws-2019/cis/ms-ws-2019-cis-level2-dc-v4.0.0.yaml) | 🟡 Enhanced | Domain Controller | 177 | Enhanced security for domain controllers | ✅ Verified |
| [Level 2 MS](ms/ws-2019/cis/ms-ws-2019-cis-level2-ms-v4.0.0.yaml) | 🟡 Enhanced | Member Server | 177 | Enhanced security for member servers | ✅ Verified |

#### DISA STIG

| Document | Category | Severity | Rules | Description | Status |
|----------|----------|----------|-------|-------------|--------|
| [CAT I](ms/ws-2019/stig/ms-ws-2019-stig-cat1-v3r4.yaml) | 🔴 CAT I | High | 34 | Critical controls - Immediate action | ✅ Verified |
| [CAT II](ms/ws-2019/stig/ms-ws-2019-stig-cat2-v3r4.yaml) | 🟡 CAT II | Medium | 227 | Standard controls - Required | ✅ Verified |
| [CAT III](ms/ws-2019/stig/ms-ws-2019-stig-cat3-v3r4.yaml) | 🟢 CAT III | Low | 14 | Best practices - Recommended | ✅ Verified |

<details>
<summary>📊 View Coverage Summary</summary>

| Framework | Product | Total Rules | High | Medium | Low |
|-----------|---------|-------------|------|--------|-----|
| CIS | WS 2019 DC | 420 | 105 | 315 | 0 |
| CIS | WS 2019 MS | 420 | 105 | 315 | 0 |
| STIG | WS 2019 | 275 | 34 | 227 | 14 |
| **Total** | | **695** | **139** | **542** | **14** |

</details>

---

### ☀️ Oracle Solaris 11.4

#### DISA STIG

##### X86 Architecture

| Document | Category | Severity | Rules | Description | Status |
|----------|----------|----------|-------|-------------|--------|
| [CAT I](ora/solaris-11.4/stig/ora-solaris-114-x86-stig-cat1.yaml) | 🔴 CAT I | High | 14 | Critical controls - Immediate action | ✅ Verified |
| [CAT II](ora/solaris-11.4/stig/ora-solaris-114-x86-stig-cat2.yaml) | 🟡 CAT II | Medium | 152 | Standard controls - Required | ✅ Verified |
| [CAT III](ora/solaris-11.4/stig/ora-solaris-114-x86-stig-cat3.yaml) | 🟢 CAT III | Low | 50 | Best practices - Recommended | ✅ Verified |

##### SPARC Architecture

| Document | Category | Severity | Rules | Description | Status |
|----------|----------|----------|-------|-------------|--------|
| [CAT I](ora/solaris-11.4/stig/ora-solaris-114-sparc-stig-cat1.yaml) | 🔴 CAT I | High | 14 | Critical controls - Immediate action | ✅ Verified |
| [CAT II](ora/solaris-11.4/stig/ora-solaris-114-sparc-stig-cat2.yaml) | 🟡 CAT II | Medium | 154 | Standard controls - Required | ✅ Verified |
| [CAT III](ora/solaris-11.4/stig/ora-solaris-114-sparc-stig-cat3.yaml) | 🟢 CAT III | Low | 49 | Best practices - Recommended | ✅ Verified |

<details>
<summary>📊 View Coverage Summary</summary>

| Framework | Product | Total Rules | High | Medium | Low |
|-----------|---------|-------------|------|--------|-----|
| STIG | Solaris 11.4 X86 | 216 | 14 | 152 | 50 |
| STIG | Solaris 11.4 SPARC | 217 | 14 | 154 | 49 |
| **Total** | | **433** | **28** | **306** | **99** |

</details>

#### CIS Benchmarks

> ⚠️ **Not Yet Available** - CIS Benchmark for Oracle Solaris 11.4 requires manual extraction from the PDF document. The benchmark is available at [CIS Oracle Solaris Benchmark](https://www.cisecurity.org/benchmark/oracle_solaris) v1.1.0.

---

### 🔧 Oracle WebLogic Server 12c

#### Oracle Security Best Practices

| Document | Level | Profile | Rules | Description | Status |
|----------|------|---------|-------|-------------|--------|
| [Security Hardening](ora/weblogic-12c/security/ora-weblogic-12c-security-hardening-1.0.0.yaml) | 🟢 Production | Server | 40 | Security hardening based on Oracle documentation | ✅ Verified |

<details>
<summary>📊 View Coverage Summary</summary>

| Category | Rules | Description |
|----------|-------|-------------|
| Authentication | 7 | User authentication and password policies |
| Encryption | 7 | SSL/TLS and certificate management |
| Auditing | 2 | Logging and configuration auditing |
| Network Security | 3 | Connection filtering and ports |
| Session Management | 2 | Session timeout and cookie security |
| Application Security | 6 | EJB, REST, Web Services security |
| Configuration | 4 | Production mode and default applications |
| Management | 3 | JMX, Node Manager, SNMP security |
| Cluster Security | 2 | Cluster and Coherence security |
| **Total** | **40** | |

</details>

#### CIS Benchmarks & DISA STIG

> ⚠️ **Not Available** - Neither CIS Benchmark nor DISA STIG is publicly available for Oracle WebLogic Server 12c. The rules in this repository are based on Oracle's official security documentation and best practices.

---

### 🔧 Oracle WebLogic Server 14c

#### Oracle Security Best Practices

| Document | Level | Profile | Rules | Description | Status |
|----------|------|---------|-------|-------------|--------|
| [Security Hardening](ora/weblogic-14c/security/ora-weblogic-14c-security-hardening-1.0.0.yaml) | 🟢 Production | Server | 45 | Security hardening based on Oracle documentation | ✅ Verified |

<details>
<summary>📊 View Coverage Summary</summary>

| Category | Rules | Description |
|----------|-------|-------------|
| Authentication | 6 | User authentication, password policies, SAML, OAuth |
| Encryption | 7 | SSL/TLS, certificate management, HSTS |
| Auditing | 3 | Logging, configuration auditing, request logging |
| Network Security | 3 | Connection filtering, ports, virtual hosts |
| Session Management | 2 | Session timeout and cookie security |
| Application Security | 9 | EJB, REST, Web Services, security headers, error handling |
| Configuration | 4 | Production mode, boot identity, classloading |
| Management | 2 | JMX, Node Manager security |
| Cluster Security | 1 | Cluster communication security |
| Coherence Security | 1 | Coherence cluster security |
| Resource Management | 1 | Work Manager constraints |
| Monitoring | 1 | SNMP security |
| Domain Security | 1 | Cross-domain security |
| Database Security | 1 | JDBC security |
| Messaging Security | 1 | JMS security |
| **Total** | **45** | |

</details>

#### CIS Benchmarks & DISA STIG

> ⚠️ **Not Available** - Neither CIS Benchmark nor DISA STIG is publicly available for Oracle WebLogic Server 14c. The rules in this repository are based on Oracle's official security documentation and best practices.

---

## 🏛️ Supported Frameworks

<table>
<tr>
<td width="50%">

### ✅ Available Now

| Framework | Status | Products |
|-----------|--------|----------|
| **CIS Benchmarks** | ✅ Active | RHEL 8, RHEL 9, RHEL 10, Windows Server 2016, Windows Server 2019 |
| **DISA STIG** | ✅ Active | RHEL 8, RHEL 9, Windows Server 2019 |

</td>
<td width="50%">

### 🚧 Coming Soon

| Framework | Status | ETA |
|-----------|--------|-----|
| **NIST 800-53** | 🔄 Planned | Q2 2026 |
| **PCI-DSS** | 🔄 Planned | Q3 2026 |
| **HIPAA** | 🔄 Planned | Q4 2026 |
| **ISO 27001** | 🔄 Planned | Q4 2026 |

</td>
</tr>
</table>

---

## 🚀 Quick Start

### Prerequisites

<img src="https://img.shields.io/badge/Python-3.6+-blue?style=flat-square&logo=python&logoColor=white" alt="Python"/> <img src="https://img.shields.io/badge/PyYAML-Required-green?style=flat-square&logo=yaml&logoColor=white" alt="PyYAML"/>

### Installation

```bash
# Clone the repository
git clone https://github.com/azmankudus/compliance-rules.git
cd compliance-rules

# Install dependencies
pip install pyyaml jsonschema
```

### Quick Examples

#### 1️⃣ Load a Compliance File

```python
import yaml

# Load CIS Level 1 Server rules
with open('rh/rhel-9/cis/rh-rhel-9-cis-level1-server-v2.0.0.yaml') as f:
    rules = yaml.safe_load(f)
    
print(f"Framework: {rules['compliance_info']['framework']}")
print(f"Total Rules: {len(rules['rules'])}")
```

#### 2️⃣ Validate Against Schema

```python
import json, yaml
from jsonschema import validate

# Load schema
with open('docs/schema.json') as f:
    schema = json.load(f)

# Load and validate rules
with open('rh/rhel-9/cis/rh-rhel-9-cis-level1-server-v2.0.0.yaml') as f:
    data = yaml.safe_load(f)
    validate(instance=data, schema=schema)
    print("✅ Valid!")
```

#### 3️⃣ Filter Rules by Severity

```python
import yaml

with open('rh/rhel-9/stig/rh-rhel-9-stig-cat2-v2r7.yaml') as f:
    data = yaml.safe_load(f)

# Get all high severity rules
high_severity = [
    rule for rule in data['rules']
    if rule['assessment']['severity'] == 'High'
]

print(f"Found {len(high_severity)} high severity rules")
```

---

## 📖 Rule Structure

### Complete Rule Example

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
  data_sources:
    - /etc/fstab
    - /proc/mounts
remediation:
  remediation_step: "Configure /tmp in /etc/fstab with nodev,nosuid,noexec"
  remediation_script: "echo 'tmpfs /tmp tmpfs defaults,nodev,nosuid,noexec 0 0' >> /etc/fstab"
  revert_step: "Remove /tmp entry from /etc/fstab"
  rollback_supported: false
  reboot_required: true
  service_impact: "Requires filesystem reconfiguration"
  estimated_time: "30 minutes"
  dependencies:
    - CIS-1.1.1.1
context:
  rationale: "Separate /tmp prevents resource exhaustion and allows restrictive mount options"
  impact: "Medium - Improves security and stability"
  false_positive_risk: None
  default_value: "Not configured"
  references:
    - type: CIS
      reference: "CIS RHEL 9 Benchmark v2.0.0 - Section 1.1.2.1"
    - type: NIST
      reference: "NIST 800-53 Rev 5 - CM-6"
  cve_references:
    - CVE-2021-4034
tags:
  - filesystem
  - partitioning
  - tmp
  - mount-options
```

### Field Descriptions

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `rule_id` | string | ✅ | Unique identifier |
| `rule_name` | string | ✅ | Short human-readable name |
| `rule_description` | string | ✅ | Detailed description |
| `category` | string | ✅ | Primary category |
| `subcategory` | string | ❌ | Secondary category |
| `testing_status` | enum | ❌ | `untested`, `partial`, `verified` |
| `assessment` | object | ✅ | Assessment configuration |
| `remediation` | object | ✅ | Remediation steps |
| `context` | object | ❌ | Additional context |
| `tags` | array | ❌ | Tags for filtering |

<details>
<summary>🔍 View Assessment Fields</summary>

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `severity` | enum | ✅ | `Critical`, `High`, `Medium`, `Low`, `Informational` |
| `is_auto` | boolean | ✅ | Can be automated |
| `automation_level` | enum | ❌ | `Full`, `Partial`, `Manual` |
| `audit_type` | string | ✅ | Type of audit (config, runtime, log) |
| `detection_step` | string | ✅ | Step-by-step detection |
| `check_command` | string | ❌ | Command to check compliance |
| `expected_value` | string | ❌ | Expected result |
| `detection_script` | string | ❌ | Script for detection |
| `data_sources` | array | ❌ | Data sources for assessment |

</details>

<details>
<summary>🔧 View Remediation Fields</summary>

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `remediation_step` | string | ✅ | Step-by-step fix |
| `remediation_script` | string | ❌ | Automated fix script |
| `revert_step` | string | ❌ | How to revert |
| `rollback_supported` | boolean | ❌ | Can be rolled back |
| `reboot_required` | boolean | ❌ | Requires reboot |
| `service_impact` | string | ❌ | Impact description |
| `dependencies` | array | ❌ | Prerequisite rule IDs |
| `estimated_time` | string | ❌ | Time to fix |

</details>

---

## 🔗 Integration

### Compatible Tools

<table>
<tr>
<td width="33%" align="center">

**OpenSCAP**

[![OpenSCAP](https://img.shields.io/badge/OpenSCAP-Compatible-blue?style=flat-square)](https://www.open-scap.org/)

Convert to XCCDF/OVAL format

</td>
<td width="33%" align="center">

**Ansible**

[![Ansible](https://img.shields.io/badge/Ansible-Compatible-red?style=flat-square)](https://www.ansible.com/)

Generate remediation playbooks

</td>
<td width="33%" align="center">

**Terraform**

[![Terraform](https://img.shields.io/badge/Terraform-Compatible-purple?style=flat-square)](https://www.terraform.io/)

Infrastructure as code compliance

</td>
</tr>
<tr>
<td width="33%" align="center">

**Puppet**

[![Puppet](https://img.shields.io/badge/Puppet-Compatible-orange?style=flat-square)](https://puppet.com/)

Configuration management

</td>
<td width="33%" align="center">

**Chef**

[![Chef](https://img.shields.io/badge/Chef-Compatible-green?style=flat-square)](https://www.chef.io/)

Infrastructure automation

</td>
<td width="33%" align="center">

**Custom Tools**

[![Custom](https://img.shields.io/badge/Custom-Build-informational?style=flat-square)](#)

Build your own scanner

</td>
</tr>
</table>

### Integration Examples

#### Ansible Playbook Generator

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
    
    playbook = [{
        'hosts': 'all',
        'become': 'yes',
        'tasks': tasks
    }]
    
    with open(output_file, 'w') as f:
        yaml.dump(playbook, f)

generate_ansible_playbook(
    'rh/rhel-9/cis/rh-rhel-9-cis-level1-server-v2.0.0.yaml',
    'compliance-scan.yml'
)
```

---

## 📈 Statistics

### Repository Stats

<img src="https://img.shields.io/github/repo-size/azmankudus/compliance-rules?style=flat-square" alt="Repo Size"/> <img src="https://img.shields.io/github/languages/count/azmankudus/compliance-rules?style=flat-square" alt="Languages"/> <img src="https://img.shields.io/github/last-commit/azmankudus/compliance-rules?style=flat-square" alt="Last Commit"/>

### Rule Coverage

| Product | CIS L1 | CIS L2 | STIG CAT I | STIG CAT II | STIG CAT III | Oracle Sec | **Total** |
|---------|--------|--------|------------|-------------|--------------|------------|-----------|
| WS 2025 DC | 247 | 198 | - | - | - | - | **445** |
| WS 2025 MS | 247 | 198 | - | - | - | - | **445** |
| WS 2022 DC | 247 | 198 | - | - | - | - | **445** |
| WS 2022 MS | 247 | 198 | - | - | - | - | **445** |
| WS 2022 STIG | - | - | 31 | 232 | 12 | - | **275** |
| WS 2019 DC | 243 | 177 | - | - | - | - | **420** |
| WS 2019 MS | 243 | 177 | - | - | - | - | **420** |
| WS 2019 STIG | - | - | 34 | 227 | 14 | - | **275** |
| WS 2016 DC | 256 | 55 | - | - | - | - | **311** |
| WS 2016 MS | 264 | 59 | - | - | - | - | **323** |
| Solaris 11.4 X86 STIG | - | - | 14 | 152 | 50 | - | **216** |
| Solaris 11.4 SPARC STIG | - | - | 14 | 154 | 49 | - | **217** |
| WebLogic 12c Security | - | - | - | - | - | 40 | **40** |
| WebLogic 14c Security | - | - | - | - | - | 45 | **45** |
| RHEL 10 Server | 225 | 77 | - | - | - | - | **302** |
| RHEL 10 Workstation | 219 | 78 | - | - | - | - | **297** |
| RHEL 9 Server | 31 | 4 | 20 | 414 | 16 | - | **485** |
| RHEL 9 Workstation | 6 | 3 | - | - | - | - | **9** |
| RHEL 8 Server | 5 | 2 | 22 | 320 | 27 | - | **376** |
| RHEL 8 Workstation | 2 | 2 | - | - | - | - | **4** |
| **Total** | **2482** | **1232** | **135** | **1499** | **168** | **85** | **5601** |

### Severity Distribution

```
High (Critical):   657 rules (11.8%) ████████████░░░░░░░░░░░░░░░
Medium:           4478 rules (80.7%) ████████████████████████████
Low:               156 rules (2.8%)  ███░░░░░░░░░░░░░░░░░░░░░░░░
```

### Automation Coverage

```
Fully Automated:  3946 rules (95.0%) ████████████████████████████
Partially Auto:    185 rules (4.5%)  ██░░░░░░░░░░░░░░░░░░░░░░░░░░
Manual:             21 rules (0.5%)  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░
```

---

## 📚 Sources & References

### Official Benchmarks

| Framework | Source | Version | Date |
|-----------|--------|---------|------|
| **CIS** | [CIS Windows Server 2025 Benchmark](https://www.cisecurity.org/benchmark/microsoft_windows_server) | v2.0.0 | 2025 |
| **CIS** | [CIS Windows Server 2022 Benchmark](https://www.cisecurity.org/benchmark/microsoft_windows_server) | v3.0.0 | 2024 |
| **STIG** | [DISA STIG Windows Server 2022](https://www.stigviewer.com/stigs/microsoft_windows_server_2022) | V2R3 | May 2025 |
| **CIS** | [CIS Windows Server 2019 Benchmark](https://www.cisecurity.org/benchmark/microsoft_windows_server) | v4.0.0 | 2024 |
| **STIG** | [DISA STIG Windows Server 2019](https://www.stigviewer.com/stigs/microsoft_windows_server_2019) | V3R4 | May 2025 |
| **CIS** | [CIS Windows Server 2016 Benchmark](https://www.cisecurity.org/benchmark/microsoft_windows_server) | v4.0.0 | 2024 |
| **CIS** | [CIS RHEL 10 Benchmark](https://www.cisecurity.org/benchmark/red_hat_linux) | v1.0.1 | September 2025 |
| **CIS** | [CIS RHEL 9 Benchmark](https://www.cisecurity.org/benchmark/red_hat_linux) | v2.0.0 | June 2024 |
| **STIG** | [DISA STIG RHEL 9](https://www.stigviewer.com/stigs/red_hat_enterprise_linux_9) | V2R7 | May 2025 |
| **CIS** | [CIS RHEL 8 Benchmark](https://www.cisecurity.org/benchmark/red_hat_linux) | v4.0.0 | August 2025 |
| **STIG** | [DISA STIG RHEL 8](https://www.stigviewer.com/stigs/red_hat_enterprise_linux_8) | V2R2 | January 2025 |
| **STIG** | [DISA STIG Solaris 11 X86](https://www.stigviewer.com/stigs/solaris_11_x86) | V3R2 | May 2025 |
| **STIG** | [DISA STIG Solaris 11 SPARC](https://www.stigviewer.com/stigs/solaris_11_sparc) | V3R2 | May 2025 |
| **CIS** | [CIS Oracle Solaris 11.4 Benchmark](https://www.cisecurity.org/benchmark/oracle_solaris) | v1.1.0 | 2024 |
| **Oracle** | [Oracle WebLogic Server 12c Security Documentation](https://docs.oracle.com/middleware/1212/wls/SECMG/toc.htm) | v1.0.0 | 2026 |
| **Oracle** | [Oracle WebLogic Server 14c Security Documentation](https://docs.oracle.com/en/middleware/standalone/weblogic-server/14.1.1.0/secmg/toc.htm) | v1.0.0 | 2026 |

### Community Resources

| Resource | Link |
|----------|------|
| **ComplianceAsCode** | [GitHub Repository](https://github.com/ComplianceAsCode/content) |
| **OpenSCAP** | [Documentation](https://www.open-scap.org/) |
| **Red Hat Security** | [Security Guide](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/security_hardening/) |

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### Ways to Contribute

<table>
<tr>
<td width="25%" align="center">

🐛 **Report Bugs**

Found an issue? Let us know!

</td>
<td width="25%" align="center">

💡 **Suggest Features**

Have an idea? Share it!

</td>
<td width="25%" align="center">

📝 **Improve Docs**

Help us clarify

</td>
<td width="25%" align="center">

🔧 **Submit Rules**

Add new compliance rules

</td>
</tr>
</table>

### Contribution Process

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Follow** the schema in `docs/schema.json`
4. **Source** rules from official compliance bodies
5. **Test** validation before submitting
6. **Commit** your changes (`git commit -m 'Add amazing feature'`)
7. **Push** to the branch (`git push origin feature/amazing-feature`)
8. **Open** a Pull Request

### Contribution Guidelines

- ✅ All rules must be from official sources (CIS, DISA, NIST)
- ✅ Follow the existing file naming convention
- ✅ Validate YAML syntax and schema compliance
- ✅ Include proper metadata and tags
- ✅ Test remediation steps

---

## 📜 License

This project is licensed under the terms specified in the [LICENSE](LICENSE) file.

### Disclaimer

The compliance rules in this repository are provided "as is" without warranty of any kind. While every effort has been made to ensure accuracy, users should:

- Verify rules against official benchmark sources
- Test rules in non-production environments first
- Review and adapt rules for their specific environment
- Consult with compliance experts for critical systems

---

<div align="center">

### 🌟 Star This Repository

If you find this project useful, please consider giving it a star! It helps others discover it and shows your support.

[![Star](https://img.shields.io/github/stars/azmankudus/compliance-rules?style=social)](https://github.com/azmankudus/compliance-rules/stargazers)

<br/><br/>

---

**Built with ❤️ by security professionals, for security professionals**

[⬆ Back to Top](#-compliance-rules)

</div>
