#import "@preview/diatypst:0.6.0": *

#show: slides.with(
  title: "Weekly Thesis Presentation", // Required
  subtitle: "A project on Non-linear loudspeaker estimation",
  date: "01.07.2024",
  authors: ("Johannes Nørskov Toke") ,

  // Optional Styling (for more / explanation see in the typst universe)
  ratio: 16/9,
  layout: "large",
  title-color: blue.darken(60%),
  toc: true,
  
)

#let boxed(body,fill:rgb("8a9aa6")) = {box(fill:fill,inset: (x: 3pt, y: 0pt),outset: (y: 3pt),radius: 2pt,)[#body]}

= Overview
== Literature
*Review of non-linear loudspeaker litterature*
- Hugos Thesis
- Klippels papers
- Jens Brehm Nielsen's repport on Thermal models
- Alexander Weider King's paper on fractional derivatives

= Relevant models

== Models of a loudspeaker in increasing complexity (decreasing number of assumptions)
\
#text(size: 12pt)[
 #set heading(numbering: none)
- *Lumped model*
  - _*Linearized*_ at x=0 and i=0
  - _*Nonlinear*_:
    - Accounting for displacement
    - Accounting for current and displacement
    - Accounting for current, displacement and structural modes (diaphragm modes)
  - *Universal differential equation* (ODE with universal approximator)
- *BEM/FEM* (Finite/boundary element method)
]

== Universal differential equations (graybox modelling)
== Model discovery

/ *Sparse Identification of Nonlinear Dynamics (SINDy)*:#block[
A data-driven method for discovering governing equations of dynamical systems directly from measurements.

Given time-series data $x(t)$, assume dynamics:
$dot(x) = Theta(x) xi$

where:
- $Theta(x)$: library of candidate basis functions (e.g. polynomials, trigonometric, rational, etc.)
- $xi$: sparse coefficient vector → selects which terms are active in the dynamics

The algorithm:
+ Build $Theta(x)$ from data
+ Solve sparse regression for $xi$
+ Recover the governing ODE/PDE structure
]
#pagebreak()

/ *Symbolic Regression (SR)*:#block[
A machine-learning approach for identifying analytic expressions that fit observed data by searching over both model structure and parameters.

Given data ${(x _ i, y _ i)} _ (i=1) ^ N $, find an expression:
$ y approx F(x; theta)$
where:
- $F(x; theta)$ is built from a predefined function set $ cal(F) = { +, -, times, div, sin, cos, exp, log, … }$
- $theta$ are tunable parameters in the candidate expression

Algorithm (general form):
+ Generate candidate expressions by composing elements of $cal(F)$
+ Estimate parameters $theta$ for each candidate (e.g. regression, least squares)
+ Score candidates using loss (e.g. MSE, AIC, BIC, complexity penalties)
+ Search expression space via genetic programming, evolutionary search, Monte-Carlo tree search, or differentiable approaches
]
#pagebreak()
/ *Dynamic Mode Decomposition (DMD)*:#block[
A data-driven method for approximating the dynamics of complex systems by decomposing time-series data into spatial-temporal modes.

Given snapshot data $ X = [x _ 1, x _ 2, …, x _ m]$, assume linear evolution:
$ x _ (k+1) approx A x _ k$
where:
- $A$: best-fit linear operator mapping between successive states
- Eigenvalues of $A$: temporal dynamics
- Eigenvectors of $A$: spatial modes

The algorithm:
+ Collect snapshot matrices $X$ and $X'$
+ Compute reduced operator $A$ via SVD
+ Extract DMD modes and frequencies
]
#pagebreak()
== Model approximation
/ *Universal Differential Equations (UDEs)*:#block[
A differential equation with a universal approximator embedded in the right-hand side.
Form:
$ dot(u) = "NN"(u, p, t) $

where:
$"NN"$ is ODE partially or fully explained using a neural network

Training:
+ Define a loss between simulated and observed data
+ Differentiate through the solver (adjoint sensitivities)
+ Optimize $p$ and the weights of $"NN"$

Notes:
- Works for ODEs, SDEs, DAEs, and DDEs; extend to PDEs via method of lines
- Structure (bounds, symmetries, conservation) can be enforced in $f$ or via regularization
]

== Results
*DISCLAIMER - Results are all in comparison to dynax model*
#figure(
image("../loudspeaker.jl/data/results/compare_all_methods_20250912_071548/compare_methods_eval.png",width: 50%)  
)

= Relevant research questions 
== Possible Research questions
#text(size:18pt)[
+ Combine models from manuel and Alex
+ Adressing thermal effect on parameters using either gray or blackbox modelling!
+ Adressing Magnetic hysterisis
+ Adressing polymer hysteresis
  - phenomena: speaker params after having been hot are different than cold after a long time
]