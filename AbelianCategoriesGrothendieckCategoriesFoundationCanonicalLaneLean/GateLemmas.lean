import BridgeLemmas

/-!
# Gate Lemmas for Abelian Categories Grothendieck Categories Foundation

This module provides the gate side of the admissible-class closure.
-/

namespace AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean

/-- The gate is closed when either the endpoint is satisfied or the remainder
    is recorded. -/
def gateClosed (A : AdmissibleClass) : Prop :=
  A.endpointSatisfied ∨ A.remainderRecorded

/-- Every admissible class supplies the gate witness. -/
theorem gate_from_admissible_class (A : AdmissibleClass) :
    gateClosed A := by
  exact A.gateWitness

end AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean