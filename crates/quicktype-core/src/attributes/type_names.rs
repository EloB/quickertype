//! Port of `packages/quicktype-core/src/attributes/TypeNames.ts`.
//!
//! The names a type may get, collected from property names, top-level names,
//! titles, ... together with their "distance" (0 = given by the user, larger
//! = inferred from farther away). When the names of a type are combined, the
//! closest ones win.
//!
//! A type with 1000 or more names gets a random name instead
//! (`TooManyTypeNames`), drawn from a seeded [`Chance`] generator. In
//! TypeScript that generator and the set of used random names are module
//! state, reset by `initTypeNames` at the start of every run, so two runs
//! awaiting at the same time share it. Here each run owns a
//! [`TypeNameGenerator`] and installs it for the code it executes
//! ([`with_type_name_generator`]), so interleaved runs on one thread draw
//! from their own generators. Code outside any run draws from a per-thread
//! default generator, which [`init_type_names`] resets.

use std::cell::RefCell;
use std::rc::Rc;

use indexmap::IndexSet;

use crate::attributes::type_attributes::{AttributeKind, TypeAttributes};
use crate::messages::Result;
use crate::support::chance::Chance;
use crate::support::fast_hash::HashSet;
use crate::support::strings::snake_case;
use crate::support::support::panic;
use quicktype_js_compat::utf16;

/// `namesTypeAttributeKind`: the `names` attribute.
#[derive(Clone, Copy, Debug, Default)]
pub struct NamesTypeAttributeKind;

/// `tooManyNamesThreshold`.
pub const TOO_MANY_NAMES_THRESHOLD: usize = 1000;

struct RandomNames {
    /// `Chance(31415)`, seeded when the first random name is drawn: the
    /// seeding (624 steps of the Mersenne Twister) took about 8% of a run
    /// on a tiny input in WebAssembly, and most runs draw no random name.
    /// Nothing else draws from it, so the names are the same.
    chance: Option<Chance>,
    used: HashSet<String>,
}

/// The seed of `initTypeNames`'s generator.
const SEED: u32 = 31415;

/// The random type names of one run: the generator `initTypeNames` seeds
/// (`Chance(31415)`) and the names drawn so far.
pub struct TypeNameGenerator(RefCell<RandomNames>);

impl TypeNameGenerator {
    /// A freshly seeded generator, as `initTypeNames()` leaves it.
    pub fn new() -> Self {
        TypeNameGenerator(RefCell::new(RandomNames {
            chance: None,
            used: HashSet::default(),
        }))
    }

    /// `makeRandomName()`: `"${city} ${animal}"`, retried until unused.
    fn make_random_name(&self) -> String {
        let mut r = self.0.borrow_mut();
        let RandomNames { chance, used } = &mut *r;
        let chance = chance.get_or_insert_with(|| Chance::new(SEED));
        loop {
            let name = format!("{} {}", chance.city(), chance.animal());
            if used.contains(&name) {
                continue;
            }
            used.insert(name.clone());
            return name;
        }
    }
}

impl Default for TypeNameGenerator {
    fn default() -> Self {
        Self::new()
    }
}

impl std::fmt::Debug for TypeNameGenerator {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("TypeNameGenerator")
            .field("used", &self.0.borrow().used.len())
            .finish_non_exhaustive()
    }
}

thread_local! {
    /// The generator of the run whose code is executing on this thread.
    static CURRENT: RefCell<Option<Rc<TypeNameGenerator>>> = const { RefCell::new(None) };
    /// The generator for code that runs outside of any run.
    static DEFAULT: RefCell<Rc<TypeNameGenerator>> = RefCell::new(Rc::new(TypeNameGenerator::new()));
}

/// Runs `f` with `generator` as the source of random type names, then
/// restores the previous one. A run calls this around everything it
/// executes, including each poll of its future.
pub fn with_type_name_generator<R>(generator: &Rc<TypeNameGenerator>, f: impl FnOnce() -> R) -> R {
    struct Restore(Option<Rc<TypeNameGenerator>>);
    impl Drop for Restore {
        fn drop(&mut self) {
            let previous = self.0.take();
            CURRENT.with(|current| *current.borrow_mut() = previous);
        }
    }
    let previous = CURRENT.with(|current| current.replace(Some(Rc::clone(generator))));
    let _restore = Restore(previous);
    f()
}

