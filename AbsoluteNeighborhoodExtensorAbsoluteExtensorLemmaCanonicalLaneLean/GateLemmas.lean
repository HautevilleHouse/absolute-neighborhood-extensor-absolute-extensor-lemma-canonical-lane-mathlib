import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace AbsoluteNeighborhoodExtensorAbsoluteExtensorLemmaCanonicalLaneLean

/--
The epistemological gate for the Absolute Neighborhood Extensor / Absolute Extensor Lemma.
It is closed when either:
- `A.endpointSatisfied` witnesses the absolute extensor property (every continuous map into A from a closed subspace of a normal space extends);
- or `A.remainderRecorded` records the remaining obstruction to the absolute neighborhood extensor property, so that it can be carried through the bridge closure.
-/
def gateClosed (A : AdmissibleClass) : Prop :=
  A.endpointSatisfied ∨ A.remainderRecorded

/--
Every admissible class in this canonical lane satisfies the gate closure by construction.
-/
theorem gate_from_admissible_class (A : AdmissibleClass) :
    gateClosed A := by
  exact A.gateWitness

end AbsoluteNeighborhoodExtensorAbsoluteExtensorLemmaCanonicalLaneLean
end HautevilleHouse