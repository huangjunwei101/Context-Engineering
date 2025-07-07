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
**[What is Context Engineering?](#what-is-context-engineering)**

**[Template Structure](#template-structure)**

**[Step-by-Step Guide](#step-by-step-guide)**

**[Writing Effective INITIAL.md Files](#writing-effective-intial.md-files)**

**[The PRP Workflow]()**

**[Using Examples Effectively]()**

**[Best Practices]()**

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

## Writing Effective INITIAL.md Files
The `INITIAL.md` file is the starting point for any new feature. The quality of your input here directly impacts the quality of the AI's output. Here’s how to make it effective:

- **🎯 The Goal:** Be specific and clear. Instead of "make a login page," write "create a login page with email/password fields, a 'Forgot Password' link, and Google OAuth integration." The more detail, the better.

- **🎨 Inspiration & Examples:** This is one of the most powerful sections. If you have an existing file that shows how you handle API clients, database connections, or error handling, reference it here. It gives the AI a concrete pattern to follow, ensuring consistency.

- **📚 Required Knowledge:** Don't make the AI guess. Provide direct links to the exact API documentation, libraries, or Stack Overflow threads it will need. This saves time and prevents the AI from using outdated or incorrect information.

- **⚠️Potential Pitfalls & Gotchas:** Think about what might go wrong. Does the API have a weird rate limit? Is there a tricky authentication flow? Mentioning these upfront helps the AI avoid common mistakes and build more robust code from the start.

## The PRP Workflow
The PRP (Product Requirements Prompt) workflow is a two-step process designed to ensure the AI has a comprehensive plan before writing a single line of code.

1. **Generation (`generate-prp.sh`):** This first step is about **planning**. The script takes your high-level `INITIAL.md` feature request and asks Gemini to expand it into a detailed technical blueprint (the PRP). This blueprint includes a proposed file structure, a task breakdown, pseudocode, and a validation plan. It forces the AI to think through the entire implementation first.

2. **Execution (`execute-prp.sh`):** This second step is about **implementation**. The script takes the detailed PRP and sends it back to Gemini with a clear instruction: "Build this." Because all the research and planning is already done, the AI can focus solely on writing clean, correct code that follows the blueprint.

This separation of planning from implementation is the key to the workflow's success.

## Using Examples Effectively
The `examples/` folder is your secret weapon for ensuring project consistency. AI assistants excel at pattern recognition.

### What makes a good example?

- **Complete Patterns:** Show a full, working example of a pattern, not just a snippet. For instance, provide a complete API client class, not just one function.

- **Code Structure:** Include examples of how you structure your classes, organize your imports, and name your variables.

- **Error Handling:** Show how you expect errors to be caught and handled. This is often overlooked but is critical for production-quality code.

- **Testing:** Provide an example of a test file (`test_*.py`) that shows your preferred testing style, including how to use mocks.

The more high-quality examples you provide, the less the AI has to guess, and the more the final code will look like you wrote it yourself.

## Best Practices
- **Be Explicit:** Never assume the AI knows your preferences. The more explicit you are in your `INITIAL.md` and `GEMINI.md` files, the better the result will be.

- **Iterate on the Process:** If the AI makes a mistake, don't just fix the code. Think about why it made the mistake. Does a rule in `GEMINI.md` need to be clearer? Do you need a better example in the `examples/` folder? Improving the process will prevent the same mistake from happening again.

- **Trust the Workflow:** It might seem like extra work to write a detailed `INITIAL.md` and review a PRP, but this upfront investment saves a massive amount of time on debugging and refactoring later.

## Acknowledgements
This project's workflow and the core concepts of Context Engineering were inspired by the original [Context-Engineering-Intro](https://github.com/coleam00/context-engineering-intro) repository by coleam00. While the code and templates have been rewritten for a Gemini-based workflow, the foundational ideas come from that excellent project.