/// `initTypeNames()` for code outside of any run: reseeds this thread's
/// default generator and forgets the names it drew. Runs start with a
/// fresh generator of their own.
pub fn init_type_names() {
    DEFAULT.with(|d| *d.borrow_mut() = Rc::new(TypeNameGenerator::new()));
}

/// `makeRandomName()`, from the current run's generator.
fn make_random_name() -> String {
    let generator = CURRENT
        .with(|current| current.borrow().clone())
        .unwrap_or_else(|| DEFAULT.with(|d| Rc::clone(&d.borrow())));
    generator.make_random_name()
}

/// `singularizeName(name)`: `pluralize.singular`, except that a name ending
/// in `cookies` (ASCII case-insensitively) just loses its final `s`.
pub fn singularize_name(name: &str) -> String {
    let bytes = name.as_bytes();
    if bytes.len() >= 7 && bytes[bytes.len() - 7..].eq_ignore_ascii_case(b"cookies") {
        return name[..name.len() - 1].to_owned();
    }
    quicktype_js_compat::pluralize::singular(name)
}

/// `combineNames(names)`: one name for a set of names. Several names are
/// normalized to snake case; if they still differ, their common prefix and
/// suffix (in UTF-16 code units, each kept only if longer than 2) form the
/// name, falling back to the first one.
fn combine_names(names: &IndexSet<String>) -> Result<String> {
    let Some(original_first) = names.first() else {
        return panic("Named type has no names");
    };
    if names.len() == 1 {
        return Ok(original_first.clone());
    }

    let names_set: IndexSet<String> = names.iter().map(|s| snake_case(s)).collect();
    let first: Vec<u16> = names_set[0].encode_utf16().collect();
    if names_set.len() == 1 {
        return Ok(names_set[0].clone());
    }

    let mut prefix_length = first.len();
    let mut suffix_length = first.len();
    for n in names_set.iter().skip(1) {
        let n: Vec<u16> = n.encode_utf16().collect();
        prefix_length = prefix_length.min(n.len());
        for i in 0..prefix_length {
            if first[i] != n[i] {
                prefix_length = i;
                break;
            }
        }

        suffix_length = suffix_length.min(n.len());
        for i in 0..suffix_length {
            if first[first.len() - i - 1] != n[n.len() - i - 1] {
                suffix_length = i;
                break;
            }
        }
    }

    let mut combined: Vec<u16> = Vec::new();
    if prefix_length > 2 {
        combined.extend_from_slice(&first[..prefix_length]);
    }
    if suffix_length > 2 {
        combined.extend_from_slice(&first[first.len() - suffix_length..]);
    }
    if combined.len() > 2 {
        // A prefix or suffix can split a surrogate pair. TypeScript keeps
        // the lone surrogate; it is dropped here (see "Known gaps" in
        // docs/PARITY.md).
        return Ok(utf16::units_to_string(&combined));
    }
    Ok(names_set[0].clone())
}

/// `RegularTypeNames`: a set of names at a distance, plus alternatives.
#[derive(Clone, Debug, PartialEq)]
pub struct RegularTypeNames {
    names: IndexSet<String>,
    alternative_names: Option<IndexSet<String>>,
    distance: u32,
}

/// `TooManyTypeNames`: a type that had too many names to choose from, named
/// randomly instead.
#[derive(Clone, Debug, PartialEq)]
pub struct TooManyTypeNames {
    names: IndexSet<String>,
    distance: u32,
}

impl TooManyTypeNames {
    /// `new TooManyTypeNames(distance, name)`; without a name, draws a random
    /// one from the current run's generator.
    pub fn new(distance: u32, name: Option<String>) -> Self {
        let name = name.unwrap_or_else(make_random_name);
        TooManyTypeNames {
            names: [name].into_iter().collect(),
            distance,
        }
    }
}

/// `TypeNames`.
#[derive(Clone, Debug, PartialEq)]
pub enum TypeNames {
    /// `RegularTypeNames`.
    Regular(RegularTypeNames),
    /// `TooManyTypeNames`.
    TooMany(TooManyTypeNames),
}

