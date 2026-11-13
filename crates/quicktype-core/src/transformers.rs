//! Port of `packages/quicktype-core/src/Transformers.ts`.
//!
//! Transformers describe how a value of one type is decoded into (or encoded
//! from) a value of another type: a union of a string and an integer-string
//! that a target language cannot represent directly is decoded from `any`
//! by a [`TransformerData::DecodingChoice`], an enum is matched case by case
//! from a string, and so on. [`MakeTransformations`](crate::make_transformations)
//! attaches them to types as the `transformation` attribute, a
//! [`Transformation`]: the transformer plus the type it produces.
//!
//! The 14 TypeScript classes are one [`Transformer`] struct whose
//! [`TransformerData`] holds the kind-specific fields. Transformers refer to
//! types by [`TypeRef`] only; whatever needs to look at a type (debug output,
//! [`Transformer::reverse`]) takes a [`TypeLookup`], which both a frozen
//! [`TypeGraph`] and a [`TypeBuilder`] (the graph under construction)
//! implement. Child transformers are shared [`Rc`]s, so `areEqual`'s
//! identity check (`a === b`) is a pointer comparison.
//!
//! Hashing and equality are exact ports, quirks included: a
//! [`StringMatch`](TransformerData::StringMatch) equals another one only if
//! their cases *differ*, while its hash includes the case, and a
//! [`StringProducer`](TransformerData::StringProducer) adds its consumer's
//! hash twice. They matter because transformations are identity attributes,
//! so they decide which types the builder deduplicates.

use std::any::Any;
use std::rc::Rc;

use indexmap::IndexSet;

use crate::attributes::type_attributes::{
    AttributeKind, TransformationAttribute, TransformationTypeAttributeKind, TypeAttributes,
};
pub use crate::attributes::type_attributes::{follow_target_type, transformation_for_type};
use crate::messages::Result;
use crate::support::collection_utils::{JsHash, add_hash_code, hash_string};
use crate::support::support::{assert, console_log, indentation_string, panic};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::{TypeRef, assert_type_ref_graph};

/// Read access to the types of a graph, frozen or under construction
/// (`derefTypeRef` / `attributesForTypeRef` with a `TypeGraph` whose builder
/// may still be running).
pub trait TypeLookup {
    /// The kind of the type `t`.
    fn lookup_kind(&self, t: TypeRef) -> Result<TypeKind>;
    /// The attributes of the type `t`.
    fn lookup_attributes(&self, t: TypeRef) -> Result<&TypeAttributes>;
}

impl TypeLookup for TypeGraph {
    fn lookup_kind(&self, t: TypeRef) -> Result<TypeKind> {
        self.kind(t)
    }

    fn lookup_attributes(&self, t: TypeRef) -> Result<&TypeAttributes> {
        self.attributes(t)
    }
}

impl TypeLookup for TypeBuilder<'_> {
    fn lookup_kind(&self, t: TypeRef) -> Result<TypeKind> {
        assert_type_ref_graph(t, self.serial())?;
        Ok(self.type_at_index(t.index())?.kind())
    }

    fn lookup_attributes(&self, t: TypeRef) -> Result<&TypeAttributes> {
        assert_type_ref_graph(t, self.serial())?;
        Ok(self.at_index(t.index())?.1)
    }
}

/// The seven optional cases of a
/// [`DecodingChoice`](TransformerData::DecodingChoice), one per JSON value
/// kind.
#[derive(Clone, Debug, Default)]
pub struct DecodingChoiceCases {
    /// `nullTransformer`.
    pub null: Option<Rc<Transformer>>,
    /// `integerTransformer`.
    pub integer: Option<Rc<Transformer>>,
    /// `doubleTransformer`.
    pub double: Option<Rc<Transformer>>,
    /// `boolTransformer`.
    pub bool: Option<Rc<Transformer>>,
    /// `stringTransformer`.
    pub string: Option<Rc<Transformer>>,
    /// `arrayTransformer`.
    pub array: Option<Rc<Transformer>>,
    /// `objectTransformer`.
    pub object: Option<Rc<Transformer>>,
}

impl DecodingChoiceCases {
    /// The slots in declaration order.
    fn slots(&self) -> [&Option<Rc<Transformer>>; 7] {
        [
            &self.null,
            &self.integer,
            &self.double,
            &self.bool,
            &self.string,
            &self.array,
            &self.object,
        ]
    }
}

/// The kind-specific fields of a [`Transformer`]; one variant per
/// TypeScript transformer class.
#[derive(Clone, Debug)]
pub enum TransformerData {
    /// `DecodingTransformer` (`decode`): decodes the source, then hands the
    /// value to the consumer.
    Decoding {
        /// `consumer`.
        consumer: Option<Rc<Transformer>>,
    },
    /// `EncodingTransformer` (`encode`).
    Encoding,
    /// `ArrayDecodingTransformer` (`decode-array`).
    ArrayDecoding {
        /// `consumer`.
        consumer: Option<Rc<Transformer>>,
        /// `_itemTargetTypeRef`.
        item_target_type_ref: TypeRef,
        /// `itemTransformer`.
        item_transformer: Rc<Transformer>,
    },
    /// `ArrayEncodingTransformer` (`encode-array`).
    ArrayEncoding {
        /// `_itemTargetTypeRef`.
        item_target_type_ref: TypeRef,
        /// `itemTransformer`.
        item_transformer: Rc<Transformer>,
    },
    /// `ChoiceTransformer` (`choice`): the first transformer that succeeds.
    Choice {
        /// `transformers` (never empty).
        transformers: Vec<Rc<Transformer>>,
    },
    /// `DecodingChoiceTransformer` (`decoding-choice`): picks a transformer
    /// by the kind of the JSON value.
    DecodingChoice(DecodingChoiceCases),
    /// `UnionMemberMatchTransformer` (`union-member-match`).
    UnionMemberMatch {
        /// `transformer`.
        transformer: Rc<Transformer>,
        /// `memberTypeRef`.
        member_type_ref: TypeRef,
    },
    /// `StringMatchTransformer` (`string-match`): matches a string or enum
    /// case.
    StringMatch {
        /// `transformer`.
        transformer: Rc<Transformer>,
        /// `stringCase`.
        string_case: String,
    },
    /// `UnionInstantiationTransformer` (`union-instantiation`).
    UnionInstantiation,
    /// `StringProducerTransformer` (`string-producer`): produces a string or
    /// enum case.
    StringProducer {
        /// `consumer`.
        consumer: Option<Rc<Transformer>>,
        /// `result`.
        result: String,
    },
    /// `ParseStringTransformer` (`parse-string`).
    ParseString {
        /// `consumer`.
        consumer: Option<Rc<Transformer>>,
    },
    /// `StringifyTransformer` (`stringify`).
    Stringify {
        /// `consumer`.
        consumer: Option<Rc<Transformer>>,
    },
    /// `MinMaxLengthCheckTransformer` (`min-max-length-check`).
    MinMaxLengthCheck {
        /// `consumer`.
        consumer: Option<Rc<Transformer>>,
        /// `minLength`.
        min_length: Option<f64>,
        /// `maxLength`.
        max_length: Option<f64>,
    },
    /// `MinMaxValueTransformer` (`min-max-value-check`).
    MinMaxValue {
        /// `consumer`.
        consumer: Option<Rc<Transformer>>,
        /// `minimum`.
        minimum: Option<f64>,
        /// `maximum`.
        maximum: Option<f64>,
    },
}

