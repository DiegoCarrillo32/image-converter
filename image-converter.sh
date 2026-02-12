#!/bin/bash

# Folder with input images (default is current folder)
INPUT_DIR=${1:-.}

# Output sizes
SIZES=(400 768 1200)

# Create output directory if needed
OUTPUT_DIR="$INPUT_DIR/webp"
mkdir -p "$OUTPUT_DIR"

# Loop through image files (JPG, PNG, etc.)
for image in "$INPUT_DIR"/*.{jpg,jpeg,png,JPG,JPEG,PNG,HEIC}; do
  [ -e "$image" ] || continue  # Skip if no matching files

  filename=$(basename "$image")
  name="${filename%.*}"

  for size in "${SIZES[@]}"; do
    output="$OUTPUT_DIR/${name}-${size}.webp"
    echo "Creating $output"
    magick "$image" -resize "${size}" -quality 85 "$output"
  done
done

echo "✅ Done converting images to WebP in $OUTPUT_DIR"