impl TypeNames {
    /// `TypeNames.makeWithDistance(names, alternativeNames, distance)`.
    pub fn make_with_distance(
        names: IndexSet<String>,
        alternative_names: Option<IndexSet<String>>,
        distance: u32,
    ) -> TypeNames {
        if names.len() >= TOO_MANY_NAMES_THRESHOLD {
            return TypeNames::TooMany(TooManyTypeNames::new(distance, None));
        }
        let alternative_names = alternative_names.filter(|a| a.len() <= TOO_MANY_NAMES_THRESHOLD);
        TypeNames::Regular(RegularTypeNames {
            names,
            alternative_names,
            distance,
        })
    }

    /// `TypeNames.make(names, alternativeNames, areInferred)`.
    pub fn make(
        names: IndexSet<String>,
        alternative_names: Option<IndexSet<String>>,
        are_inferred: bool,
    ) -> TypeNames {
        TypeNames::make_with_distance(names, alternative_names, u32::from(are_inferred))
    }

    /// `distance`.
    pub fn distance(&self) -> u32 {
        match self {
            TypeNames::Regular(r) => r.distance,
            TypeNames::TooMany(t) => t.distance,
        }
    }

    /// `areInferred`.
    pub fn are_inferred(&self) -> bool {
        self.distance() > 0
    }

    /// `names`.
    pub fn names(&self) -> &IndexSet<String> {
        match self {
            TypeNames::Regular(r) => &r.names,
            TypeNames::TooMany(t) => &t.names,
        }
    }

    /// `combinedName`: errors if there are no names.
    pub fn combined_name(&self) -> Result<String> {
        match self {
            TypeNames::Regular(r) => combine_names(&r.names),
            TypeNames::TooMany(t) => match t.names.first() {
                Some(n) => Ok(n.clone()),
                None => panic("Defined value expected, but got undefined"),
            },
        }
    }

    /// `proposedNames`: the combined name, then the alternatives.
    pub fn proposed_names(&self) -> Result<IndexSet<String>> {
        match self {
            TypeNames::Regular(r) => {
                let mut set: IndexSet<String> = [self.combined_name()?].into_iter().collect();
                if let Some(alternatives) = &r.alternative_names {
                    set.extend(alternatives.iter().cloned());
                }
                Ok(set)
            }
            TypeNames::TooMany(t) => Ok(t.names.clone()),
        }
    }

    /// `add(namesArray, startIndex)`: combines these names with
    /// `names_array[start_index..]`. Closer names win; at equal distance the
    /// names are merged. Alternatives are merged regardless of distance.
    pub fn add(&self, names_array: &[&TypeNames], start_index: usize) -> TypeNames {
        match self {
            TypeNames::Regular(r) => r.add(names_array, start_index),
            TypeNames::TooMany(t) => {
                if !self.are_inferred() {
                    return self.clone();
                }
                for (i, other) in names_array.iter().enumerate().skip(start_index) {
                    if other.distance() < t.distance {
                        return other.add(names_array, i + 1);
                    }
                }
                self.clone()
            }
        }
    }

    /// `clearInferred()`.
    pub fn clear_inferred(&self) -> TypeNames {
        match self {
            TypeNames::Regular(r) => {
                let names = if self.are_inferred() {
                    IndexSet::new()
                } else {
                    r.names.clone()
                };
                TypeNames::make_with_distance(names, Some(IndexSet::new()), r.distance)
            }
            TypeNames::TooMany(t) => {
                if !self.are_inferred() {
                    return self.clone();
                }
                TypeNames::make_with_distance(IndexSet::new(), Some(IndexSet::new()), t.distance)
            }
        }
    }

    /// `makeInferred()`: one step farther away.
    pub fn make_inferred(&self) -> TypeNames {
        match self {
            TypeNames::Regular(r) => TypeNames::make_with_distance(
                r.names.clone(),
                r.alternative_names.clone(),
                r.distance + 1,
            ),
            TypeNames::TooMany(t) => TypeNames::TooMany(TooManyTypeNames::new(
                t.distance + 1,
                t.names.first().cloned(),
            )),
        }
    }

    /// `singularize()`: singular names, one step farther away.
    pub fn singularize(&self) -> TypeNames {
        match self {
            TypeNames::Regular(r) => TypeNames::make_with_distance(
                r.names.iter().map(|n| singularize_name(n)).collect(),
                r.alternative_names
                    .as_ref()
                    .map(|a| a.iter().map(|n| singularize_name(n)).collect()),
                r.distance + 1,
            ),
            TypeNames::TooMany(_) => self.clone(),
        }
    }

