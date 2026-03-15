#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import re
import yaml

def parse_xccdf_stig(xml_file):
    """Parse XCCDF STIG XML file and extract rules"""
    tree = ET.parse(xml_file)
    root = tree.getroot()
    
    rules = []
    for group in root.findall('.//Group'):
        rule_id = group.get('id')
        title_elem = group.find('.//title')
        if title_elem is not None:
            title = title_elem.text
        else:
            title = ""
        
        description_elem = group.find('.//description')
        if description_elem is not None:
            # Get full description including vulnDiscussion
            desc_text = ET.tostring(description_elem)
            # Clean up the description
            desc_text = re.sub(r'<[^>]+>', '', desc_text)  # Remove nested tags
            desc_text = re.sub(r'<VulnDiscussion>.*?</VulnDiscussion>', '', desc_text, flags=re.DOTALL)
            desc_text = re.sub(r'<FalsePositives>.*?</FalsePositives>', '', desc_text, flags=re.DOTALL)
            desc_text = re.sub(r'<FalseNegatives>.*?</FalseNegatives>', '', desc_text, flags=re.DOTALL)
            desc_text = re.sub(r'<Documentable>.*?</Documentable>', '', desc_text, flags=re.DOTALL)
            desc_text = re.sub(r'<Mitigations>.*?</Mitigations>', '', desc_text, flags=re.DOTALL)
            desc_text = re.sub(r'<SeverityOverrideGuidance>.*?</SeverityOverrideGuidance>', '', desc_text, flags=re.DOTALL)
            desc_text = re.sub(r'<PotentialImpacts>.*?</PotentialImpacts>', '', desc_text, flags=re.DOTALL)
            desc_text = re.sub(r'<ThirdPartyTools>.*?</ThirdPartyTools>', '', desc_text, flags=re.DOTALL)
            desc_text = re.sub(r'<MitigationControl>.*?</MitigationControl>', '', desc_text, flags=re.DOTALL)
            desc_text = re.sub(r'<Responsibility>.*?</Responsibility>', '', desc_text, flags=re.DOTALL)
            desc_text = re.sub(r'<IAControls>.*?</IAControls>', '', desc_text, flags=re.DOTALL)
            desc_text = re.sub(r'&lt;', '', desc_text)
            desc_text = re.sub(r'&gt;', '', desc_text)
        else:
            desc_text = ""
        
        # Get severity
        severity = "medium"  # Default
        rule_info = group.find('.//Rule')
        if rule_info is not None:
            severity_elem = rule_info.find('.//severity')
            if severity_elem is not None:
                severity = severity_elem.get('weight')
                if severity == "10.0":
                    severity = "high"
                elif severity == "high":
                    severity = "high"
                elif severity == "medium":
                    severity = "medium"
                elif severity == "low":
                    severity = "low"
        
        # Get check content (fix text)
        check_text = ""
        fixtext = group.find('.//fixtext')
        if fixtext is not None:
            fixtext = fixtext.text
        
        rules.append({
            'rule_id': f"STIG-{rule_id}",
            'title': title,
            'description': desc_text.strip(),
            'severity': severity.capitalize() if severity else 'Medium',
            'check': fixtext.strip() if fixtext else ''
        })
    
    return rules

def generate_yaml(rules, output_file, metadata):
    """Generate YAML file from rules"""
    with open(output_file, 'w') as f:
        f.write(yaml.dump({
            'schema_version': '1.0.0',
            'metadata': metadata,
            'compliance_info': {
                'framework': 'STIG',
                'version': metadata.get('version', '1.0.0'),
                'profile': 'official'
            },
            'rules': rules
        }, default_flow_style=False))
    
    f.write('\n')

if __name__ == '__main__':
    import sys
    
    # Parse Apache HTTPD 2.4 Server STIG
    xml_file = '/tmp/stigs/apache-httpd-24/U_Apache_Server_2-4_Unix_Server_V3R2_Manual_STIG/U_Apache_Server_2-4_UNIX_Server_STIG_V3R2_Manual-xccdf.xml'
    rules = parse_xccdf_stig(xml_file)
    
    metadata = {
        'name': 'Apache HTTP Server 2.4 UNIX Server STIG',
        'version': '3.2',
        'description': 'DISA Apache Server 2.4 UNIX Server Security Technical Implementation Guide',
        'platform': 'Apache HTTP Server 2.4',
        'benchmark': 'Apache Server 2.4 UNIX Server STIG',
        'author': 'Compliance Rules Team',
        'created': '2026-03-15T00:00:00Z',
        'modified': '2026-03-15T00:00:00Z',
        'compatible_platforms': ['Apache HTTP Server 2.4.x'],
        'references': [
            {'type': 'DISA STIG', 'reference': 'Apache Server 2.4 UNIX Server STIG V3R2'},
            {'type': 'DISA', 'reference': 'https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_Apache_Server_2-4_Unix_Y25M04_STIG.zip'}
        ]
    }
    
    output_file = '/tmp/stigs/apache-httpd-24-server.yaml'
    generate_yaml(rules, output_file, metadata)
    print(f"Generated {len(rules)} rules for Apache HTTPD 2.4 Server STIG")
