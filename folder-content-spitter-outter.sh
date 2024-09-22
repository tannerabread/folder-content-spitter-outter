#!/usr/bin/env zsh
set -e # Exit if a command fails

# Define the name of the ignore file (like .gitignore)
IGNORE_FILE=".foldercontentspitteroutterignore"

# Default output file (can be overridden via command-line arguments)
OUTPUT_FILE=""

# Function to display usage
usage() {
  echo "Usage: $0 -o output_file [files/folders to filter]"
  exit 1
}

# Parse command-line arguments
echo "Parsing command-line arguments..."
while getopts ":o:" opt; do
  case $opt in
    o) OUTPUT_FILE="$OPTARG" ;;
    \?) echo "Invalid option: -$OPTARG" >&2; usage ;;
    :) echo "Option -$OPTARG requires an argument." >&2; usage ;;
  esac
done
shift $((OPTIND -1))

# If no output file is provided, exit
if [[ -z "$OUTPUT_FILE" ]]; then
  echo "Error: Output file must be specified."
  usage
fi

echo "Output file set to: $OUTPUT_FILE"

# Ensure output directory exists
echo "Ensuring output directory exists..."
mkdir -p "$(dirname "$OUTPUT_FILE")"

# Prevent processing the output file
echo "Preventing processing of the output file..."
EXCLUDES+=("$OUTPUT_FILE")

# Check if the .filterignore file exists and load the ignored items
echo "Checking for .filterignore file..."
if [ -f "$IGNORE_FILE" ]; then
  echo "Loading excludes from $IGNORE_FILE..."
  while IFS= read -r line || [ -n "$line" ]; do
    # Ignore comments and empty lines
    [[ "$line" =~ ^#.*$ ]] && continue
    [[ -z "$line" ]] && continue
    EXCLUDES+=("$line")
    echo "Excluding: $line"
  done < "$IGNORE_FILE"
else
  echo "No .filterignore file found."
fi

# Collect the additional command-line filters
INCLUDES=("$@")
echo "Additional includes from command-line: ${INCLUDES[@]}"

# Generate the list of files based on includes
FILE_LIST=()
if [ ${#INCLUDES[@]} -gt 0 ]; then
  echo "Using specific files/folders from command-line..."
  for item in "${INCLUDES[@]}"; do
    if [ -d "$item" ]; then
      echo "Adding directory: $item"
      FILE_LIST+=($(tree "$item" --gitignore -if --noreport))
    elif [ -f "$item" ]; then
      echo "Adding file: $item"
      FILE_LIST+=("$item")
    else
      echo "Skipping non-existent item: $item"
    fi
  done
else
  echo "No specific includes provided, processing current directory..."
  FILE_LIST+=($(tree . --gitignore -if --noreport))
fi

# Debug: Print all the files in the file list
echo "Files to be processed: ${FILE_LIST[@]}"

# Remove excluded files/folders from the file list
echo "Removing excluded files/folders..."
for exclude in "${EXCLUDES[@]}"; do
  echo "Excluding $exclude"
  FILE_LIST=("${FILE_LIST[@]//*$exclude*}")
done

# Debug: Print files after exclusion
echo "Files after exclusion: ${FILE_LIST[@]}"

# Process each file in the filtered file list
for file in "${FILE_LIST[@]}"; do
  echo "Processing file: $file"

  # Skip directories
  if [ -d "$file" ]; then
    echo "Skipping directory: $file"
    continue
  fi

  # Skip empty files
  if [ ! -s "$file" ]; then
    echo "Skipping empty file: $file"
    continue
  fi

  # Add a markdown header with the filename
  echo "Writing filename to output: $file"
  echo "## $file" >> "$OUTPUT_FILE"

  # Detect the language for syntax highlighting based on file extension
  extension="${file##*.}"
  case "$extension" in
    py) lang="python" ;;
    js) lang="javascript" ;;
    ts) lang="typescript" ;;
    sh|zsh|bash) lang="bash" ;;
    md) lang="markdown" ;;
    html|htm) lang="html" ;;
    css) lang="css" ;;
    java) lang="java" ;;
    c) lang="c" ;;
    cpp|cxx|cc) lang="cpp" ;;
    json) lang="json" ;;
    yaml|yml) lang="yaml" ;;
    xml) lang="xml" ;;
    txt) lang="" ;;  # Plain text
    *) lang="" ;;    # Default to no language
  esac

  echo "Detected language for $file: $lang"

  # Add the opening code block with language
  echo "\`\`\`$lang" >> "$OUTPUT_FILE"

  # Append the contents of the file
  echo "Appending file contents: $file"
  cat "$file" >> "$OUTPUT_FILE" || { echo "Error reading file: $file"; continue; }

  # Add the closing code block
  echo "\`\`\`" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
done

# Final output
echo "All files processed. Output written to $OUTPUT_FILE."
