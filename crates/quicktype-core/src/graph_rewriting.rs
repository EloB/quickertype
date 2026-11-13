//! Port of `packages/quicktype-core/src/GraphRewriting.ts`.
//!
//! Rewriting a type graph means building a new graph from an old one:
//!
//! * The *rewrite builder* (`GraphRewriteBuilder`) reconstitutes every type
//!   reachable from the old graph's top-levels, except that each group of
//!   types to replace is built by a [`Replacer`] instead. Reconstitution is
//!   lazy and depth-first, so the new graph's type order is the order in
//!   which types are first reached. Replacers are re-entrant: building a
//!   replacement can reach another group, whose replacer then runs first.
//! * The *remap builder* (`GraphRemapBuilder`) maps some types to others and
//!   never deduplicates; it removes forwarding intersections and does the
//!   final garbage collection.
//!
//! Both are a [`TypeBuilder`] with rewrite state. The rewrite methods
//! below are `impl TypeBuilder` blocks; [`TypeReconstituter`] is the
//! one-shot helper through which a type of the old graph rebuilds itself
//! (see `reconstitute` in [`crate::ty::ty`]).

use std::collections::HashMap;
use std::rc::Rc;

use indexmap::{IndexMap, IndexSet};

use crate::attributes::type_attributes::{
    CombinationKind, TypeAttributes, combine_type_attributes, combine_type_attributes2,
};
use crate::messages::Result;
use crate::support::collection_utils::EqualityMap;
use crate::support::support::{assert, console_log, indentation_string, panic};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::ty::{self, ClassProperty};
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_builder_utils::StringTypeMapping;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::{TypeRef, assert_type_ref_graph};

/// The replacer of a rewrite: given a group of types of the old graph, the
/// builder and the forwarding ref the replacement must be built at, builds
/// the replacement and returns that ref.
pub type Replacer<'g> =
    Rc<dyn Fn(&IndexSet<TypeRef>, &mut TypeBuilder<'g>, TypeRef) -> Result<TypeRef> + 'g>;

/// Makes a [`Replacer`] from a closure (this helps closure type inference).
pub fn make_replacer<'g, F>(f: F) -> Replacer<'g>
where
    F: Fn(&IndexSet<TypeRef>, &mut TypeBuilder<'g>, TypeRef) -> Result<TypeRef> + 'g,
{
    Rc::new(f)
}

/// The state of a rewrite or remap builder.
pub(crate) struct RewriteState<'g> {
    original: &'g TypeGraph,
    /// `reconstitutedTypes`: old type index → new type.
    reconstituted_types: Vec<Option<TypeRef>>,
    pub(crate) lost_type_attributes: bool,
    debug_print: bool,
    print_indent: usize,
    mode: RewriteMode<'g>,
}

enum RewriteMode<'g> {
    Remap {
        map: HashMap<TypeRef, TypeRef>,
        attribute_sources: HashMap<TypeRef, Vec<TypeRef>>,
    },
    Rewrite {
        /// `_setsToReplaceByMember`: old type index → group index.
        sets_to_replace_by_member: HashMap<usize, usize>,
        groups: Vec<Rc<IndexSet<TypeRef>>>,
        reconstituted_unions: EqualityMap<IndexSet<TypeRef>, TypeRef>,
        replacer: Replacer<'g>,
    },
}

/// A finished rewrite: the new graph plus the builder flags the type graph
/// needs.
pub(crate) struct FinishedRewrite {
    pub(crate) graph: TypeGraph,
    pub(crate) lost_type_attributes: bool,
    pub(crate) added_forwarding_intersection: bool,
}

