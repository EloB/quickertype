//! Port of `packages/quicktype-core/src/Naming.ts`.
//!
//! Names of generated identifiers and the global algorithm that assigns
//! them ([`assign_names`]).
//!
//! The TypeScript `Name` and `Namespace` objects become ids into a
//! [`Naming`] arena: a [`Name`] is `Copy`, compares by identity like the JS
//! object did, and is resolved to its string through the [`Names`] that
//! [`assign_names`] returns. `AssociatedName` has no users in quicktype and
//! is not ported.
//!
//! [`Namer`]s are compared by identity, as in TypeScript, where names are
//! grouped by their namer object before conflicts are resolved: clone a
//! `Namer` to share it, construct a new one to get a separate group. That
//! matters for output, because each group gets its own prefix sequence
//! (`Purple`, `Fluffy`, ...) and suffix counter.

use std::collections::{HashMap, HashSet};
use std::fmt;
use std::rc::Rc;

use indexmap::{IndexMap, IndexSet};

use crate::messages::Result;
use crate::support::support::{assert, defined, panic};

/// A name to be assigned (TS `Name`). Resolve it with [`Names::get`] once
/// [`assign_names`] has run.
#[derive(Clone, Copy, PartialEq, Eq, Hash, PartialOrd, Ord, Debug)]
pub struct Name(u32);

impl Name {
    /// The name's index in its [`Naming`] arena.
    pub fn index(self) -> usize {
        self.0 as usize
    }
}

/// As a JavaScript `Map` key, a `Name` object is compared by identity.
impl crate::support::collection_utils::SameValueZeroKey for Name {
    fn same_value_zero_key(&self) -> crate::support::collection_utils::SameValueZero {
        crate::support::collection_utils::SameValueZero::Identity(u64::from(self.0))
    }
}

/// A namespace (TS `Namespace`): names in the same namespace, or forbidden
/// for it, must not get the same string.
#[derive(Clone, Copy, PartialEq, Eq, Hash, PartialOrd, Ord, Debug)]
pub struct NamespaceId(u32);

/// `NameStyle`: turns an unstyled name proposal into a legal identifier.
pub type NameStyle = Rc<dyn Fn(&str) -> String>;

struct NamerData {
    name: String,
    name_style: NameStyle,
    prefixes: Vec<String>,
    prefix_set: IndexSet<String>,
    case_insensitive_styled_names: bool,
}

/// `Namer`: styles names and resolves conflicts between them.
///
/// Cloning shares the namer; namers are equal only if they are clones of
/// each other (TS object identity).
#[derive(Clone)]
pub struct Namer(Rc<NamerData>);

impl fmt::Debug for Namer {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("Namer")
            .field("name", &self.0.name)
            .field("prefixes", &self.0.prefixes)
            .finish_non_exhaustive()
    }
}

impl PartialEq for Namer {
    fn eq(&self, other: &Self) -> bool {
        Rc::ptr_eq(&self.0, &other.0)
    }
}

impl Eq for Namer {}

impl Namer {
    /// `new Namer(name, nameStyle, prefixes, caseInsensitiveStyledNames)`.
    ///
    /// With `case_insensitive_styled_names`, a proposal also counts as
    /// forbidden if it differs from a forbidden name only in case and both
    /// are already in this namer's style (Java and PHP type names, for
    /// case-insensitive file systems).
    pub fn new(
        name: impl Into<String>,
        name_style: impl Fn(&str) -> String + 'static,
        prefixes: impl IntoIterator<Item = impl Into<String>>,
        case_insensitive_styled_names: bool,
    ) -> Namer {
        let prefixes: Vec<String> = prefixes.into_iter().map(Into::into).collect();
        let prefix_set = prefixes.iter().cloned().collect();
        Namer(Rc::new(NamerData {
            name: name.into(),
            name_style: Rc::new(name_style),
            prefixes,
            prefix_set,
            case_insensitive_styled_names,
        }))
    }

    /// `name`: a label for debugging.
    pub fn name(&self) -> &str {
        &self.0.name
    }

    /// `prefixes`, as given to the constructor.
    pub fn prefixes(&self) -> &[String] {
        &self.0.prefixes
    }

    /// `nameStyle(rawName)`.
    pub fn name_style(&self, raw_name: &str) -> String {
        (self.0.name_style)(raw_name)
    }

    /// The style function itself, for renderers that reuse it outside of
    /// naming.
    pub fn style_function(&self) -> NameStyle {
        Rc::clone(&self.0.name_style)
    }

    fn identity(&self) -> usize {
        Rc::as_ptr(&self.0) as *const () as usize
    }

    /// `assignNames(names, forbiddenNames, namesToAssign)`: assigns a string
    /// to every name in `names_to_assign`, avoiding `forbidden_names` and
    /// each other.
    ///
    /// Each name first gets the first of its proposals that is not
    /// forbidden and that no *other* name in the group proposes. The rest
    /// get the namer's prefixes, `"<prefix>_<first proposal>"`, one after
    /// the other across the whole group, then numeric suffixes
    /// `"<first proposal>_<n>"` with one counter for the group.
    pub fn assign_names(
        &self,
        naming: &Naming,
        names: &Names,
        forbidden_names: &IndexSet<String>,
        names_to_assign: &[Name],
    ) -> Result<Vec<(Name, String)>> {
        let mut forbidden = ForbiddenSet::new(self.0.case_insensitive_styled_names);
        for f in forbidden_names {
            forbidden.insert(f.clone());
        }

        assert(
            !names_to_assign.is_empty(),
            "Number of names can't be less than 1",
        )?;

        let proposals: Vec<IndexSet<String>> = names_to_assign
            .iter()
            .map(|&n| naming.propose_unstyled_names(n, names))
            .collect::<Result<_>>()?;

        let mut all_assigned: Vec<(Name, String)> = Vec::new();
        let mut names_to_prefix: Vec<(Name, usize)> = Vec::new();
        for (i, &name) in names_to_assign.iter().enumerate() {
            let naming_function = naming.naming_function(name)?;
            // Find the first proposed name that isn't proposed by any of the
            // other names and that isn't already forbidden.
            let mut maybe_unique: Option<String> = None;
            for proposed in &proposals[i] {
                let styled = naming_function.name_style(proposed);
                if forbidden.is_forbidden(self, &styled) {
                    continue;
                }
                let proposed_by_other = proposals
                    .iter()
                    .enumerate()
                    .any(|(j, other)| j != i && other.contains(proposed));
                if !proposed_by_other {
                    maybe_unique = Some(styled);
                    break;
                }
            }
            if let Some(styled_name) = maybe_unique {
                // `name.nameAssignments(forbiddenNames, styledName)`
                if !forbidden.contains(&styled_name) {
                    forbidden.insert(styled_name.clone());
                    all_assigned.push((name, styled_name));
                    continue;
                }
            }

            // There's no unique name, or it couldn't be assigned, so we need
            // to prefix-name this one.
            names_to_prefix.push((name, i));
        }

        let mut prefixes = self.0.prefix_set.iter();
        let mut suffix_number: u64 = 1;
        for (name, i) in names_to_prefix {
            let original_name = defined(proposals[i].first())?;
            let naming_function = naming.naming_function(name)?;
            loop {
                let name_to_try = match prefixes.next() {
                    Some(prefix) => format!("{prefix}_{original_name}"),
                    None => {
                        let n = format!("{original_name}_{suffix_number}");
                        suffix_number += 1;
                        n
                    }
                };
                let styled_name = naming_function.name_style(&name_to_try);
                if forbidden.contains(&styled_name) {
                    continue;
                }
                forbidden.insert(styled_name.clone());
                all_assigned.push((name, styled_name));
                break;
            }
        }

        Ok(all_assigned)
    }
}

