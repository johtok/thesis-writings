#import "@preview/diatypst:0.7.1": *
#import "@preview/pintorita:0.1.4"

#set page(height: auto, width: auto, fill: black, margin: 2em)

#show raw.where(lang: "pintora"): it => pintorita.render(it.text,factor:0.33)


#show: slides.with(
  title: "Weekly Thesis Presentation", // Required
  subtitle: "A project on Non-linear loudspeaker estimation",
  date: "01.07.2024",
  authors: ("Johannes Nørskov Toke") ,
  // Optional Styling (for more / explanation see in the typst universe)
  ratio: 16/9,
  layout: "large",
  count: "number",
  title-color: blue.darken(60%),
  toc: true  
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
```pintora
  mindmap
  @param layoutDirection LR
  + Modelling of Nonlinear loudspeaker
  ++ numerical solver
  ++++ Verify the Bodeplot [exp 0]
  ++++ Verify the solver [exp 0]
  ++ Model dynamics
  +++ Linear Model dynamics
  ++++ Mass Spring Damper [exp 0,2]
  ++++ Linear Loudspeaker model [exp 1,2]
  +++ Nonlinear Model dynamics
  ++++ Nonlinear Mass Spring Damper [exp 3]
  ++++ Nonlinear Loudspeaker [exp 3]
  ++ Data Driven Models
  +++ MLP [exp 2,3]
  +++ N4SID [exp 2,3]
  +++ VARX [exp 2,3]
  +++ Kalman filter [exp 2,3]
  +++ SINDy [exp 2,3]
  +++ DMD [exp 2,3]
  +++ NN+SR [exp 2,3]
```
=== Notes on experimental principles and strategies
To uncover the complexities and minimize increase the chances of success experiments are created based on the scientific method and principles of decomposing complexity.

== Experiment 0: Mass Spring Damper system + varifying setup
=== Theory
/ Definition: #text[
  A mass spring damper is a physical system which has a mass, a spring and viscous damping! Assuming an ideal mass, spring and damper its reaction to an external force can be described using newtons 1st and 2nd law, Hooke's law and using the formula of viscous damping.
]
/ Time Domain : #text[
  Using the system description the following second order ODE in the time domain can be formulated as
  $ inline(sum)F &= F_"system"+F_"ext" = F_"mass" + F_"viscous"+F_"spring" + F_"ext" \
  dot.double(x)  &= (- (c dot(x) + k x)+F_"ext")/m 
  $
]
#pagebreak()
/ State Space : #text[
  Because the derivative is of 2nd order $x,dot(x),dot.double(x)$ can be derived using 2 states! Using the time domain formulations the state space formulation is formulated
  $ dot.double(x)  &= (F_"ext" - (c dot(x) + k x))/m \
  &<=> dot(X)=A X +B u quad "where" \ 
  &X=[x,dot(x)]^T, quad u=F_"ext",quad A=mat(0, 1; -k/m, -c/m), B=mat(0; 1/m)\
  $
]
#pagebreak()
/ Harmonic analysis : #text[
  Using the Laplace transformation we obtain the transfer functions for a, v and d
  $ cal(L){dot.double(x)}&=X s^2 - X(0)- X(0)s  = (- (c X s -X(0) + k X)+F_"ext")/m <=>F_"ext"/m = X s^2 +X(c s+k)/m \
