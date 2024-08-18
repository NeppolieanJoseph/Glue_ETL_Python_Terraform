#!/bin/bash

# Define the file to be read
FILE="glue_script.py"

# Check if the file exists
if [[ ! -f "$FILE" ]]; then
  echo "File not found!"
  exit 1
fi

# Print each line using sed
sed '' "$FILE"

