//! Port of `packages/quicktype-core/src/Type/TypeGraph.ts`.
//!
//! A frozen type graph: an arena of [`Type`]s indexed by [`TypeRef`], their
//! attributes (the attribute store, which stays mutable for `GatherNames`),
//! and the named top-level types in insertion order.
//!
//! Graphs are never modified structurally. A *rewrite* builds a new graph
//! (serial + 1) by reconstituting the old one through a
//! [`TypeBuilder`], replacing groups of
//! types along the way; a *remap* redirects types to other types.
//! [`TypeGraph::rewrite`] and [`TypeGraph::remap`] return `None` where the
//! TypeScript methods return `this` (nothing to do), so callers can tell
//! whether the graph changed.
//!
//! # Debugging against the reference
//!
//! [`TypeGraph::print_graph`] reproduces `printGraph()` (`--debug
//! print-graph`) byte for byte, and [`TypeGraph::set_print_on_rewrite`]
//! makes every rewrite print a `# <title>` header followed by the new graph,
//! like the reference does. To find the first stage where the port diverges,
//! run the reference with `--debug print-graph` and diff its output against
//! ours stage by stage; [`TypeGraph::graph_text`] returns the lines for use
//! in tests. See `docs/research/01-type-graph-and-pipeline.md` for the stage
//! list.

use std::cell::OnceCell;

use indexmap::{IndexMap, IndexSet};

use crate::attributes::type_attributes::{AttributeKind, TypeAttributeValue, TypeAttributes};
use crate::attributes::type_names::NamesTypeAttributeKind;
use crate::graph::Graph;
use crate::graph_rewriting::{Replacer, make_replacer};
use crate::messages::{ErrorKind, MessageValue, Result, message_error};
use crate::support::collection_utils::set_subtract;
use crate::support::fast_hash::HashSet;
use crate::support::support::{assert, console_log, defined, must_not_happen, panic};
use crate::ty::provenance_type_attribute_kind::ProvenanceTypeAttributeKind;
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::ty::{Type, TypeData, sort_members_by_kind};
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_builder_utils::{StringTypeMapping, get_no_string_type_mapping};
use crate::ty::type_graph_utils::remove_indirection_intersections;
use crate::ty::type_ref::{TypeRef, assert_type_ref_graph};
use crate::ty::type_utils::{SeparatedNamedTypes, is_named_type, separate_named_types};

/// A frozen type graph.
#[derive(Debug)]
pub struct TypeGraph {
    serial: u32,
    have_provenance_attributes: bool,
    types: Vec<Type>,
    attributes: Vec<TypeAttributes>,
    top_level_attributes: IndexMap<String, TypeAttributes>,
    top_levels: IndexMap<String, TypeRef>,
    parents: OnceCell<Vec<IndexSet<TypeRef>>>,
    print_on_rewrite: bool,
}

impl TypeGraph {
    /// `freeze(topLevels, types, typeAttributes)`.
    pub(crate) fn freeze(
        serial: u32,
        have_provenance_attributes: bool,
        top_levels: IndexMap<String, TypeRef>,
        types: Vec<Type>,
        attributes: Vec<TypeAttributes>,
    ) -> Result<TypeGraph> {
        for t in &types {
            assert_type_ref_graph(t.type_ref(), serial)?;
        }
        for &r in top_levels.values() {
            assert_type_ref_graph(r, serial)?;
            defined(types.get(r.index()))?;
        }
        Ok(TypeGraph {
            serial,
            have_provenance_attributes,
            types,
            attributes,
            top_level_attributes: IndexMap::new(),
            top_levels,
            parents: OnceCell::new(),
            print_on_rewrite: false,
        })
    }

    /// The graph's serial number. The initial graph has serial 0, each
    /// rewrite or remap adds one.
    pub fn serial(&self) -> u32 {
        self.serial
    }

    /// Whether the graph tracks provenance (`--debug provenance`).
    pub fn have_provenance_attributes(&self) -> bool {
        self.have_provenance_attributes
    }

    /// The named top-level types, in insertion order (`topLevels`).
    pub fn top_levels(&self) -> &IndexMap<String, TypeRef> {
        &self.top_levels
    }