impl<'g> TypeBuilder<'g> {
    /// `new GraphRewriteBuilder(originalGraph, stringTypeMapping,
    /// alphabetizeProperties, graphHasProvenanceAttributes, setsToReplace,
    /// debugPrintReconstitution, replacer)`.
    pub(crate) fn new_rewrite(
        original: &'g TypeGraph,
        string_type_mapping: StringTypeMapping,
        alphabetize_properties: bool,
        sets_to_replace: Vec<Vec<TypeRef>>,
        debug_print_reconstitution: bool,
        replacer: Replacer<'g>,
    ) -> Result<TypeBuilder<'g>> {
        let mut sets_to_replace_by_member = HashMap::new();
        let mut groups = Vec::with_capacity(sets_to_replace.len());
        for types in sets_to_replace {
            let set: IndexSet<TypeRef> = types.into_iter().collect();
            let group = groups.len();
            for t in &set {
                assert(
                    !sets_to_replace_by_member.contains_key(&t.index()),
                    "A type is member of more than one set to be replaced",
                )?;
                sets_to_replace_by_member.insert(t.index(), group);
            }
            groups.push(Rc::new(set));
        }
        let mode = RewriteMode::Rewrite {
            sets_to_replace_by_member,
            groups,
            reconstituted_unions: EqualityMap::new(),
            replacer,
        };
        TypeBuilder::new_rewrite_builder(
            original,
            string_type_mapping,
            alphabetize_properties,
            debug_print_reconstitution,
            mode,
        )
    }

    /// `new GraphRemapBuilder(originalGraph, stringTypeMapping,
    /// alphabetizeProperties, graphHasProvenanceAttributes, map,
    /// debugPrintRemapping)`.
    pub(crate) fn new_remap(
        original: &'g TypeGraph,
        string_type_mapping: StringTypeMapping,
        alphabetize_properties: bool,
        map: IndexMap<TypeRef, TypeRef>,
        debug_print_remapping: bool,
    ) -> Result<TypeBuilder<'g>> {
        let mut attribute_sources: HashMap<TypeRef, Vec<TypeRef>> = HashMap::new();
        for (&source, &target) in &map {
            attribute_sources
                .entry(target)
                .or_insert_with(|| vec![target])
                .push(source);
        }
        let mode = RewriteMode::Remap {
            map: map.into_iter().collect(),
            attribute_sources,
        };
        TypeBuilder::new_rewrite_builder(
            original,
            string_type_mapping,
            alphabetize_properties,
            debug_print_remapping,
            mode,
        )
    }

    /// `BaseGraphRewriteBuilder`'s constructor: no all-optional properties,
    /// no added provenance, provenance inherited from the original graph.
    fn new_rewrite_builder(
        original: &'g TypeGraph,
        string_type_mapping: StringTypeMapping,
        alphabetize_properties: bool,
        debug_print: bool,
        mode: RewriteMode<'g>,
    ) -> Result<TypeBuilder<'g>> {
        let mut builder = TypeBuilder::with_graph(
            original.serial() + 1,
            original.have_provenance_attributes(),
            string_type_mapping,
            alphabetize_properties,
            false,
            false,
            original.have_provenance_attributes(),
        )?;
        builder.rewrite = Some(RewriteState {
            original,
            reconstituted_types: vec![None; original.len()],
            lost_type_attributes: false,
            debug_print,
            print_indent: 0,
            mode,
        });
        Ok(builder)
    }

    fn rewrite_state(&self) -> Result<&RewriteState<'g>> {
        match &self.rewrite {
            Some(r) => Ok(r),
            None => panic("Not a graph rewrite builder"),
        }
    }

    fn rewrite_state_mut(&mut self) -> Result<&mut RewriteState<'g>> {
        match &mut self.rewrite {
            Some(r) => Ok(r),
            None => panic("Not a graph rewrite builder"),
        }
    }

    pub(crate) fn is_remap(&self) -> bool {
        matches!(
            &self.rewrite,
            Some(RewriteState {
                mode: RewriteMode::Remap { .. },
                ..
            })
        )
    }

    /// `originalGraph`: the graph being rewritten.
    pub fn original_graph(&self) -> Result<&'g TypeGraph> {
        Ok(self.rewrite_state()?.original)
    }

    /// `lostTypeAttributes`: whether attributes were dropped on purpose.
    pub fn lost_type_attributes(&self) -> bool {
        self.rewrite
            .as_ref()
            .is_some_and(|r| r.lost_type_attributes)
    }

    /// `finish()` of a rewrite builder: reconstitutes the top-levels in
    /// order, then freezes.
    pub(crate) fn finish_rewrite(mut self) -> Result<FinishedRewrite> {
        let original = self.original_graph()?;
        for (name, &t) in original.top_levels() {
            let r = self.reconstitute_type_ref(t, TypeAttributes::new(), None)?;
            self.add_top_level(name, r)?;
        }
        let lost_type_attributes = self.lost_type_attributes();
        let added_forwarding_intersection = self.did_add_forwarding_intersection();
        let graph = self.freeze()?;
        Ok(FinishedRewrite {
            graph,
            lost_type_attributes,
            added_forwarding_intersection,
        })
    }

    fn debug_log(&self, line: &str) {
        if let Some(r) = &self.rewrite
            && r.debug_print
        {
            console_log(&format!("{}{line}", indentation_string(r.print_indent)));
        }
    }

    fn change_debug_print_indent(&mut self, delta: isize) {
        if let Some(r) = &mut self.rewrite {
            r.print_indent = r.print_indent.saturating_add_signed(delta);
        }
    }

    fn debug_print(&self) -> bool {
        self.rewrite.as_ref().is_some_and(|r| r.debug_print)
    }

    /// `withForwardingRef(maybeForwardingRef, typeCreator)`: calls `creator`
    /// with the given forwarding ref, or with a newly reserved one, which it
    /// must return.
    pub fn with_forwarding_ref(
        &mut self,
        maybe_forwarding_ref: Option<TypeRef>,
        creator: impl FnOnce(&mut Self, TypeRef) -> Result<TypeRef>,
    ) -> Result<TypeRef> {
        if let Some(fwd) = maybe_forwarding_ref {
            return creator(self, fwd);
        }
        let forwarding_ref = self.reserve_type_ref()?;
        let actual_ref = creator(self, forwarding_ref)?;
        assert(
            actual_ref == forwarding_ref,
            "Type creator didn't return its forwarding ref",
        )?;
        Ok(actual_ref)
    }

    /// `reconstituteType(t, attributes, forwardingRef)`.
    pub fn reconstitute_type(
        &mut self,
        t: TypeRef,
        attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        self.reconstitute_type_ref(t, attributes, forwarding_ref)
    }

    /// `reconstituteTypeRef(originalRef, attributes, forwardingRef)`: the new
    /// type for an old one, reconstituting it if it isn't yet. `attributes`
    /// are added to it (empty for none).
    pub fn reconstitute_type_ref(
        &mut self,
        original_ref: TypeRef,
        attributes: TypeAttributes,
        maybe_forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        if let Some(r) = self.lookup_type_refs(&[original_ref], maybe_forwarding_ref, true)? {
            self.add_attributes(r, &attributes)?;
            return Ok(r);
        }
        self.force_reconstitute_type_ref(original_ref, attributes, maybe_forwarding_ref)
    }

    /// `reconstituteTypeAttributes(attributes)`: attributes of the old graph
    /// in terms of the new one (only transformations refer to types).
    pub fn reconstitute_type_attributes(
        &mut self,
        attributes: &TypeAttributes,
    ) -> Result<TypeAttributes> {
        let mut result = TypeAttributes::new();
        for value in attributes.iter() {
            result.insert(value.reconstitute(self)?);
        }
        Ok(result)
    }

    fn assert_type_refs_to_reconstitute(
        &self,
        type_refs: &[TypeRef],
        forwarding_ref: Option<TypeRef>,
    ) -> Result<()> {
        assert(
            !type_refs.is_empty(),
            "Must have at least one type to reconstitute",
        )?;
        let original = self.original_graph()?;
        for &r in type_refs {
            assert_type_ref_graph(r, original.serial())?;
        }
        if let Some(fwd) = forwarding_ref {
            self.assert_type_ref_graph(fwd)?;
        }
        Ok(())
    }

    /// `getMapTarget(tref)` of the remap builder.
    fn get_map_target(&self, tref: TypeRef) -> Result<TypeRef> {
        let Some(RewriteState {
            mode: RewriteMode::Remap { map, .. },
            ..
        }) = &self.rewrite
        else {
            return Ok(tref);
        };
        match map.get(&tref) {
            None => Ok(tref),
            Some(&target) => {
                assert(
                    !map.contains_key(&target),
                    "We have a type that's remapped to a remapped type",
                )?;
                Ok(target)
            }
        }
    }

    fn reconstituted(&self, original_index: usize) -> Result<Option<TypeRef>> {
        Ok(self
            .rewrite_state()?
            .reconstituted_types
            .get(original_index)
            .copied()
            .flatten())
    }

    fn set_reconstituted(&mut self, original_index: usize, tref: TypeRef) -> Result<()> {
        let state = self.rewrite_state_mut()?;
        match state.reconstituted_types.get_mut(original_index) {
            Some(slot) => {
                *slot = Some(tref);
                Ok(())
            }
            None => panic("Type index out of range of the original graph"),
        }
    }

    /// `lookupTypeRefs(typeRefs, forwardingRef, replaceSet)`: if the old
    /// types `type_refs` have been, or are to be, reconstituted to a single
    /// new type, that type. With `replace_set`, a group to be replaced is
    /// replaced now.
    pub fn lookup_type_refs(
        &mut self,
        type_refs: &[TypeRef],
        forwarding_ref: Option<TypeRef>,
        replace_set: bool,
    ) -> Result<Option<TypeRef>> {
        if self.is_remap() {
            return self.remap_lookup_type_refs(type_refs, forwarding_ref);
        }

        self.assert_type_refs_to_reconstitute(type_refs, forwarding_ref)?;

        // Already reconstituted, all to the same type?
        let maybe_ref = self.reconstituted(type_refs[0].index())?;
        if let Some(r) = maybe_ref
            && Some(r) != forwarding_ref
        {
            let mut all_equal = true;
            for t in &type_refs[1..] {
                if self.reconstituted(t.index())? != Some(r) {
                    all_equal = false;
                    break;
                }
            }
            if all_equal {
                return self.forward_if_necessary(forwarding_ref, r).map(Some);
            }
        }

        // Reconstituted as a set?
        let key: IndexSet<TypeRef> = type_refs.iter().copied().collect();
        let maybe_ref = match &self.rewrite_state()?.mode {
            RewriteMode::Rewrite {
                reconstituted_unions,
                ..
            } => reconstituted_unions.get(&key).copied(),
            RewriteMode::Remap { .. } => None,
        };
        if let Some(r) = maybe_ref
            && Some(r) != forwarding_ref
        {
            return self.forward_if_necessary(forwarding_ref, r).map(Some);
        }

        // Requested to be replaced?
        let maybe_group = match &self.rewrite_state()?.mode {
            RewriteMode::Rewrite {
                sets_to_replace_by_member,
                ..
            } => {
                let first = sets_to_replace_by_member
                    .get(&type_refs[0].index())
                    .copied();
                match first {
                    None => None,
                    Some(group) => {
                        let all_in_group = type_refs[1..]
                            .iter()
                            .all(|t| sets_to_replace_by_member.get(&t.index()) == Some(&group));
                        all_in_group.then_some(group)
                    }
                }
            }
            RewriteMode::Remap { .. } => None,
        };
        let Some(group) = maybe_group else {
            return Ok(None);
        };

        if !replace_set {
            return Ok(None);
        }
        self.replace_set(group, forwarding_ref).map(Some)
    }

    /// `lookupTypeRefs` of the remap builder.
    fn remap_lookup_type_refs(
        &mut self,
        type_refs: &[TypeRef],
        forwarding_ref: Option<TypeRef>,
    ) -> Result<Option<TypeRef>> {
        assert(
            forwarding_ref.is_none(),
            "We can't have a forwarding ref when we remap",
        )?;
        self.assert_type_refs_to_reconstitute(type_refs, forwarding_ref)?;

        let first_target = self.get_map_target(type_refs[0])?;
        let Some(first) = self.reconstituted(first_target.index())? else {
            return Ok(None);
        };
        for &t in &type_refs[1..] {
            let target = self.get_map_target(t)?;
            if self.reconstituted(target.index())? != Some(first) {
                return Ok(None);
            }
        }
        Ok(Some(first))
    }

    /// `registerUnion(typeRefs, reconstituted)`: records that the set of old
    /// types `type_refs` became `reconstituted`.
    pub fn register_union(&mut self, type_refs: &[TypeRef], reconstituted: TypeRef) -> Result<()> {
        let set: IndexSet<TypeRef> = type_refs.iter().copied().collect();
        match &mut self.rewrite_state_mut()?.mode {
            RewriteMode::Rewrite {
                reconstituted_unions,
                ..
            } => {
                assert(
                    !reconstituted_unions.has(&set),
                    "Cannot register reconstituted set twice",
                )?;
                reconstituted_unions.set(set, reconstituted);
                Ok(())
            }
            RewriteMode::Remap { .. } => panic("Not a graph rewrite builder"),
        }
    }

    fn group_indexes(set: &IndexSet<TypeRef>) -> String {
        set.iter()
            .map(|t| t.index().to_string())
            .collect::<Vec<_>>()
            .join(",")
    }

    /// `replaceSet(typesToReplace, maybeForwardingRef)`.
    fn replace_set(
        &mut self,
        group: usize,
        maybe_forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let (types_to_replace, replacer) = match &self.rewrite_state()?.mode {
            RewriteMode::Rewrite {
                groups, replacer, ..
            } => (Rc::clone(&groups[group]), Rc::clone(replacer)),
            RewriteMode::Remap { .. } => return panic("Not a graph rewrite builder"),
        };
        self.with_forwarding_ref(maybe_forwarding_ref, |b, forwarding_ref| {
            if b.debug_print() {
                b.debug_log(&format!(
                    "replacing set {} as {}",
                    Self::group_indexes(&types_to_replace),
                    forwarding_ref.index()
                ));
                b.change_debug_print_indent(1);
            }

            for t in types_to_replace.iter() {
                b.set_reconstituted(t.index(), forwarding_ref)?;
                if let RewriteMode::Rewrite {
                    sets_to_replace_by_member,
                    ..
                } = &mut b.rewrite_state_mut()?.mode
                {
                    sets_to_replace_by_member.remove(&t.index());
                }
            }

            let result = replacer(&types_to_replace, b, forwarding_ref)?;
            assert(
                result == forwarding_ref,
                "The forwarding ref got lost when replacing",
            )?;

            if b.debug_print() {
                b.change_debug_print_indent(-1);
                b.debug_log(&format!(
                    "replaced set {} as {}",
                    Self::group_indexes(&types_to_replace),
                    forwarding_ref.index()
                ));
            }
            Ok(result)
        })
    }

    /// `forceReconstituteTypeRef(originalRef, attributes, forwardingRef)`.
    fn force_reconstitute_type_ref(
        &mut self,
        original_ref: TypeRef,
        attributes: TypeAttributes,
        maybe_forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        if self.is_remap() {
            return self.remap_force_reconstitute_type_ref(
                original_ref,
                attributes,
                maybe_forwarding_ref,
            );
        }

        let original = self.original_graph()?;
        let original_type = original.type_at(original_ref);
        let original_attributes = original.attributes(original_ref);
        let index = original_ref.index();

        if self.debug_print() {
            self.debug_log(&format!("reconstituting {index}"));
            self.change_debug_print_indent(1);
        }

        // The attributes are reconstituted before the type, so types that
        // transformations refer to come first.
        let reconstituted_attributes = self.reconstitute_type_attributes(original_attributes)?;
        let attributes = combine_type_attributes2(
            CombinationKind::Union,
            &attributes,
            &reconstituted_attributes,
        )?;

        let canonical_order = self.canonical_order();
        let mut reconstituter = TypeReconstituter::new(
            self,
            canonical_order,
            attributes,
            maybe_forwarding_ref,
            Registration::Rewrite {
                original_index: index,
                forwarding_ref: maybe_forwarding_ref,
            },
        );
        ty::reconstitute(original, original_type, &mut reconstituter, canonical_order)?;
        reconstituter.get_result()
    }

    /// `GraphRemapBuilder.forceReconstituteTypeRef`: reserves the new ref
    /// first, then computes the attributes (merged from every type mapped to
    /// this one), so a type's index precedes its transformation's types.
    fn remap_force_reconstitute_type_ref(
        &mut self,
        original_ref: TypeRef,
        attributes: TypeAttributes,
        maybe_forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let original_ref = self.get_map_target(original_ref)?;
        let index = original_ref.index();
        assert(
            self.reconstituted(index)?.is_none(),
            "Type has already been reconstituted",
        )?;
        assert(
            maybe_forwarding_ref.is_none(),
            "We can't have a forwarding ref when we remap",
        )?;

        self.with_forwarding_ref(None, |b, forwarding_ref| {
            b.set_reconstituted(index, forwarding_ref)?;

            if b.debug_print() {
                b.debug_log(&format!(
                    "reconstituting {index} as {}",
                    forwarding_ref.index()
                ));
                b.change_debug_print_indent(1);
            }

            let original = b.original_graph()?;
            let original_type = original.type_at(original_ref);
            let original_attributes = original.attributes(original_ref);

            let sources = match &b.rewrite_state()?.mode {
                RewriteMode::Remap {
                    attribute_sources, ..
                } => attribute_sources.get(&original_ref).cloned(),
                RewriteMode::Rewrite { .. } => None,
            };
            let source_attributes = match sources {
                None => original_attributes.clone(),
                Some(sources) => {
                    let all: Vec<&TypeAttributes> =
                        sources.iter().map(|&s| original.attributes(s)).collect();
                    combine_type_attributes(CombinationKind::Union, &all)?
                }
            };
            let reconstituted_attributes = b.reconstitute_type_attributes(&source_attributes)?;
            let attributes = combine_type_attributes2(
                CombinationKind::Union,
                &attributes,
                &reconstituted_attributes,
            )?;

            let canonical_order = b.canonical_order();
            let mut reconstituter = TypeReconstituter::new(
                b,
                canonical_order,
                attributes,
                Some(forwarding_ref),
                Registration::Remap {
                    original_index: index,
                    forwarding_ref,
                },
            );
            ty::reconstitute(original, original_type, &mut reconstituter, canonical_order)?;
            reconstituter.get_result()
        })
    }

    /// The `register` callbacks the builders pass to their reconstituters.
    fn register_reconstituted(&mut self, registration: Registration, tref: TypeRef) -> Result<()> {
        match registration {
            Registration::Rewrite {
                original_index,
                forwarding_ref,
            } => {
                if self.debug_print() {
                    self.change_debug_print_indent(-1);
                    self.debug_log(&format!(
                        "reconstituted {original_index} as {}",
                        tref.index()
                    ));
                }
                if let Some(fwd) = forwarding_ref {
                    assert(tref == fwd, "We didn't pass the forwarding ref")?;
                }
                match self.reconstituted(original_index)? {
                    None => self.set_reconstituted(original_index, tref),
                    Some(already) => {
                        assert(tref == already, "We reconstituted a type twice differently")
                    }
                }
            }
            Registration::Remap {
                original_index,
                forwarding_ref,
            } => {
                assert(
                    tref == forwarding_ref,
                    "Reconstituted type as a different ref",
                )?;
                if self.debug_print() {
                    self.change_debug_print_indent(-1);
                    self.debug_log(&format!(
                        "reconstituted {original_index} as {}",
                        tref.index()
                    ));
                }
                Ok(())
            }
        }
    }
}

