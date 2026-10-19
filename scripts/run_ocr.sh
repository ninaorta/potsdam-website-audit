#!/bin/bash
# Run Tesseract on screenshots and save raw output to ocr/raw/.
# Usage (from the repository root):
#   bash scripts/run_ocr.sh screenshots/ps-fire.png screenshots/parks-garner.png screenshots/board-rec.png
# Raw files are evidence: never edit them. Copy to ocr/verified/ and correct the copy.

set -e
mkdir -p ocr/raw
tesseract --version | head -n 1 > ocr/raw/TESSERACT_VERSION.txt

for img in "$@"; do
  name=$(basename "$img" .png)
  # --psm 3 = automatic page layout (Tesseract default), stated explicitly for reproducibility
  tesseract "$img" "ocr/raw/$name" -l eng --psm 3
  echo "done: ocr/raw/$name.txt"
done
