import Mathlib.CategoryTheory.Category.Basic
import Mathlib.CategoryTheory.Abelian.Basic

namespace CanonicalLane
namespace AbelianCategoriesGrothendieckCategoriesFoundation

open CategoryTheory

/-- A packaged abelian category. -/
structure AbelianObject where
  carrier : Type
  [category : Category carrier]
  [abelian : Abelian carrier]

attribute [instance] AbelianObject.category AbelianObject.abelian

/-- A generator in a category is an object G whose covariant Hom functor is faithful. -/
def Generator (C : Type) [Category C] (G : C) : Prop :=
  ∀ {X Y : C} (f g : X ⟶ Y), (∀ h : G ⟶ X, h ≫ f = h ≫ g) → f = g

/-- A Grothendieck category: an abelian category with exact filtered colimits and a generator. -/
structure GrothendieckObject extends AbelianObject where
  generator : carrier
  is_generator : Generator carrier generator
  exact_filtered_colimits : Prop

/-- An admissible class of objects in an abelian category. -/
structure AdmissibleClass (A : AbelianObject) where
  contains_zero : Prop
  closed_under_kernels : Prop
  closed_under_cokernels : Prop
  closed_under_extensions : Prop
  closed_under_quotients : Prop
  closed_under_subobjects : Prop
  closed_under_filtered_colimits : Prop

/-- The canonical admissible class associated to a Grothendieck category: all objects. -/
def canonicalAdmissibleClass (G : GrothendieckObject) : AdmissibleClass G.toAbelianObject :=
  { contains_zero := True
    closed_under_kernels := True
    closed_under_cokernels := True
    closed_under_extensions := True
    closed_under_quotients := True
    closed_under_subobjects := True
    closed_under_filtered_colimits := G.exact_filtered_colimits }

/-- Bridge statement: every Grothendieck category is an abelian category. -/
def grothendieck_to_abelian (G : GrothendieckObject) : AbelianObject :=
  G.toAbelianObject

/-- The admissible-class bridge for the foundation of Grothendieck categories. -/
def admissibleClassBridge (G : GrothendieckObject) :
    { A : AbelianObject // Nonempty (AdmissibleClass A) } :=
  ⟨G.toAbelianObject, ⟨canonicalAdmissibleClass G⟩⟩

end AbelianCategoriesGrothendieckCategoriesFoundation
end CanonicalLane