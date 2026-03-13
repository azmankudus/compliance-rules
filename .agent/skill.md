# Compliance Rules Agent Skill

## Purpose
This skill enables agents to create, validate, and maintain security compliance rules in YAML format based on CIS Benchmarks, DISA STIGs, and vendor official documentation.

## Capabilities

### 1. Rule Creation
- Create new compliance rules following the schema in `docs/schema.json`
- Source rules from official CIS and STIG benchmarks
- Source rules from vendor official documentation (Red Hat, Microsoft, Oracle)
- Maintain consistent file naming conventions

### 2. Rule Validation
- Validate YAML syntax
- Validate schema compliance against `docs/schema.json`
- Verify required fields are present

### 3. Information Retrieval
- Search STIG sources in priority order (see sources.md)
- Search CIS benchmarks for reference information
- Fetch vendor documentation from official sources
- Extract and structure compliance requirements

## File Naming Convention

```
rules/<vendor>/<product>-<version>/<vendor>-<product>-<version>-<framework>-<type>-<doc-version>[-additional-info].yaml
```

### Components
- `<vendor>` - Full name: `redhat`, `microsoft`, `oracle`
- `<product>` - Product name (no spaces): `rhel`, `windowsserver`, `solaris`, `weblogic`
- `<version>` - Product version: `10`, `2022`, `114`, `12c`
- `<framework>` - Compliance source: `cis`, `stig`, `redhat`, `oracle`
- `<type>` - Rule type: `level1`, `level2`, `cat1`, `cat2`, `cat3`, `security`
- `<doc-version>` - Document version: `v1.0.0`, `v2r7`
- `[-additional-info]` - Optional suffix: `server`, `workstation`, `dc`, `ms`, `x86`, `sparc`

### Examples
```
rules/redhat/rhel-10/redhat-rhel-10-cis-level1-v1.0.1-server.yaml
rules/redhat/rhel-9/redhat-rhel-9-stig-cat1-v2r7.yaml
rules/redhat/rhel-10/redhat-rhel-10-redhat-security-1.0.0.yaml
rules/microsoft/windowsserver-2022/microsoft-windowsserver-2022-cis-level1-v3.0.0-dc.yaml
rules/oracle/solaris-11.4/oracle-solaris-114-stig-cat1-v1r0-x86.yaml
rules/oracle/weblogic-12c/oracle-weblogic-12c-oracle-security-1.0.0.yaml
```

## Invocation

When asked to create compliance rules:

1. **Understand the Request**
   - Identify target product (e.g., RHEL 10, Windows Server 2022)
   - Identify framework (CIS, STIG, or vendor documentation)
   - Identify profile/level (Level 1/2 Server, CAT I/II/III, Security)

2. **Search for Information**
   - Follow STIG search sequence from sources.md
   - Use CIS benchmarks for CIS rules
   - Fetch vendor documentation for vendor-sourced rules
   - Always use LATEST versions

3. **Create Rules**
   - Follow output structure exactly
   - Include all required fields
   - Validate against schema
   - Use correct file naming convention

## Framework Sources

| Framework | Source | Used For |
|-----------|--------|----------|
| `cis` | CIS Benchmarks | All products |
| `stig` | DISA STIGs | All products |
| `redhat` | Red Hat Documentation | RHEL products |
| `oracle` | Oracle Documentation | Oracle products |
| `microsoft` | Microsoft Documentation | Windows products |

## Constraints

- NEVER fabricate compliance rules
- ALWAYS source from official benchmarks or vendor documentation
- ALWAYS verify information is current/latest
- ALWAYS follow the schema structure
- ALWAYS use full vendor names (not abbreviations)
- ALWAYS place additional info at the end of filenames
