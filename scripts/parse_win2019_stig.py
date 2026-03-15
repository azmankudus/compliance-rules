#!/usr/bin/env python3
"""Parse Windows Server 2019 STIG V3R7 XCCDF XML and generate YAML rule files."""

import xml.etree.ElementTree as ET
import yaml
import re
from pathlib import Path
from html import unescape

XML_FILE = "/tmp/stigs/win2019/U_MS_Windows_Server_2019_V3R7_Manual_STIG/U_MS_Windows_Server_2019_STIG_V3R7_Manual-xccdf.xml"
OUTPUT_DIR = Path("rules/microsoft/windowsserver-2019")

NS = {'xccdf': 'http://checklists.nist.gov/xccdf/1.1'}

def clean_text(text):
    """Clean and unescape HTML text."""
    if not text:
        return ""
    text = unescape(text)
    text = re.sub(r'\s+', ' ', text).strip()
    return text

def extract_vuln_discussion(description):
    """Extract VulnDiscussion content from description."""
    if not description:
        return ""
    match = re.search(r'<VulnDiscussion>(.*?)</VulnDiscussion>', description, re.DOTALL)
    if match:
        return clean_text(match.group(1))
    return clean_text(description)

def extract_tags(title, srg_title):
    """Extract relevant tags from title and SRG."""
    tags = set()
    title_lower = title.lower()
    
    if 'audit' in title_lower:
        tags.add('audit')
    if 'password' in title_lower:
        tags.add('password')
    if 'account' in title_lower:
        tags.add('account')
    if 'logon' in title_lower:
        tags.add('logon')
    if 'registry' in title_lower:
        tags.add('registry')
    if 'firewall' in title_lower:
        tags.add('firewall')
    if 'service' in title_lower:
        tags.add('service')
    if 'permission' in title_lower:
        tags.add('permission')
    if 'user' in title_lower:
        tags.add('user')
    if 'group' in title_lower:
        tags.add('group')
    if 'security' in title_lower:
        tags.add('security')
    if 'event' in title_lower:
        tags.add('event')
    if 'policy' in title_lower:
        tags.add('policy')
    if 'network' in title_lower:
        tags.add('network')
    if 'encryption' in title_lower:
        tags.add('encryption')
    if 'admin' in title_lower:
        tags.add('administrator')
    if 'remote' in title_lower:
        tags.add('remote')
    if 'windows' in title_lower:
        tags.add('windows')
    if 'credential' in title_lower:
        tags.add('credentials')
    if 'smart' in title_lower:
        tags.add('smartcard')
    if 'domain' in title_lower:
        tags.add('domain')
    if 'local' in title_lower:
        tags.add('local')
    
    if srg_title:
        srg_lower = srg_title.lower()
        if 'audit' in srg_lower:
            tags.add('audit')
        if 'access' in srg_lower:
            tags.add('access-control')
        if 'identification' in srg_lower:
            tags.add('identification')
        if 'authentication' in srg_lower:
            tags.add('authentication')
    
    if not tags:
        tags.add('windows-server')
    
    return sorted(list(tags))

def extract_subcategory(title):
    """Extract subcategory from title."""
    if ' - ' in title:
        parts = title.split(' - ')
        if len(parts) > 1:
            return parts[0].replace('Windows Server 2019 ', '').strip()
    return 'General'

def extract_category(srg_title):
    """Extract category from SRG title."""
    if not srg_title:
        return 'Security'
    if 'AUDIT' in srg_title:
        return 'Audit'
    if 'ACCOUNT' in srg_title:
        return 'Account Management'
    if 'IDENTIFICATION' in srg_title or 'AUTH' in srg_title:
        return 'Identification and Authentication'
    if 'ACCESS' in srg_title:
        return 'Access Control'
    if 'CRYPTO' in srg_title:
        return 'Cryptography'
    if 'NETWORK' in srg_title:
        return 'Network Security'
    return 'Security'

def parse_xml():
    """Parse the XCCDF XML file and return rules grouped by severity."""
    tree = ET.parse(XML_FILE)
    root = tree.getroot()
    
    rules_by_severity = {
        'high': [],
        'medium': [],
        'low': []
    }
    
    for group in root.findall('.//xccdf:Group', NS):
        group_id = group.get('id', '')
        srg_title_elem = group.find('xccdf:title', NS)
        srg_title = srg_title_elem.text if srg_title_elem is not None else ''
        
        rule = group.find('xccdf:Rule', NS)
        if rule is None:
            continue
        
        rule_id = rule.get('id', '')
        severity = rule.get('severity', 'medium').lower()
        
        version_elem = rule.find('xccdf:version', NS)
        version = version_elem.text if version_elem is not None else ''
        
        title_elem = rule.find('xccdf:title', NS)
        title = title_elem.text if title_elem is not None else ''
        
        description_elem = rule.find('xccdf:description', NS)
        description = description_elem.text if description_elem is not None else ''
        
        fixtext_elem = rule.find('xccdf:fixtext', NS)
        fixtext = fixtext_elem.text if fixtext_elem is not None else ''
        
        check = rule.find('xccdf:check', NS)
        check_content = ''
        if check is not None:
            check_content_elem = check.find('xccdf:check-content', NS)
            check_content = check_content_elem.text if check_content_elem is not None else ''
        
        legacy_ids = [group_id]
        for ident in rule.findall('xccdf:ident', NS):
            ident_text = ident.text
            if ident_text:
                legacy_ids.append(ident_text)
        legacy_ids.append(rule_id)
        
        vuln_discussion = extract_vuln_discussion(description)
        tags = extract_tags(title, srg_title)
        subcategory = extract_subcategory(title)
        category = extract_category(srg_title)
        
        rule_data = {
            'rule_id': f'STIG-{group_id}',
            'legacy_ids': legacy_ids,
            'rule_name': title,
            'rule_description': vuln_discussion,
            'category': category,
            'subcategory': subcategory,
            'assessment': {
                'severity': severity.capitalize(),
                'is_auto': True,
                'automation_level': 'Full',
                'audit_type': 'config',
                'detection_step': check_content.strip() if check_content else '',
                'check_command': check_content.strip() if check_content else ''
            },
            'remediation': {
                'remediation_step': fixtext.strip() if fixtext else '',
                'rollback_supported': True,
                'reboot_required': False,
                'service_impact': 'Service restart required',
                'estimated_time': '5 minutes'
            },
            'context': {
                'rationale': vuln_discussion,
                'false_positive_risk': 'Low'
            },
            'id': f'STIG-{group_id}',
            'title': title,
            'description': vuln_discussion,
            'severity': severity.capitalize(),
            'tags': tags
        }
        
        if severity in rules_by_severity:
            rules_by_severity[severity].append(rule_data)
    
    return rules_by_severity

def create_metadata(cat_name, cat_num):
    """Create metadata section for YAML file."""
    return {
        'metadata': {
            'name': f'DISA STIG for Windows Server 2019 - CAT {cat_num}',
            'version': '3.7',
            'description': 'DISA Security Technical Implementation Guide for Windows Server 2019 V3R7',
            'platform': 'Microsoft Windows Server 2019',
            'benchmark': 'DISA STIG Windows Server 2019 V3R7',
            'author': 'Compliance Rules Team',
            'created': '2026-03-15T00:00:00Z',
            'modified': '2026-03-15T00:00:00Z',
            'compatible_platforms': ['Microsoft Windows Server 2019'],
            'references': [
                {'type': 'DISA STIG', 'reference': 'Microsoft Windows Server 2019 STIG V3R7'},
                {'type': 'DISA', 'reference': 'https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_MS_Windows_Server_2019_V3R7_STIG.zip'}
            ]
        },
        'compliance_info': {
            'framework': 'STIG',
            'version': '3.7',
            'profile': 'official'
        }
    }

def should_use_literal(s):
    """Determine if string should use literal block style."""
    return '\n' in s or len(s) > 100

def str_representer(dumper, data):
    """Custom string representer that uses literal style for multiline strings."""
    if should_use_literal(data):
        return dumper.represent_scalar('tag:yaml.org,2002:str', data, style='|')
    return dumper.represent_scalar('tag:yaml.org,2002:str', data)

class CustomDumper(yaml.SafeDumper):
    pass

def dict_representer(dumper, data):
    return dumper.represent_mapping('tag:yaml.org,2002:map', data.items())

CustomDumper.add_representer(dict, dict_representer)
CustomDumper.add_representer(str, str_representer)

def write_yaml_file(rules, cat_name, cat_num, filename):
    """Write rules to a YAML file."""
    metadata = create_metadata(cat_name, cat_num)
    
    content = {}
    content.update(metadata)
    content['rules'] = rules
    
    with open(filename, 'w') as f:
        yaml.dump(content, f, Dumper=CustomDumper, default_flow_style=False, sort_keys=False, allow_unicode=True, width=1000)
    
    return len(rules)

def main():
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    print("Parsing XCCDF XML...")
    rules_by_severity = parse_xml()
    
    cat_mapping = [
        ('high', 'cat1', '1'),
        ('medium', 'cat2', '2'),
        ('low', 'cat3', '3')
    ]
    
    counts = {}
    
    for severity, cat_name, cat_num in cat_mapping:
        rules = rules_by_severity[severity]
        filename = OUTPUT_DIR / f'microsoft-windowsserver-2019-stig-{cat_name}-v3r7.yaml'
        count = write_yaml_file(rules, cat_name, cat_num, filename)
        counts[cat_name] = count
        print(f"Wrote {count} rules to {filename}")
    
    print(f"\nTotal: {sum(counts.values())} rules")
    print(f"CAT1 (High): {counts['cat1']}")
    print(f"CAT2 (Medium): {counts['cat2']}")
    print(f"CAT3 (Low): {counts['cat3']}")

if __name__ == '__main__':
    main()
