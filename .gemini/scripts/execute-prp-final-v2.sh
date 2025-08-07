#!/bin/bash

# --- 
# execute-prp-final-v2.sh (v14 - Simplified Prompt Loading)
#
# Description:
#   A simplified script that loads the prompt from a separate file.
# ---

# 1. Validate Input & Environment
# --------------------------------
if [ -z "$GEMINI_API_KEY" ]; then
  echo "Error: GEMINI_API_KEY environment variable is not set."
  exit 1
fi
if ! command -v jq &> /dev/null || ! command -v awk &> /dev/null; then
    echo "Error: jq and awk are required. Please install them."
    exit 1
fi
if [ -z "$1" ]; then
  echo "Error: No PRP file specified."
  exit 1
fi

PRP_FILE_PATH=$1
if [ ! -f "$PRP_FILE_PATH" ]; then
  echo "Error: PRP file '$PRP_FILE_PATH' not found."
  exit 1
fi

# 2. Load Prompts from Files
# ---------------------------
SCRIPT_DIR="$(dirname "$0")"
EXECUTE_PRP_PROMPT=$(cat "$SCRIPT_DIR/prp_prompt.txt")
PRP_CONTENT=$(cat "$PRP_FILE_PATH")
FULL_PROMPT="${EXECUTE_PRP_PROMPT}\n\nHere is the PRP to execute:\n---\n${PRP_CONTENT}"

# 3. Send PRP to Gemini and Get the Plan
# --------------------------------------
echo "🤖 Sending PRP to Gemini to generate an implementation plan..."

API_RESPONSE=$(jq -n --arg prompt "$FULL_PROMPT" '{ "contents": [ { "parts": [ { "text": $prompt } ] } ] }' | \
  curl -s -X POST "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=${GEMINI_API_KEY}" \
  -H "Content-Type: application/json" -d @-)

AI_PLAN=$(echo "$API_RESPONSE" | jq -r '.candidates[0].content.parts[0].text')

if [ -z "$AI_PLAN" ] || [ "$AI_PLAN" == "null" ]; then
    echo "Error: Could not get a valid plan from the API."
    echo "Full API Response:"
    echo "$API_RESPONSE"
    exit 1
fi

echo "✅ AI has generated the following plan:"
echo "--------------------------------------------------"
echo "$AI_PLAN"
echo "--------------------------------------------------"

# 4. Parse and Execute the Plan
# -----------------------------
# (The rest of the script remains the same)
PARSED_PLAN=$(echo "$AI_PLAN" | awk '
function print_block() {
    if (type != "") {
        print type " " path;
        print content;
        print "<--BLOCK_SEPARATOR-->";
    }
    in_block = 0; type = ""; path = ""; content = "";
}
/^(CREATE|MODIFY) / { print_block(); type = $1; path = $2; getline; in_block = 1; next; }
/^```bash/ { print_block(); type = "COMMAND"; path = ""; in_block = 1; next; }
/^```/ { print_block(); next; }
{ if (in_block) { if (content == "") content = $0; else content = content "\n" $0; } }
END { print_block(); }
')

echo "🤖 Starting execution of the parsed plan..."

while IFS= read -r header; do
    content=""
    while IFS= read -r line && [[ "$line" != "<--BLOCK_SEPARATOR-->" ]]; do
        if [ -z "$content" ]; then content="$line"; else content="$content\n$line"; fi
    done

    action=$(echo "$header" | awk '{print $1}')
    filepath=$(echo "$header" | awk '{print $2}')

    if [ "$action" == "COMMAND" ]; then
        echo -e "\n🔥 AI wants to execute command:"
        echo "--- Command: ---"
        echo -e "$content"
        echo "----------------"
        read -p "Proceed? [y/n] " -n 1 -r REPLY </dev/tty
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "✅ Action approved. Executing command..."
            eval "$(echo -e "$content")"
        else
            echo "❌ Action skipped by user."
        fi
    elif [ "$action" == "CREATE" ] || [ "$action" == "MODIFY" ]; then
        echo -e "\n🔥 AI wants to $action file: $filepath"
        echo "--- Code: ---"
        echo -e "$content"
        echo "---------------"
        read -p "Proceed? [y/n] " -n 1 -r REPLY </dev/tty
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mkdir -p "$(dirname "$filepath")"
            echo -e "$content" > "$filepath"
            echo "✅ Action approved. File '$filepath' has been written."
        else
            echo "❌ Action skipped by user."
        fi
    fi
done <<< "$PARSED_PLAN"

echo -e "\n🎉 Plan execution complete."
