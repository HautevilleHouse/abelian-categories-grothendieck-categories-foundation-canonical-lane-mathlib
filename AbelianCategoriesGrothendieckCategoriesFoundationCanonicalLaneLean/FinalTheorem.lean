import GateLemmas

/-!
# Final Theorem for Abelian Categories Grothendieck Categories Foundation

This module combines the bridge and gate into the constrained closure theorem.
-/

namespace AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean

/-- The constrained abelian Grothendieck closure: bridge and gate must both close. -/
def ConstrainedAbelianGrothendieckClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

/-- Every admissible class yields the constrained abelian Grothendieck closure. -/
theorem constrained_abelian_grothendieck_endgame (A : AdmissibleClass) :
    ConstrainedAbelianGrothendieckClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean