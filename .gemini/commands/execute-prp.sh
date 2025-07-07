#!/bin/bash

# ---
# execute-prp.sh
#
# Description:
#   This script starts the feature implementation process by sending a
#   completed PRP (Product Requirements Prompt) to the Gemini API.
#
# Usage:
#   ./.gemini/scripts/execute-prp.sh <path_to_prp_file>
#
# Example:
#   ./.gemini/scripts/execute-prp.sh PRPs/weather_cli_prp.md
# ---

# 1. Validate Input
# -----------------
if [ -z "$1" ]; then
  echo "Error: No PRP file specified."
  echo "Usage: $0 <path_to_prp_file>"
  exit 1
fi

if [ ! -f "$1" ]; then
  echo "Error: File '$1' not found."
  exit 1
fi

PRP_FILE_PATH=$1

# 2. Define the Execution Prompt
# ------------------------------
EXECUTE_PRP_PROMPT=$(cat <<'END_PROMPT'
You are an expert-level AI software engineer. Your task is to implement the feature described in the following Product Requirements Prompt (PRP).

Your process should be:
1.  **Full Context Ingestion**: Read and fully understand every part of the PRP, including the goal, context, implementation plan, and validation loops.
2.  **Create a Step-by-Step Plan**: Before writing any code, list the specific actions you will take (e.g., "CREATE file `src/new_feature.py`", "MODIFY file `src/api/routes.py`", "RUN test command `pytest tests/`").
3.  **Execute the Plan**: Implement the code changes as planned. Write the full content for new files and provide clear instructions for modifying existing ones.
4.  **Validate Your Work**: After implementation, explain how you would run the validation commands listed in the PRP and what the expected outcome is.
5.  **Iterate if Necessary**: If a validation step were to fail, explain the likely cause and how you would correct the code.

Begin the implementation now.
END_PROMPT
)

# Read the content of the PRP file
PRP_CONTENT=$(cat "$PRP_FILE_PATH")

# 3. Prepare and "Send" the Prompt
# --------------------------------
FULL_PROMPT="${EXECUTE_PRP_PROMPT}

Here is the PRP to execute:
---
${PRP_CONTENT}
---
"

echo "------------------------------------------------------------------"
echo "✅ Prepared PRP for execution."
echo "------------------------------------------------------------------"
echo "This script's job is to kick off the interactive session with Gemini."
echo "Copy the full prompt below and paste it into your Gemini chat interface"
echo "to begin the implementation process."
echo "------------------------------------------------------------------"
echo ""

# We will save the full prompt to a temporary file for the user to easily copy.
TEMP_FILE=$(mktemp)
echo "$FULL_PROMPT" > "$TEMP_FILE"

echo "A temporary file has been created with the full prompt:"
echo "$TEMP_FILE"
echo ""
echo "You can now copy its content to your clipboard."
echo "For example, on macOS:"
echo "pbcopy < $TEMP_FILE"
echo "On Linux (with xclip):"
echo "xclip -selection clipboard < $TEMP_FILE"
echo ""
echo "------------------------------------------------------------------"

