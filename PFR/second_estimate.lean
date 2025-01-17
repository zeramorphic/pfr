import PFR.first_estimate

/-!
# Second estimate

The second estimate on tau-minimizers.

Assumptions:

* $X_1, X_2$ are tau-minimizers
* $X_1, X_2, \tilde X_1, \tilde X_2$ be independent random variables, with $X_1,\tilde X_1$ copies of $X_1$ and $X_2,\tilde X_2$ copies of $X_2$.
* $d[X_1;X_2] = k$
* $I_1 :=  I_1 [ X_1+X_2 : \tilde X_1 + X_2 | X_1+X_2+\tilde X_1+\tilde X_2 ]$
* $I_2 := I[ X_1+X_2 : X_1 + \tilde X_1 | X_1+X_2+\tilde X_1+\tilde X_2 ]$

It may make sense to merge this file with first_estimate.lean
-/

open MeasureTheory ProbabilityTheory

variable {G : Type*} [AddCommGroup G] [Fintype G] [hG : MeasurableSpace G] [ElementaryAddCommGroup G 2]

variable {Ω₀₁ Ω₀₂ : Type*} [MeasurableSpace Ω₀₁] [MeasurableSpace Ω₀₂]

variable (p : ref_package Ω₀₁ Ω₀₂ G)

variable {Ω : Type*} [mΩ : MeasurableSpace Ω] {μ : Measure Ω}

variable (X₁ X₂ X₁' X₂' : Ω → G)

variable (h₁ : IdentDistrib X₁ X₁' μ μ) (h2 : IdentDistrib X₂ X₂' μ μ)

variable (h_indep : iIndepFun ![hG, hG, hG, hG] ![X₁, X₂, X₁', X₂'] μ)

variable (h_min: tau_minimizes p (μ.map X₁) (μ.map X₂))

local notation3 "k" => d[ X₁; μ # X₂; μ ]

local notation3 "I₁" => I[ X₁ + X₂ : X₁' + X₂ | X₁ + X₂ + X₁' + X₂' ; μ ]

local notation3 "I₂" => I[ X₁ + X₂ : X₁' + X₁ | X₁ + X₂ + X₁' + X₂' ; μ ]

/--  $$ I_2 \leq 2 \eta k + \frac{2 \eta (2 \eta k - I_1)}{1 - \eta}.$$ -/
lemma second_estimate : I₂ ≤ 2 * η * k + (2 * η * (2 * η * k - I₁)) / (1 - η) := by sorry