<=>F_"ext" &= m X  (s^2+(c s+k)/m)  \
  <=> X/F_"ext" &=  (k/m 1/k)/(s^2+c/m s+k/m) <=> "2nd order Lowpass with:" omega_n=sqrt(k/m), quad zeta= c/(2sqrt(k m))quad "gain"=1/k\
  <=> (X s)/F_"ext" &= (2 c/(2 m sqrt(k/m))sqrt(k/m)1/c s)/(s^2+c/m s+k/m)  <=> "2nd order Bandpass with:" omega_n=sqrt(k/m), quad zeta= c/(2sqrt(k m))= quad "gain"=1/c\
  <=> (X s^2)/F_"ext" &=  (1/m s^2)/(s^2+c/m s+k/m)  <=> "2nd order Highpass with:" omega_n=sqrt(k/m), quad zeta= c/(2sqrt(k m))quad "gain"=1/m
  $
]
=== Hypothesis
Thus making a 50g mass spring damper with natural frequency at 250Hz and damping ratio 0.1 has the parameters $ m=0.05"Kg",k=0.05 dot (250 dot 2 pi)^2 = 123370.055N,c=2 zeta m omega_n = 2 dot 0.01 dot 0.05"Kg" dot 250 dot 2 pi"rad" = 1.571"Ns"/m $  
This theoretical mass spring damper would be very underdamp and thus we expect a ressonance at 250Hz aswell as a -12db rolloff after around 250Hz (not exactly 250 as the damping isn't $omega=omega_n$).

To verify this theory aswell as the solver and Bodeplot we will apply a pinknoise testsignal bandpassed to 10Hz-1000Hz aswell as a complex sine tone!
=== Results
- TODO make julia control statespace model
view results of normal model

=== Discussion

== Experiment 2: Linear models
=== Theory
  In _*experiment 0*_ a linear mass spring damper was derived and tuned with a natural frequency of 250Hz! 
  
  Now a linear loudspeaker will be analyzed, and the findings will be compared to the mass spring damper:
/ Definition: #text[
  A Linear Loudspeaker is a physical system comprised of 3 subsystems: 
  - an electrical system, 
  - a mechanical system 
  - an acoustical system
]
/ *The electrical system*: #text[The electrical system is comprised of a voice coil which is assumed to have a parasitic Resistance, an inductance and to be coupled with the mechanical system by the Lorentz force (converting current to force) and the electromotive force (converting velocity to voltage). Thus this constitutes an "RL" circuit with a current dependent force and velocity dependent voltage source. 
]
#pagebreak()
/ The mechanical system : #text[The mechanical system is comprised of the suspension and the motor system, and the diaphragm and the acoustical load on the diaphragm. Assuming a discretization of physical properties a lumped model of each component can be described which can be described as an equivalent circuit.  Its also comprised of the electrical coupling by the Lorentz force and the electromotive force and an acoustical coupling through the diaphragm velocity and through the ! Thus the mechanical system then can be formulated as an effective mass spring and damper with a voltage dependent force, and a voltage dependent ! 
]
/ The acoustical system : #text[The acoustical system can also be described as having an acoustical resistance,acoustic mass and acoustic compliance thus an equivalent circuit. In academia this system is often accounted for in the mechanical system parameters!

*NOTE:* 

This has to be tested! A hypothesis as to why is that the acoustic resistance, mass and compliance is almost zero speaker in free air! This is a gross assumption which would have to be studied! 
]

#pagebreak()
/ Time Domain : #text[
  Using the system description the following second order ODE in the time domain can be formulated as an second order ode
  $
         u&=B l dot(x)+L_e dif/(dif t)i + R_e i \
    B l i &=K_m x + M_m dot.double(x)+R_m dot(x)
  $
  or as an first order ode by introducing $v=dot(x)$
  $
         u&=B l v+L_e dif/(dif t)i + R_e i \
    B l i &=K_m x + M_m dot(v)+R_m v
  $
]
#pagebreak()
/ State Space : #text[ 
We formulate the statespace model of Second Order ODE Loudspeaker model using the time domain formulation using 3 states as we observe that the highest derivative is 2 for $x$ and 1 for $i$ 
$
         u&=B l dot(x)+L_e dif/(dif t)i + R_e i <=> &dif/(dif t)i=& (u - (B l dot(x) + R_e i))/L_e\
    B l i &=K_m x + M_m dot.double(x)+R_m dot(x) <=> &dot.double(x) =& (B l i - (K_m x +R_m dot(x)))/M_m \
    & &dot.double(x)=&dif/(dif t) dot(x)\
    <=>dot(X)&=A X + B u, "where" quad X = [i,x,dot(x)]^T, quad &A=&mat(-R_e/L_e,0,-(B l)/L_e;0,0,1;(B l)/M_m,-K_m/M_m,-R_m/M_m),B=[1/L_e,0,0]^T
$
  
]
/ Harmonic analysis 1/2 : #text[
  Using the Laplace transformation we obtain the transfer functions for $i$, $x$ and $dot(x)$
  $
    cal(L){B l i } &= B l I = K_m X + M_m X s^2 - X(0)s - X(0) +R_m X s - X(0) <=> I =  (K_m + M_m s^2 +R_m s)/(B l) X\
    cal(L){u}   &= U = B l X s - X(0)+L_e I s -I(0)+ R_e I <=> U = B l X s +( L_e s+ R_e)I  \
    <=>U        &= X B l s +X(L_e s+ R_e)(K_m + M_m s^2 +R_m s)/(B l) = X(B l s +(L_e s+ R_e)(K_m + M_m s^2 +R_m s)/(B l))\
    X/U         &=(B l)/(B l^2 s +(K_m + M_m s^2 +R_m s)(L_e s+ R_e))  <=> "3 poles" => "Lowpass" \ 
    (X s)/U     &= (s B l)/(B l^2 s +(K_m + M_m s^2 +R_m s)(L_e s+ R_e)) <=> "3 poles, 1 zeros" => "Bandpass" \ 
    I/U         &=(K_m + M_m s^2 +R_m s)/(B l^2 s +(K_m + M_m s^2 +R_m s)(L_e s+ R_e)) => "p poles, 2 zeros" => "Notch"
  $
]
=== Experiment 2.a 
==== Hypothesis

==== Results
==== Discussion

== Nonlinear Loudspeaker system

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