/// `Transformer`: transforms a value of the source type.
#[derive(Clone, Debug)]
pub struct Transformer {
    source_type_ref: TypeRef,
    data: TransformerData,
}

/// `getNumberOfNodes(xfer)`: 0 for no transformer.
fn number_of_nodes(xfer: Option<&Rc<Transformer>>) -> usize {
    xfer.map_or(0, |x| x.get_number_of_nodes())
}

/// `hashCodeOf(xfer)` for an optional transformer.
fn optional_hash(xfer: Option<&Rc<Transformer>>) -> i64 {
    xfer.map_or(crate::support::collection_utils::HASH_CODE_INIT, |x| {
        x.hash_code()
    })
}

/// `areEqual(a, b)` for optional transformers: identical objects are equal
/// without asking `equals`.
fn optional_are_equal(a: Option<&Rc<Transformer>>, b: Option<&Rc<Transformer>>) -> bool {
    match (a, b) {
        (None, None) => true,
        (Some(a), Some(b)) => are_equal(a, b),
        _ => false,
    }
}

/// `areEqual(a, b)` for two transformers.
fn are_equal(a: &Rc<Transformer>, b: &Rc<Transformer>) -> bool {
    Rc::ptr_eq(a, b) || a.equals(b)
}

/// `debugStringForType(t)`: the kind, and the kind of the transformation's
/// final target if `t` has a transformation.
fn debug_string_for_type(lookup: &dyn TypeLookup, t: TypeRef) -> Result<String> {
    let target = follow_target_type(lookup, t)?;
    let kind = lookup.lookup_kind(t)?;
    if target == t {
        return Ok(kind.as_str().to_owned());
    }
    Ok(format!(
        "{} ({})",
        kind.as_str(),
        lookup.lookup_kind(target)?.as_str()
    ))
}

impl Transformer {
    fn new(source_type_ref: TypeRef, data: TransformerData) -> Rc<Transformer> {
        Rc::new(Transformer {
            source_type_ref,
            data,
        })
    }

    /// `new DecodingTransformer(graph, sourceTypeRef, consumer)`.
    pub fn decoding(source: TypeRef, consumer: Option<Rc<Transformer>>) -> Rc<Transformer> {
        Transformer::new(source, TransformerData::Decoding { consumer })
    }

    /// `new EncodingTransformer(graph, sourceTypeRef)`.
    pub fn encoding(source: TypeRef) -> Rc<Transformer> {
        Transformer::new(source, TransformerData::Encoding)
    }

    /// `new ArrayDecodingTransformer(graph, sourceTypeRef, consumer,
    /// itemTargetTypeRef, itemTransformer)`.
    pub fn array_decoding(
        source: TypeRef,
        consumer: Option<Rc<Transformer>>,
        item_target_type_ref: TypeRef,
        item_transformer: Rc<Transformer>,
    ) -> Rc<Transformer> {
        Transformer::new(
            source,
            TransformerData::ArrayDecoding {
                consumer,
                item_target_type_ref,
                item_transformer,
            },
        )
    }

    /// `new ArrayEncodingTransformer(graph, sourceTypeRef,
    /// itemTargetTypeRef, itemTransformer)`.
    pub fn array_encoding(
        source: TypeRef,
        item_target_type_ref: TypeRef,
        item_transformer: Rc<Transformer>,
    ) -> Rc<Transformer> {
        Transformer::new(
            source,
            TransformerData::ArrayEncoding {
                item_target_type_ref,
                item_transformer,
            },
        )
    }

    /// `new ChoiceTransformer(graph, sourceTypeRef, transformers)`: errors
    /// if `transformers` is empty.
    pub fn choice(source: TypeRef, transformers: Vec<Rc<Transformer>>) -> Result<Rc<Transformer>> {
        assert(
            !transformers.is_empty(),
            "Choice must have at least one transformer",
        )?;
        Ok(Transformer::new(
            source,
            TransformerData::Choice { transformers },
        ))
    }

    /// `new DecodingChoiceTransformer(graph, sourceTypeRef, ...)`.
    pub fn decoding_choice(source: TypeRef, cases: DecodingChoiceCases) -> Rc<Transformer> {
        Transformer::new(source, TransformerData::DecodingChoice(cases))
    }

    /// `new UnionMemberMatchTransformer(graph, sourceTypeRef, transformer,
    /// memberTypeRef)`.
    pub fn union_member_match(
        source: TypeRef,
        transformer: Rc<Transformer>,
        member_type_ref: TypeRef,
    ) -> Rc<Transformer> {
        Transformer::new(
            source,
            TransformerData::UnionMemberMatch {
                transformer,
                member_type_ref,
            },
        )
    }

    /// `new StringMatchTransformer(graph, sourceTypeRef, transformer,
    /// stringCase)`.
    pub fn string_match(
        source: TypeRef,
        transformer: Rc<Transformer>,
        string_case: String,
    ) -> Rc<Transformer> {
        Transformer::new(
            source,
            TransformerData::StringMatch {
                transformer,
                string_case,
            },
        )
    }