/// The forbidden-name set inside [`Namer::assign_names`], with the
/// case-insensitive lookup of the first pass.
struct ForbiddenSet {
    exact: HashSet<String>,
    by_lowercase: Option<HashMap<String, Vec<String>>>,
}

impl ForbiddenSet {
    fn new(case_insensitive: bool) -> Self {
        ForbiddenSet {
            exact: HashSet::new(),
            by_lowercase: case_insensitive.then(HashMap::new),
        }
    }

    fn insert(&mut self, name: String) {
        if let Some(by_lowercase) = &mut self.by_lowercase {
            if !self.exact.contains(&name) {
                by_lowercase
                    .entry(name.to_lowercase())
                    .or_default()
                    .push(name.clone());
            }
        }
        self.exact.insert(name);
    }

    fn contains(&self, name: &str) -> bool {
        self.exact.contains(name)
    }

    /// `isForbidden(candidate)`: exact, or (case-insensitive namers) equal
    /// ignoring case to a forbidden name, if both are already styled.
    fn is_forbidden(&self, namer: &Namer, candidate: &str) -> bool {
        if self.exact.contains(candidate) {
            return true;
        }
        let Some(by_lowercase) = &self.by_lowercase else {
            return false;
        };
        let Some(same_lowercase) = by_lowercase.get(&candidate.to_lowercase()) else {
            return false;
        };
        if namer.name_style(candidate) != candidate {
            return false;
        }
        same_lowercase.iter().any(|f| namer.name_style(f) == *f)
    }
}

/// The prefixes of [`fun_prefix_namer`].
pub const FUN_PREFIXES: [&str; 13] = [
    "Purple",
    "Fluffy",
    "Tentacled",
    "Sticky",
    "Indigo",
    "Indecent",
    "Hilarious",
    "Ambitious",
    "Cunning",
    "Magenta",
    "Frisky",
    "Mischievous",
    "Braggadocious",
];

/// `funPrefixNamer(name, nameStyle)`: a namer that resolves conflicts with
/// [`FUN_PREFIXES`] first.
pub fn fun_prefix_namer(name: &str, name_style: impl Fn(&str) -> String + 'static) -> Namer {
    Namer::new(name, name_style, FUN_PREFIXES, false)
}

/// A `DependencyName`'s proposal function: it gets a `lookup` that returns
/// the assigned string of a [`Name`] and returns the unstyled proposal.
///
/// The TypeScript proposers are closures over the renderer; here they must
/// capture everything they need by value (resolve renderer state when the
/// proposer is built, which is equivalent because the state is fixed by
/// then).
pub type Proposer = Rc<dyn Fn(&mut dyn FnMut(Name) -> String) -> String>;

enum NameKind {
    Fixed(String),
    Simple(IndexSet<String>),
    Dependency {
        dependencies: IndexSet<Name>,
        propose: Proposer,
    },
}

struct NameData {
    kind: NameKind,
    namer: Option<Namer>,
    order: u32,
}

struct NamespaceData {
    name: String,
    forbidden_namespaces: IndexSet<NamespaceId>,
    additional_forbidden: IndexSet<Name>,
    children: IndexSet<NamespaceId>,
    members: IndexSet<Name>,
}

/// The arena of names and namespaces of one render.
#[derive(Default)]
pub struct Naming {
    names: Vec<NameData>,
    namespaces: Vec<NamespaceData>,
}

impl fmt::Debug for Naming {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("Naming")
            .field("names", &self.names.len())
            .field("namespaces", &self.namespaces.len())
            .finish()
    }
}

impl Naming {
    /// An empty arena.
    pub fn new() -> Self {
        Naming::default()
    }

    fn push_name(&mut self, kind: NameKind, namer: Option<Namer>, order: u32) -> Name {
        let id = Name(self.names.len() as u32);
        self.names.push(NameData { kind, namer, order });
        id
    }

    /// `new FixedName(name)`: always assigned exactly `name`.
    pub fn fixed_name(&mut self, fixed: impl Into<String>) -> Name {
        self.push_name(NameKind::Fixed(fixed.into()), None, 0)
    }

    /// `new SimpleName(unstyledNames, namer, order)`: proposes the given
    /// names (deduplicated, in order). Lower orders are assigned first.
    pub fn simple_name(
        &mut self,
        unstyled_names: impl IntoIterator<Item = impl Into<String>>,
        namer: &Namer,
        order: u32,
    ) -> Name {
        let names = unstyled_names.into_iter().map(Into::into).collect();
        self.push_name(NameKind::Simple(names), Some(namer.clone()), order)
    }

    /// `new DependencyName(namer, order, proposeUnstyledName)`: proposes one
    /// name computed from other, already assigned names.
    ///
    /// Like the TypeScript constructor, this runs `propose` once with a
    /// lookup that records the names it asks for (and answers
    /// `"0xDEADBEEF"`); those are the dependencies that must be assigned
    /// first.
    pub fn dependency_name(
        &mut self,
        namer: Option<&Namer>,
        order: u32,
        propose: impl Fn(&mut dyn FnMut(Name) -> String) -> String + 'static,
    ) -> Name {
        self.dependency_name_with_proposer(namer, order, Rc::new(propose))
    }

    /// [`dependency_name`](Self::dependency_name) with a shared
    /// [`Proposer`].
    pub fn dependency_name_with_proposer(
        &mut self,
        namer: Option<&Namer>,
        order: u32,
        propose: Proposer,
    ) -> Name {
        let mut dependencies = IndexSet::new();
        propose(&mut |n| {
            dependencies.insert(n);
            "0xDEADBEEF".to_owned()
        });
        self.push_name(
            NameKind::Dependency {
                dependencies,
                propose,
            },
            namer.cloned(),
            order,
        )
    }

    /// `new Namespace(name, parent, forbiddenNamespaces,
    /// additionalForbidden)`. A parent only lists its children (for
    /// [`assign_names`] to find them); it does not forbid anything.
    pub fn namespace(
        &mut self,
        name: impl Into<String>,
        parent: Option<NamespaceId>,
        forbidden_namespaces: impl IntoIterator<Item = NamespaceId>,
        additional_forbidden: impl IntoIterator<Item = Name>,
    ) -> NamespaceId {
        let id = NamespaceId(self.namespaces.len() as u32);
        self.namespaces.push(NamespaceData {
            name: name.into(),
            forbidden_namespaces: forbidden_namespaces.into_iter().collect(),
            additional_forbidden: additional_forbidden.into_iter().collect(),
            children: IndexSet::new(),
            members: IndexSet::new(),
        });
        if let Some(parent) = parent {
            self.namespaces[parent.0 as usize].children.insert(id);
        }
        id
    }

    /// `keywordNamespace(name, keywords)`: a namespace of fixed names.
    pub fn keyword_namespace(
        &mut self,
        name: &str,
        keywords: impl IntoIterator<Item = impl Into<String>>,
    ) -> NamespaceId {
        let ns = self.namespace(name, None, [], []);
        for kw in keywords {
            let n = self.fixed_name(kw);
            self.add(ns, n);
        }
        ns
    }

    /// `namespace.add(named)`.
    pub fn add(&mut self, namespace: NamespaceId, name: Name) -> Name {
        self.namespaces[namespace.0 as usize].members.insert(name);
        name
    }

    /// `namespace.members`.
    pub fn members(&self, namespace: NamespaceId) -> &IndexSet<Name> {
        &self.namespaces[namespace.0 as usize].members
    }

    /// `namespace.children`.
    pub fn children(&self, namespace: NamespaceId) -> &IndexSet<NamespaceId> {
        &self.namespaces[namespace.0 as usize].children
    }

    /// The display name a namespace was created with.
    pub fn namespace_name(&self, namespace: NamespaceId) -> &str {
        &self.namespaces[namespace.0 as usize].name
    }