/// What a [`TypeReconstituter`] does when its type is registered.
#[derive(Clone, Copy, Debug)]
enum Registration {
    Rewrite {
        original_index: usize,
        forwarding_ref: Option<TypeRef>,
    },
    Remap {
        original_index: usize,
        forwarding_ref: TypeRef,
    },
}

/// `TypeReconstituter`: builds the new version of one old type. It must
/// create exactly one type (a `get*Type` method), may look up children
/// before that and reconstitute and set them after.
pub struct TypeReconstituter<'a, 'g> {
    builder: &'a mut TypeBuilder<'g>,
    make_class_unique: bool,
    type_attributes: TypeAttributes,
    forwarding_ref: Option<TypeRef>,
    registration: Registration,
    was_used: bool,
    type_ref: Option<TypeRef>,
}

impl<'a, 'g> TypeReconstituter<'a, 'g> {
    fn new(
        builder: &'a mut TypeBuilder<'g>,
        make_class_unique: bool,
        type_attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
        registration: Registration,
    ) -> Self {
        TypeReconstituter {
            builder,
            make_class_unique,
            type_attributes,
            forwarding_ref,
            registration,
            was_used: false,
            type_ref: None,
        }
    }

    fn builder_for_new_type(&mut self) -> Result<&mut TypeBuilder<'g>> {
        assert(!self.was_used, "TypeReconstituter used more than once")?;
        self.was_used = true;
        Ok(self.builder)
    }

    fn builder_for_setting(&mut self) -> Result<&mut TypeBuilder<'g>> {
        assert(
            self.was_used && self.type_ref.is_some(),
            "Can't set type members before constructing a type",
        )?;
        Ok(self.builder)
    }

    /// `getResult()`: the new type.
    pub fn get_result(&self) -> Result<TypeRef> {
        match self.type_ref {
            Some(r) => Ok(r),
            None => panic("Type was not reconstituted"),
        }
    }

    fn register(&mut self, tref: TypeRef) -> Result<()> {
        assert(self.type_ref.is_none(), "Cannot register a type twice")?;
        self.type_ref = Some(tref);
        self.builder.register_reconstituted(self.registration, tref)
    }

    fn register_and_add_attributes(&mut self, tref: TypeRef) -> Result<()> {
        self.builder.add_attributes(tref, &self.type_attributes)?;
        self.register(tref)
    }

    /// `lookup(tref)`: the new type for an old one, if it already exists.
    pub fn lookup(&mut self, tref: TypeRef) -> Result<Option<TypeRef>> {
        assert(
            !self.was_used,
            "Cannot lookup constituents after building type",
        )?;
        self.builder.lookup_type_refs(&[tref], None, false)
    }

    /// `lookup(trefs)`: all new types, or `None` if any is missing.
    pub fn lookup_many(&mut self, trefs: &[TypeRef]) -> Result<Option<Vec<TypeRef>>> {
        assert(
            !self.was_used,
            "Cannot lookup constituents after building type",
        )?;
        let mut maybe_refs = Vec::with_capacity(trefs.len());
        for &tref in trefs {
            maybe_refs.push(self.builder.lookup_type_refs(&[tref], None, false)?);
        }
        Ok(maybe_refs.into_iter().collect())
    }

    /// `lookupMap(trefs)`.
    pub fn lookup_map<K: Clone + std::hash::Hash + Eq>(
        &mut self,
        trefs: &IndexMap<K, TypeRef>,
    ) -> Result<Option<IndexMap<K, TypeRef>>> {
        let values: Vec<TypeRef> = trefs.values().copied().collect();
        let Some(result_values) = self.lookup_many(&values)? else {
            return Ok(None);
        };
        assert(
            result_values.len() == trefs.len(),
            "Didn't get back the correct number of types",
        )?;
        Ok(Some(trefs.keys().cloned().zip(result_values).collect()))
    }

    /// `reconstitute(tref)`: reconstitutes a child after the type was built.
    pub fn reconstitute(&mut self, tref: TypeRef) -> Result<TypeRef> {
        assert(
            self.was_used,
            "Cannot reconstitute constituents before building type",
        )?;
        self.builder
            .reconstitute_type_ref(tref, TypeAttributes::new(), None)
    }

    /// `reconstituteMap(trefs)`.
    pub fn reconstitute_map<K: Clone + std::hash::Hash + Eq>(
        &mut self,
        trefs: &IndexMap<K, TypeRef>,
    ) -> Result<IndexMap<K, TypeRef>> {
        let mut result = IndexMap::with_capacity(trefs.len());
        for (k, &tref) in trefs {
            let r = self
                .builder
                .reconstitute_type_ref(tref, TypeAttributes::new(), None)?;
            result.insert(k.clone(), r);
        }
        Ok(result)
    }

    /// `getPrimitiveType(kind)`.
    pub fn get_primitive_type(&mut self, kind: TypeKind) -> Result<()> {
        let attributes = self.type_attributes.clone();
        let fwd = self.forwarding_ref;
        let r = self
            .builder_for_new_type()?
            .get_primitive_type(kind, attributes, fwd)?;
        self.register(r)
    }

    /// `getEnumType(cases)`.
    pub fn get_enum_type(&mut self, cases: IndexSet<String>) -> Result<()> {
        let attributes = self.type_attributes.clone();
        let fwd = self.forwarding_ref;
        let r = self
            .builder_for_new_type()?
            .get_enum_type(attributes, cases, fwd)?;
        self.register(r)
    }

    /// `getUniqueMapType()`: the attributes are added after creation.
    pub fn get_unique_map_type(&mut self) -> Result<()> {
        let fwd = self.forwarding_ref;
        let r = self.builder_for_new_type()?.get_unique_map_type(fwd)?;
        self.register_and_add_attributes(r)
    }

    /// `getMapType(values)`.
    pub fn get_map_type(&mut self, values: TypeRef) -> Result<()> {
        let attributes = self.type_attributes.clone();
        let fwd = self.forwarding_ref;
        let r = self
            .builder_for_new_type()?
            .get_map_type(attributes, values, fwd)?;
        self.register(r)
    }

    /// `getUniqueArrayType()`.
    pub fn get_unique_array_type(&mut self) -> Result<()> {
        let attributes = self.type_attributes.clone();
        let fwd = self.forwarding_ref;
        let r = self
            .builder_for_new_type()?
            .get_unique_array_type(attributes, fwd)?;
        self.register(r)
    }

    /// `getArrayType(items)`.
    pub fn get_array_type(&mut self, items: TypeRef) -> Result<()> {
        let attributes = self.type_attributes.clone();
        let fwd = self.forwarding_ref;
        let r = self
            .builder_for_new_type()?
            .get_array_type(attributes, items, fwd)?;
        self.register(r)
    }

    /// `setArrayItems(items)`.
    pub fn set_array_items(&mut self, items: TypeRef) -> Result<()> {
        let r = self.get_result()?;
        self.builder_for_setting()?.set_array_items(r, items)
    }

    /// `makeClassProperty(tref, isOptional)`.
    pub fn make_class_property(&self, tref: TypeRef, is_optional: bool) -> ClassProperty {
        ClassProperty::new(tref, is_optional)
    }

    /// `getObjectType(properties, additionalProperties)`: always unique.
    pub fn get_object_type(
        &mut self,
        properties: IndexMap<String, ClassProperty>,
        additional_properties: Option<TypeRef>,
    ) -> Result<()> {
        self.get_unique_object_type(Some(properties), additional_properties)
    }

    /// `getUniqueObjectType(properties, additionalProperties)`.
    pub fn get_unique_object_type(
        &mut self,
        properties: Option<IndexMap<String, ClassProperty>>,
        additional_properties: Option<TypeRef>,
    ) -> Result<()> {
        let attributes = self.type_attributes.clone();
        let fwd = self.forwarding_ref;
        let r = self.builder_for_new_type()?.get_unique_object_type(
            attributes,
            properties,
            additional_properties,
            fwd,
        )?;
        self.register(r)
    }

    /// `getClassType(properties)`: unique if the builder sorts properties
    /// (`_makeClassUnique` is the builder's `canonicalOrder`).
    pub fn get_class_type(&mut self, properties: IndexMap<String, ClassProperty>) -> Result<()> {
        if self.make_class_unique {
            return self.get_unique_class_type(false, Some(properties));
        }
        let attributes = self.type_attributes.clone();
        let fwd = self.forwarding_ref;
        let r = self
            .builder_for_new_type()?
            .get_class_type(attributes, properties, fwd)?;
        self.register(r)
    }

    /// `getUniqueClassType(isFixed, properties)`.
    pub fn get_unique_class_type(
        &mut self,
        is_fixed: bool,
        properties: Option<IndexMap<String, ClassProperty>>,
    ) -> Result<()> {
        let attributes = self.type_attributes.clone();
        let fwd = self.forwarding_ref;
        let r = self
            .builder_for_new_type()?
            .get_unique_class_type(attributes, is_fixed, properties, fwd)?;
        self.register(r)
    }

    /// `setObjectProperties(properties, additionalProperties)`.
    pub fn set_object_properties(
        &mut self,
        properties: IndexMap<String, ClassProperty>,
        additional_properties: Option<TypeRef>,
    ) -> Result<()> {
        let r = self.get_result()?;
        self.builder_for_setting()?
            .set_object_properties(r, properties, additional_properties)
    }

    /// `getUnionType(members)`.
    pub fn get_union_type(&mut self, members: IndexSet<TypeRef>) -> Result<()> {
        let attributes = self.type_attributes.clone();
        let fwd = self.forwarding_ref;
        let r = self
            .builder_for_new_type()?
            .get_union_type(attributes, members, fwd)?;
        self.register(r)
    }

    /// `getUniqueUnionType()`.
    pub fn get_unique_union_type(&mut self) -> Result<()> {
        let attributes = self.type_attributes.clone();
        let fwd = self.forwarding_ref;
        let r = self
            .builder_for_new_type()?
            .get_unique_union_type(attributes, None, fwd)?;
        self.register(r)
    }

    /// `getIntersectionType(members)`.
    pub fn get_intersection_type(&mut self, members: IndexSet<TypeRef>) -> Result<()> {
        let attributes = self.type_attributes.clone();
        let fwd = self.forwarding_ref;
        let r = self
            .builder_for_new_type()?
            .get_intersection_type(attributes, members, fwd)?;
        self.register(r)
    }

    /// `getUniqueIntersectionType()`.
    pub fn get_unique_intersection_type(&mut self) -> Result<()> {
        let attributes = self.type_attributes.clone();
        let fwd = self.forwarding_ref;
        let r = self
            .builder_for_new_type()?
            .get_unique_intersection_type(attributes, None, fwd)?;
        self.register(r)
    }

    /// `setSetOperationMembers(members)`.
    pub fn set_set_operation_members(&mut self, members: IndexSet<TypeRef>) -> Result<()> {
        let r = self.get_result()?;
        self.builder_for_setting()?
            .set_set_operation_members(r, members)
    }
}
