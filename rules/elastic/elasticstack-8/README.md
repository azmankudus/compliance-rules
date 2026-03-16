# Elastic Stack Compliance Rules

This directory contains machine-readable compliance rules for Elastic Stack 8.x (ELK Stack).

## Overview

Compliance rules are provided based on:
- **DISA STIG** - Central Log Server Security Requirements Guide V3R3
- **Elastic Official Documentation** - Security best practices from vendor documentation

**Note**: There is no specific CIS Benchmark for Elastic Stack. The CIS Amazon EKS Benchmark is for Kubernetes, not Elastic Stack.

## Files

### 1. STIG CAT I (Critical/High Severity)
**File**: `elastic-elasticstack-8-stig-cat1-v3r3.yaml`
- **Rules**: 13 high-severity rules
- **Source**: DISA Central Log Server SRG V3R3
- **Coverage**: 
  - Access control and authorization
  - Authentication and user identification
  - FIPS compliance and cryptography
  - PKI certificate validation
  - Password security
  - TLS/SSL configuration
  - Patch management
  - Version support

### 2. STIG CAT II (Medium Severity)
**File**: `elastic-elasticstack-8-stig-cat2-v3r3.yaml`
- **Rules**: 11 medium-severity rules
- **Source**: DISA Central Log Server SRG V3R3
- **Coverage**:
  - Log aggregation and retention
  - Audit logging and off-loading
  - Multifactor authentication
  - Account management
  - Source identity tracking
  - Network protocol configuration
  - Attack detection and alerting

### 3. Vendor Documentation (Best Practices)
**File**: `elastic-elasticstack-8-elastic-security-1.0.0.yaml`
- **Rules**: 30 security best practice rules
- **Source**: Elastic official documentation
- **Coverage**:
  - Elasticsearch security configuration
  - TLS/SSL for transport and HTTP layers
  - User and role management
  - Kibana security settings
  - Logstash security configuration
  - Realm configuration (LDAP, AD, SAML, OIDC)
  - API key and token management
  - Audit logging
  - FIPS mode
  - Session management

## Directory Structure

```
rules/elastic/elasticstack-8/
├── elastic-elasticstack-8-elastic-security-1.0.0.yaml    # Vendor docs
├── elastic-elasticstack-8-stig-cat1-v3r3.yaml            # STIG CAT I
└── elastic-elasticstack-8-stig-cat2-v3r3.yaml            # STIG CAT II
```

## Rule Categories

### Authentication & Authorization
- Enable security features
- Configure RBAC
- Set up authentication realms (Native, LDAP, AD, SAML, OIDC, PKI)
- Implement MFA
- Manage users and roles

### Encryption
- TLS for transport layer (inter-node)
- TLS for HTTP layer (client-server)
- Certificate verification
- Cipher suite configuration
- FIPS 140-2 compliance

### Logging & Auditing
- Enable audit logging
- Configure log aggregation
- Set up log retention policies
- Off-load audit records
- Protect audit information

### Access Control
- Document and field level security
- Role-based access control
- IP filtering
- Anonymous access management

### System Configuration
- Run as non-root user
- Patch management
- Version support
- Secure settings keystore
- File permissions

### Monitoring & Alerting
- Attack detection
- Alerting configuration
- Event correlation
- Notification systems

## Usage

### Validation

Validate YAML syntax:
```bash
python3 -c "import yaml; yaml.safe_load(open('file.yaml'))"
```

Validate against schema:
```bash
python3 -c "
import yaml, json
from jsonschema import validate
with open('docs/schema.json') as f: schema = json.load(f)
with open('file.yaml') as f: data = yaml.safe_load(f)
validate(instance=data, schema=schema)
print('Valid!')
"
```

### Implementation

1. **Review Rules**: Start with CAT I (high severity) rules
2. **Test in Non-Production**: Always test changes in a non-production environment
3. **Enable Security**: Begin by enabling Elasticsearch security features
4. **Configure TLS**: Set up TLS for both transport and HTTP layers
5. **Configure Authentication**: Set up appropriate authentication realms
6. **Enable Auditing**: Configure audit logging
7. **Monitor Compliance**: Regularly assess compliance status

### Example: Enable Security

```yaml
# In elasticsearch.yml
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.http.ssl.enabled: true
```

### Example: Create Role

```bash
curl -X PUT "localhost:9200/_security/role/logs_reader" -H 'Content-Type: application/json' -d'
{
  "indices": [
    {
      "names": [ "logs-*" ],
      "privileges": [ "read" ]
    }
  ]
}
'
```

## Sources

### STIG
- **Source**: DISA Cyber.mil
- **Document**: Central Log Server Security Requirements Guide V3R3
- **URL**: https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_Central_Log_Server_V3R3_SRG.zip
- **Date**: September 2025

### Elastic Documentation
- **Security Settings**: https://www.elastic.co/guide/en/elasticsearch/reference/current/security-settings.html
- **Minimal Security Setup**: https://www.elastic.co/guide/en/elasticsearch/reference/current/security-minimal-setup.html
- **Audit Logging**: https://www.elastic.co/guide/en/elasticsearch/reference/current/auditing-settings.html
- **Logstash Security**: https://www.elastic.co/guide/en/logstash/current/ls-security.html

## Compliance Status

| Framework | Available | Version | Rules |
|-----------|-----------|---------|-------|
| DISA STIG | Yes | V3R3 | 24 (13 CAT I + 11 CAT II) |
| CIS Benchmark | No | N/A | N/A |
| Vendor Docs | Yes | 1.0.0 | 30 |

## Notes

1. **CIS Benchmark**: There is no CIS Benchmark specifically for Elastic Stack. The CIS Amazon EKS Benchmark is for Kubernetes, not Elastic.

2. **STIG Applicability**: The Central Log Server STIG is a Security Requirements Guide (SRG) that applies to any central log aggregation system, including ELK Stack.

3. **FIPS Compliance**: For FIPS 140-2 compliance, additional JVM configuration is required with a FIPS-validated cryptographic provider.

4. **Production Deployment**: The minimal security configuration is not sufficient for production. Always enable TLS on both transport and HTTP layers for multi-node clusters.

5. **Testing**: All rules are marked as "untested". Validate and test rules in your environment before production deployment.

## Additional Resources

- [Elastic Security Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-minimal-setup.html)
- [DISA STIGs](https://public.cyber.mil/stigs/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)

## Support

For issues with these compliance rules:
1. Check the official Elastic documentation
2. Review DISA STIG documentation
3. Consult with your security team

## Version History

- **1.0.0** (2026-03-17): Initial release
  - 30 vendor documentation rules
  - 13 STIG CAT I rules
  - 11 STIG CAT II rules
