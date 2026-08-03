import AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean.Route

/-!
# Abelian Categories and Grothendieck Categories Foundation

This module encodes admissible-class bridge certificates for the
foundations of abelian categories and Grothendieck categories.
Each certificate packages named categorical statements and projects
onto earlier closure surfaces.
-/

namespace AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean

structure AbelianCategoryPackage where
  hasZeroObject : Prop
  hasKernels : Prop
  hasCokernels : Prop
  everyMonoIsKernel : Prop
  everyEpiIsCokernel : Prop

structure AbelianCategoryEvidence (P : AbelianCategoryPackage) where
  hasZeroObjectProof : P.hasZeroObject
  hasKernelsProof : P.hasKernels
  hasCokernelsProof : P.hasCokernels
  everyMonoIsKernelProof : P.everyMonoIsKernel
  everyEpiIsCokernelProof : P.everyEpiIsCokernel

def AbelianCategoryClosed (P : AbelianCategoryPackage) : Prop :=
  P.hasZeroObject ∧ P.hasKernels ∧ P.hasCokernels ∧ P.everyMonoIsKernel ∧ P.everyEpiIsCokernel

def abelian_category_closed_from_evidence (P : AbelianCategoryPackage) (E : AbelianCategoryEvidence P) : AbelianCategoryClosed P := by
  exact And.intro E.hasZeroObjectProof
    (And.intro E.hasKernelsProof
      (And.intro E.hasCokernelsProof
        (And.intro E.everyMonoIsKernelProof E.everyEpiIsCokernelProof)))

structure AbelianCategoryCertificate (P : AbelianCategoryPackage) where
  fiveLemma : Prop
  snakeLemma : Prop
  nineLemma : Prop
  fiveLemmaClosed : fiveLemma
  snakeLemmaClosed : snakeLemma
  nineLemmaClosed : nineLemma
  abelianEvidence : AbelianCategoryEvidence P

def AbelianCategoryCertificateClosed {P : AbelianCategoryPackage} (C : AbelianCategoryCertificate P) : Prop :=
  C.fiveLemma ∧ C.snakeLemma ∧ C.nineLemma ∧ AbelianCategoryClosed P

theorem abelian_category_certificate_closed {P : AbelianCategoryPackage} (C : AbelianCategoryCertificate P) :
    AbelianCategoryCertificateClosed C := by
  exact And.intro C.fiveLemmaClosed
    (And.intro C.snakeLemmaClosed
      (And.intro C.nineLemmaClosed
        (abelian_category_closed_from_evidence P C.abelianEvidence)))

structure GrothendieckPackage where
  abelian : AbelianCategoryPackage
  hasFilteredColimits : Prop
  filteredColimitsExact : Prop
  hasGenerator : Prop
  hasInjectiveEnvelopes : Prop

structure GrothendieckEvidence (G : GrothendieckPackage) where
  abelianEvidence : AbelianCategoryEvidence G.abelian
  hasFilteredColimitsProof : G.hasFilteredColimits
  filteredColimitsExactProof : G.filteredColimitsExact
  hasGeneratorProof : G.hasGenerator
  hasInjectiveEnvelopesProof : G.hasInjectiveEnvelopes

def GrothendieckClosed (G : GrothendieckPackage) : Prop :=
  AbelianCategoryClosed G.abelian ∧ G.hasFilteredColimits ∧ G.filteredColimitsExact ∧ G.hasGenerator ∧ G.hasInjectiveEnvelopes

def grothendieck_closed_from_evidence (G : GrothendieckPackage) (E : GrothendieckEvidence G) : GrothendieckClosed G := by
  exact And.intro (abelian_category_closed_from_evidence G.abelian E.abelianEvidence)
    (And.intro E.hasFilteredColimitsProof
      (And.intro E.filteredColimitsExactProof
        (And.intro E.hasGeneratorProof E.hasInjectiveEnvelopesProof)))

structure GrothendieckCertificate (G : GrothendieckPackage) where
  grothendieckAbelianBridge : Prop
  freydMitchellEmbedding : Prop
  injectiveResolutionExistence : Prop
  grothendieckAbelianBridgeClosed : grothendieckAbelianBridge
  freydMitchellEmbeddingClosed : freydMitchellEmbedding
  injectiveResolutionExistenceClosed : injectiveResolutionExistence
  grothendieckEvidence : GrothendieckEvidence G

def GrothendieckCertificateClosed {G : GrothendieckPackage} (C : GrothendieckCertificate G) : Prop :=
  C.grothendieckAbelianBridge ∧ C.freydMitchellEmbedding ∧ C.injectiveResolutionExistence ∧ GrothendieckClosed G

theorem grothendieck_certificate_closed {G : GrothendieckPackage} (C : GrothendieckCertificate G) :
    GrothendieckCertificateClosed C := by
  exact And.intro C.grothendieckAbelianBridgeClosed
    (And.intro C.freydMitchellEmbeddingClosed
      (And.intro C.injectiveResolutionExistenceClosed
        (grothendieck_closed_from_evidence G C.grothendieckEvidence)))

structure AdmissibleClass where
  containsIdentity : Prop
  closedUnderComposition : Prop
  leftCancellation : Prop
  rightCancellation : Prop

structure AdmissibleClassCertificate (G : GrothendieckPackage) where
  filteredColimitsAdmissible : Prop
  generatorAdmissible : Prop
  torsionTheoryInduced : Prop
  filteredColimitsAdmissibleClosed : filteredColimitsAdmissible
  generatorAdmissibleClosed : generatorAdmissible
  torsionTheoryInducedClosed : torsionTheoryInduced
  grothendieckEvidence : GrothendieckEvidence G

def AdmissibleClassCertificateClosed {G : GrothendieckPackage} (A : AdmissibleClassCertificate G) : Prop :=
  A.filteredColimitsAdmissible ∧ A.generatorAdmissible ∧ A.torsionTheoryInduced ∧ GrothendieckClosed G

theorem admissible_class_certificate_closed {G : GrothendieckPackage} (A : AdmissibleClassCertificate G) :
    AdmissibleClassCertificateClosed A := by
  exact And.intro A.filteredColimitsAdmissibleClosed
    (And.intro A.generatorAdmissibleClosed
      (And.intro A.torsionTheoryInducedClosed
        (grothendieck_closed_from_evidence G A.grothendieckEvidence)))

theorem grothendieck_closed_implies_abelian_closed {G : GrothendieckPackage}
    (hG : GrothendieckClosed G) : AbelianCategoryClosed G.abelian := by
  exact hG.1

end AbelianCategoriesGrothendieckCategoriesFoundationCanonicalLaneLean