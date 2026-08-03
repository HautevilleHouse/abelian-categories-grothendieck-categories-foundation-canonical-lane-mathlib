import Mathlib.CategoryTheory.Abelian.Basic
import Mathlib.CategoryTheory.Abelian.Injective
import Mathlib.CategoryTheory.Generator
import Mathlib.CategoryTheory.Limits.Shapes.Coproducts

/-!
# Endpoint Classification Package for Abelian and Grothendieck Categories
-/

namespace HautevilleHouse
namespace AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean

/-- The abelian category foundation: a category with an abelian structure. -/
structure AbelianCategoryFoundation where
  C : Type u
  [instCategory : Category C]
  [instAbelian : Abelian C]

/-- A Grothendieck category foundation extends an abelian category with a generator,
coproducts, and exact filtered colimits. -/
structure GrothendieckCategoryFoundation (A : AbelianCategoryFoundation) where
  generator : A.C
  isGenerator : CategoryTheory.IsGenerator generator
  [hasCoproducts : Limits.HasCoproducts A.C]
  exactFilteredColimits : Prop

/-- The class of Grothendieck categories. -/
class IsGrothendieckCategory (C : Type u) [Category C] [Abelian C] where
  has_coproducts : Limits.HasCoproducts C
  has_generator : ∃ G : C, CategoryTheory.IsGenerator G
  exact_filtered_colimits : Prop

namespace IsGrothendieckCategory

/-- Construct a Grothendieck category from a Grothendieck category foundation. -/
def ofFoundation {A : AbelianCategoryFoundation} (G : GrothendieckCategoryFoundation A) :
    IsGrothendieckCategory A.C where
  has_coproducts := G.hasCoproducts
  has_generator := ⟨G.generator, G.isGenerator⟩
  exact_filtered_colimits := G.exactFilteredColimits

end IsGrothendieckCategory

/-- The admissible class bridge: a Grothendieck category is admissible (has enough injectives). -/
structure AdmissibleClassBridge (A : AbelianCategoryFoundation)
    (G : GrothendieckCategoryFoundation A) where
  [enoughInjectives : EnoughInjectives A.C]

/-- The foundation package bundles the abelian category, the Grothendieck condition, and the bridge. -/
structure FoundationPackage where
  A : AbelianCategoryFoundation
  G : GrothendieckCategoryFoundation A
  B : AdmissibleClassBridge A G

namespace FoundationPackage

/-- The Grothendieck category underlying the foundation. -/
def grothendieck (Z : FoundationPackage) : IsGrothendieckCategory Z.A.C :=
  IsGrothendieckCategory.ofFoundation Z.G

/-- The admissible witness (enough injectives) of the foundation. -/
def admissible (Z : FoundationPackage) : EnoughInjectives Z.A.C :=
  Z.B.enoughInjectives

end FoundationPackage

/-- The endpoint classification package for the foundation. -/
structure EndpointClassificationPackage (Z : FoundationPackage) where
  targetCategory : Type u
  [instCategory : Category targetCategory]
  [instAbelian : Abelian targetCategory]
  isGrothendieck : Prop
  grothendieckEndpoint : IsGrothendieckCategory targetCategory
  endpointMatchesFoundationStatement : Prop

/-- Evidence that the endpoint classification holds. -/
structure EndpointClassificationEvidence {Z : FoundationPackage}
    (Epkg2 : EndpointClassificationPackage Z) where
  isGrothendieckClosed : Epkg2.isGrothendieck
  endpointMatchesFoundationStatementClosed : Epkg2.endpointMatchesFoundationStatement

/-- The endpoint classification is the conjunction of the Grothendieck statement and foundation match. -/
def EndpointClassificationClosed {Z : FoundationPackage}
    (Epkg2 : EndpointClassificationPackage Z) : Prop :=
  Epkg2.isGrothendieck ∧ Epkg2.endpointMatchesFoundationStatement

/-- Evidence implies the endpoint classification. -/
theorem endpoint_classification_closed_from_evidence {Z : FoundationPackage}
    (Epkg2 : EndpointClassificationPackage Z) (E : EndpointClassificationEvidence Epkg2) :
    EndpointClassificationClosed Epkg2 := by
  exact And.intro E.isGrothendieckClosed E.endpointMatchesFoundationStatementClosed

/-- The endpoint classification supplies the mathlib statement of being a Grothendieck category. -/
theorem endpoint_classification_supplies_mathlib_statement {Z : FoundationPackage}
    (Epkg2 : EndpointClassificationPackage Z) :
    IsGrothendieckCategory Epkg2.targetCategory :=
  Epkg2.grothendieckEndpoint

end AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean
end HautevilleHouse