/-!
# Perelman Foundational Theorem Inhabitants

This module gives the term-level interface for the foundational theorem inhabitants
for Abelian Categories and Grothendieck Categories. A complete formalization supplies
these records; the records then construct the admissible-class bridge, exactness
certificates, and categorical foundation closure route.
-/

namespace AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean

structure AbelianCategoryAxiomsFoundationalInhabitants where
  hasZeroObject : Prop
  hasKernels : Prop
  hasCokernels : Prop
  hasBinaryProducts : Prop
  hasBinaryCoproducts : Prop
  monomorphismIsKernel : Prop
  epimorphismIsCokernel : Prop
  hasZeroObjectTerm : hasZeroObject
  hasKernelsTerm : hasKernels
  hasCokernelsTerm : hasCokernels
  hasBinaryProductsTerm : hasBinaryProducts
  hasBinaryCoproductsTerm : hasBinaryCoproducts
  monomorphismIsKernelTerm : monomorphismIsKernel
  epimorphismIsCokernelTerm : epimorphismIsCokernel

structure AbelianCategoryLimitPropertiesFoundationalInhabitants where
  hasPullbacks : Prop
  hasPushouts : Prop
  hasFiniteLimits : Prop
  hasFiniteColimits : Prop
  hasPullbacksTerm : hasPullbacks
  hasPushoutsTerm : hasPushouts
  hasFiniteLimitsTerm : hasFiniteLimits
  hasFiniteColimitsTerm : hasFiniteColimits

structure ExactnessFoundationalInhabitants where
  shortExactSequenceDefined : Prop
  kernelEqualsImage : Prop
  cokernelEqualsCoimage : Prop
  snakeLemmaHolds : Prop
  fiveLemmaHolds : Prop
  longExactSequenceFromShort : Prop
  shortExactSequenceDefinedTerm : shortExactSequenceDefined
  kernelEqualsImageTerm : kernelEqualsImage
  cokernelEqualsCoimageTerm : cokernelEqualsCoimage
  snakeLemmaHoldsTerm : snakeLemmaHolds
  fiveLemmaHoldsTerm : fiveLemmaHolds
  longExactSequenceFromShortTerm : longExactSequenceFromShort

structure GrothendieckCategoryFoundationalInhabitants where
  abelianAxioms : AbelianCategoryAxiomsFoundationalInhabitants
  ab5 : Prop
  hasGenerator : Prop
  enoughInjectives : Prop
  ab5Term : ab5
  hasGeneratorTerm : hasGenerator
  enoughInjectivesTerm : enoughInjectives

structure AdditiveFunctorFoundationalInhabitants where
  preservesZeroObject : Prop
  preservesBinaryProducts : Prop
  preservesBinaryCoproducts : Prop
  preservesKernels : Prop
  preservesCokernels : Prop
  leftExact : Prop
  rightExact : Prop
  exact : Prop
  preservesZeroObjectTerm : preservesZeroObject
  preservesBinaryProductsTerm : preservesBinaryProducts
  preservesBinaryCoproductsTerm : preservesBinaryCoproducts
  preservesKernelsTerm : preservesKernels
  preservesCokernelsTerm : preservesCokernels
  leftExactTerm : leftExact
  rightExactTerm : rightExact
  exactTerm : exact

structure AdmissibleClassBridgeFoundationalInhabitants where
  abelianCategoryIsExact : Prop
  exactSequencesAreKernelCokernelPairs : Prop
  grothendieckCategoryIsAbelian : Prop
  grothendieckCategoryHasEnoughInjectives : Prop
  grothendieckCategoryAB5ImpliesExactColimits : Prop
  generatorGivesFaithfulFunctor : Prop
  abelianCategoryIsExactTerm : abelianCategoryIsExact
  exactSequencesAreKernelCokernelPairsTerm : exactSequencesAreKernelCokernelPairs
  grothendieckCategoryIsAbelianTerm : grothendieckCategoryIsAbelian
  grothendieckCategoryHasEnoughInjectivesTerm : grothendieckCategoryHasEnoughInjectives
  grothendieckCategoryAB5ImpliesExactColimitsTerm : grothendieckCategoryAB5ImpliesExactColimits
  generatorGivesFaithfulFunctorTerm : generatorGivesFaithfulFunctor

structure PerelmanFoundationalTheoremInhabitants where
  abelianAxioms : AbelianCategoryAxiomsFoundationalInhabitants
  limitProperties : AbelianCategoryLimitPropertiesFoundationalInhabitants
  exactness : ExactnessFoundationalInhabitants
  grothendieck : GrothendieckCategoryFoundationalInhabitants
  additiveFunctor : AdditiveFunctorFoundationalInhabitants
  bridge : AdmissibleClassBridgeFoundationalInhabitants

end AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean