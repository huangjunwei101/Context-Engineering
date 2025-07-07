# Context Engineering Template (Gemini Edition)
A comprehensive template for getting started with Context Engineering - the discipline of engineering context for AI coding assistants so they have the information necessary to get the job done end to end.

**Context Engineering is 10x better than prompt engineering and 100x better than vibe coding.**

## 🚀 Quick Start
```
# 1. Clone this template
git clone https://github.com/your-username/context-engineering-gemini.git
cd context-engineering-gemini

# 2. Set up your project rules (optional - template provided)
# Edit GEMINI.md to add your project-specific guidelines

# 3. Add examples (highly recommended)
# Place relevant code examples in the examples/ folder

# 4. Create your initial feature request
# Edit INITIAL.md with your feature requirements

# 5. Generate a comprehensive PRP (Product Requirements Prompt)
# Make the script executable first: chmod +x .gemini/scripts/generate-prp.sh
./.gemini/scripts/generate-prp.sh INITIAL.md

# 6. Execute the PRP to implement your feature
# Make the script executable first: chmod +x .gemini/scripts/execute-prp.sh
./.gemini/scripts/execute-prp.sh PRPs/initial_prp.md
```

## 📚 Table of Contents
[What is Context Engineering?]

[Template Structure]

[Step-by-Step Guide]

[Writing Effective INITIAL.md Files]

[The PRP Workflow]

[Using Examples Effectively]

[Best Practices]

## What is Context Engineering?
Context Engineering represents a paradigm shift from traditional prompt engineering:

### Prompt Engineering vs Context Engineering
**Prompt Engineering:**

- Focuses on clever wording and specific phrasing

- Limited to how you phrase a task

- Like giving someone a sticky note

**Context Engineering:**

- A complete system for providing comprehensive context

- Includes documentation, examples, rules, patterns, and validation

- Like writing a full screenplay with all the details

### Why Context Engineering Matters
1. **Reduces AI Failures:** Most agent failures aren't model failures - they're context failures

2. **Ensures Consistency:** AI follows your project patterns and conventions

3. **Enables Complex Features:** AI can handle multi-step implementations with proper context

4. **Self-Correcting:** Validation loops allow AI to fix its own mistakes

## Template Structure
```
context-engineering-gemini/
├── .gemini/
│   ├── scripts/
│   │   ├── generate-prp.sh    # Generates comprehensive PRPs
│   │   └── execute-prp.sh     # Kicks off PRP implementation
│   └── templates/
│       └── prp_base.md        # Base template for PRPs
├── PRPs/
│   └── EXAMPLE_multi_agent_prp.md  # Example of a complete PRP
├── examples/                  # Your code examples (critical!)
├── GEMINI.md                  # Global rules for the Gemini assistant
├── INITIAL.md                 # Template for feature requests
├── INITIAL_EXAMPLE.md         # Example feature request
└── README.md                  # This file
```

This template doesn't focus on RAG and tools with context engineering because I have a LOT more in store for that soon. ;)

## Step-by-Step Guide
### 1. Set Up Global Rules (GEMINI.md)
The `GEMINI.md` file contains project-wide rules that the AI assistant will follow.

### 2. Create Your Initial Feature Request
Edit `INITIAL.md` to describe what you want to build.

### 3. Generate the PRP
PRPs (Product Requirements Prompts) are comprehensive implementation blueprints. Run the script:
```
./.gemini/scripts/generate-prp.sh INITIAL.md
```

This script will:

1. Read your feature request.

2. Combine it with a master prompt.

3. Simulate a call to the Gemini API to generate the PRP.

4. Save the result in `PRPs/initial_prp.md`.

**(Note: You will need to replace the simulated API call in the script with your actual Gemini API command.)**

### 4. Execute the PRP
Once generated, use the `execute-prp.sh` script to prepare the final prompt for Gemini.
```
./.gemini/scripts/execute-prp.sh PRPs/initial_prp.md
```
This script prepares a final, comprehensive prompt and saves it to a temporary file. You then copy this prompt and paste it into your interactive Gemini session to begin the implementation.

## Acknowledgements
This project's workflow and the core concepts of Context Engineering were inspired by the original [Context-Engineering-Intro](https://github.com/coleam00/context-engineering-intro) repository by coleam00. While the code and templates have been rewritten for a Gemini-based workflow, the foundational ideas come from that excellent project.