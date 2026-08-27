Create a structured meeting note from raw notes or a transcription.

The user will provide either:
- A path to a raw transcription/notes file
- Or paste raw notes directly in the conversation

Ask for:
1. Meeting date (YYYY-MM-DD)
2. Participants
3. Project folder where to save the note

Then produce a structured meeting note with:

```markdown
# Meeting — {date} — {short title}

## Participants
- {list}

## Context
{why this meeting happened, what was discussed previously}

## Key points
{numbered list of main discussion points}

## Decisions
{what was decided, by whom}

## Action items
- [ ] {action} — {owner} — {deadline if mentioned}

## Next steps
{next meeting, follow-ups}
```

Save the file in the project's `meetings/` subfolder as `{date}-{short-title}.md` (e.g., `meetings/2026-03-07-kickoff.md`). Create the `meetings/` folder if it doesn't exist.

Follow the guidelines: match the language of the source material. Write N/C for information not available. Don't hallucinate details not in the source.
