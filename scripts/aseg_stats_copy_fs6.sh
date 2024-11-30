#!/bin/bash

# Define base and target directories
BASE_DIR="/home/ben/BrainGut/fs6_all"
TARGET_DIR="/home/arvid/fs6_all"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Initialize counters
total_files=0
copied_files=0

# Print start message
echo "Starting to copy aseg.stats files..."
echo "From: $BASE_DIR"
echo "To: $TARGET_DIR"
echo "----------------------------------------"

# Find all aseg.stats files in the specified directory structure
while IFS= read -r file; do
    ((total_files++))
    
    # Extract the BG_xxx_yyyymmdd_hhmm part from the path
    # Example path: /home/ben/BrainGut/fs6_all/BG_004/BG_004_20190531_0825/stats/aseg.stats
    session_dir=$(basename "$(dirname "$(dirname "$file")")")
    
    # Construct new filename
    new_filename="${session_dir}_aseg.stats"
    target_path="$TARGET_DIR/$new_filename"
    
    # Copy the file
    if cp "$file" "$target_path"; then
        ((copied_files++))
        echo "Copied: $file"
        echo "To: $target_path"
        echo "----------------------------------------"
    else
        echo "Failed to copy: $file"
        echo "----------------------------------------"
    fi
    
done < <(find "$BASE_DIR" -type f -path "*/BG_*/BG_*_*/stats/aseg.stats")

# Print summary
echo "Copy operation completed"
echo "Total files found: $total_files"
echo "Successfully copied: $copied_files"

# Check if any files were found
if [ $total_files -eq 0 ]; then
    echo "Warning: No aseg.stats files were found in the specified directory structure"
    exit 1
fi

# Check if all files were copied successfully
if [ $copied_files -ne $total_files ]; then
    echo "Warning: Some files failed to copy"
    exit 1
fi

exit 0