    /// `namespace.forbiddenNameds`: the additional forbidden names, then the
    /// members of each forbidden namespace.
    ///
    /// TypeScript caches this on first access, which happens only once
    /// naming has started, after every namespace is complete; computing it
    /// on demand gives the same sets.
    pub fn forbidden_nameds(&self, namespace: NamespaceId) -> IndexSet<Name> {
        let data = &self.namespaces[namespace.0 as usize];
        let mut result = data.additional_forbidden.clone();
        for ns in &data.forbidden_namespaces {
            result.extend(self.members(*ns).iter().copied());
        }
        result
    }

    fn data(&self, name: Name) -> &NameData {
        &self.names[name.index()]
    }

    /// The fixed string of a `FixedName`, or `None` for other names.
    pub fn fixed_name_of(&self, name: Name) -> Option<&str> {
        match &self.data(name).kind {
            NameKind::Fixed(s) => Some(s),
            _ => None,
        }
    }

    /// `name.isFixed()`.
    pub fn is_fixed(&self, name: Name) -> bool {
        self.fixed_name_of(name).is_some()
    }

    /// `name.order`.
    pub fn order(&self, name: Name) -> u32 {
        self.data(name).order
    }

    /// `name.namingFunction`: errors for names without a namer.
    pub fn naming_function(&self, name: Name) -> Result<&Namer> {
        defined(self.data(name).namer.as_ref())
    }

    /// `name.dependencies`.
    pub fn dependencies(&self, name: Name) -> Vec<Name> {
        match &self.data(name).kind {
            NameKind::Dependency { dependencies, .. } => dependencies.iter().copied().collect(),
            _ => Vec::new(),
        }
    }

    fn all_dependencies_named(&self, name: Name, names: &Names) -> bool {
        match &self.data(name).kind {
            NameKind::Dependency { dependencies, .. } => dependencies.iter().all(|&d| names.has(d)),
            _ => true,
        }
    }

    /// `name.proposeUnstyledNames(names)`: the proposals, in order.
    pub fn propose_unstyled_names(&self, name: Name, names: &Names) -> Result<IndexSet<String>> {
        match &self.data(name).kind {
            NameKind::Fixed(_) => panic("Only fixedName should be called on FixedName."),
            NameKind::Simple(proposals) => Ok(proposals.clone()),
            NameKind::Dependency {
                dependencies,
                propose,
            } => {
                let mut error: Option<&'static str> = None;
                let proposal = propose(&mut |n| {
                    if !dependencies.contains(&n) {
                        error.get_or_insert("DependencyName proposer is not pure");
                        return String::new();
                    }
                    match names.get(n) {
                        Some(s) => s.to_owned(),
                        None => {
                            error.get_or_insert("Defined value expected, but got undefined");
                            String::new()
                        }
                    }
                });
                if let Some(message) = error {
                    return panic(message);
                }
                Ok([proposal].into_iter().collect())
            }
        }
    }

    /// `name.firstProposedName(names)`.
    pub fn first_proposed_name(&self, name: Name, names: &Names) -> Result<String> {
        defined(self.propose_unstyled_names(name, names)?.into_iter().next())
    }
}

/// The strings [`assign_names`] gave to [`Name`]s (TS `Map<Name, string>`).
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct Names {
    assigned: Vec<Option<String>>,
}

impl Names {
    /// No names assigned.
    pub fn new() -> Self {
        Names::default()
    }

    /// The string assigned to `name`, if any.
    pub fn get(&self, name: Name) -> Option<&str> {
        self.assigned.get(name.index()).and_then(|s| s.as_deref())
    }

    /// Whether `name` has been assigned.
    pub fn has(&self, name: Name) -> bool {
        self.get(name).is_some()
    }

    fn set(&mut self, name: Name, value: String) {
        if self.assigned.len() <= name.index() {
            self.assigned.resize(name.index() + 1, None);
        }
        self.assigned[name.index()] = Some(value);
    }
}

