#import "@preview/diatypst:0.6.0": *

#show: slides.with(
  title: "Pros & Cons of Modeling Methods",
  subtitle: "Nonlinear Loudspeaker Modeling Overview",
  date: "09.09.2025",
  authors: ("Johannes Nørskov Toke"),
  ratio: 16/9,
  layout: "medium",
  title-color: blue.darken(60%),
  toc: true,
)

// Helper for subtle callouts
#let note(body) = box(fill: gray.lighten(40%), inset: 6pt, radius: 2pt)[#body]

= Overview
== Scope
This deck summarizes typical methods used to model or approximate loudspeaker nonlinearities and their trade‑offs.

== Methods covered
- Physical state‑space (white‑box)
- Volterra / polynomial series
- Hammerstein–Wiener block models
- Data‑driven ML (neural nets)
- Finite‑element (FEA) co‑simulation

= Method: Physical State‑Space (White‑box)
== Pros
- Interpretable parameters (Bl(x), Cms(x), Le(i)) map to mechanics.
- Good extrapolation when physics and constraints are correct.
- Works directly in time domain; captures memory effects.
- Integrates with control and safety limits.
== Cons
- Parameter identification can be laborious and equipment‑heavy.
- Model complexity grows quickly with added effects (thermal, suspension aging).
- Sensitive to unmodeled dynamics and assembly tolerances.

= Method: Volterra / Polynomial Series
== Pros
- Systematic expansion for weak/moderate nonlinearities.
- Closed‑form relations in frequency domain (e.g., distortion orders).
- Useful for analysis, benchmarking, and simplified simulation.
== Cons
- Scales poorly with order and memory length (parameter explosion).
- Limited for strong nonlinearities and hard saturation.
- Interpretation is mathematical, not directly physical.

= Method: Hammerstein–Wiener Blocks
== Pros
- Compact representation of static nonlinearity + linear dynamics.
- Efficient identification (ARX/N4SID for LTI part; simple static maps).
- Good baseline for many audio NL systems.
== Cons
- Misses complex dynamic nonlinearities (e.g., hysteresis, thermal drift).
- Choosing block structure and orders requires care.
- May underfit far‑from‑linear regimes.

= Method: Data‑Driven ML (Neural Nets)
== Pros
- Flexible function approximation of complex NL behavior.
- Can model multi‑input/multi‑domain couplings and memory.
- Strong performance with sufficient, diverse data.
== Cons
- Requires curated datasets; risk of dataset bias and leakage.
- Limited interpretability; harder to trust for extrapolation.
- Needs regularization and monitoring to avoid overfitting.

= Method: Finite‑Element (FEA) Co‑Simulation
== Pros
- High‑fidelity multiphysics (electro‑mech‑acoustic, geometry‑accurate).
- Supports virtual prototyping and sensitivity analysis.
- Produces physically grounded insights for design changes.
== Cons
- Computationally expensive; long turnaround.
- Requires expert meshing and boundary conditions.
- Not ideal for fast system‑ID or real‑time prediction.

= Choosing a Method
== Decision hints
- Need interpretability and safe extrapolation → Physical state‑space.
- Weak/moderate NL analysis or order‑specific metrics → Volterra.
- Lightweight baseline with static NL + dynamics → Hammerstein–Wiener.
- Complex behavior with rich data → ML.
- Geometry/design exploration and multiphysics accuracy → FEA.

#note[
Tip: Hybrid workflows are common, e.g., use FEA for parameter priors, then ID a gray‑box state‑space; or augment Hammerstein–Wiener with a small NN for residuals.
]

= References & Next Steps
== Actions
- Define evaluation signals and metrics (THD, IMD, transient error).
- Collect/curate datasets covering operating envelope.
- Start with a simple baseline (HW/Volterra), then iterate.

== Notes
Replace or extend these slides with project‑specific data, figures, and results as they become available.

