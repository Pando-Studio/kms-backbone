Perform an adversarial review of a document or set of documents.

An adversarial review explicitly tries to **find failures, gaps, and misalignments** — not to confirm quality. The goal is to discover what's missing before it costs more downstream.

Reference: the KMS Backbone docs (docs/ in the backbone repo) — Gates, Adversarial review.

The user will provide:
1. Path to the document(s) to review
2. Optional: review type (spec-review, architecture-review, story-review, gate-review)

Steps:
1. Read the target document(s) thoroughly
2. Read upstream documents for context:
   - For specs: read the intents and signals that motivated them
   - For architecture: read the stories and glossary it should serve
   - For stories: read the personas and research report
   - For tasks: read the parent story and architecture
3. Apply the review checklist below
4. Score each dimension

## Review dimensions

**Completeness** (are all required sections present and filled?):
- [ ] No N/C or TODO items left unresolved
- [ ] All referenced documents exist
- [ ] Edge cases and error states documented

**Consistency** (does it align with upstream documents?):
- [ ] Terminology matches the glossary
- [ ] Requirements trace back to user needs (signals/intents)
- [ ] No contradictions with other specs or ADRs

**Clarity** (can someone implement from this without asking questions?):
- [ ] Acceptance criteria are testable (Given/When/Then)
- [ ] No ambiguous words ("should", "might", "probably", "etc.")
- [ ] Scope boundaries are explicit (what's in vs out)

**Feasibility** (can this actually be built as described?):
- [ ] Technical approach is realistic
- [ ] Dependencies are identified and available
- [ ] No blocking unknowns

**Information loss** (is fidelity preserved from upstream?):
- [ ] User needs from signals are accurately reflected
- [ ] No requirements invented that don't trace to a signal or intent
- [ ] Nuance preserved (not oversimplified)

## Output format

```markdown
# Review — {document name} — {date}

## Summary
{1-2 sentences: overall assessment}

## Score
| Dimension | Score (1-5) | Key issue |
|---|---|---|
| Completeness | {score} | {main gap} |
| Consistency | {score} | {main contradiction} |
| Clarity | {score} | {main ambiguity} |
| Feasibility | {score} | {main risk} |
| Information loss | {score} | {main drift} |
| **Overall** | **{avg}** | |

## Critical issues (blockers)
- {issues that must be fixed before proceeding}

## Warnings (should fix)
- {issues that create risk but don't block}

## Suggestions (nice to have)
- {improvements that would increase quality}
```

Rules:
- Be genuinely critical — the value is in finding problems, not in validation
- Always check traceability (can you trace each requirement back to a signal?)
- Flag any "invented" requirements (present in spec but absent from signals/intents)
- Do NOT fix the issues — report them. The author decides how to address them.
