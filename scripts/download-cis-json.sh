#!/bin/bash

# Download latest CIS benchmark catalog from downloads.cisecurity.org
# Output: docs/cis-yyyyMMdd.json

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="${SCRIPT_DIR}/../docs"
DATE_STAMP=$(date +%Y%m%d)
OUTPUT_FILE="${OUTPUT_DIR}/cis-${DATE_STAMP}.json"
TEMP_DIR=$(mktemp -d)

# Create output directory if it doesn't exist
mkdir -p "${OUTPUT_DIR}"

echo "Downloading CIS benchmark catalog..."

cd "${TEMP_DIR}"

# Step 1: Get technology list
curl -sSL 'https://downloads.cisecurity.org/technology' \
  -H 'accept: */*' \
  -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8' \
  -b 'CookieConsent={stamp:%27YSpmvN/ElLgk7iqAm7IIg/F7nIl2U/Y0CYNFNkpu8hWpdu9it7jG2w==%27%2Cnecessary:true%2Cpreferences:false%2Cstatistics:false%2Cmarketing:false%2Cmethod:%27explicit%27%2Cver:1%2Cutc:1772436175752%2Cregion:%27my%27}' \
  -H 'dnt: 1' \
  -H 'priority: u=1, i' \
  -H 'referer: https://downloads.cisecurity.org/' \
  -H 'sec-ch-ua: "Not(A:Brand";v="8", "Chromium";v="144", "Google Chrome";v="144"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36' \
  -H 'x-requested-with: XMLHttpRequest' \
  > tech-list.json

# Step 2: Download benchmarks for each technology
echo "Fetching benchmarks for each technology..."

# Extract technology IDs and download benchmarks
TECH_IDS=$(jq -r '.[] | .[].id' tech-list.json 2>/dev/null || echo "")

if [ -z "$TECH_IDS" ]; then
    echo "Warning: Could not extract technology IDs, using cached or empty list"
    echo '{"generated": "'$(date -Iseconds)'", "source": "cis_security", "count": 0, "benchmarks": []}' > "${OUTPUT_FILE}"
else
    # Download each technology's benchmarks
    for TECH_ID in $TECH_IDS; do
        echo "  Fetching technology: ${TECH_ID}"
        curl -sSL "https://downloads.cisecurity.org/technology/${TECH_ID}/benchmarks/latest" \
          -H "accept: */*" \
          -H "accept-language: en-GB,en-US;q=0.9,en;q=0.8" \
          -b "CookieConsent={stamp:%27YSpmvN/ElLgk7iqAm7IIg/F7nIl2U/Y0CYNFNkpu8hWpdu9it7jG2w==%27%2Cnecessary:true%2Cpreferences:false%2Cstatistics:false%2Cmarketing:false%2Cmethod:%27explicit%27%2Cver:1%2Cutc:1772436175752%2Cregion:%27my%27}" \
          -H "dnt: 1" \
          -H "priority: u=1, i" \
          -H "referer: https://downloads.cisecurity.org/" \
          -H "sec-ch-ua: \"Not(A:Brand\";v=\"8\", \"Chromium\";v=\"144\", \"Google Chrome\";v=\"144\"" \
          -H "sec-ch-ua-mobile: ?0" \
          -H "sec-ch-ua-platform: \"Linux\"" \
          -H "sec-fetch-dest: empty" \
          -H "sec-fetch-mode: cors" \
          -H "sec-fetch-site: same-origin" \
          -H "user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36" \
          -H "x-requested-with: XMLHttpRequest" \
          > "tech-${TECH_ID}.json" 2>/dev/null || true
    done

    # Step 3: Combine all benchmarks into single JSON
    echo "Combining benchmarks..."

    python3 << PYTHON_SCRIPT
import json
import glob
import os
from datetime import datetime

benchmarks = []

for filename in glob.glob("tech-*.json"):
    try:
        with open(filename, 'r') as f:
            data = json.load(f)
            if isinstance(data, list):
                for item in data:
                    if isinstance(item, dict):
                        benchmarks.append(item)
            elif isinstance(data, dict):
                benchmarks.append(data)
    except Exception as e:
        print(f"Warning: Could not parse {filename}: {e}")

output = {
    'generated': datetime.now().isoformat(),
    'source': 'cis_security',
    'count': len(benchmarks),
    'benchmarks': benchmarks
}

with open('${OUTPUT_FILE}', 'w') as f:
    json.dump(output, f, indent=2)

print(f"Combined {len(benchmarks)} benchmarks")
PYTHON_SCRIPT
fi

# Cleanup temp directory
rm -rf "${TEMP_DIR}"

if [ -s "${OUTPUT_FILE}" ]; then
    echo "Successfully downloaded CIS catalog to: ${OUTPUT_FILE}"
    
    # Get file size
    FILE_SIZE=$(stat -c%s "${OUTPUT_FILE}" 2>/dev/null || stat -f%z "${OUTPUT_FILE}" 2>/dev/null)
    echo "File size: ${FILE_SIZE} bytes"
    
    # Count benchmarks
    BENCHMARK_COUNT=$(python3 -c "import json; data=json.load(open('${OUTPUT_FILE}')); print(len(data.get('benchmarks', [])))" 2>/dev/null || echo "N/A")
    echo "Number of benchmarks: ${BENCHMARK_COUNT}"
    
    # Clean up old CIS JSON files (keep only current)
    find "${OUTPUT_DIR}" -name "cis-*.json" ! -name "cis-${DATE_STAMP}.json" -type f -delete 2>/dev/null || true
else
    echo "Error: Failed to download CIS catalog"
    exit 1
fi

echo "Done."
