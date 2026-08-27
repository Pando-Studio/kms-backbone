Generate user stories from project intents and personas.

Reference: the KMS Backbone docs (docs/ in the backbone repo) — Define toolkit, User stories.

The user will provide:
1. Project path (e.g., `projects/acme-app/`)
2. Optional: specific intent or persona to focus on

Steps:
1. Read `{project}/2.intents/` for decisions, briefs, product vision
2. Read `{project}/3.specs/personas.md` (or equivalent) for target users
3. Read `{project}/3.specs/glossary.md` for domain terminology (use exact terms)
4. If a research report exists in `3.specs/`, read it for context
5. Generate stories following the INVEST criteria

Story format:
```
### US-{NNN}: {Short title}

**As a** {persona name},
**I want to** {action using glossary terms},
**So that** {benefit tied to a real user need from signals/intents}.

**Acceptance criteria:**

```gherkin
Given {precondition}
When  {action taken}
Then  {expected result}
```

**Priority:** {Must / Should / Could / Won't} (MoSCoW)
**Effort:** {S / M / L}
**Notes:** {edge cases, dependencies, or open questions}
```

INVEST checklist (verify for each story):
- **I**ndependent: can be built without other stories?
- **N**egotiable: flexible on implementation?
- **V**aluable: delivers user value?
- **E**stimable: effort can be sized (S/M/L)?
- **S**mall: completable in a single wave?
- **T**estable: acceptance criteria are verifiable?

Rules:
- Every story MUST trace back to an intent or signal (cite the source)
- Use glossary terms exactly — flag any term not in the glossary
- Group stories by theme or persona
- Flag stories that fail INVEST criteria
- Do NOT create the file automatically — present stories and wait for user validation
- Write in the language of the project (see the language policy in CLAUDE.md)
- Write N/C for information not available — never invent user needs