    /// The number of types.
    pub fn len(&self) -> usize {
        self.types.len()
    }

    /// Whether the graph has no types.
    pub fn is_empty(&self) -> bool {
        self.types.is_empty()
    }

    /// All types, in index order.
    pub fn types(&self) -> &[Type] {
        &self.types
    }

    /// `allTypesUnordered()`: all type refs, in index order.
    pub fn all_types_unordered(&self) -> impl Iterator<Item = TypeRef> + '_ {
        self.types.iter().map(Type::type_ref)
    }

    /// The arena index of `r`, checking that `r` belongs to this graph
    /// (`assertTypeRefGraph`).
    fn index_of(&self, r: TypeRef) -> Result<usize> {
        assert_type_ref_graph(r, self.serial)?;
        let index = r.index();
        if index >= self.types.len() {
            return panic("Defined value expected, but got undefined");
        }
        Ok(index)
    }

    /// `derefTypeRef(tref, graph)`. Errors with `Mixing the wrong type
    /// reference and graph` for a ref of another graph.
    pub fn type_at(&self, r: TypeRef) -> Result<&Type> {
        Ok(&self.types[self.index_of(r)?])
    }

    /// The kind of the type `r`.
    pub fn kind(&self, r: TypeRef) -> Result<TypeKind> {
        Ok(self.type_at(r)?.kind())
    }

    /// `attributesForTypeRef(tref, graph)` / `t.getAttributes()`.
    pub fn attributes(&self, r: TypeRef) -> Result<&TypeAttributes> {
        Ok(&self.attributes[self.index_of(r)?])
    }

    /// `TypeAttributeStore.set(kind, t, value)`: sets an attribute after
    /// freezing (used by `GatherNames`).
    pub fn set_attribute(&mut self, r: TypeRef, value: TypeAttributeValue) -> Result<()> {
        let index = self.index_of(r)?;
        self.attributes[index].insert(value);
        Ok(())
    }

    /// Typed [`set_attribute`](Self::set_attribute)
    /// (`TypeAttributeStoreView.set`).
    pub fn set_attribute_value<K: AttributeKind>(
        &mut self,
        kind: K,
        r: TypeRef,
        value: K::Value,
    ) -> Result<()> {
        self.set_attribute(r, kind.wrap_value(value))
    }

    /// `TypeAttributeStore.attributesForTopLevel(name)`.
    pub fn top_level_attributes(&self, name: &str) -> TypeAttributes {
        self.top_level_attributes
            .get(name)
            .cloned()
            .unwrap_or_default()
    }

    /// `TypeAttributeStore.setForTopLevel(kind, name, value)`.
    pub fn set_top_level_attribute(&mut self, name: &str, value: TypeAttributeValue) {
        self.top_level_attributes
            .entry(name.to_owned())
            .or_default()
            .insert(value);
    }

    /// `t.hasNames`.
    pub fn has_names(&self, r: TypeRef) -> Result<bool> {
        Ok(NamesTypeAttributeKind
            .try_get_in_attributes(self.attributes(r)?)
            .is_some())
    }

    /// `t.getCombinedName()`.
    pub fn combined_name(&self, r: TypeRef) -> Result<String> {
        defined(NamesTypeAttributeKind.try_get_in_attributes(self.attributes(r)?))?.combined_name()
    }

    /// `getNonAttributeChildren()`: array items; object property types
    /// sorted by property name, then additional properties; set operation
    /// members sorted by kind. Deduplicated, in that order.
    pub fn non_attribute_children(&self, r: TypeRef) -> Result<IndexSet<TypeRef>> {
        let t = self.type_at(r)?;
        Ok(match t.data() {
            TypeData::Primitive | TypeData::Enum { .. } => IndexSet::new(),
            TypeData::Array { .. } => [t.items()?].into_iter().collect(),
            TypeData::Object { .. } => {
                let mut children: IndexSet<TypeRef> = t
                    .sorted_property_refs()?
                    .into_iter()
                    .map(|(_, p)| p.type_ref)
                    .collect();
                if let Some(additional) = t.additional_properties()? {
                    children.insert(additional);
                }
                children
            }
            TypeData::SetOperation { .. } => sort_members_by_kind(self, t.members()?)?,
        })
    }

    /// `getChildren()`: the non-attribute children, then the children of the
    /// attributes (transformations) in attribute order.
    pub fn children(&self, r: TypeRef) -> Result<IndexSet<TypeRef>> {
        let mut result = self.non_attribute_children(r)?;
        for value in self.attributes(r)?.iter() {
            result.extend(value.children());
        }
        // TypeScript derefs every child, which asserts it is in this graph.
        for &c in &result {
            self.index_of(c)?;
        }
        Ok(result)
    }

    /// `filterTypes(predicate)`: types reachable from the top-levels (in
    /// top-level order), depth-first pre-order over `getChildren()`, that
    /// satisfy `predicate`.
    pub fn filter_types(
        &self,
        mut predicate: impl FnMut(&TypeGraph, TypeRef) -> Result<bool>,
    ) -> Result<IndexSet<TypeRef>> {
        let mut seen: HashSet<TypeRef> = HashSet::default();
        let mut types: IndexSet<TypeRef> = IndexSet::new();
        // An explicit stack instead of recursion, visiting in the same order.
        let mut stack: Vec<(IndexSet<TypeRef>, usize)> = Vec::new();
        for &top in self.top_levels.values() {
            let mut visit = |t: TypeRef,
                             stack: &mut Vec<(IndexSet<TypeRef>, usize)>,
                             seen: &mut HashSet<TypeRef>|
             -> Result<()> {
                if !seen.insert(t) {
                    return Ok(());
                }
                if predicate(self, t)? {
                    types.insert(t);
                }
                stack.push((self.children(t)?, 0));
                Ok(())
            };
            visit(top, &mut stack, &mut seen)?;
            while let Some((children, position)) = stack.last_mut() {
                match children.get_index(*position) {
                    Some(&child) => {
                        *position += 1;
                        visit(child, &mut stack, &mut seen)?;
                    }
                    None => {
                        stack.pop();
                    }
                }
            }
        }
        Ok(types)
    }

    /// `allNamedTypes()`: classes, objects, enums and unions reachable from
    /// the top-levels, in depth-first order.
    pub fn all_named_types(&self) -> Result<IndexSet<TypeRef>> {
        self.filter_types(|g, t| Ok(is_named_type(g.type_at(t)?)))
    }

    /// `allNamedTypesSeparated()`.
    pub fn all_named_types_separated(&self) -> Result<SeparatedNamedTypes> {
        let types = self.all_named_types()?;
        separate_named_types(self, &types)
    }

    /// `getParentsOfType(t)`: the types that have `t` as a child, in index
    /// order. Computed once and cached.
    pub fn parents_of_type(&self, r: TypeRef) -> Result<&IndexSet<TypeRef>> {
        if self.parents.get().is_none() {
            let mut parents: Vec<IndexSet<TypeRef>> = vec![IndexSet::new(); self.types.len()];
            for p in self.all_types_unordered() {
                for c in self.children(p)? {
                    parents[self.index_of(c)?].insert(p);
                }
            }
            let _ = self.parents.set(parents);
        }
        let index = self.index_of(r)?;
        Ok(&defined(self.parents.get())?[index])
    }

    /// `makeGraph(invertDirection, childrenOfType)`: a [`Graph`] over all
    /// types in index order.
    pub fn make_graph(
        &self,
        invert_direction: bool,
        mut children_of_type: impl FnMut(TypeRef) -> Result<IndexSet<TypeRef>>,
    ) -> Result<Graph<TypeRef>> {
        let nodes: Vec<TypeRef> = self.all_types_unordered().collect();
        let mut edges: Vec<Vec<usize>> = Vec::with_capacity(nodes.len());
        for &n in &nodes {
            let mut successors = Vec::new();
            for c in children_of_type(n)? {
                // `defined(this._indexByNode.get(s))`
                if !c.belongs_to(self.serial) || c.index() >= nodes.len() {
                    return panic("Defined value expected, but got undefined");
                }
                successors.push(c.index());
            }
            edges.push(successors);
        }
        Graph::with_edges(nodes, invert_direction, edges)
    }

    fn all_provenance(&self) -> Result<IndexSet<u32>> {
        assert(self.have_provenance_attributes, "Assertion failed")?;
        let mut result = IndexSet::new();
        for attributes in &self.attributes {
            if let Some(p) = ProvenanceTypeAttributeKind.try_get_in_attributes(attributes) {
                result.extend(p.iter().copied());
            }
        }
        Ok(result)
    }

    /// `checkLostTypeAttributes(builder, newGraph)`: with provenance, every
    /// rewrite that does not knowingly drop attributes must keep all of it.
    fn check_lost_type_attributes(
        &self,
        builder_lost_type_attributes: bool,
        new_graph: &TypeGraph,
    ) -> Result<()> {
        if !self.have_provenance_attributes || builder_lost_type_attributes {
            return Ok(());
        }
        let old_provenance = self.all_provenance()?;
        let new_provenance = new_graph.all_provenance()?;
        if old_provenance.len() != new_provenance.len() {
            let difference = set_subtract(&old_provenance, &new_provenance);
            return message_error(
                ErrorKind::IRTypeAttributesNotPropagated,
                vec![
                    ("count", MessageValue::from(difference.len())),
                    (
                        "indexes",
                        MessageValue::Array(
                            difference
                                .iter()
                                .map(|&i| MessageValue::Number(f64::from(i)))
                                .collect(),
                        ),
                    ),
                ],
            );
        }
        Ok(())
    }

    /// `setPrintOnRewrite()`: print every rewrite's title and resulting graph.
    pub fn set_print_on_rewrite(&mut self) {
        self.print_on_rewrite = true;
    }

    fn print_rewrite(&self, title: &str) {
        if self.print_on_rewrite {
            console_log(&format!("\n# {title}"));
        }
    }

    /// `rewrite(title, stringTypeMapping, alphabetizeProperties,
    /// replacementGroups, debugPrintReconstitution, replacer, force)`.
    ///
    /// Each group of types (refs into this graph) is replaced by the single
    /// type `replacer` builds; everything else is reconstituted. Returns
    /// `None` (TypeScript: `this`) if there are no groups and `force` is
    /// false. If the rewrite created forwarding intersections, they are
    /// removed by a second, remapping pass, as in TypeScript.
    #[allow(clippy::too_many_arguments)]
    pub fn rewrite<'g>(
        &'g self,
        title: &str,
        string_type_mapping: &StringTypeMapping,
        alphabetize_properties: bool,
        replacement_groups: Vec<Vec<TypeRef>>,
        debug_print_reconstitution: bool,
        replacer: Replacer<'g>,
        force: bool,
    ) -> Result<Option<TypeGraph>> {
        self.print_rewrite(title);

        if !force && replacement_groups.is_empty() {
            return Ok(None);
        }

        let builder = TypeBuilder::new_rewrite(
            self,
            string_type_mapping.clone(),
            alphabetize_properties,
            replacement_groups,
            debug_print_reconstitution,
            replacer,
        )?;
        let finished = builder.finish_rewrite()?;
        let mut new_graph = finished.graph;

        self.check_lost_type_attributes(finished.lost_type_attributes, &new_graph)?;

        if self.print_on_rewrite {
            new_graph.set_print_on_rewrite();
            new_graph.print_graph()?;
        }

        if !finished.added_forwarding_intersection {
            return Ok(Some(new_graph));
        }

        let remapped = remove_indirection_intersections(
            &new_graph,
            string_type_mapping,
            debug_print_reconstitution,
        )?;
        Ok(Some(remapped.unwrap_or(new_graph)))
    }

    /// `remap(title, stringTypeMapping, alphabetizeProperties, map,
    /// debugPrintRemapping, force)`: rebuilds the graph with each key of
    /// `map` replaced by its value (refs into this graph), merging their
    /// attributes. Returns `None` (TypeScript: `this`) if `map` is empty and
    /// `force` is false.
    pub fn remap(
        &self,
        title: &str,
        string_type_mapping: &StringTypeMapping,
        alphabetize_properties: bool,
        map: IndexMap<TypeRef, TypeRef>,
        debug_print_remapping: bool,
        force: bool,
    ) -> Result<Option<TypeGraph>> {
        self.print_rewrite(title);

        if !force && map.is_empty() {
            return Ok(None);
        }

        let builder = TypeBuilder::new_remap(
            self,
            string_type_mapping.clone(),
            alphabetize_properties,
            map,
            debug_print_remapping,
        )?;
        let finished = builder.finish_rewrite()?;
        let mut new_graph = finished.graph;

        self.check_lost_type_attributes(finished.lost_type_attributes, &new_graph)?;

        if self.print_on_rewrite {
            new_graph.set_print_on_rewrite();
            new_graph.print_graph()?;
        }

        assert(!finished.added_forwarding_intersection, "Assertion failed")?;

        Ok(Some(new_graph))
    }

    /// `garbageCollect(alphabetizeProperties, debugPrintReconstitution)`: a
    /// forced remap that drops unreachable types and renumbers the rest in
    /// reconstitution order.
    pub fn garbage_collect(
        &self,
        alphabetize_properties: bool,
        debug_print_reconstitution: bool,
    ) -> Result<TypeGraph> {
        let graph = self.remap(
            "GC",
            &get_no_string_type_mapping(),
            alphabetize_properties,
            IndexMap::new(),
            debug_print_reconstitution,
            true,
        )?;
        defined(graph)
    }

    /// `rewriteFixedPoint(alphabetizeProperties, debugPrintReconstitution)`.
    ///
    /// Reproduces the TypeScript bug: every iteration rewrites `self`, not
    /// the previous result. If the first rewrite has as many types as `self`
    /// it returns `None` (TypeScript: `this`), discarding the rewrite;
    /// otherwise it rewrites `self` a second time (which can consume the
    /// random name generator) and returns the first rewrite.
    pub fn rewrite_fixed_point(
        &self,
        alphabetize_properties: bool,
        debug_print_reconstitution: bool,
    ) -> Result<Option<TypeGraph>> {
        let mut graph: Option<TypeGraph> = None;
        loop {
            let replacer = make_replacer(|_, _, _| must_not_happen());
            let new_graph = defined(self.rewrite(
                "fixed-point",
                &get_no_string_type_mapping(),
                alphabetize_properties,
                Vec::new(),
                debug_print_reconstitution,
                replacer,
                true,
            )?)?;
            let size = graph.as_ref().map_or(self.len(), TypeGraph::len);
            if size == new_graph.len() {
                return Ok(graph);
            }
            graph = Some(new_graph);
        }
    }

    /// The line `printGraph()` prints for the type at `index`:
    /// `"${i}: ${kind}[ ${name}] | children a,b | ${attribute strings}"`.
    pub fn type_text(&self, index: usize) -> Result<String> {
        let t = defined(self.types.get(index))?;
        let r = t.type_ref();
        let mut parts: Vec<String> = Vec::new();
        let name = if self.has_names(r)? {
            format!(" {}", self.combined_name(r)?)
        } else {
            String::new()
        };
        parts.push(format!("{}{name}", t.debug_print_kind()));
        let children = self.children(r)?;
        if !children.is_empty() {
            parts.push(format!(
                "children {}",
                children
                    .iter()
                    .map(|c| c.index().to_string())
                    .collect::<Vec<_>>()
                    .join(",")
            ));
        }
        for value in self.attributes(r)?.iter() {
            if let Some(s) = value.stringify()? {
                parts.push(s);
            }
        }
        Ok(format!("{index}: {}", parts.join(" | ")))
    }

    /// All lines `printGraph()` prints.
    pub fn graph_text(&self) -> Result<Vec<String>> {
        (0..self.types.len()).map(|i| self.type_text(i)).collect()
    }

    /// `printGraph()`: prints the graph with [`console_log`], one line per
    /// type. Like TypeScript, the lines before a failing type are printed.
    pub fn print_graph(&self) -> Result<()> {
        for i in 0..self.types.len() {
            console_log(&self.type_text(i)?);
        }
        Ok(())
    }
}
