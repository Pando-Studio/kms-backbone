Synthesize the contents of a folder in the KMS.

Reference: the KMS Backbone docs (docs/ in the backbone repo) — pipeline: signals → intents → specs.

The user will provide a folder path (e.g., `projects/acme-travel/1.signals/`). If not provided, ask for it.

Steps:
1. Read all `.md` files in the folder (and subfolders if relevant)
2. Produce a structured synthesis with:
   - **Overview**: what the folder contains, how many documents, date range
   - **Key themes**: main topics and recurring patterns across documents
   - **Key decisions / insights**: important conclusions or decisions found
   - **Open questions**: unresolved items, contradictions, or gaps
   - **Action items**: any pending tasks or next steps mentioned

Output the synthesis directly in the conversation (do NOT create a file unless the user asks to save it).

Follow the guidelines: don't hallucinate. Write N/C for information not found. Match the language of the source documents.
