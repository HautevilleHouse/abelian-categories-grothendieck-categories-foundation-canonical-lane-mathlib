import TheoremStatement

/-!
# Admissible Class for Abelian Categories Grothendieck Categories Foundation

This module defines the admissible-class carrier for the canonical bridge.
-/

namespace AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean

/-- The admissible class packages an admitted abelian/Grothendieck object
    together with the endpoint/gate remainder data. -/
structure AdmissibleClass where
  object : AbelianAdmittedObject
  endpointSatisfied : Prop
  remainderRecorded : Prop
  gateWitness : endpointSatisfied ∨ remainderRecorded

/-- The full admitted closure combines the bridge and gate witnesses. -/
def admittedClosure (A : AdmissibleClass) : Prop :=
  AbelianWitnessClosed A.object ∧ (A.endpointSatisfied ∨ A.remainderRecorded)

end AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean