# Compliance Information Sources

## STIG Search Sequence (MUST FOLLOW ORDER)

### 1. Official DISA Cyber.mil (PRIMARY)
**URL:** https://www.cyber.mil/stigs/downloads/

**Usage:**
- First source for all STIG information
- Contains official STIG ZIP files with XCCDF/XML content
- Download and extract to view rule details
- Check version/release date for latest

**Search Pattern:**
1. Navigate to STIGs Downloads page
2. Search for product name (e.g., "Red Hat Enterprise Linux 9")
3. Download latest ZIP file
4. Extract and parse XCCDF content

### 2. STIG Viewer (SECONDARY)
**URL:** https://www.stigviewer.com/stigs

**Usage:**
- Use when Cyber.mil is unavailable or for quick reference
- Browse by product category
- Contains formatted STIG rules with V-IDs

**Search Pattern:**
1. Navigate to STIGs page
2. Find product in list
3. Click to view all rules
4. Filter by category (CAT I, II, III)

### 3. Cyber Trackr (TERTIARY)
**URL:** https://cyber.trackr.live/stig

**Usage:**
- Fallback source
- May have additional context or cross-references

## CIS Benchmark Sources

### Official CIS Benchmarks
**URL:** https://www.cisecurity.org/benchmark/

**Usage:**
- Primary source for all CIS rules
- Requires free membership for PDF downloads
- Check version and release date

**Available Benchmarks:**
- Red Hat Enterprise Linux
- Microsoft Windows Server
- Oracle Solaris
- Various other platforms

## Information Extraction Guidelines

### For STIG Rules
Extract these fields from XCCDF:
- `rule_id`: Use STIG ID (e.g., `STIG-211010`)
- `legacy_ids`: V-ID and SV-ID (e.g., `V-257777`, `SV-257777r991589_rule`)
- `rule_name`: Rule title
- `rule_description`: Full description text
- `category`: Group/rule category
- `assessment.severity`: Map CAT I=High, CAT II=Medium, CAT III=Low
- `assessment.check_command`: From check content
- `remediation.remediation_step`: From fix text

### For CIS Rules
Extract these fields from PDF/XLS:
- `rule_id`: CIS section number (e.g., `CIS-1.1.1.1`)
- `rule_name`: Rule title
- `rule_description`: Description text
- `category`: Chapter/section category
- `assessment.severity`: From profile scoring
- `assessment.check_command`: From audit section
- `remediation.remediation_step`: From remediation section

## Version Verification

### Always Check:
1. **Release Date** - Must be current
2. **Version Number** - Must be latest
3. **Status** - Must not be deprecated/retired

### STIG Version Format
- Format: `V<version>R<release>` (e.g., `V2R7`)
- Higher R number = more recent

### CIS Version Format
- Format: `v<major>.<minor>.<patch>` (e.g., `v2.0.0`)
- Semantic versioning

## Anti-Hallucination Rules

1. **NEVER** fabricate rule content
2. **ALWAYS** cite source URL or document
3. **ALWAYS** verify version is latest before writing
4. **IF** information not found, state clearly
5. **IF** rule not in official source, do not create it