    /// `toString()`, as printed by the graph printer.
    pub fn to_string(&self) -> Result<String> {
        match self {
            TypeNames::Regular(r) => {
                let inferred = if self.are_inferred() {
                    format!("distance {}", r.distance)
                } else {
                    "given".to_owned()
                };
                let names = format!(
                    "{inferred} {}",
                    r.names
                        .iter()
                        .map(String::as_str)
                        .collect::<Vec<_>>()
                        .join(",")
                );
                Ok(match &r.alternative_names {
                    None => names,
                    Some(alternatives) => format!(
                        "{names} ({})",
                        alternatives
                            .iter()
                            .map(String::as_str)
                            .collect::<Vec<_>>()
                            .join(",")
                    ),
                })
            }
            TypeNames::TooMany(_) => Ok(format!("too many {}", self.combined_name()?)),
        }
    }
}

impl RegularTypeNames {
    fn add(&self, names_array: &[&TypeNames], start_index: usize) -> TypeNames {
        let mut new_names = self.names.clone();
        let mut new_distance = self.distance;
        let mut new_alternative_names = self.alternative_names.clone();

        for (i, other) in names_array.iter().enumerate().skip(start_index) {
            if let TypeNames::Regular(o) = other
                && let Some(alternatives) = &o.alternative_names
            {
                new_alternative_names
                    .get_or_insert_with(IndexSet::new)
                    .extend(alternatives.iter().cloned());
            }

            if other.distance() > new_distance {
                continue;
            }

            let o = match other {
                TypeNames::TooMany(_) => {
                    // The other one is at most our distance, so let it sort it out.
                    return other.add(names_array, i + 1);
                }
                TypeNames::Regular(o) => o,
            };

            if o.distance < new_distance {
                // The other one is closer, so take its names.
                new_names = o.names.clone();
                new_distance = o.distance;
                new_alternative_names = o.alternative_names.clone();
            } else {
                // Same distance, merge them.
                new_names.extend(o.names.iter().cloned());
            }
        }

        TypeNames::make_with_distance(new_names, new_alternative_names, new_distance)
    }
}

/// `namesTypeAttributeKind.combine(namesArray)`:
/// `namesArray[0].add(namesArray, 1)`.
pub(crate) fn combine(names_array: &[&TypeNames]) -> TypeNames {
    match names_array.first() {
        Some(first) => first.add(names_array, 1),
        None => TypeNames::make_with_distance(IndexSet::new(), None, 0),
    }
}

/// `modifyTypeNames(attributes, modifier)`.
pub fn modify_type_names(
    attributes: &TypeAttributes,
    modifier: impl FnOnce(Option<&TypeNames>) -> Option<TypeNames>,
) -> TypeAttributes {
    NamesTypeAttributeKind.modify_in_attributes(attributes, modifier)
}

/// `singularizeTypeNames(attributes)`.
pub fn singularize_type_names(attributes: &TypeAttributes) -> TypeAttributes {
    modify_type_names(attributes, |names| names.map(TypeNames::singularize))
}

/// `makeNamesTypeAttributes(name, areNamesInferred)`: a single name, with an
/// empty (not absent) set of alternatives.
pub fn make_names_type_attributes(name: &str, are_names_inferred: bool) -> TypeAttributes {
    let names = TypeNames::make(
        [name.to_owned()].into_iter().collect(),
        Some(IndexSet::new()),
        are_names_inferred,
    );
    NamesTypeAttributeKind.make_attributes(names)
}

/// `makeNamesTypeAttributes(typeNames)`.
pub fn make_names_type_attributes_from_names(names: TypeNames) -> TypeAttributes {
    NamesTypeAttributeKind.make_attributes(names)
}

#[cfg(test)]
mod tests {
    use super::*;

    /// The generator seeded when the first name is drawn gives the names
    /// `Chance(31415)` gives from the start (`chance.txt` checks those
    /// against TypeScript).
    #[test]
    fn random_names_from_a_generator_seeded_late() {
        let generator = TypeNameGenerator::new();
        let mut chance = Chance::new(SEED);
        let mut used = HashSet::default();
        for _ in 0..500 {
            let expected = loop {
                let name = format!("{} {}", chance.city(), chance.animal());
                if used.insert(name.clone()) {
                    break name;
                }
            };
            assert_eq!(generator.make_random_name(), expected);
        }
    }

