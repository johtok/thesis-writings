# Repository Guidelines

## Project Structure & Module Organization
- `content/` — thesis source (entry: `content/main.typ`).
- `figures/` — images/plots used by the thesis.
- `bibliography/` — references (e.g., `references.bib`).
- `notes/` — drafts and planning.
- `output/` — compiled PDFs (e.g., `output/thesis.pdf`).
- `weekly_slides/` and `weekly_slides_pre/` — Typst slide decks (`main.typ` → `main.pdf`).

## Build, Test, and Development Commands
- Compile thesis: `typst compile content/main.typ output/thesis.pdf`.
- Live watch thesis: `typst watch content/main.typ`.
- Build slides: `typst compile weekly_slides/main.typ weekly_slides/main.pdf` (same for `weekly_slides_pre`).
- Optional formatting (if installed): `typstfmt -w content/**/*.typ weekly_slides/**/*.typ`.

## Coding Style & Naming Conventions
- Typst: 2‑space indentation; keep lines ≤100 chars; prefer comments over clever macros.
- Filenames/dirs: snake_case (e.g., `room_response.typ`, `weekly_slides_pre/`).
- Figures: `topic_variant.ext` (e.g., `blm_sweep_v2.png`).
- Citations: keep keys stable and readable (e.g., `smith2020_loudspeaker`).
- Use relative paths; do not rely on local absolute paths.

## Testing Guidelines
- No formal unit tests. A change “passes” if:
  - `typst compile` runs without errors and outputs expected PDF(s).
  - References, figures, and cross‑links resolve correctly.
  - Large binaries are not added accidentally (prefer `output/` or Git LFS if needed).

## Commit & Pull Request Guidelines
- Commit style (keep focused; present tense):
  - Prefixes: `docs:`, `content:`, `fig:`, `slides:`, `build:`, `chore:`.
  - Example: `slides: add week-03 nonlinearity demo`
- PRs should include:
  - Scope summary, key pages/sections touched, and build command used.
  - Before/after screenshot or page numbers if visual changes.
  - Linked issue or TODO where applicable.

## Security & Configuration Tips
- Keep fonts and assets in-repo or document system dependencies.
- Avoid embedding sensitive data in sources or PDFs.
- Ensure reproducibility: pin external data paths; prefer checked‑in figures over remote links.
