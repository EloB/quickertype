//! Port of `packages/quicktype-core/src/Type/ProvenanceTypeAttributeKind.ts`.
//!
//! With `--debug provenance`, every type of the input graph gets its own
//! index as provenance. Rewrites must carry all provenance over to the new
//! graph unless they deliberately drop attributes; the type graph checks
//! that after every rewrite (`IRTypeAttributesNotPropagated`).

use indexmap::IndexSet;

/// `provenanceTypeAttributeKind`: `provenance`. Applies to every kind,
/// including `any`, and survives `makeInferred`.
#[derive(Clone, Copy, Debug, Default)]
pub struct ProvenanceTypeAttributeKind;

/// `ProvenanceTypeAttributeKind.combine`: the union.
pub(crate) fn combine(arr: &[&IndexSet<u32>]) -> IndexSet<u32> {
    arr.iter().flat_map(|s| s.iter().copied()).collect()
}

/// `ProvenanceTypeAttributeKind.stringify`: the indexes sorted with the
/// default `Array.prototype.sort`, i.e. as strings (`1,10,9`).
pub(crate) fn stringify(p: &IndexSet<u32>) -> String {
    let mut strings: Vec<String> = p.iter().map(u32::to_string).collect();
    strings.sort();
    strings.join(",")
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn sorts_lexicographically() {
        let p: IndexSet<u32> = [10, 9, 1].into_iter().collect();
        assert_eq!(stringify(&p), "1,10,9");
        let q: IndexSet<u32> = [9, 2].into_iter().collect();
        assert_eq!(
            combine(&[&p, &q]).into_iter().collect::<Vec<_>>(),
            vec![10, 9, 1, 2]
        );
    }
}