/// `allNamespacesRecursively(namespaces)`: the namespaces, then the
/// recursive children of each.
fn all_namespaces_recursively(
    naming: &Naming,
    namespaces: &[NamespaceId],
) -> IndexSet<NamespaceId> {
    let mut result: IndexSet<NamespaceId> = namespaces.iter().copied().collect();
    for &ns in namespaces {
        let children: Vec<NamespaceId> = naming.children(ns).iter().copied().collect();
        result.extend(all_namespaces_recursively(naming, &children));
    }
    result
}

/// `NamingContext`.
struct NamingContext<'n> {
    naming: &'n Naming,
    names: Names,
    nameds_for_name: HashMap<String, Vec<Name>>,
    forbidden_nameds: HashMap<NamespaceId, IndexSet<Name>>,
}

impl NamingContext<'_> {
    /// Computes `namespace.forbiddenNameds` into the cache if needed.
    fn cache_forbidden_nameds(&mut self, namespace: NamespaceId) {
        let naming = self.naming;
        self.forbidden_nameds
            .entry(namespace)
            .or_insert_with(|| naming.forbidden_nameds(namespace));
    }

    fn is_ready_to_be_named(&self, named: Name) -> bool {
        !self.names.has(named) && self.naming.all_dependencies_named(named, &self.names)
    }

    fn are_forbiddens_fully_named(&mut self, namespace: NamespaceId) -> bool {
        self.cache_forbidden_nameds(namespace);
        let names = &self.names;
        self.forbidden_nameds[&namespace]
            .iter()
            .all(|&n| names.has(n))
    }

    fn is_conflicting(&mut self, namespace: NamespaceId, proposed: &str) -> bool {
        self.cache_forbidden_nameds(namespace);
        let Some(nameds) = self.nameds_for_name.get(proposed) else {
            // If the name is not assigned at all, there is no conflict.
            return false;
        };
        let members = self.naming.members(namespace);
        let forbidden = &self.forbidden_nameds[&namespace];
        // The name is assigned, but it might still not be forbidden.
        nameds
            .iter()
            .any(|n| members.contains(n) || forbidden.contains(n))
    }

    fn assign(&mut self, named: Name, namespace: NamespaceId, name: &str) -> Result<()> {
        assert(
            !self.names.has(named),
            &format!("Name \"{name}\" assigned twice"),
        )?;
        assert(
            !self.is_conflicting(namespace, name),
            &format!("Assigned name \"{name}\" conflicts"),
        )?;
        self.names.set(named, name.to_owned());
        self.nameds_for_name
            .entry(name.to_owned())
            .or_default()
            .push(named);
        Ok(())
    }
}

