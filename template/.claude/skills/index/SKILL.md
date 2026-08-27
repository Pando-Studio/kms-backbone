Regenerate the index (README.md or table of contents) for a folder.

The user will provide a folder path. If not provided, ask for it.

Steps:
1. List all files and subfolders in the directory
2. Read the first few lines of each `.md` file to extract titles and descriptions
3. Generate a structured index:

```markdown
# {Folder name}

> {One-line description based on content}

## Contents

| File | Description |
|---|---|
| [filename.md](./filename.md) | {extracted title or first heading} |
| [subfolder/](./subfolder/) | {description from subfolder README or content summary} |
```

Rules:
- If a README.md already exists, update it (preserve custom sections, regenerate the file listing)
- If no README.md exists, create one
- Skip binary files, `.DS_Store`, `node_modules/`, etc.
- Sort: folders first (alphabetical), then files (alphabetical)
- Keep it concise — one line per item