    /// `new UnionInstantiationTransformer(graph, sourceTypeRef)`.
    pub fn union_instantiation(source: TypeRef) -> Rc<Transformer> {
        Transformer::new(source, TransformerData::UnionInstantiation)
    }

    /// `new StringProducerTransformer(graph, sourceTypeRef, consumer,
    /// result)`.
    pub fn string_producer(
        source: TypeRef,
        consumer: Option<Rc<Transformer>>,
        result: String,
    ) -> Rc<Transformer> {
        Transformer::new(source, TransformerData::StringProducer { consumer, result })
    }

    /// `new ParseStringTransformer(graph, sourceTypeRef, consumer)`.
    pub fn parse_string(source: TypeRef, consumer: Option<Rc<Transformer>>) -> Rc<Transformer> {
        Transformer::new(source, TransformerData::ParseString { consumer })
    }

    /// `new StringifyTransformer(graph, sourceTypeRef, consumer)`.
    pub fn stringify(source: TypeRef, consumer: Option<Rc<Transformer>>) -> Rc<Transformer> {
        Transformer::new(source, TransformerData::Stringify { consumer })
    }

    /// `new MinMaxLengthCheckTransformer(graph, sourceTypeRef, consumer,
    /// minLength, maxLength)`.
    pub fn min_max_length_check(
        source: TypeRef,
        consumer: Option<Rc<Transformer>>,
        min_length: Option<f64>,
        max_length: Option<f64>,
    ) -> Rc<Transformer> {
        Transformer::new(
            source,
            TransformerData::MinMaxLengthCheck {
                consumer,
                min_length,
                max_length,
            },
        )
    }

    /// `new MinMaxValueTransformer(graph, sourceTypeRef, consumer, minimum,
    /// maximum)`.
    pub fn min_max_value(
        source: TypeRef,
        consumer: Option<Rc<Transformer>>,
        minimum: Option<f64>,
        maximum: Option<f64>,
    ) -> Rc<Transformer> {
        Transformer::new(
            source,
            TransformerData::MinMaxValue {
                consumer,
                minimum,
                maximum,
            },
        )
    }

    /// `kind`: the transformer's name, e.g. `"decode"`.
    pub fn kind(&self) -> &'static str {
        match &self.data {
            TransformerData::Decoding { .. } => "decode",
            TransformerData::Encoding => "encode",
            TransformerData::ArrayDecoding { .. } => "decode-array",
            TransformerData::ArrayEncoding { .. } => "encode-array",
            TransformerData::Choice { .. } => "choice",
            TransformerData::DecodingChoice(_) => "decoding-choice",
            TransformerData::UnionMemberMatch { .. } => "union-member-match",
            TransformerData::StringMatch { .. } => "string-match",
            TransformerData::UnionInstantiation => "union-instantiation",
            TransformerData::StringProducer { .. } => "string-producer",
            TransformerData::ParseString { .. } => "parse-string",
            TransformerData::Stringify { .. } => "stringify",
            TransformerData::MinMaxLengthCheck { .. } => "min-max-length-check",
            TransformerData::MinMaxValue { .. } => "min-max-value-check",
        }
    }

    /// The kind-specific fields.
    pub fn data(&self) -> &TransformerData {
        &self.data
    }

    /// `sourceTypeRef`.
    pub fn source_type_ref(&self) -> TypeRef {
        self.source_type_ref
    }

    /// `ProducerTransformer.consumer`: `None` for transformers that are no
    /// producers, or producers without a consumer.
    pub fn consumer(&self) -> Option<&Rc<Transformer>> {
        match &self.data {
            TransformerData::Decoding { consumer }
            | TransformerData::ArrayDecoding { consumer, .. }
            | TransformerData::StringProducer { consumer, .. }
            | TransformerData::ParseString { consumer }
            | TransformerData::Stringify { consumer }
            | TransformerData::MinMaxLengthCheck { consumer, .. }
            | TransformerData::MinMaxValue { consumer, .. } => consumer.as_ref(),
            _ => None,
        }
    }

    /// Whether this is a `ProducerTransformer`.
    pub fn is_producer(&self) -> bool {
        matches!(
            self.data,
            TransformerData::Decoding { .. }
                | TransformerData::ArrayDecoding { .. }
                | TransformerData::StringProducer { .. }
                | TransformerData::ParseString { .. }
                | TransformerData::Stringify { .. }
                | TransformerData::MinMaxLengthCheck { .. }
                | TransformerData::MinMaxValue { .. }
        )
    }

    /// `MatchTransformer.transformer`: the continuation of a union member
    /// match or string match.
    pub fn match_transformer(&self) -> Option<&Rc<Transformer>> {
        match &self.data {
            TransformerData::UnionMemberMatch { transformer, .. }
            | TransformerData::StringMatch { transformer, .. } => Some(transformer),
            _ => None,
        }
    }

    /// `transformers` of a choice or decoding choice (for a decoding choice,
    /// the present cases in declaration order); empty otherwise.
    pub fn transformers(&self) -> Vec<Rc<Transformer>> {
        match &self.data {
            TransformerData::Choice { transformers } => transformers.clone(),
            TransformerData::DecodingChoice(cases) => {
                cases.slots().into_iter().flatten().cloned().collect()
            }
            _ => Vec::new(),
        }
    }

    /// `sourceType.kind`, with the checks of the overridden `sourceType`
    /// getters: a union member match must start from a union, a string match
    /// from an enum or a string.
    pub fn source_type_kind(&self, lookup: &dyn TypeLookup) -> Result<TypeKind> {
        let kind = lookup.lookup_kind(self.source_type_ref)?;
        match &self.data {
            TransformerData::UnionMemberMatch { .. } if kind != TypeKind::Union => {
                panic("The source of a union member match transformer must be a union type")
            }
            TransformerData::StringMatch { .. }
                if kind != TypeKind::Enum && kind != TypeKind::String =>
            {
                panic("The source of a string match transformer must be an enum or string type")
            }
            _ => Ok(kind),
        }
    }

    /// `getChildren()`: the source type, then the children of the
    /// continuations, in order.
    pub fn get_children(&self) -> IndexSet<TypeRef> {
        let mut children: IndexSet<TypeRef> = [self.source_type_ref].into_iter().collect();
        match &self.data {
            TransformerData::Decoding { consumer }
            | TransformerData::StringProducer { consumer, .. }
            | TransformerData::ParseString { consumer }
            | TransformerData::Stringify { consumer }
            | TransformerData::MinMaxLengthCheck { consumer, .. }
            | TransformerData::MinMaxValue { consumer, .. } => {
                if let Some(c) = consumer {
                    children.extend(c.get_children());
                }
            }
            TransformerData::ArrayDecoding {
                consumer,
                item_target_type_ref,
                item_transformer,
            } => {
                if let Some(c) = consumer {
                    children.extend(c.get_children());
                }
                children.insert(*item_target_type_ref);
                children.extend(item_transformer.get_children());
            }
            TransformerData::ArrayEncoding {
                item_target_type_ref,
                item_transformer,
            } => {
                children.insert(*item_target_type_ref);
                children.extend(item_transformer.get_children());
            }
            TransformerData::Choice { transformers } => {
                for xfer in transformers {
                    children.extend(xfer.get_children());
                }
            }
            TransformerData::DecodingChoice(cases) => {
                for xfer in cases.slots().into_iter().flatten() {
                    children.extend(xfer.get_children());
                }
            }
            TransformerData::UnionMemberMatch {
                transformer,
                member_type_ref,
            } => {
                children.extend(transformer.get_children());
                children.insert(*member_type_ref);
            }
            TransformerData::StringMatch { transformer, .. } => {
                children.extend(transformer.get_children());
            }
            TransformerData::Encoding | TransformerData::UnionInstantiation => {}
        }
        children
    }

    /// `getNumberOfNodes()`.
    pub fn get_number_of_nodes(&self) -> usize {
        match &self.data {
            TransformerData::Decoding { consumer }
            | TransformerData::StringProducer { consumer, .. }
            | TransformerData::ParseString { consumer }
            | TransformerData::Stringify { consumer }
            | TransformerData::MinMaxLengthCheck { consumer, .. }
            | TransformerData::MinMaxValue { consumer, .. } => {
                1 + number_of_nodes(consumer.as_ref())
            }
            TransformerData::ArrayDecoding {
                consumer,
                item_transformer,
                ..
            } => 1 + number_of_nodes(consumer.as_ref()) + item_transformer.get_number_of_nodes(),
            TransformerData::ArrayEncoding {
                item_transformer, ..
            } => 1 + item_transformer.get_number_of_nodes(),
            TransformerData::Choice { transformers } => {
                1 + transformers
                    .iter()
                    .map(|x| x.get_number_of_nodes())
                    .sum::<usize>()
            }
            TransformerData::DecodingChoice(cases) => {
                1 + cases
                    .slots()
                    .into_iter()
                    .map(|x| number_of_nodes(x.as_ref()))
                    .sum::<usize>()
            }
            TransformerData::UnionMemberMatch { transformer, .. }
            | TransformerData::StringMatch { transformer, .. } => {
                1 + transformer.get_number_of_nodes()
            }
            TransformerData::Encoding | TransformerData::UnionInstantiation => 1,
        }
    }

    /// `canFail`.
    pub fn can_fail(&self) -> bool {
        match &self.data {
            TransformerData::Choice { transformers } => transformers.iter().any(|x| x.can_fail()),
            TransformerData::UnionMemberMatch { .. }
            | TransformerData::StringMatch { .. }
            | TransformerData::ParseString { .. }
            | TransformerData::MinMaxLengthCheck { .. }
            | TransformerData::MinMaxValue { .. } => true,
            TransformerData::Decoding { .. }
            | TransformerData::Encoding
            | TransformerData::ArrayDecoding { .. }
            | TransformerData::ArrayEncoding { .. }
            | TransformerData::DecodingChoice(_)
            | TransformerData::UnionInstantiation
            | TransformerData::StringProducer { .. }
            | TransformerData::Stringify { .. } => false,
        }
    }

    /// `reverse(targetTypeRef, continuationTransformer)`: the transformer
    /// that undoes this one, producing `target_type_ref`, followed by
    /// `continuation`.
    pub fn reverse(
        &self,
        lookup: &dyn TypeLookup,
        target_type_ref: TypeRef,
        continuation: Option<Rc<Transformer>>,
    ) -> Result<Rc<Transformer>> {
        match &self.data {
            TransformerData::Decoding { consumer } => {
                if continuation.is_some() {
                    return panic("Reversing a decoding transformer cannot have a continuation");
                }
                match consumer {
                    None => Ok(Transformer::encoding(target_type_ref)),
                    Some(c) => c.reverse(
                        lookup,
                        target_type_ref,
                        Some(Transformer::encoding(c.source_type_ref)),
                    ),
                }
            }
            TransformerData::Encoding => panic("Can't reverse encoding transformer"),
            TransformerData::ArrayDecoding {
                consumer,
                item_target_type_ref,
                item_transformer,
            } => {
                if continuation.is_some() {
                    return panic("Reversing a decoding transformer cannot have a continuation");
                }
                let reversed_item =
                    item_transformer.reverse(lookup, *item_target_type_ref, None)?;
                match consumer {
                    None => Ok(Transformer::array_encoding(
                        target_type_ref,
                        item_transformer.source_type_ref,
                        reversed_item,
                    )),
                    Some(c) => c.reverse(
                        lookup,
                        target_type_ref,
                        Some(Transformer::array_encoding(
                            c.source_type_ref,
                            item_transformer.source_type_ref,
                            reversed_item,
                        )),
                    ),
                }
            }
            TransformerData::ArrayEncoding { .. } => {
                panic("Can't reverse array encoding transformer")
            }
            TransformerData::Choice { transformers } => {
                let reversed: Vec<Rc<Transformer>> = transformers
                    .iter()
                    .map(|x| x.reverse(lookup, target_type_ref, continuation.clone()))
                    .collect::<Result<_>>()?;
                let member_matches: Option<Vec<(&Rc<Transformer>, TypeRef)>> = reversed
                    .iter()
                    .map(|x| match &x.data {
                        TransformerData::UnionMemberMatch {
                            transformer,
                            member_type_ref,
                        } => Some((transformer, *member_type_ref)),
                        _ => None,
                    })
                    .collect();
                if let Some(member_matches) = member_matches
                    && let Some(&(_, first_member)) = member_matches.first()
                    && member_matches.iter().all(|(_, m)| *m == first_member)
                {
                    let sub_transformers: Vec<Rc<Transformer>> =
                        member_matches.iter().map(|(x, _)| Rc::clone(x)).collect();
                    let source = sub_transformers[0].source_type_ref;
                    return Ok(Transformer::union_member_match(
                        target_type_ref,
                        Transformer::choice(source, sub_transformers)?,
                        first_member,
                    ));
                }
                Transformer::choice(target_type_ref, reversed)
            }
            TransformerData::DecodingChoice(cases) => {
                self.reverse_decoding_choice(lookup, cases, target_type_ref, continuation)
            }
            TransformerData::UnionMemberMatch { .. } => {
                panic("Can't reverse union member match transformer")
            }
            TransformerData::StringMatch {
                transformer,
                string_case,
            } => transformer.reverse(
                lookup,
                target_type_ref,
                Some(Transformer::string_producer(
                    transformer.source_type_ref,
                    continuation,
                    string_case.clone(),
                )),
            ),
            TransformerData::UnionInstantiation => match continuation {
                None => panic("Union instantiation transformer reverse must have a continuation"),
                Some(c) => Ok(Transformer::union_member_match(
                    target_type_ref,
                    c,
                    self.source_type_ref,
                )),
            },
            TransformerData::StringProducer { consumer, result } => {
                let Some(continuation) = continuation else {
                    return panic(
                        "Reversing a string producer transformer must have a continuation",
                    );
                };
                match consumer {
                    None => Ok(Transformer::string_match(
                        target_type_ref,
                        continuation,
                        result.clone(),
                    )),
                    Some(c) => c.reverse(
                        lookup,
                        target_type_ref,
                        Some(Transformer::string_match(
                            c.source_type_ref,
                            continuation,
                            result.clone(),
                        )),
                    ),
                }
            }
            TransformerData::ParseString { consumer } => match consumer {
                None => Ok(Transformer::stringify(target_type_ref, continuation)),
                Some(c) => c.reverse(
                    lookup,
                    target_type_ref,
                    Some(Transformer::stringify(c.source_type_ref, continuation)),
                ),
            },
            TransformerData::Stringify { consumer } => match consumer {
                None => Ok(Transformer::parse_string(target_type_ref, continuation)),
                Some(c) => c.reverse(
                    lookup,
                    target_type_ref,
                    Some(Transformer::parse_string(c.source_type_ref, continuation)),
                ),
            },
            TransformerData::MinMaxLengthCheck {
                consumer,
                min_length,
                max_length,
            } => match consumer {
                None => Ok(Transformer::min_max_length_check(
                    target_type_ref,
                    continuation,
                    *min_length,
                    *max_length,
                )),
                Some(c) => c.reverse(
                    lookup,
                    target_type_ref,
                    Some(Transformer::min_max_length_check(
                        c.source_type_ref,
                        continuation,
                        *min_length,
                        *max_length,
                    )),
                ),
            },
            TransformerData::MinMaxValue {
                consumer,
                minimum,
                maximum,
            } => match consumer {
                None => Ok(Transformer::min_max_value(
                    target_type_ref,
                    continuation,
                    *minimum,
                    *maximum,
                )),
                Some(c) => c.reverse(
                    lookup,
                    target_type_ref,
                    Some(Transformer::min_max_value(
                        c.source_type_ref,
                        continuation,
                        *minimum,
                        *maximum,
                    )),
                ),
            },
        }
    }

    /// `DecodingChoiceTransformer.reverse`: reverses every case, groups the
    /// results by source kind (union member matches by member type), and
    /// keeps per group either all cases (if all can fail) or the first one
    /// with the fewest nodes among those that can't.
    fn reverse_decoding_choice(
        &self,
        lookup: &dyn TypeLookup,
        cases: &DecodingChoiceCases,
        target_type_ref: TypeRef,
        continuation: Option<Rc<Transformer>>,
    ) -> Result<Rc<Transformer>> {
        assert(
            continuation.is_none(),
            "Reversing a decoding transformer can't have a target transformer",
        )?;

        let mut by_kind: indexmap::IndexMap<TypeKind, Vec<Rc<Transformer>>> =
            indexmap::IndexMap::new();
        let mut by_member: indexmap::IndexMap<TypeRef, Vec<Rc<Transformer>>> =
            indexmap::IndexMap::new();

        for xfer in cases.slots().into_iter().flatten() {
            let reversed = xfer.reverse(lookup, target_type_ref, None)?;
            // Flatten nested choices.
            let reversed_cases = match &reversed.data {
                TransformerData::Choice { transformers } => transformers.clone(),
                _ => vec![reversed],
            };
            for case in reversed_cases {
                if let TransformerData::UnionMemberMatch {
                    member_type_ref, ..
                } = &case.data
                {
                    by_member.entry(*member_type_ref).or_default().push(case);
                } else {
                    let kind = case.source_type_kind(lookup)?;
                    by_kind.entry(kind).or_default().push(case);
                }
            }
        }

        let filter = |xfers: &Vec<Rc<Transformer>>| -> Result<Vec<Rc<Transformer>>> {
            assert(!xfers.is_empty(), "Must have at least one transformer")?;
            let nonfailing: Vec<&Rc<Transformer>> = xfers
                .iter()
                .filter(|x| match &x.data {
                    TransformerData::UnionMemberMatch { transformer, .. } => {
                        !transformer.can_fail()
                    }
                    _ => !x.can_fail(),
                })
                .collect();
            // A stable sort by node count, then the first: the first of the
            // smallest.
            let mut smallest: Option<(usize, &Rc<Transformer>)> = None;
            for x in nonfailing {
                let n = x.get_number_of_nodes();
                if smallest.is_none_or(|(m, _)| n < m) {
                    smallest = Some((n, x));
                }
            }
            Ok(match smallest {
                None => xfers.clone(),
                Some((_, x)) => vec![Rc::clone(x)],
            })
        };

        let mut resulting: Vec<Rc<Transformer>> = Vec::new();
        for xfers in by_kind.values().chain(by_member.values()) {
            resulting.extend(filter(xfers)?);
        }

        if resulting.len() == 1 {
            return Ok(resulting.swap_remove(0));
        }
        Transformer::choice(target_type_ref, resulting)
    }

    /// `reconstitute(builder)`: the same transformer in the graph `builder`
    /// builds. Arguments are reconstituted in the TypeScript constructor
    /// argument order, which decides the new type indexes.
    pub fn reconstitute(&self, builder: &mut TypeBuilder<'_>) -> Result<Rc<Transformer>> {
        fn re(builder: &mut TypeBuilder<'_>, t: TypeRef) -> Result<TypeRef> {
            builder.reconstitute_type_ref(t, TypeAttributes::new(), None)
        }
        fn re_opt(
            builder: &mut TypeBuilder<'_>,
            x: &Option<Rc<Transformer>>,
        ) -> Result<Option<Rc<Transformer>>> {
            x.as_ref().map(|x| x.reconstitute(builder)).transpose()
        }

        let source = re(builder, self.source_type_ref)?;
        let data = match &self.data {
            TransformerData::Decoding { consumer } => TransformerData::Decoding {
                consumer: re_opt(builder, consumer)?,
            },
            TransformerData::Encoding => TransformerData::Encoding,
            TransformerData::ArrayDecoding {
                consumer,
                item_target_type_ref,
                item_transformer,
            } => {
                let consumer = re_opt(builder, consumer)?;
                let item_target_type_ref = re(builder, *item_target_type_ref)?;
                let item_transformer = item_transformer.reconstitute(builder)?;
                TransformerData::ArrayDecoding {
                    consumer,
                    item_target_type_ref,
                    item_transformer,
                }
            }
            TransformerData::ArrayEncoding {
                item_target_type_ref,
                item_transformer,
            } => {
                let item_target_type_ref = re(builder, *item_target_type_ref)?;
                let item_transformer = item_transformer.reconstitute(builder)?;
                TransformerData::ArrayEncoding {
                    item_target_type_ref,
                    item_transformer,
                }
            }
            TransformerData::Choice { transformers } => {
                let transformers = transformers
                    .iter()
                    .map(|x| x.reconstitute(builder))
                    .collect::<Result<Vec<_>>>()?;
                return Transformer::choice(source, transformers);
            }
            TransformerData::DecodingChoice(cases) => {
                TransformerData::DecodingChoice(DecodingChoiceCases {
                    null: re_opt(builder, &cases.null)?,
                    integer: re_opt(builder, &cases.integer)?,
                    double: re_opt(builder, &cases.double)?,
                    bool: re_opt(builder, &cases.bool)?,
                    string: re_opt(builder, &cases.string)?,
                    array: re_opt(builder, &cases.array)?,
                    object: re_opt(builder, &cases.object)?,
                })
            }
            TransformerData::UnionMemberMatch {
                transformer,
                member_type_ref,
            } => {
                let transformer = transformer.reconstitute(builder)?;
                let member_type_ref = re(builder, *member_type_ref)?;
                TransformerData::UnionMemberMatch {
                    transformer,
                    member_type_ref,
                }
            }
            TransformerData::StringMatch {
                transformer,
                string_case,
            } => TransformerData::StringMatch {
                transformer: transformer.reconstitute(builder)?,
                string_case: string_case.clone(),
            },
            TransformerData::UnionInstantiation => TransformerData::UnionInstantiation,
            TransformerData::StringProducer { consumer, result } => {
                TransformerData::StringProducer {
                    consumer: re_opt(builder, consumer)?,
                    result: result.clone(),
                }
            }
            TransformerData::ParseString { consumer } => TransformerData::ParseString {
                consumer: re_opt(builder, consumer)?,
            },
            TransformerData::Stringify { consumer } => TransformerData::Stringify {
                consumer: re_opt(builder, consumer)?,
            },
            TransformerData::MinMaxLengthCheck {
                consumer,
                min_length,
                max_length,
            } => TransformerData::MinMaxLengthCheck {
                consumer: re_opt(builder, consumer)?,
                min_length: *min_length,
                max_length: *max_length,
            },
            TransformerData::MinMaxValue {
                consumer,
                minimum,
                maximum,
            } => TransformerData::MinMaxValue {
                consumer: re_opt(builder, consumer)?,
                minimum: *minimum,
                maximum: *maximum,
            },
        };
        Ok(Transformer::new(source, data))
    }

    /// `hashCode()`, including the quirk that a string producer adds its
    /// consumer's hash twice.
    pub fn hash_code(&self) -> i64 {
        let h = self.source_type_ref.hash_code();
        match &self.data {
            TransformerData::Decoding { consumer }
            | TransformerData::ParseString { consumer }
            | TransformerData::Stringify { consumer }
            | TransformerData::MinMaxLengthCheck { consumer, .. }
            | TransformerData::MinMaxValue { consumer, .. } => {
                add_hash_code(h, optional_hash(consumer.as_ref()))
            }
            TransformerData::StringProducer { consumer, .. } => {
                let h = add_hash_code(h, optional_hash(consumer.as_ref()));
                add_hash_code(h, optional_hash(consumer.as_ref()))
            }
            TransformerData::ArrayDecoding {
                consumer,
                item_target_type_ref,
                item_transformer,
            } => {
                let h = add_hash_code(h, optional_hash(consumer.as_ref()));
                let h = add_hash_code(h, item_target_type_ref.hash_code());
                add_hash_code(h, item_transformer.hash_code())
            }
            TransformerData::ArrayEncoding {
                item_target_type_ref,
                item_transformer,
            } => {
                let h = add_hash_code(h, item_target_type_ref.hash_code());
                add_hash_code(h, item_transformer.hash_code())
            }
            TransformerData::Choice { transformers } => {
                // `hashCodeOf(array)`: `addHashCode` folded from 17.
                let array_hash = transformers.iter().fold(
                    crate::support::collection_utils::HASH_CODE_INIT,
                    |acc, x| add_hash_code(acc, x.hash_code()),
                );
                add_hash_code(h, array_hash)
            }
            TransformerData::DecodingChoice(cases) => cases
                .slots()
                .into_iter()
                .fold(h, |acc, x| add_hash_code(acc, optional_hash(x.as_ref()))),
            TransformerData::UnionMemberMatch {
                transformer,
                member_type_ref,
            } => {
                let h = add_hash_code(h, transformer.hash_code());
                add_hash_code(h, member_type_ref.hash_code())
            }
            TransformerData::StringMatch {
                transformer,
                string_case,
            } => {
                let h = add_hash_code(h, transformer.hash_code());
                add_hash_code(h, i64::from(hash_string(string_case)))
            }
            TransformerData::Encoding | TransformerData::UnionInstantiation => h,
        }
    }

    /// `equals(other)`: the same class with equal fields, except that two
    /// string matches are equal only if their cases differ (a bug in
    /// quicktype, reproduced because it changes deduplication).
    pub fn equals(&self, other: &Transformer) -> bool {
        if self.source_type_ref != other.source_type_ref {
            return false;
        }
        use TransformerData as D;
        match (&self.data, &other.data) {
            (D::Decoding { consumer: a }, D::Decoding { consumer: b })
            | (D::ParseString { consumer: a }, D::ParseString { consumer: b })
            | (D::Stringify { consumer: a }, D::Stringify { consumer: b }) => {
                optional_are_equal(a.as_ref(), b.as_ref())
            }
            (D::Encoding, D::Encoding) | (D::UnionInstantiation, D::UnionInstantiation) => true,
            (
                D::ArrayDecoding {
                    consumer: ca,
                    item_target_type_ref: ia,
                    item_transformer: xa,
                },
                D::ArrayDecoding {
                    consumer: cb,
                    item_target_type_ref: ib,
                    item_transformer: xb,
                },
            ) => optional_are_equal(ca.as_ref(), cb.as_ref()) && ia == ib && xa.equals(xb),
            (
                D::ArrayEncoding {
                    item_target_type_ref: ia,
                    item_transformer: xa,
                },
                D::ArrayEncoding {
                    item_target_type_ref: ib,
                    item_transformer: xb,
                },
            ) => ia == ib && xa.equals(xb),
            (D::Choice { transformers: a }, D::Choice { transformers: b }) => {
                a.len() == b.len() && a.iter().zip(b).all(|(x, y)| are_equal(x, y))
            }
            (D::DecodingChoice(a), D::DecodingChoice(b)) => a
                .slots()
                .into_iter()
                .zip(b.slots())
                .all(|(x, y)| optional_are_equal(x.as_ref(), y.as_ref())),
            (
                D::UnionMemberMatch {
                    transformer: xa,
                    member_type_ref: ma,
                },
                D::UnionMemberMatch {
                    transformer: xb,
                    member_type_ref: mb,
                },
            ) => xa.equals(xb) && ma == mb,
            (
                D::StringMatch {
                    transformer: xa,
                    string_case: sa,
                },
                D::StringMatch {
                    transformer: xb,
                    string_case: sb,
                },
            ) => xa.equals(xb) && sa != sb,
            (
                D::StringProducer {
                    consumer: ca,
                    result: ra,
                },
                D::StringProducer {
                    consumer: cb,
                    result: rb,
                },
            ) => optional_are_equal(ca.as_ref(), cb.as_ref()) && ra == rb,
            (
                D::MinMaxLengthCheck {
                    consumer: ca,
                    min_length: mina,
                    max_length: maxa,
                },
                D::MinMaxLengthCheck {
                    consumer: cb,
                    min_length: minb,
                    max_length: maxb,
                },
            )
            | (
                D::MinMaxValue {
                    consumer: ca,
                    minimum: mina,
                    maximum: maxa,
                },
                D::MinMaxValue {
                    consumer: cb,
                    minimum: minb,
                    maximum: maxb,
                },
            ) => optional_are_equal(ca.as_ref(), cb.as_ref()) && mina == minb && maxa == maxb,
            _ => false,
        }
    }

    /// `debugDescription()`.
    fn debug_description(&self, lookup: &dyn TypeLookup) -> Result<String> {
        // `sourceType` is checked by the overridden getters.
        self.source_type_kind(lookup)?;
        let base = format!(
            "{} -> {}",
            debug_string_for_type(lookup, self.source_type_ref)?,
            self.kind()
        );
        Ok(match &self.data {
            TransformerData::UnionMemberMatch {
                member_type_ref, ..
            } => format!(
                "{base} - member: {}",
                debug_string_for_type(lookup, *member_type_ref)?
            ),
            TransformerData::StringMatch { string_case, .. } => {
                format!("{base} - case: {string_case}")
            }
            TransformerData::StringProducer { result, .. } => format!("{base} - result: {result}"),
            _ => base,
        })
    }

    /// `debugPrint(indent)`: prints the transformer tree with
    /// [`console_log`].
    pub fn debug_print(&self, lookup: &dyn TypeLookup, indent: usize) -> Result<()> {
        console_log(&format!(
            "{}{}",
            indentation_string(indent),
            self.debug_description(lookup)?
        ));
        let indent = indent + 1;
        match &self.data {
            TransformerData::Decoding { consumer }
            | TransformerData::StringProducer { consumer, .. }
            | TransformerData::ParseString { consumer }
            | TransformerData::Stringify { consumer }
            | TransformerData::MinMaxLengthCheck { consumer, .. }
            | TransformerData::MinMaxValue { consumer, .. } => {
                if let Some(c) = consumer {
                    c.debug_print(lookup, indent)?;
                }
            }
            TransformerData::ArrayDecoding {
                consumer,
                item_transformer,
                ..
            } => {
                item_transformer.debug_print(lookup, indent)?;
                if let Some(c) = consumer {
                    c.debug_print(lookup, indent)?;
                }
            }
            TransformerData::ArrayEncoding {
                item_transformer, ..
            } => item_transformer.debug_print(lookup, indent)?,
            TransformerData::Choice { transformers } => {
                for x in transformers {
                    x.debug_print(lookup, indent)?;
                }
            }
            TransformerData::DecodingChoice(cases) => {
                for x in cases.slots().into_iter().flatten() {
                    x.debug_print(lookup, indent)?;
                }
            }
            TransformerData::UnionMemberMatch { transformer, .. }
            | TransformerData::StringMatch { transformer, .. } => {
                transformer.debug_print(lookup, indent)?
            }
            TransformerData::Encoding | TransformerData::UnionInstantiation => {}
        }
        Ok(())
    }
}

