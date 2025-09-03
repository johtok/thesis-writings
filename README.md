# Thesis Writing Repository

This repository contains the source files for my master's thesis on **[working title: e.g. "Modeling Nonlinearities in Loudspeakers"]**.  
The project is written in [Typst](https://typst.app/) (with some notes in Markdown/LaTeX) and organized for reproducibility and version control.

## Structure
- `content/` — main thesis chapters and sections  
- `figures/` — figures and plots  
- `bibliography/` — reference files (BibTeX/Zotero export)  
- `notes/` — additional notes, drafts, and planning  
- `output/` — compiled PDFs  

## Building
To compile the thesis:

```bash
typst compile content/main.typ output/thesis.pdf
```

For auto-reload during writing:

```bash
typst watch content/main.typ
```

## Contributing
This is primarily a personal writing repo, but feel free to open issues for:
- Typos or clarity suggestions
- Reference material suggestions

## License
All text is © 2025 Johannes Nørskov Toke.  
Figures and data may have separate licenses (see figure captions or appendix).
