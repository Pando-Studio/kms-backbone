# Vectorization Pipeline

**Status: `spec`** — reference implementation to come. This document is the contract; it is precise enough to implement against with any embedding provider and any vector store.

Context: [docs/04-knowledge-cicd.md](../../docs/04-knowledge-cicd.md). CI wiring: [template/.github/workflows/vectorize.yml](../../template/.github/workflows/vectorize.yml).

## Inputs

- **Changed file list** — newline-separated relative paths of `.md` files (env `CHANGED_FILES` or stdin). May include paths that no longer exist on disk: these are deletions.
- **Repository identity** — a stable string identifying the repository (env `REPO_NAMESPACE`, e.g. the repo name). This is the index namespace.

## Chunking

Split each file **by heading**: one chunk per section, where a section is a heading (`#` to `###`) plus its body down to the next heading of the same or higher level. Prepend the file's title and the section's heading path to the chunk text (e.g. `Project X > Specs > Auth flow`) so chunks are self-describing at retrieval time. Sections longer than the embedding model's input limit are split at paragraph boundaries with modest overlap; files with no headings are chunked by paragraphs. Skip files under a minimal size.

## Embedding

One call per batch of chunks to any embedding endpoint (`EMBEDDINGS_API_URL`). The model choice is free but must be uniform across the whole namespace; record the model name in chunk metadata. Changing models means a full rebuild of the namespace.

## Storage

One **namespace per repository** — a distinct collection, table partition, or mandatory `namespace` key, depending on the store. **This is the permission-inheritance property**: because each repository indexes only itself into its own namespace, the index partition is identical to the git access partition, and retrieval scoping reduces to namespace selection ([docs/02-governance.md](../../docs/02-governance.md)). A store shared by several repositories must make cross-namespace queries impossible without explicitly naming the namespace.

Row shape: `(namespace, file_path, chunk_index, content, embedding, metadata)` with a unique key on `(namespace, file_path, chunk_index)`. Metadata carries at least the embedding model and any frontmatter worth filtering on (phase, project).

## Upsert / delete semantics

For each input path, in order:

1. **Delete** all existing rows for `(namespace, file_path)`. This handles deleted files (nothing more to do), renames (the old path arrives as a deletion), and files whose chunk count shrank (no stale trailing chunks).
2. **If the file exists on disk**: chunk, embed, insert the new rows.

Full-rebuild runs additionally **prune orphans**: list distinct `file_path` values in the namespace, delete any not present in the working tree.

## Query-side scoping

A retrieval client (typically an agent tool) determines its allowed namespaces from **the list of repositories present in its checkout** — the hub plus whichever submodules are initialized on its filesystem. It queries exactly those namespaces and merges results. No other filtering is performed, and none is needed: a namespace outside the checkout corresponds to a repository the caller could not clone.
