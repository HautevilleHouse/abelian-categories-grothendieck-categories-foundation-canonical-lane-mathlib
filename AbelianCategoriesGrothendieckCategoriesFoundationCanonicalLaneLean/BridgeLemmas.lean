import AdmissibleClass

/-!
# Bridge Lemmas for Abelian Categories Grothendieck Categories Foundation

This module provides the bridge side of the admissible-class closure.
-/

namespace AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean

/-- The bridge is closed exactly when the admitted object's Grothendieck
    condition is witnessed. -/
def bridgeClosed (A : AdmissibleClass) : Prop :=
  AbelianWitnessClosed A.object

/-- Every admissible class supplies the bridge witness. -/
theorem bridge_from_admissible_class (A : AdmissibleClass) :
    bridgeClosed A := by
  exact A.object.conclusion

end AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean