#!/bin/bash

# ---
# execute-prp.sh (v3)
#
# Description:
#   Prepares the final prompt for implementation by finding all local file
#   references within the PRP and injecting their content directly into the prompt.
# ---

# 1. Validate Input
# -----------------
if [ -z "$1" ]; then
  echo "Error: No PRP file specified."
  echo "Usage: $0 <path_to_prp_file>"
  exit 1
fi

PRP_FILE_PATH=$1
if [ ! -f "$PRP_FILE_PATH" ]; then
  echo "Error: PRP file '$PRP_FILE_PATH' not found."
  exit 1
fi

# 2. Define the Execution Prompt
# ------------------------------
EXECUTE_PRP_PROMPT=$(cat <<'END_PROMPT'
You are an expert-level AI software engineer. Your task is to implement the feature described in the following Product Requirements Prompt (PRP).

You have been provided with the full contents of all referenced local files. Use this code as context and a style guide for the new code you will write.

Your process should be:
1.  **Full Context Ingestion**: Read and fully understand every part of the PRP and all the provided file contents.
2.  **Create a Step-by-Step Plan**: Before writing any code, list the specific actions you will take.
3.  **Execute the Plan**: Implement the code changes as planned.
4.  **Validate Your Work**: Explain how you would run the validation commands listed in the PRP.

Begin the implementation now.
END_PROMPT
)

# 3. Inject Referenced File Content
# ---------------------------------
echo "🔎 Scanning PRP for local file references..."
REFERENCED_CONTENT=""
# Use grep to find lines starting with "File:" and awk to extract the file path
REFERENCED_FILES=$(grep -E "^- File:" "$PRP_FILE_PATH" | awk '{print $3}')

for file in $REFERENCED_FILES; do
    if [ -f "$file" ]; then
        echo "  -> Found and injecting content of: $file"
        # Append file content with clear markers
        REFERENCED_CONTENT+=$(cat <<EOF


--- BEGIN content of: $file ---
\`\`\`
$(cat "$file")
\`\`\`
--- END content of: $file ---
EOF
)
    else
        echo "  -> Warning: Referenced file not found: $file"
    fi
done


# 4. Prepare and Output the Final Prompt
# --------------------------------------
PRP_CONTENT=$(cat "$PRP_FILE_PATH")
FULL_PROMPT="${EXECUTE_PRP_PROMPT}

Here is the PRP to execute:
---
${PRP_CONTENT}
---
${REFERENCED_CONTENT}
"

# Save to a temporary file for convenience
TEMP_FILE=$(mktemp)
echo "$FULL_PROMPT" > "$TEMP_FILE"


# Print clear instructions and the final prompt for easy copying
echo ""
echo "✅ PRP and all referenced file content prepared for execution."
echo "--------------------------------------------------------------------------------"
echo "Copy the entire block of text below and paste it into your AI chat interface."
echo "A copy has also been saved to: $TEMP_FILE"
echo "--------------------------------------------------------------------------------"
echo ""
echo "$FULL_PROMPT"
echo ""
echo "--------------------------------------------------------------------------------"
