---
description: Review code changes for bugs, readability, security, and best practices. Use when reviewing staged/unstaged changes or specific files.
---

# Code Review

Review the code changes and provide actionable feedback.

**IMPORTANT: All review output MUST be written in Japanese.**

## Review Target

If `$ARGUMENTS` is provided, review the specified file or path. Otherwise, review the current uncommitted changes:

!`git diff HEAD 2>/dev/null`

## Review Process

1. Read and understand the changed code and its surrounding context
2. Evaluate against the checklist below
3. Report findings grouped by severity

## Checklist

### Correctness
- Logic errors or edge cases not handled
- Off-by-one errors
- Null/undefined access
- Race conditions

### Readability
- Unclear naming
- Overly complex logic that could be simplified
- Missing context where comments would help

### Security
- Hardcoded secrets or credentials
- Unsanitized input
- Injection vulnerabilities (SQL, command, XSS)

### Performance
- Unnecessary allocations or copies
- N+1 queries
- Missing indexes or inefficient data structures

### Best Practices
- Violations of project conventions
- Dead code or unused imports
- Error handling gaps

## Output Format

For each issue found:
- **Severity**: Critical / Warning / Suggestion
- **Location**: `file_path:line_number`
- **Description**: What the issue is and why it matters
- **Suggestion**: How to fix it

End with a brief summary of the overall quality and top priorities.
