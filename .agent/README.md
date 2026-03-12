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

1. **Source First** - Always source from official benchmarks
2. **Latest Version** - Always use the most recent version
3. **Schema Compliance** - All rules must validate against schema
4. **No Hallucination** - Never fabricate compliance content

## STIG Search Sequence

1. https://www.cyber.mil/stigs/downloads/ (PRIMARY)
2. https://www.stigviewer.com/stigs (SECONDARY)
3. https://cyber.trackr.live/stig (TERTIARY)

## CIS Source

- https://www.cisecurity.org/benchmark/

## Validation

All YAML files must validate against:
- `docs/schema.json` (authoritative)
- `docs/schema.yaml` (reference)
