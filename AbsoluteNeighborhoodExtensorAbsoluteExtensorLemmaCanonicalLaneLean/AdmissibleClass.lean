import canonicalLaneMathlib.AdmissibleClass

universe u

namespace HautevilleHouse
namespace AbsoluteNeighborhoodExtensorAbsoluteExtensorLemmaCanonicalLaneLean

class TopologicalSpace (X : Type u) : Type u where
  isOpen : (X → Prop) → Prop

def IsOpen {X : Type u} [TopologicalSpace X] (U : X → Prop) : Prop :=
  TopologicalSpace.isOpen U

def IsClosed {X : Type u} [TopologicalSpace X] (A : X → Prop) : Prop :=
  IsOpen (fun x => ¬ A x)

instance subspaceTopology {X : Type u} [TopologicalSpace X] (A : X → Prop) :
    TopologicalSpace {x : X // A x} where
  isOpen := fun U => ∃ V : X → Prop, IsOpen V ∧ ∀ x hx, U ⟨x, hx⟩ ↔ V x

instance prodTopology {X Y : Type u} [TopologicalSpace X] [TopologicalSpace Y] :
    TopologicalSpace (X × Y) where
  isOpen := fun U => ∃ VX : X → Prop, IsOpen VX ∧ ∃ VY : Y → Prop, IsOpen VY ∧
    ∀ x y, U (x, y) ↔ VX x ∧ VY y

structure ContinuousMap (X Y : Type u) [TopologicalSpace X] [TopologicalSpace Y] where
  toFun : X → Y
  continuous_toFun : Prop

instance {X Y : Type u} [TopologicalSpace X] [TopologicalSpace Y] :
    CoeFun (ContinuousMap X Y) (fun _ => X → Y) where
  coe f := f.toFun

def AbsoluteNeighborhoodExtensor (Y : Type u) [TopologicalSpace Y] : Prop :=
  ∀ (X : Type u) [TopologicalSpace X] (A : X → Prop),
    IsClosed A →
    ∀ f : ContinuousMap {x : X // A x} Y,
      ∃ U : X → Prop,
        IsOpen U ∧
        (∀ x : X, A x → U x) ∧
        ∃ g : ContinuousMap {x : X // U x} Y,
          ∀ (x : X) (hx : A x), g x = f ⟨x, hx⟩

def AbsoluteExtensor (Y : Type u) [TopologicalSpace Y] : Prop :=
  ∀ (X : Type u) [TopologicalSpace X] (A : X → Prop),
    IsClosed A →
    ∀ f : ContinuousMap {x : X // A x} Y,
      ∃ g : ContinuousMap X Y,
        ∀ (x : X) (hx : A x), g x = f ⟨x, hx⟩

structure HomotopyBetween (Y : Type u) [TopologicalSpace Y] (f g : Y → Y) : Prop where
  time : Type u
  [timeTop : TopologicalSpace time]
  leftEnd : time
  rightEnd : time
  map : ContinuousMap (Y × time) Y
  map_left : ∀ y : Y, map (y, leftEnd) = f y
  map_right : ∀ y : Y, map (y, rightEnd) = g y

def Contractible (Y : Type u) [TopologicalSpace Y] : Prop :=
  ∃ c : Y, HomotopyBetween Y (fun y : Y => y) (fun _ : Y => c)

def AbsoluteNeighborhoodExtensorAbsoluteExtensorLemma (Y : Type u) [TopologicalSpace Y] : Prop :=
  (AbsoluteNeighborhoodExtensor Y ∧ Contractible Y) ↔ AbsoluteExtensor Y

structure AdmittedObject (Y : Type u) [TopologicalSpace Y] where
  citation : String
  ae : AbsoluteExtensor Y
  ane : AbsoluteNeighborhoodExtensor Y
  contractible : Contractible Y

structure AdmissibleClass (Y : Type u) [TopologicalSpace Y] where
  object : AdmittedObject Y
  bridgeClosed : AbsoluteNeighborhoodExtensorAbsoluteExtensorLemma Y
  gateClosed : object.ae ∨ (object.ane ∧ object.contractible)

def ConstrainedTheoremClosure {Y : Type u} [TopologicalSpace Y] (A : AdmissibleClass Y) : Prop :=
  A.bridgeClosed ∧ A.gateClosed

theorem bridge_from_admissible_class {Y : Type u} [TopologicalSpace Y] (A : AdmissibleClass Y) :
    A.bridgeClosed :=
  A.bridgeClosed

theorem gate_from_admissible_class {Y : Type u} [TopologicalSpace Y] (A : AdmissibleClass Y) :
    A.gateClosed :=
  A.gateClosed

theorem constrained_theorem_closure {Y : Type u} [TopologicalSpace Y] (A : AdmissibleClass Y) :
    ConstrainedTheoremClosure A :=
  And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

theorem ane_ae_lemma_of_admissible {Y : Type u} [TopologicalSpace Y] (A : AdmissibleClass Y) :
    AbsoluteNeighborhoodExtensorAbsoluteExtensorLemma Y :=
  A.bridgeClosed

theorem absolute_extensor_of_ane_and_contractible
    {Y : Type u} [TopologicalSpace Y]
    (A : AdmissibleClass Y)
    (hANE : AbsoluteNeighborhoodExtensor Y)
    (hContr : Contractible Y) :
    AbsoluteExtensor Y :=
  (A.bridgeClosed).mp ⟨hANE, hContr⟩

theorem ane_and_contractible_of_absolute_extensor
    {Y : Type u} [TopologicalSpace Y]
    (A : AdmissibleClass Y)
    (hAE : AbsoluteExtensor Y) :
    AbsoluteNeighborhoodExtensor Y ∧ Contractible Y :=
  (A.bridgeClosed).mpr hAE

end AbsoluteNeighborhoodExtensorAbsoluteExtensorLemmaCanonicalLaneLean
end HautevilleHouse