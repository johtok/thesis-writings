#import "@preview/diatypst:0.6.0": *

#show: slides.with(
  title: "Weekly Thesis Presentation", // Required
  subtitle: "A project on Non-linear loudspeaker estimation",
  date: "01.07.2024",
  authors: ("Johannes Nørskov Toke") ,

  // Optional Styling (for more / explanation see in the typst universe)
  ratio: 16/9,
  layout: "medium",
  title-color: blue.darken(60%),
  toc: true,
  
)

#let boxed(body,fill:rgb("8a9aa6")) = {box(fill:fill,inset: (x: 3pt, y: 0pt),outset: (y: 3pt),radius: 2pt,)[#body]}

= Overview
== Overview of work performed this summer and the first week
*Review of non-linear loudspeaker litterature*
- Hugos Thesis
- Klippels papers
*Function approximation*
- ODE param estimation (whitebox modelling)
- Universal Differential Equations (UDEs) (graybox modelling)
- NN approximation (blackbox modelling)

*Symbolic Function retrieval*
- Sparse identification of non-linear dynamics (SINDy)
- Dynamic Mode Decomposition (DMD)
- symbolic regression (SR)

*System identification*
- ARX
- N4SID
- PEM

= Properties of non-linearities
=== Read work of 
*Work over the summer:*
- Explored function approximation
- Explored system Identification
  - q-lpv models


Status and thoughts on research questions