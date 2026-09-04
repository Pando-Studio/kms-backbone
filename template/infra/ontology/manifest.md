# Repository manifest

> Maps each root module of THIS repository to its profile. One line per module.
> Most organizations compose several profiles (a studio that also teaches, a lab that also sells);
> composition is normal, not an edge case. Deviations from the profile are declared here, not hidden.

| Root module | Profile | Deviations from the profile |
|---|---|---|
| `<module>/` | <profile name or "kernel"> | none \| <declared delta> |
| `infra/` | kernel | none |
| `_archive/` | kernel | none |
| `private/` | kernel (local-only, gitignored) | none |

## Submodule map

A module is NOT a git submodule by default: the submodule is the unit of ACCESS, not of structure. List here the modules that ARE submodules and why (which distinct access population), plus code under `apps/` (always submodules).

| Submodule | Reason (access population) |
|---|---|
| N/C | N/C |