/// `Transformation`: a transformer and the type it produces. This is the
/// value of the `transformation` type attribute.
#[derive(Clone, Debug)]
pub struct Transformation {
    target_type_ref: TypeRef,
    transformer: Rc<Transformer>,
}

impl Transformation {
    /// `new Transformation(graph, targetTypeRef, transformer)`.
    pub fn new(target_type_ref: TypeRef, transformer: Rc<Transformer>) -> Transformation {
        Transformation {
            target_type_ref,
            transformer,
        }
    }

    /// `transformer`.
    pub fn transformer(&self) -> &Rc<Transformer> {
        &self.transformer
    }

    /// `sourceType` (as a ref).
    pub fn source_type_ref(&self) -> TypeRef {
        self.transformer.source_type_ref
    }

    /// `targetType` (as a ref).
    pub fn target_type_ref(&self) -> TypeRef {
        self.target_type_ref
    }

    /// `reverse`: the transformation from the target type back to the
    /// source type.
    pub fn reverse(&self, lookup: &dyn TypeLookup) -> Result<Transformation> {
        Ok(Transformation::new(
            self.transformer.source_type_ref,
            self.transformer
                .reverse(lookup, self.target_type_ref, None)?,
        ))
    }

    /// `getChildren()`: the transformer's children, then the target type.
    pub fn get_children(&self) -> IndexSet<TypeRef> {
        let mut children = self.transformer.get_children();
        children.insert(self.target_type_ref);
        children
    }

    /// `reconstitute(builder)`: the target type first, then the transformer.
    pub fn reconstitute_transformation(
        &self,
        builder: &mut TypeBuilder<'_>,
    ) -> Result<Transformation> {
        let target =
            builder.reconstitute_type_ref(self.target_type_ref, TypeAttributes::new(), None)?;
        let transformer = self.transformer.reconstitute(builder)?;
        Ok(Transformation::new(target, transformer))
    }

    /// `equals(other)`.
    pub fn equals(&self, other: &Transformation) -> bool {
        self.target_type_ref == other.target_type_ref && self.transformer.equals(&other.transformer)
    }

    /// `hashCode()`.
    pub fn hash_code(&self) -> i64 {
        add_hash_code(
            self.target_type_ref.hash_code(),
            self.transformer.hash_code(),
        )
    }

    /// `debugPrint()`: the transformer tree, then `-> <target>`.
    pub fn debug_print(&self, lookup: &dyn TypeLookup) -> Result<()> {
        self.transformer.debug_print(lookup, 0)?;
        console_log(&format!(
            "-> {}",
            debug_string_for_type(lookup, self.target_type_ref)?
        ));
        Ok(())
    }
}

impl TransformationAttribute for Transformation {
    fn hash_code(&self) -> i64 {
        Transformation::hash_code(self)
    }

    fn js_equals(&self, other: &dyn TransformationAttribute) -> bool {
        match other.as_any().downcast_ref::<Transformation>() {
            Some(other) => self.equals(other),
            None => false,
        }
    }

    fn children(&self) -> IndexSet<TypeRef> {
        self.get_children()
    }

    fn reconstitute(
        &self,
        builder: &mut TypeBuilder<'_>,
    ) -> Result<Rc<dyn TransformationAttribute>> {
        Ok(Rc::new(self.reconstitute_transformation(builder)?))
    }

    fn as_any(&self) -> &dyn Any {
        self
    }

    fn target_type(&self) -> TypeRef {
        self.target_type_ref
    }
}

/// `transformationTypeAttributeKind.makeAttributes(transformation)`.
pub fn make_transformation_attributes(transformation: Transformation) -> TypeAttributes {
    TransformationTypeAttributeKind.make_attributes(Rc::new(transformation))
}

/// The concrete [`Transformation`] behind a `transformation` attribute
/// value (which the attribute module only knows as a trait object).
pub fn downcast_transformation(xf: &dyn TransformationAttribute) -> Option<&Transformation> {
    xf.as_any().downcast_ref::<Transformation>()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn r(i: usize) -> TypeRef {
        TypeRef::new(0, i).unwrap()
    }

    #[test]
    fn string_match_equality_is_inverted() {
        let producer = Transformer::string_producer(r(1), None, "a".into());
        let a = Transformer::string_match(r(1), Rc::clone(&producer), "a".into());
        let b = Transformer::string_match(r(1), Rc::clone(&producer), "a".into());
        let c = Transformer::string_match(r(1), Rc::clone(&producer), "c".into());
        assert!(!a.equals(&b));
        assert!(a.equals(&c));
        assert_eq!(a.hash_code(), b.hash_code());
        assert_ne!(a.hash_code(), c.hash_code());
        // `areEqual` short-circuits on identity.
        assert!(are_equal(&a, &a));
    }

    #[test]
    fn string_producer_hashes_its_consumer_twice() {
        let consumer = Transformer::union_instantiation(r(3));
        let p = Transformer::string_producer(r(1), Some(Rc::clone(&consumer)), "x".into());
        let once = add_hash_code(r(1).hash_code(), consumer.hash_code());
        assert_eq!(p.hash_code(), add_hash_code(once, consumer.hash_code()));
        let d = Transformer::decoding(r(1), None);
        assert_eq!(d.hash_code(), add_hash_code(r(1).hash_code(), 17));
    }

    #[test]
    fn children_nodes_and_failure() {
        let item = Transformer::decoding(r(2), None);
        let arr = Transformer::array_decoding(r(1), None, r(5), item);
        assert_eq!(
            arr.get_children().into_iter().collect::<Vec<_>>(),
            vec![r(1), r(5), r(2)]
        );
        assert_eq!(arr.get_number_of_nodes(), 2);
        assert!(!arr.can_fail());
        let choice = Transformer::choice(
            r(1),
            vec![
                Transformer::parse_string(r(1), None),
                Transformer::decoding(r(1), None),
            ],
        )
        .unwrap();
        assert!(choice.can_fail());
        assert_eq!(choice.get_number_of_nodes(), 3);
        assert!(Transformer::choice(r(1), Vec::new()).is_err());
        let xf = Transformation::new(r(9), choice);
        assert_eq!(
            xf.get_children().into_iter().collect::<Vec<_>>(),
            vec![r(1), r(9)]
        );
    }
}