/// `assignNames(rootNamespaces)`: the naming algorithm.
///
/// 1. Every fixed name gets its string.
/// 2. Repeatedly take the first unfinished namespace whose forbidden names
///    are all assigned and that has a member ready to be named (all its
///    dependencies assigned). If there is none, stop: names that are still
///    unassigned stay so.
/// 3. In that namespace, from low to high order, group the ready names by
///    namer, then by styled first proposal, and let each group's namer
///    assign them, avoiding the strings already taken in the namespace and
///    its forbidden names.
pub fn assign_names(naming: &Naming, root_namespaces: &[NamespaceId]) -> Result<Names> {
    let namespaces = all_namespaces_recursively(naming, root_namespaces);
    let mut ctx = NamingContext {
        naming,
        names: Names {
            assigned: vec![None; naming.names.len()],
        },
        nameds_for_name: HashMap::new(),
        forbidden_nameds: HashMap::new(),
    };

    // Assign all fixed names.
    for &ns in &namespaces {
        for &n in naming.members(ns) {
            if let Some(fixed) = naming.fixed_name_of(n) {
                ctx.assign(n, ns, fixed)?;
            }
        }
    }

    let mut unfinished: IndexSet<NamespaceId> = namespaces
        .iter()
        .copied()
        .filter(|&ns| naming.members(ns).iter().any(|&m| !ctx.names.has(m)))
        .collect();

    loop {
        // 1. Find a namespace whose forbiddens are all fully named, and which
        //    has at least one unnamed Named that has all its dependencies
        //    satisfied.
        let mut ready_namespace = None;
        for &ns in &unfinished {
            if ctx.are_forbiddens_fully_named(ns)
                && naming
                    .members(ns)
                    .iter()
                    .any(|&m| ctx.is_ready_to_be_named(m))
            {
                ready_namespace = Some(ns);
                break;
            }
        }
        let Some(namespace) = ready_namespace else {
            return Ok(ctx.names);
        };

        let members = naming.members(namespace);
        let mut forbidden_names: IndexSet<String> = IndexSet::new();
        ctx.cache_forbidden_nameds(namespace);
        let forbidden_nameds = &ctx.forbidden_nameds[&namespace];
        let mut seen: HashSet<Name> = HashSet::new();
        for &n in members.iter().chain(forbidden_nameds.iter()) {
            if !seen.insert(n) {
                continue;
            }
            if let Some(s) = ctx.names.get(n) {
                forbidden_names.insert(s.to_owned());
            }
        }

        // 2. From low order to high order, sort those names into sets where
        //    all members of a set propose the same name and have the same
        //    naming function.
        loop {
            let all_ready: Vec<Name> = members
                .iter()
                .copied()
                .filter(|&m| ctx.is_ready_to_be_named(m))
                .collect();
            let Some(min_order) = first_min(all_ready.iter().map(|&n| naming.order(n))) else {
                break;
            };
            let ready: Vec<Name> = all_ready
                .into_iter()
                .filter(|&n| naming.order(n) == min_order)
                .collect();

            let mut by_naming_function: IndexMap<usize, (Namer, Vec<Name>)> = IndexMap::new();
            for &n in &ready {
                let namer = naming.naming_function(n)?;
                by_naming_function
                    .entry(namer.identity())
                    .or_insert_with(|| (namer.clone(), Vec::new()))
                    .1
                    .push(n);
            }
            for (_, (namer, nameds_for_naming_function)) in by_naming_function {
                let mut by_proposed: IndexMap<String, Vec<Name>> = IndexMap::new();
                for &n in &nameds_for_naming_function {
                    let key = naming
                        .naming_function(n)?
                        .name_style(&naming.first_proposed_name(n, &ctx.names)?);
                    by_proposed.entry(key).or_default().push(n);
                }
                for (_, nameds) in by_proposed {
                    // 3. Use each set's naming function to name its members.
                    let assigned =
                        namer.assign_names(naming, &ctx.names, &forbidden_names, &nameds)?;
                    for (name, s) in &assigned {
                        ctx.assign(*name, namespace, s)?;
                    }
                    forbidden_names.extend(assigned.into_iter().map(|(_, s)| s));
                }
            }
        }

        if naming.members(namespace).iter().all(|&m| ctx.names.has(m)) {
            unfinished.shift_remove(&namespace);
        }
    }
}

/// `iterableMinBy`: the first minimum (strict `<`).
fn first_min(values: impl Iterator<Item = u32>) -> Option<u32> {
    let mut min: Option<u32> = None;
    for v in values {
        if min.is_none_or(|m| v < m) {
            min = Some(v);
        }
    }
    min
}

#[cfg(test)]
mod tests {
    use super::*;

    fn identity_namer() -> Namer {
        Namer::new("identity", str::to_owned, ["renamed"], false)
    }

