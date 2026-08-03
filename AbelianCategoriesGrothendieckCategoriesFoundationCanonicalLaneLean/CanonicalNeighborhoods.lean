/-!
# Canonical Neighborhoods Package for Abelian Categories and Grothendieck Categories
-/

namespace AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean

/-!
The notion of an admissible-class bridge between an abelian category and a
Grothendieck category. This package encodes the key hypotheses needed for
the canonical neighborhood decomposition in the foundation of abelian
categories and Grothendieck categories.
-/

structure CanonicalNeighborhoodsPackage where
  abelianCategory : Prop
  grothendieckCategory : Prop
  admissibleClassBridge : Prop
  exactnessCompatibility : Prop
  generatorExistence : Prop

structure CanonicalNeighborhoodsEvidence (C : CanonicalNeighborhoodsPackage) where
  abelianCategory_closed : C.abelianCategory
  grothendieckCategory_closed : C.grothendieckCategory
  admissibleClassBridge_closed : C.admissibleClassBridge
  exactnessCompatibility_closed : C.exactnessCompatibility
  generatorExistence_closed : C.generatorExistence

def CanonicalNeighborhoodsClosed (C : CanonicalNeighborhoodsPackage) : Prop :=
  C.abelianCategory ∧ C.grothendieckCategory ∧ C.admissibleClassBridge ∧
  C.exactnessCompatibility ∧ C.generatorExistence

theorem canonical_neighborhoods_closed_of_evidence
    (C : CanonicalNeighborhoodsPackage) (E : CanonicalNeighborhoodsEvidence C) :
    CanonicalNeighborhoodsClosed C := by
  exact And.intro E.abelianCategory_closed
    (And.intro E.grothendieckCategory_closed
      (And.intro E.admissibleClassBridge_closed
        (And.intro E.exactnessCompatibility_closed E.generatorExistence_closed)))

theorem canonical_neighborhoods_evidence_of_closed
    (C : CanonicalNeighborhoodsPackage) (H : CanonicalNeighborhoodsClosed C) :
    CanonicalNeighborhoodsEvidence C := by
  exact {
    abelianCategory_closed := H.1
    grothendieckCategory_closed := H.2.1
    admissibleClassBridge_closed := H.2.2.1
    exactnessCompatibility_closed := H.2.2.2.1
    generatorExistence_closed := H.2.2.2.2
  }

end AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean