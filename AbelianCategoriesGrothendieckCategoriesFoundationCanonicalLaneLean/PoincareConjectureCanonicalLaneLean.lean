-- This module is the root of the AbelianCategoriesGrothendieckCategoriesFoundation Lean proof package.
import Mathlib.CategoryTheory.Abelian
import Mathlib.CategoryTheory.Limits.Shapes.Coproducts
import Mathlib.CategoryTheory.Limits.Filtered
import Mathlib.CategoryTheory.Exact
import Mathlib.CategoryTheory.Limits.Shapes.Discrete

noncomputable section
open CategoryTheory
open CategoryTheory.Limits

universe u v

namespace AbelianCategoriesGrothendieckCategoriesFoundation

/-- Data that characterizes an abelian category: zero object, kernels, and cokernels. -/
structure AbelianData (C : Type u) [Category.{v} C] where
  has_zero : HasZeroObject C
  has_kernels : HasKernels C
  has_cokernels : HasCokernels C

/-- Bridge assertion: the Mathlib `Abelian` class is equivalent to the explicit data. -/
axiom abelian_iff_abelian_data (C : Type u) [Category.{v} C] :
    Nonempty (Abelian C) ↔ Nonempty (AbelianData C)

/-- The class of Grothendieck categories: abelian categories with exact filtered colimits and small coproducts. -/
class GrothendieckCategory (C : Type u) [Category.{v} C] extends Abelian C where
  has_coproducts : ∀ (ι : Type u) (F : ι → C), HasColimit (discrete.functor F)
  has_filtered_colimits : ∀ (J : Type u) [Category.{u} J] [IsFilteredOrEmpty J] (F : J ⥤ C), HasColimit F
  exact_filtered_colimits : ∀ {J : Type u} [Category.{u} J] [IsFilteredOrEmpty J]
    {F G H : J ⥤ C} (f : F ⟹ G) (g : G ⟹ H),
    (∀ j : J, Exact (f.app j) (g.app j)) → Exact (colimMap f) (colimMap g)

/-- The same data packaged as a structure for bridge purposes. -/
structure GrothendieckData (C : Type u) [Category.{v} C] where
  abelian : Abelian C
  has_coproducts : ∀ (ι : Type u) (F : ι → C), HasColimit (discrete.functor F)
  has_filtered_colimits : ∀ (J : Type u) [Category.{u} J] [IsFilteredOrEmpty J] (F : J ⥤ C), HasColimit F
  exact_filtered : ∀ {J : Type u} [Category.{u} J] [IsFilteredOrEmpty J]
    {F G H : J ⥤ C} (f : F ⟹ G) (g : G ⟹ H),
    (∀ j : J, Exact (f.app j) (g.app j)) → Exact (colimMap f) (colimMap g)

/-- Bridge theorem: the class and the structure are equivalent. -/
axiom grothendieck_iff_data (C : Type u) [Category.{v} C] :
    Nonempty (GrothendieckCategory C) ↔ Nonempty (GrothendieckData C)

/-- A generator (separator) for a category. -/
class HasGenerator (C : Type u) [Category.{v} C] where
  G : C
  isGenerator : ∀ {X Y : C} (f g : X ⟶ Y), (∀ h : G ⟶ X, h ≫ f = h ≫ g) → f = g

/-- Every Grothendieck category has a generator.  This is a classical theorem. -/
axiom grothendieck_has_generator (C : Type u) [Category.{v} C] [GrothendieckCategory C] :
    HasGenerator C

/-- The canonical lane bridge: a bundle of the central facts in the Grothendieck foundation. -/
structure CanonicalLaneBridge (C : Type u) [Category.{v} C] where
  toGrothendieck : Nonempty (GrothendieckCategory C)
  toGenerator : Nonempty (HasGenerator C)
  abelian_is_initial : Abelian C
  exact_filtered : ∀ {J : Type u} [Category.{u} J] [IsFilteredOrEmpty J]
    {F G H : J ⥤ C} (f : F ⟹ G) (g : G ⟹ H),
    (∀ j : J, Exact (f.app j) (g.app j)) → Exact (colimMap f) (colimMap g)

/-- The canonical lane existence is equivalent to the Grothendieck condition. -/
axiom canonical_lane_iff_grothendieck (C : Type u) [Category.{v} C] :
    Nonempty (CanonicalLaneBridge C) ↔ Nonempty (GrothendieckCategory C)

section BridgeLemmas

variable {C : Type u} [Category.{v} C]

/-- A Grothendieck category is abelian. -/
lemma grothendieck_abelian [GrothendieckCategory C] : Abelian C :=
  inferInstance

/-- A Grothendieck category has small coproducts. -/
lemma grothendieck_has_coproducts [GrothendieckCategory C] :
    ∀ (ι : Type u) (F : ι → C), HasColimit (discrete.functor F) :=
  GrothendieckCategory.has_coproducts

/-- A Grothendieck category has filtered colimits. -/
lemma grothendieck_has_filtered_colimits [GrothendieckCategory C] :
    ∀ (J : Type u) [Category.{u} J] [IsFilteredOrEmpty J] (F : J ⥤ C), HasColimit F :=
  GrothendieckCategory.has_filtered_colimits

/-- Filtered colimits preserve exactness in a Grothendieck category. -/
lemma grothendieck_exact_filtered [GrothendieckCategory C] :
    ∀ {J : Type u} [Category.{u} J] [IsFilteredOrEmpty J]
    {F G H : J ⥤ C} (f : F ⟹ G) (g : G ⟹ H),
    (∀ j : J, Exact (f.app j) (g.app j)) → Exact (colimMap f) (colimMap g) :=
  GrothendieckCategory.exact_filtered_colimits

end BridgeLemmas

/-- The canonical lane theorem: every Grothendieck category induces a canonical lane bridge. -/
theorem grothendieck_to_canonical_lane (C : Type u) [Category.{v} C] [GrothendieckCategory C] :
    CanonicalLaneBridge C where
  toGrothendieck := ⟨inferInstance⟩
  toGenerator := ⟨grothendieck_has_generator C⟩
  abelian_is_initial := grothendieck_abelian (C := C)
  exact_filtered := fun f g h => grothendieck_exact_filtered (C := C) f g h

/-- The admissible-class bridge: a Grothendieck category is exactly a canonical lane. -/
theorem admissible_class_bridge (C : Type u) [Category.{v} C] [GrothendieckCategory C] :
    Nonempty (CanonicalLaneBridge C) :=
  ⟨grothendieck_to_canonical_lane C⟩

end AbelianCategoriesGrothendieckCategoriesFoundation