    // Ported from test/unit/naming.test.ts.
    #[test]
    fn revisits_an_unfinished_namespace_after_a_dependency_is_named() {
        let namer = identity_namer();
        let mut naming = Naming::new();
        let first_namespace = naming.namespace("first", None, [], []);
        let second_namespace = naming.namespace("second", None, [], []);
        let first = naming.simple_name(["first"], &namer, 1);
        naming.add(first_namespace, first);
        let dependency = naming.simple_name(["dependency"], &namer, 1);
        naming.add(second_namespace, dependency);
        let dependent = naming.dependency_name(Some(&namer), 2, move |lookup| {
            format!("{}Dependent", lookup(dependency))
        });
        naming.add(first_namespace, dependent);

        let names = assign_names(&naming, &[first_namespace, second_namespace]).unwrap();
        assert_eq!(names.get(first), Some("first"));
        assert_eq!(names.get(dependency), Some("dependency"));
        assert_eq!(names.get(dependent), Some("dependencyDependent"));
    }

    // Ported from test/unit/naming.test.ts.
    #[test]
    fn caches_and_observes_forbidden_namespace_members() {
        let namer = identity_namer();
        let mut naming = Naming::new();
        let reserved = naming.keyword_namespace("reserved", ["match"]);
        let namespace = naming.namespace("names", None, [reserved], []);
        let conflicting = naming.simple_name(["match"], &namer, 1);
        naming.add(namespace, conflicting);

        let forbidden = naming.forbidden_nameds(namespace);
        assert_eq!(&forbidden, naming.members(reserved));

        let names = assign_names(&naming, &[reserved, namespace]).unwrap();
        assert_eq!(names.get(conflicting), Some("renamed_match"));
    }

    #[test]
    fn prefixes_are_shared_across_a_group_then_suffixes() {
        let namer = Namer::new("n", str::to_owned, ["A", "B"], false);
        let mut naming = Naming::new();
        let ns = naming.namespace("ns", None, [], []);
        let names: Vec<Name> = (0..4)
            .map(|_| {
                let n = naming.simple_name(["x"], &namer, 1);
                naming.add(ns, n)
            })
            .collect();
        let assigned = assign_names(&naming, &[ns]).unwrap();
        let got: Vec<&str> = names.iter().map(|&n| assigned.get(n).unwrap()).collect();
        assert_eq!(got, ["A_x", "B_x", "x_1", "x_2"]);
    }

    #[test]
    fn separate_namers_get_separate_prefix_sequences() {
        let mut naming = Naming::new();
        let ns = naming.namespace("ns", None, [], []);
        let keyword = naming.keyword_namespace("kw", ["x"]);
        let ns2 = naming.namespace("ns2", None, [keyword], []);
        let a = naming.simple_name(["x"], &Namer::new("a", str::to_owned, ["P"], false), 1);
        let b = naming.simple_name(["x"], &Namer::new("b", str::to_owned, ["P"], false), 1);
        naming.add(ns, a);
        naming.add(ns2, b);
        let assigned = assign_names(&naming, &[keyword, ns, ns2]).unwrap();
        assert_eq!(assigned.get(a), Some("x"));
        assert_eq!(assigned.get(b), Some("P_x"));
    }

    #[test]
    fn case_insensitive_namers_avoid_case_variants() {
        let upper = |s: &str| crate::support::strings::capitalize(s);
        let namer = Namer::new("ci", upper, ["Q"], true);
        let mut naming = Naming::new();
        let keyword = naming.keyword_namespace("kw", ["Bool"]);
        let ns = naming.namespace("ns", None, [keyword], []);
        let n = naming.simple_name(["bOOL", "other"], &namer, 1);
        naming.add(ns, n);
        let assigned = assign_names(&naming, &[keyword, ns]).unwrap();
        // "BOOL" is styled and differs from "Bool" only in case.
        assert_eq!(assigned.get(n), Some("Other"));
    }

    #[test]
    fn fixed_names_cannot_be_proposed() {
        let mut naming = Naming::new();
        let f = naming.fixed_name("x");
        assert!(naming.propose_unstyled_names(f, &Names::new()).is_err());
        assert!(naming.naming_function(f).is_err());
    }
}
