# Compliance Rules Agent Skill

## Purpose
This skill enables agents to create, validate, and maintain security compliance rules in YAML format based on CIS Benchmarks and DISA STIGs.

## Capabilities

### 1. Rule Creation
- Create new compliance rules following the schema in `docs/schema.json`
- Source rules from official CIS and STIG benchmarks
- Maintain consistent file naming conventions

### 2. Rule Validation
- Validate YAML syntax
- Validate schema compliance against `docs/schema.json`
- Verify required fields are present

### 3. Information Retrieval
- Search STIG sources in priority order (see sources.md)
- Search CIS benchmarks for reference information
- Extract and structure compliance requirements

## Invocation

When asked to create compliance rules:

1. **Understand the Request**
   - Identify target product (e.g., RHEL 9, Windows Server 2022)
   - Identify framework (CIS or STIG)
   - Identify profile/level (Level 1/2 Server, CAT I/II/III)

2. **Search for Information**
   - Follow STIG search sequence from sources.md
   - Use CIS benchmarks for CIS rules
   - Always use LATEST versions

3. **Create Rules**
   - Follow output structure exactly
   - Include all required fields
   - Validate against schema

## Constraints

- NEVER fabricate compliance rules
- ALWAYS source from official benchmarks
- ALWAYS verify information is current/latest
- ALWAYS follow the schema structure
