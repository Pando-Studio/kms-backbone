Transform raw signals into structured intents.

This is the core KMS pipeline operation: `1.signals/` → `2.intents/`.

Reference: the KMS Backbone docs (docs/ in the backbone repo) — pipeline and Discovery toolkit (insight extraction).

The user will provide a project path (e.g., `projects/acme-travel/`). If not provided, ask for it.

Steps:
1. Read all `.md` files in `{project}/1.signals/`
2. For each signal, extract:
   - **Type**: feedback, interview, email, analytics, meeting notes, market research
   - **Source**: user, client, market, internal
   - **Key observations**: what was said/observed (factual)
   - **Insights**: what it means (interpretation)
   - **Implications**: what we should do about it (action)
3. Group insights by theme (affinity diagramming)
4. Identify patterns: what comes up repeatedly across signals?
5. Flag contradictions between signals
6. Propose structured intent documents to create in `2.intents/`

Output format:

```markdown
# Signal Processing — {project name} — {date}

## Signals analyzed
- {count} documents in 1.signals/

## Themes identified
### Theme 1: {name}
- **Signals**: {list of source files}
- **Key insight**: {synthesis}
- **Implication**: {recommended action}

### Theme 2: ...

## Patterns
- {recurring observations across multiple signals}

## Contradictions
- {signal A says X, signal B says Y}

## Proposed intents
The following documents should be created in `2.intents/`:
- `{filename}.md` — {what it would contain}
```

Rules:
- Do NOT create files automatically — propose and wait for user confirmation
- Use the insight extraction format: Observation → Insight → Implication
- Match the language of the source documents
- Write N/C when information is ambiguous — never invent data
