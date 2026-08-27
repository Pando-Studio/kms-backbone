Build or update a domain glossary for a project.

The glossary is the **first artifact of the Define phase**. It prevents terminological drift between stakeholders, specs, and code.

Reference: the KMS Backbone docs (docs/ in the backbone repo) — Define toolkit, Domain glossary.

The user will provide a project path. If not provided, ask for it.

Steps:
1. Check if `{project}/3.specs/glossary.md` exists
2. Read all available project documents (signals, intents, specs, meetings) to extract domain terms
3. For each term found, capture:
   - **Term**: the word or phrase
   - **Definition**: what it means in this project's context
   - **Category**: Actor, Entity, Action, State, Relationship, or Rule
   - **Aliases**: other words used for the same concept (terminological drift)
   - **Source**: where the term was found

Output format:

```markdown
# Domain Glossary — {project name}

> Shared language between all stakeholders. See the KMS Backbone docs.

| Term | Definition | Category | Aliases | Notes |
|---|---|---|---|---|
| {term} | {definition} | {category} | {aliases or —} | {contextual notes} |
```

Rules:
- Group terms by category (Actors first, then Entities, Actions, States, Relationships, Rules)
- Flag ambiguous terms where the same word is used with different meanings
- Flag missing definitions (term used but never defined) as N/C
- If updating an existing glossary, show what's added/changed
- Ask user to validate before writing the file
- Write in the language of the project (see the language policy in CLAUDE.md)
