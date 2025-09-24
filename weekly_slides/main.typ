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
#counter(heading).update(2)
#set heading(numbering: "1.")
= First weekly meeting
== Overview
=== Literature
*Review of non-linear loudspeaker litterature*
- Hugos Thesis
- Klippels papers
- Jens Brehm Nielsen's repport on Thermal models
- Alexander Weider King's paper on fractional derivatives

== Relevant models

=== Models of a loudspeaker in increasing complexity (decreasing number of assumptions)
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

=== Universal differential equations (graybox modelling)
=== Model discovery

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
=== Model approximation
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

=== Results
*DISCLAIMER - Results are all in comparison to dynax model*
// #figure(
// image("../Loudspeaker.jl/data/results/compare_all_methods_20250912_071548/compare_methods_eval.png",width: 50%)  
// )

== Relevant research questions 
=== Possible Research questions
#text(size:18pt)[
+ Combine models from manuel and Alex
+ Adressing thermal effect on parameters using either gray or blackbox modelling!
+ Adressing Magnetic hysterisis
+ Adressing polymer hysteresis
  - phenomena: speaker params after having been hot are different than cold after a long time
]

= MLP without activation
== Quick Summary:
=== Wrote and verified
- Testsignals for simulation and estimation
  - complex sine
  - Bandpassed pinknoise
- Simulation of MassSpringDamperModel in package LoudspeakerModels.jl
  - Currently Only MassSpringDamperModel
- Estimation of Dynamic systems in package AbstractEstimation.jl 
  - Currently Only estimate_with_ann with parametrized activation (currently identity) and optimizer currently adam with bfgs after and cubic interpolation

== Results:
=== Complex sine

=== Pinknoise Bandpassed at 5 to 2000Hz
==  Suggestions to future models and simulations
=== Future Simulation models to look at
- Linear Loudspeaker model (assuming x=0)
  - would enable fitting to real data and comparison to old work
  - would make a good baseline for further models
=== Future Estimation models to look at
  *Models of interest*
    - MLP with activation
    - Surrogates
    - Resovoir Computing
  *Methods of incoporation of interest*
  - end to end gradient estimation
 
  - UDE/NODE formulation
    - see as end to end

= Sceeening papers, Making plan and Fixing code
== Screening papers
=== quaried questions (690)
  (loudspeaker AND nonlinear AND model\* AND ODE) OR (loudspeaker AND nonlinear AND model\*) NOT (piezoelectric OR imaging OR Crystal OR Arrival OR array OR droplets OR "echo cancel\*")
=== Main takeaways so far
- Joint state + parameter estimation
  -   Application of Kalman and RLS adaptive algorithms to non-linear loudspeaker controler parameter estimation: A case study
- Nonlinear AR with exogeneous input (NARX)
- Parameter Estimation via PEM
== MLP results without Nonlinearity
#figure(
   image("../weekly_slides/weeks/w4/FINAL_singleshot_MSD.svg",width: 50%)  
)
#figure(
   image("../weekly_slides/weeks/w4/FINAL_singleshot_MSD_SPEC.svg",width: 50%)  
)
== MLP results without Nonlinearity multishot 
#figure(
   image("../weekly_slides/weeks/w4/FINAL_multishot_MSD.svg",width: 50%)  
)

#figure(
   image("../weekly_slides/weeks/w4/Multishot_data_and_preds_g=3_MSD.svg",width: 50%)  
)

= First principle Experiments & Studyplan 
== Experiment Overview
=== Overview
==== Physical Models
- Experiment 1: Mass Spring Damper system
==== TODO:
===== Physical Models
- Experiment 1: Loud speaker models
===== function approximation
- MLP
- 
===== Statistical Models
===== ML Models
===== Statespace models
- joint estimation

== Experiment 1: Mass Spring Damper system
=== Theory
/ Model Assumptions: #text[Assume a system consisting of a mass, a spring and a damper only consist of a spring described using hookes law $F=-k d$ and a damper (described by viscous damping $F=-c dot(x)$) driven by a force $F_e$ which collectively can be described as an acceleration times a mass described using Newtons 3'rd law $F=m dot.double(x)$, . As there is no nonlinaer or time-variant operators we conclude this is an LTI system of 2. order.
]

/ Time domain:#text[ In the time domain we determine the model as the sum of all forces acting on the system:
$
 F_("total")=& m (dot.double(x)+a(t))-(k x + c dot(x)) \
 <=> dot.double(x)_("total")=&\
$ ]
#pagebreak()
/ Frequency domain: #text[ In the Fourier domain only $sin$,$cos$ are transformed into fractions and thus for solving differential equations the Laplace domain is more suitable as it also transforms $exp$ into fractions meaning that the solution to first and second order differential equations can be solved algibraicly! \ Thus we use it to obtain:
$ cal(L)(F_("total"))=m(s^) $ 

]

/ signal analysis:#text[
  
]
=== Hypothesis
=== Results
=== Discussion

== Experiment 1: Linear Loudspeaker system
=== Assumptions
=== Theory
=== Hypothesis
=== Results
=== Discussion


= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 