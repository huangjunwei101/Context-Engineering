#!/bin/bash

# ---
# generate-prp.sh
#
# Description:
#   This script generates a comprehensive Product Requirements Prompt (PRP)
#   by sending a feature request file to the Gemini API.
#
# Usage:
#   ./.gemini/scripts/generate-prp.sh <path_to_feature_file>
#
# Example:
#   ./.gemini/scripts/generate-prp.sh INITIAL.md
# ---

# 1. Validate Input
# -----------------
if [ -z "$1" ]; then
  echo "Error: No feature file specified."
  echo "Usage: $0 <path_to_feature_file>"
  exit 1
fi

if [ ! -f "$1" ]; then
  echo "Error: File '$1' not found."
  exit 1
fi

FEATURE_FILE_PATH=$1

# 2. Define Prompts and Configuration
# -----------------------------------
# This is the core instruction for Gemini on how to behave.
# It tells the model to act as a senior engineer and create a detailed PRP.
GENERATE_PRP_PROMPT=$(cat <<'END_PROMPT'
You are an expert-level AI software engineer. Your task is to generate a complete Product Requirements Prompt (PRP) based on the provided feature request.

# Use the new template path we created.
Use the `.gemini/templates/prp_template.md` as a template for your response.-

Your process should be:
1.  **Analyze the Feature Request**: Thoroughly understand the user's goal, the provided examples, and any other context.
2.  **Research**: Assume you have access to the entire codebase. Think about what existing patterns, files, and conventions should be followed. Mention these in the PRP.
3.  **Structure the PRP**: Fill out all sections of the template, including:
    * **Overview**: A clear definition of the feature.
    * **Context & Resources**: List documentation, file paths, and code snippets the implementing AI will need.
    * **Implementation Blueprint**: Provide a step-by-step plan with tasks. Pseudocode is highly encouraged.
    * **Validation Plan**: Define executable commands for linting and testing to ensure the final code is correct.
4.  **Final Output**: Your final output should be ONLY the completed PRP markdown content, ready to be saved to a file. Do not include any conversational text before or after the markdown.
END_PROMPT
)

# Read the content of the user's feature request file (e.g., INITIAL.md)
FEATURE_REQUEST_CONTENT=$(cat "$FEATURE_FILE_PATH")


# 3. Prepare for API Call
# -----------------------
FULL_PROMPT="${GENERATE_PRP_PROMPT}

Here is the user's feature request:
---
${FEATURE_REQUEST_CONTENT}
---
"

echo "------------------------------------------------------------------"
echo "✅ Prepared Prompt for Gemini."
echo "------------------------------------------------------------------"
echo "Simulating API call... (In a real script, you'd call the Gemini API here)"
echo ""

# 4. Simulate API Call and Handle Output
# --------------------------------------
# For this example, we'll just use the prompt as the response for demonstration.

# Use our new weather PRP for a more consistent simulation.
API_RESPONSE="## THIS IS A SIMULATED RESPONSE FROM GEMINI ##

$(cat PRPs/weather_cli_prp.md)
"


# 5. Save the Output
# ------------------
# Create the PRPs directory if it doesn't exist
mkdir -p PRPs

# Generate a filename from the input file (e.g., INITIAL.md -> initial.md)
BASENAME=$(basename "$FEATURE_FILE_PATH" .md | tr '[:upper:]' '[:lower:]')
OUTPUT_FILE="PRPs/${BASENAME}_prp.md"

echo "$API_RESPONSE" > "$OUTPUT_FILE"

echo "------------------------------------------------------------------"
echo "✅ Success! PRP generated and saved to: $OUTPUT_FILE"
echo "------------------------------------------------------------------"