    fn set(names: &[&str]) -> IndexSet<String> {
        names.iter().map(|s| (*s).to_owned()).collect()
    }

    fn regular(names: &[&str], alternatives: Option<&[&str]>, distance: u32) -> TypeNames {
        TypeNames::make_with_distance(set(names), alternatives.map(set), distance)
    }

    #[test]
    fn closer_names_win_and_equal_distances_merge() {
        let a = regular(&["a"], None, 1);
        let b = regular(&["b"], Some(&["alt"]), 2);
        let c = regular(&["c"], None, 1);
        let combined = combine(&[&a, &b, &c]);
        assert_eq!(combined.to_string().unwrap(), "distance 1 a,c (alt)");
        let d = regular(&["d"], None, 0);
        let combined = combine(&[&a, &d]);
        assert_eq!(combined.to_string().unwrap(), "given d");
    }

    /// `combined-names.txt` is generated from the reference implementation
    /// by `xtask/core-type-graph/gen-fixtures.mjs`.
    #[test]
    fn combined_names_match_reference() {
        let fixture = include_str!("../../tests/fixtures/core-type-graph/combined-names.txt");
        for line in fixture.lines() {
            let parts: Vec<&str> = line.split('\t').collect();
            let (names, expected) = parts.split_at(parts.len() - 2);
            let names = regular(names, None, 0);
            assert_eq!(names.combined_name().unwrap(), expected[1], "{line}");
        }
        assert!(regular(&[], None, 0).combined_name().is_err());
    }

    #[test]
    fn too_many_names_draw_random_names() {
        init_type_names();
        let many: Vec<String> = (0..1000).map(|i| format!("n{i}")).collect();
        let names = TypeNames::make_with_distance(many.into_iter().collect(), None, 1);
        assert_eq!(names.to_string().unwrap(), "too many Pune Hedgehog");
        let names =
            TypeNames::make_with_distance((0..1000).map(|i| format!("m{i}")).collect(), None, 1);
        assert_eq!(names.combined_name().unwrap(), "Tartu Gecko");
        // makeInferred keeps the name without drawing a new one.
        assert_eq!(
            names.make_inferred().combined_name().unwrap(),
            "Tartu Gecko"
        );
        init_type_names();
        let again =
            TypeNames::make_with_distance((0..1000).map(|i| format!("k{i}")).collect(), None, 0);
        assert_eq!(again.combined_name().unwrap(), "Pune Hedgehog");
    }

    #[test]
    fn clear_inferred_and_singularize() {
        let given = regular(&["items"], None, 0);
        assert_eq!(
            given.clear_inferred().to_string().unwrap(),
            "given items ()"
        );
        let inferred = regular(&["items"], None, 2);
        assert_eq!(
            inferred.clear_inferred().to_string().unwrap(),
            "distance 2  ()"
        );
        assert_eq!(given.singularize().to_string().unwrap(), "distance 1 item");
    }

    // Port of test/unit/ie-suffix-singularization.test.ts (issue #1867): the
    // `cookies` special case must produce `cookie`, not `cooky`.
    #[test]
    fn singularizes_cookies_to_cookie_not_cooky() {
        assert_eq!(singularize_name("cookies"), "cookie");
        assert_eq!(singularize_name("Cookies"), "Cookie");
        assert_eq!(singularize_name("sessionCookies"), "sessionCookie");
        let names = regular(&["cookies"], None, 0).singularize();
        assert_eq!(names.combined_name().unwrap(), "cookie");
    }

    #[test]
    fn names_attributes_have_empty_alternatives() {
        let a = make_names_type_attributes("TopLevel", false);
        let names = NamesTypeAttributeKind.try_get_in_attributes(&a).unwrap();
        assert_eq!(names.to_string().unwrap(), "given TopLevel ()");
        let singular = singularize_type_names(&a);
        let names = NamesTypeAttributeKind
            .try_get_in_attributes(&singular)
            .unwrap();
        assert_eq!(names.to_string().unwrap(), "distance 1 TopLevel ()");
    }
}
