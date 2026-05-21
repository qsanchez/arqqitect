#!/usr/bin/env bash
# Collects *-spec.md files from docs/ into output/specs/.
# Architects create spec files named <component>-spec.md within any chapter folder.
set -euo pipefail

DOCS_DIR="${1:-docs}"
OUTPUT_DIR="${2:-output/specs}"

mkdir -p "$OUTPUT_DIR"

count=0
while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    cp "$file" "$OUTPUT_DIR/$filename"
    echo "Collected: $filename"
    count=$((count + 1))
done < <(find "$DOCS_DIR" -name "*-spec.md" -print0 | sort -z)

echo "Done. $count spec file(s) written to $OUTPUT_DIR"
