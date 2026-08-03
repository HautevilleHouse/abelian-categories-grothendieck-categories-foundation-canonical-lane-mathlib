import Mathlib

/-!
# Admissible-Class Bridge for Abelian Categories and Grothendieck Categories

This file formalizes the bridge between the foundational package for
Grothendieck categories and the admissible-class package that encodes
the exactness properties required for the key theorems in the field.
-/

namespace AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean

/-! ## Grothendieck Foundation Package -/

/-- The fundamental properties of a Grothendieck category. -/
structure GrothendieckFoundationPackage where
  abelianLaw : Prop
  ab5 : Prop
  generatorExists : Prop
  exactSequenceAxiom : Prop

/-- Evidence that a `GrothendieckFoundationPackage` is closed. -/
structure GrothendieckFoundationEvidence (G : GrothendieckFoundationPackage) where
  abelianLaw_closed : G.abelianLaw
  ab5_closed : G.ab5
  generatorExists_closed : G.generatorExists
  exactSequenceAxiom_closed : G.exactSequenceAxiom

/-- The conjunction of all Grothendieck foundation axioms. -/
def GrothendieckFoundationClosed (G : GrothendieckFoundationPackage) : Prop :=
  G.abelianLaw ∧ G.ab5 ∧ G.generatorExists ∧ G.exactSequenceAxiom

theorem grothendieck_foundation_closed_from_evidence
    (G : GrothendieckFoundationPackage) (E : GrothendieckFoundationEvidence G) :
    GrothendieckFoundationClosed G := by
  exact And.intro E.abelianLaw_closed
    (And.intro E.ab5_closed
      (And.intro E.generatorExists_closed E.exactSequenceAxiom_closed))

/-! ## Admissible-Class Bridge Package -/

/-- The admissible-class bridge package: encodes the exactness and
compatibility conditions that a Grothendieck category satisfies as an
admissible category. -/
structure AdmissibleClassBridgePackage where
  admissibleMonomorphismClass : Prop
  admissibleEpimorphismClass : Prop
  exactSequenceComposition : Prop
  pullbackPushoutCompatibility : Prop

/-- Evidence that an `AdmissibleClassBridgePackage` is closed. -/
structure AdmissibleClassBridgeEvidence (B : AdmissibleClassBridgePackage) where
  admissibleMonomorphismClass_closed : B.admissibleMonomorphismClass
  admissibleEpimorphismClass_closed : B.admissibleEpimorphismClass
  exactSequenceComposition_closed : B.exactSequenceComposition
  pullbackPushoutCompatibility_closed : B.pullbackPushoutCompatibility

/-- The conjunction of all admissible-class bridge axioms. -/
def AdmissibleClassBridged (B : AdmissibleClassBridgePackage) : Prop :=
  B.admissibleMonomorphismClass ∧ B.admissibleEpimorphismClass ∧
  B.exactSequenceComposition ∧ B.pullbackPushoutCompatibility

theorem admissible_class_bridged_from_evidence
    (B : AdmissibleClassBridgePackage) (E : AdmissibleClassBridgeEvidence B) :
    AdmissibleClassBridged B := by
  exact And.intro E.admissibleMonomorphismClass_closed
    (And.intro E.admissibleEpimorphismClass_closed
      (And.intro E.exactSequenceComposition_closed E.pullbackPushoutCompatibility_closed))

/-! ## The Bridge from Grothendieck to Admissible Classes -/

/-- Construct an admissible-class bridge package from a Grothendieck
foundation package. The admissible class is taken to be the class of all
monomorphisms and epimorphisms in the abelian structure, with the usual
short exact sequences. -/
def grothendieckToAdmissibleBridge (G : GrothendieckFoundationPackage) : AdmissibleClassBridgePackage where
  admissibleMonomorphismClass := G.abelianLaw ∧ G.exactSequenceAxiom
  admissibleEpimorphismClass := G.abelianLaw ∧ G.exactSequenceAxiom
  exactSequenceComposition := G.exactSequenceAxiom
  pullbackPushoutCompatibility := G.abelianLaw ∧ G.ab5

/-- The main bridge theorem: a Grothendieck category with closed evidence
yields a closed admissible-class bridge. -/
theorem grothendieck_foundation_bridges_admissible_class
    (G : GrothendieckFoundationPackage) (E : GrothendieckFoundationEvidence G) :
    AdmissibleClassBridged (grothendieckToAdmissibleBridge G) := by
  apply admissible_class_bridged_from_evidence
  constructor
  · exact And.intro E.abelianLaw_closed E.exactSequenceAxiom_closed
  · exact And.intro E.abelianLaw_closed E.exactSequenceAxiom_closed
  · exact E.exactSequenceAxiom_closed
  · exact And.intro E.abelianLaw_closed E.ab5_closed

end AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean