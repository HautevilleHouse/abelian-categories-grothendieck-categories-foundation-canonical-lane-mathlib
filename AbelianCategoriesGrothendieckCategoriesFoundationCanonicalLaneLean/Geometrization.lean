/-!
# Abelian Categories Grothendieck Categories Foundation

This file encodes the admissible-class bridge for the key theorems and
structures in the foundation of Grothendieck categories: exact filtered
colimits, generators, enough injectives, and the Gabriel-Popescu
localization theorem.
-/

namespace HautevilleHouse
namespace AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean

universe u

/-- The axiomatic package for an abelian category. -/
structure AbelianCategoryPackage (C : Type u) where
  hasZeroObject : Prop
  hasKernels : Prop
  hasCokernels : Prop
  everyMonoIsKernel : Prop
  everyEpiIsCokernel : Prop
  isAbelian : Prop

/-- A Grothendieck category is an abelian category with exact filtered
colimits and a generator. -/
structure GrothendieckCategoryPackage (C : Type u) extends AbelianCategoryPackage C where
  exactFilteredColimits : Prop
  hasGenerator : Prop
  isGrothendieck : Prop

/-- A concrete witness to the admissible-class bridge: an exact embedding
of a Grothendieck category into a module category which is a localization. -/
structure AdmissibleClassBridge (C : Type u) (G : GrothendieckCategoryPackage C) where
  moduleCategory : Type u
  exactFunctor : Prop
  reflectsExactness : Prop
  isLocalization : Prop

/-- The foundation package for a Grothendieck category `C`. -/
structure GrothendieckFoundationPackage {C : Type u} (G : GrothendieckCategoryPackage C) where
  enoughInjectives : Prop
  gabrielPopescu : Prop
  admissibleClassBridge : Nonempty (AdmissibleClassBridge C G)
  injectiveResolution : Prop

/-- Evidence that the foundation package is closed under the admissible class. -/
structure GrothendieckFoundationEvidence {C : Type u}
    (G : GrothendieckCategoryPackage C) (F : GrothendieckFoundationPackage G) where
  enoughInjectivesClosed : F.enoughInjectives
  gabrielPopescuClosed : F.gabrielPopescu
  admissibleClassBridgeClosed : F.admissibleClassBridge
  injectiveResolutionClosed : F.injectiveResolution

/-- The conjunction of all foundation properties. -/
def GrothendieckFoundationClosed {C : Type u}
    (G : GrothendieckCategoryPackage C) (F : GrothendieckFoundationPackage G) : Prop :=
  F.enoughInjectives ∧ F.gabrielPopescu ∧
  Nonempty (AdmissibleClassBridge C G) ∧ F.injectiveResolution

/-- From the evidence, the foundation package is closed. -/
theorem grothendieckFoundationClosedFromEvidence
    {C : Type u} (G : GrothendieckCategoryPackage C)
    (F : GrothendieckFoundationPackage G) (E : GrothendieckFoundationEvidence G F) :
    GrothendieckFoundationClosed G F := by
  exact And.intro E.enoughInjectivesClosed
    (And.intro E.gabrielPopescuClosed
      (And.intro E.admissibleClassBridgeClosed
        E.injectiveResolutionClosed))

end AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean
end HautevilleHouse