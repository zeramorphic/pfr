import PFR.f2_vec
import PFR.first_estimate
import PFR.second_estimate

/-!
# Endgame

The endgame on tau-minimizers.

Assumptions:

* $X_1, X_2$ are tau-minimizers
* $X_1, X_2, \tilde X_1, \tilde X_2$ be independent random variables, with $X_1,\tilde X_1$ copies of $X_1$ and $X_2,\tilde X_2$ copies of $X_2$.
* $d[X_1;X_2] = k$
* $I_1 :=  I_1 [ X_1+X_2 : \tilde X_1 + X_2 | X_1+X_2+\tilde X_1+\tilde X_2 ]$
* $I_2 := I[ X_1+X_2 : X_1 + \tilde X_1 | X_1+X_2+\tilde X_1+\tilde X_2 ]$
* U := X_1 + X_2,
* V := \tilde X_1 + X_2
* W := X_1 + \tilde X_1
* S := X_1 + X_2 + \tilde X_1 + \tilde X_2.
-/


open MeasureTheory ProbabilityTheory

variable {G : Type*} [addgroup: AddCommGroup G] [Fintype G] [hG : MeasurableSpace G] [elem: ElementaryAddCommGroup G 2]

variable {Ω₀₁ Ω₀₂ : Type*} [MeasurableSpace Ω₀₁] [MeasurableSpace Ω₀₂]

variable (p : ref_package Ω₀₁ Ω₀₂ G)

variable {Ω : Type*} [mΩ : MeasurableSpace Ω] {μ : Measure Ω}

variable (X₁ X₂ X₁' X₂' : Ω → G)

variable (h₁ : IdentDistrib X₁ X₁' μ μ) (h2 : IdentDistrib X₂ X₂' μ μ)

variable (h_indep : iIndepFun ![hG, hG, hG, hG] ![X₁, X₂, X₁', X₂'] μ)

variable (h_min: tau_minimizes p (μ.map X₁) (μ.map X₂))

local notation3 "k" => d[ X₁; μ # X₂; μ ]

local notation3 "U" => X₁ + X₂

local notation3 "V" => X₁' + X₂

local notation3 "W" => X₁' + X₁

local notation3 "S" => X₁ + X₂ + X₁' + X₂'

local notation3 "I₁" => I[ U : V | S ; μ ]

local notation3 "I₂" => I[ U : W | S ; μ ]

lemma I₃_eq : I[ V : W | S ; μ ] = I₂ := by sorry

/--
$$ I(U : V | S) + I(V : W | S) + I(W : U | S) $$
is less than or equal to
$$ 6 \eta k - \frac{1 - 5 \eta}{1-\eta} (2 \eta k - I_1).$$
-/
lemma sum_condMutual_le : I[ U : V | S ; μ ] + I[ V : W | S ; μ ] + I[ W : U | S ; μ ] ≤ 6 * η * k - (1 - 5 * η) / (1 - η) * (2 * η * k - I₁) := by sorry

local notation3:max "c[" A " ; " μ' "]" => d[p.X₀₁ ; p.μ₀₁ # A ; μ'] - d[p.X₀₁ ; p.μ₀₁ # X₁ ; μ] + d[p.X₀₂ ; p.μ₀₂ # A ; μ'] - d[p.X₀₂ ; p.μ₀₂ # X₂ ; μ]

local notation3:max "c[" A " | " B " ; " μ' "]" => d[p.X₀₁ ; p.μ₀₁ # A|B ; μ'] - d[p.X₀₁ ; p.μ₀₁ # X₁ ; μ] + d[p.X₀₂ ; p.μ₀₂ # A|B ; μ'] - d[p.X₀₂ ; p.μ₀₂ # X₂ ; μ]


/--
$$ \sum_{i=1}^2 \sum_{A\in\{U,V,W\}} \big(d[X^0_i;A|S] - d[X^0_i;X_i]\big)$$
is less than or equal to
$$ \leq (6 - 3\eta) k + 3(2 \eta k - I_1).$$
-/
lemma sum_dist_diff_le : c[U|S ; μ] + c[V|S ; μ]  + c[W|S; μ] ≤ (6 - 3 * η)*k + 3 * (2*η*k - I₁) := by sorry

/-- $U+V+W=0$. -/
lemma sum_uvw_eq_zero : U+V+W = 0 := by
  funext ω
  dsimp
  rw [add_comm (X₁' ω) (X₂ ω)]
  exact @sum_add_sum_add_sum_eq_zero G addgroup elem _ _ _

/-- If $T_1, T_2, T_3$ are $G$-valued random variables with $T_1+T_2+T_3=0$ holds identically and
$$ \delta := \sum_{1 \leq i < j \leq 3} I[T_i;T_j]$$
Then there exist random variables $T'_1, T'_2$ such that
$$ d[T'_1;T'_2] + \eta (d[X_1^0;T'_1] - d[X_1^0;X_1]) + \eta(d[X_2^0;T'_2] - d[X_2^0;X_2]) $$
is at most
$$\delta + \frac{\eta}{3} \biggl( \delta + \sum_{i=1}^2 \sum_{j = 1}^3 (d[X^0_i;T_j] - d[X^0_i; X_i]) \biggr).$$
-/
lemma construct_good (T₁ T₂ T₃: Ω → G) (hT: T₁+T₂+T₃ = 0) (δ: ℝ) (hδ: δ = I[T₁:T₂; μ] + I[T₂:T₃; μ] + I[T₃:T₁; μ]): ∃ Ω' : Type*, ∃ mΩ' : MeasurableSpace Ω', ∃ μ' : Measure Ω', ∃ T₁' T₂' : Ω' → G, d[T₁'; μ' # T₂'; μ'] + η * (c[T₁'; μ'] + c[T₂'; μ']) ≤ δ + (η/3) * (δ + c[T₁;μ] + c[T₂;μ] + c[T₃;μ]) := by sorry
