import * as z from "zod";


export const EnumValueSchema = z.enum([
    "ready",
    "done",
]);
export type EnumValue = z.infer<typeof EnumValueSchema>;

export const AbstractSchema = z.object({
    "abstract": z.number().int(),
});
export type Abstract = z.infer<typeof AbstractSchema>;

export const AlignasSchema = z.object({
    "alignas": z.number().int(),
});
export type Alignas = z.infer<typeof AlignasSchema>;

export const AlignofSchema = z.object({
    "alignof": z.number().int(),
});
export type Alignof = z.infer<typeof AlignofSchema>;

export const AndSchema = z.object({
    "and": z.number().int(),
});
export type And = z.infer<typeof AndSchema>;

export const AndEqSchema = z.object({
    "and_eq": z.number().int(),
});
export type AndEq = z.infer<typeof AndEqSchema>;

export const AnySchema = z.object({
    "Any": z.number().int(),
});
export type Any = z.infer<typeof AnySchema>;

export const ArrayClassSchema = z.object({
    "array": z.number().int(),
});
export type ArrayClass = z.infer<typeof ArrayClassSchema>;

export const ArrayNodeSchema = z.object({
    "ArrayNode": z.number().int(),
});
export type ArrayNode = z.infer<typeof ArrayNodeSchema>;

export const AsSchema = z.object({
    "as": z.number().int(),
});
export type As = z.infer<typeof AsSchema>;

export const AsmSchema = z.object({
    "asm": z.number().int(),
});
export type Asm = z.infer<typeof AsmSchema>;

export const AssertSchema = z.object({
    "assert": z.number().int(),
});
export type Assert = z.infer<typeof AssertSchema>;

export const AssociatedtypeSchema = z.object({
    "associatedtype": z.number().int(),
});
export type Associatedtype = z.infer<typeof AssociatedtypeSchema>;

export const AssociativitySchema = z.object({
    "associativity": z.number().int(),
});
export type Associativity = z.infer<typeof AssociativitySchema>;

export const AsyncSchema = z.object({
    "async": z.number().int(),
});
export type Async = z.infer<typeof AsyncSchema>;

export const AtomicSchema = z.object({
    "atomic": z.number().int(),
});
export type Atomic = z.infer<typeof AtomicSchema>;

export const AtomicCancelSchema = z.object({
    "atomic_cancel": z.number().int(),
});
export type AtomicCancel = z.infer<typeof AtomicCancelSchema>;

export const AtomicCommitSchema = z.object({
    "atomic_commit": z.number().int(),
});
export type AtomicCommit = z.infer<typeof AtomicCommitSchema>;

export const AtomicNoexceptSchema = z.object({
    "atomic_noexcept": z.number().int(),
});
export type AtomicNoexcept = z.infer<typeof AtomicNoexceptSchema>;

export const AutoSchema = z.object({
    "auto": z.number().int(),
});
export type Auto = z.infer<typeof AutoSchema>;

export const AwaitSchema = z.object({
    "await": z.number().int(),
});
export type Await = z.infer<typeof AwaitSchema>;

export const BaseSchema = z.object({
    "base": z.number().int(),
});
export type Base = z.infer<typeof BaseSchema>;

export const BitandSchema = z.object({
    "bitand": z.number().int(),
});
export type Bitand = z.infer<typeof BitandSchema>;

export const BitorSchema = z.object({
    "bitor": z.number().int(),
});
export type Bitor = z.infer<typeof BitorSchema>;

export const BoolSchema = z.object({
    "BOOL": z.number().int(),
});
export type Bool = z.infer<typeof BoolSchema>;

export const BooleanSchema = z.object({
    "boolean": z.number().int(),
});
export type Boolean = z.infer<typeof BooleanSchema>;

export const BooleanNodeSchema = z.object({
    "BooleanNode": z.number().int(),
});
export type BooleanNode = z.infer<typeof BooleanNodeSchema>;

export const BreakSchema = z.object({
    "break": z.number().int(),
});
export type Break = z.infer<typeof BreakSchema>;

export const BycopySchema = z.object({
    "bycopy": z.number().int(),
});
export type Bycopy = z.infer<typeof BycopySchema>;

export const ByrefSchema = z.object({
    "byref": z.number().int(),
});
export type Byref = z.infer<typeof ByrefSchema>;

export const ByteSchema = z.object({
    "byte": z.number().int(),
});
export type Byte = z.infer<typeof ByteSchema>;

export const CalendarSchema = z.object({
    "Calendar": z.number().int(),
});
export type Calendar = z.infer<typeof CalendarSchema>;

export const CaseSchema = z.object({
    "case": z.number().int(),
});
export type Case = z.infer<typeof CaseSchema>;

export const CatchSchema = z.object({
    "catch": z.number().int(),
});
export type Catch = z.infer<typeof CatchSchema>;

export const ChanSchema = z.object({
    "chan": z.number().int(),
});
export type Chan = z.infer<typeof ChanSchema>;

export const CharSchema = z.object({
    "char": z.number().int(),
});
export type Char = z.infer<typeof CharSchema>;

export const Char16TSchema = z.object({
    "char16_t": z.number().int(),
});
export type Char16T = z.infer<typeof Char16TSchema>;

export const Char32TSchema = z.object({
    "char32_t": z.number().int(),
});
export type Char32T = z.infer<typeof Char32TSchema>;

export const CheckedSchema = z.object({
    "checked": z.number().int(),
});
export type Checked = z.infer<typeof CheckedSchema>;

export const ClassClassSchema = z.object({
    "Class": z.number().int(),
});
export type ClassClass = z.infer<typeof ClassClassSchema>;

export const CloneSchema = z.object({
    "clone": z.number().int(),
});
export type Clone = z.infer<typeof CloneSchema>;

export const CoAwaitSchema = z.object({
    "co_await": z.number().int(),
});
export type CoAwait = z.infer<typeof CoAwaitSchema>;

export const CoReturnSchema = z.object({
    "co_return": z.number().int(),
});
export type CoReturn = z.infer<typeof CoReturnSchema>;

export const CoYieldSchema = z.object({
    "co_yield": z.number().int(),
});
export type CoYield = z.infer<typeof CoYieldSchema>;

export const CodableSchema = z.object({
    "Codable": z.number().int(),
});
export type Codable = z.infer<typeof CodableSchema>;

export const CodingKeySchema = z.object({
    "CodingKey": z.number().int(),
});
export type CodingKey = z.infer<typeof CodingKeySchema>;

export const CodingKeysSchema = z.object({
    "CodingKeys": z.number().int(),
});
export type CodingKeys = z.infer<typeof CodingKeysSchema>;

export const ComplSchema = z.object({
    "compl": z.number().int(),
});
export type Compl = z.infer<typeof ComplSchema>;

export const ComplexSchema = z.object({
    "_Complex": z.number().int(),
});
export type Complex = z.infer<typeof ComplexSchema>;

export const ConceptSchema = z.object({
    "concept": z.number().int(),
});
export type Concept = z.infer<typeof ConceptSchema>;

export const ConsoleSchema = z.object({
    "console": z.number().int(),
});
export type Console = z.infer<typeof ConsoleSchema>;

export const ConstSchema = z.object({
    "const": z.number().int(),
});
export type Const = z.infer<typeof ConstSchema>;

export const ConstCastSchema = z.object({
    "const_cast": z.number().int(),
});
export type ConstCast = z.infer<typeof ConstCastSchema>;

export const ConstexprSchema = z.object({
    "constexpr": z.number().int(),
});
export type Constexpr = z.infer<typeof ConstexprSchema>;

export const ConstructorSchema = z.object({
    "constructor": z.number().int(),
});
export type Constructor = z.infer<typeof ConstructorSchema>;

export const ContinueSchema = z.object({
    "continue": z.number().int(),
});
export type Continue = z.infer<typeof ContinueSchema>;

export const ConvenienceSchema = z.object({
    "convenience": z.number().int(),
});
export type Convenience = z.infer<typeof ConvenienceSchema>;

export const ConvertSchema = z.object({
    "convert": z.number().int(),
});
export type Convert = z.infer<typeof ConvertSchema>;

export const ConverterSchema = z.object({
    "converter": z.number().int(),
});
export type Converter = z.infer<typeof ConverterSchema>;

export const EmptySchema = z.object({
    "_": z.number().int(),
});
export type Empty = z.infer<typeof EmptySchema>;

export const ImaginerySchema = z.object({
    "_Imaginery": z.number().int(),
});
export type Imaginery = z.infer<typeof ImaginerySchema>;

export const AnyClassSchema = z.object({
    "any": z.number().int(),
});
export type AnyClass = z.infer<typeof AnyClassSchema>;

export const BoolClassSchema = z.object({
    "_Bool": z.number().int(),
});
export type BoolClass = z.infer<typeof BoolClassSchema>;

export const Obj1ClassSchema = z.object({
    "class": z.number().int(),
});
export type Obj1Class = z.infer<typeof Obj1ClassSchema>;

export const Obj1BoolSchema = z.object({
    "bool": z.number().int(),
});
export type Obj1Bool = z.infer<typeof Obj1BoolSchema>;

export const CultureInfoSchema = z.object({
    "CultureInfo": z.number().int(),
});
export type CultureInfo = z.infer<typeof CultureInfoSchema>;

export const DateClassSchema = z.object({
    "date": z.number().int(),
});
export type DateClass = z.infer<typeof DateClassSchema>;

export const DateFormatterSchema = z.object({
    "DateFormatter": z.number().int(),
});
export type DateFormatter = z.infer<typeof DateFormatterSchema>;

export const DateOnlySchema = z.object({
    "DateOnly": z.number().int(),
});
export type DateOnly = z.infer<typeof DateOnlySchema>;

export const DateOnlyConverterSchema = z.object({
    "DateOnlyConverter": z.number().int(),
});
export type DateOnlyConverter = z.infer<typeof DateOnlyConverterSchema>;

export const DateParseHandlingSchema = z.object({
    "date_parse_handling": z.number().int(),
});
export type DateParseHandling = z.infer<typeof DateParseHandlingSchema>;

export const DateTimeSchema = z.object({
    "DateTime": z.string().pipe(z.coerce.date()),
});
export type DateTime = z.infer<typeof DateTimeSchema>;

export const DateTimeStylesSchema = z.object({
    "DateTimeStyles": z.number().int(),
});
export type DateTimeStyles = z.infer<typeof DateTimeStylesSchema>;

export const DebuggerSchema = z.object({
    "debugger": z.number().int(),
});
export type Debugger = z.infer<typeof DebuggerSchema>;

export const DecimalSchema = z.object({
    "decimal": z.number().int(),
});
export type Decimal = z.infer<typeof DecimalSchema>;

export const DeclareSchema = z.object({
    "declare": z.number().int(),
});
export type Declare = z.infer<typeof DeclareSchema>;

export const DecltypeSchema = z.object({
    "decltype": z.number().int(),
});
export type Decltype = z.infer<typeof DecltypeSchema>;

export const DecodeStringSchema = z.object({
    "decode_string": z.number().int(),
});
export type DecodeString = z.infer<typeof DecodeStringSchema>;

export const DecoderSchema = z.object({
    "Decoder": z.number().int(),
});
export type Decoder = z.infer<typeof DecoderSchema>;

export const DecodingErrorSchema = z.object({
    "DecodingError": z.number().int(),
});
export type DecodingError = z.infer<typeof DecodingErrorSchema>;

export const DefSchema = z.object({
    "def": z.number().int(),
});
export type Def = z.infer<typeof DefSchema>;

export const DefaultSchema = z.object({
    "default": z.number().int(),
});
export type Default = z.infer<typeof DefaultSchema>;

export const DeferSchema = z.object({
    "defer": z.number().int(),
});
export type Defer = z.infer<typeof DeferSchema>;

export const DeinitSchema = z.object({
    "deinit": z.number().int(),
});
export type Deinit = z.infer<typeof DeinitSchema>;

export const DelSchema = z.object({
    "del": z.number().int(),
});
export type Del = z.infer<typeof DelSchema>;

export const DelegateSchema = z.object({
    "delegate": z.number().int(),
});
export type Delegate = z.infer<typeof DelegateSchema>;

export const DeleteSchema = z.object({
    "delete": z.number().int(),
});
export type Delete = z.infer<typeof DeleteSchema>;

export const DeserializationFeatureSchema = z.object({
    "DeserializationFeature": z.number().int(),
});
export type DeserializationFeature = z.infer<typeof DeserializationFeatureSchema>;

export const DictSchema = z.object({
    "dict": z.number().int(),
});
export type Dict = z.infer<typeof DictSchema>;

export const DictionarySchema = z.object({
    "dictionary": z.number().int(),
});
export type Dictionary = z.infer<typeof DictionarySchema>;

export const DidSetSchema = z.object({
    "didSet": z.number().int(),
});
export type DidSet = z.infer<typeof DidSetSchema>;

export const DoSchema = z.object({
    "do": z.number().int(),
});
export type Do = z.infer<typeof DoSchema>;

export const DoubleSchema = z.object({
    "double": z.number().int(),
});
export type Double = z.infer<typeof DoubleSchema>;

export const DoubleNodeSchema = z.object({
    "DoubleNode": z.number().int(),
});
export type DoubleNode = z.infer<typeof DoubleNodeSchema>;

export const DynamicSchema = z.object({
    "dynamic": z.number().int(),
});
export type Dynamic = z.infer<typeof DynamicSchema>;

export const DynamicCastSchema = z.object({
    "dynamic_cast": z.number().int(),
});
export type DynamicCast = z.infer<typeof DynamicCastSchema>;

export const ElifSchema = z.object({
    "elif": z.number().int(),
});
export type Elif = z.infer<typeof ElifSchema>;

export const ElseSchema = z.object({
    "else": z.number().int(),
});
export type Else = z.infer<typeof ElseSchema>;

export const EncodeQuickTypeSchema = z.object({
    "encode_quick_type": z.number().int(),
});
export type EncodeQuickType = z.infer<typeof EncodeQuickTypeSchema>;

export const EncoderSchema = z.object({
    "Encoder": z.number().int(),
});
export type Encoder = z.infer<typeof EncoderSchema>;

export const EnumSchema = z.object({
    "enum": z.number().int(),
});
export type Enum = z.infer<typeof EnumSchema>;

export const EnumValuesSchema = z.object({
    "EnumValues": z.array(EnumValueSchema),
});
export type EnumValues = z.infer<typeof EnumValuesSchema>;

export const EqualityContractSchema = z.object({
    "equalityContract": z.number().int(),
});
export type EqualityContract = z.infer<typeof EqualityContractSchema>;

export const EquatableSchema = z.object({
    "Equatable": z.number().int(),
});
export type Equatable = z.infer<typeof EquatableSchema>;

export const EventSchema = z.object({
    "event": z.number().int(),
});
export type Event = z.infer<typeof EventSchema>;

export const ExceptSchema = z.object({
    "except": z.number().int(),
});
export type Except = z.infer<typeof ExceptSchema>;

export const ExceptionSchema = z.object({
    "exception": z.number().int(),
});
export type Exception = z.infer<typeof ExceptionSchema>;

export const ExplicitSchema = z.object({
    "explicit": z.number().int(),
});
export type Explicit = z.infer<typeof ExplicitSchema>;

export const ExportSchema = z.object({
    "export": z.number().int(),
});
export type Export = z.infer<typeof ExportSchema>;

export const ExposingSchema = z.object({
    "exposing": z.number().int(),
});
export type Exposing = z.infer<typeof ExposingSchema>;

export const ExtendsSchema = z.object({
    "extends": z.number().int(),
});
export type Extends = z.infer<typeof ExtendsSchema>;

export const ExtensionSchema = z.object({
    "extension": z.number().int(),
});
export type Extension = z.infer<typeof ExtensionSchema>;

export const ExternSchema = z.object({
    "extern": z.number().int(),
});
export type Extern = z.infer<typeof ExternSchema>;

export const FallthroughSchema = z.object({
    "fallthrough": z.number().int(),
});
export type Fallthrough = z.infer<typeof FallthroughSchema>;

export const FalseSchema = z.object({
    "False": z.number().int(),
});
export type False = z.infer<typeof FalseSchema>;

export const FileprivateSchema = z.object({
    "fileprivate": z.number().int(),
});
export type Fileprivate = z.infer<typeof FileprivateSchema>;

export const FinalSchema = z.object({
    "final": z.number().int(),
});
export type Final = z.infer<typeof FinalSchema>;

export const FinallySchema = z.object({
    "finally": z.number().int(),
});
export type Finally = z.infer<typeof FinallySchema>;

export const FixedSchema = z.object({
    "fixed": z.number().int(),
});
export type Fixed = z.infer<typeof FixedSchema>;

export const FloatSchema = z.object({
    "float": z.number().int(),
});
export type Float = z.infer<typeof FloatSchema>;

export const ForSchema = z.object({
    "for": z.number().int(),
});
export type For = z.infer<typeof ForSchema>;

export const ForeachSchema = z.object({
    "foreach": z.number().int(),
});
export type Foreach = z.infer<typeof ForeachSchema>;

export const FormatExceptionSchema = z.object({
    "FormatException": z.number().int(),
});
export type FormatException = z.infer<typeof FormatExceptionSchema>;

export const FriendSchema = z.object({
    "friend": z.number().int(),
});
export type Friend = z.infer<typeof FriendSchema>;

export const FromSchema = z.object({
    "from": z.number().int(),
});
export type From = z.infer<typeof FromSchema>;

export const FromDictSchema = z.object({
    "from_dict": z.number().int(),
});
export type FromDict = z.infer<typeof FromDictSchema>;

export const FromJsonSchema = z.object({
    "from_json": z.number().int(),
});
export type FromJson = z.infer<typeof FromJsonSchema>;

export const FuncSchema = z.object({
    "func": z.number().int(),
});
export type Func = z.infer<typeof FuncSchema>;

export const FalseClassSchema = z.object({
    "false": z.number().int(),
});
export type FalseClass = z.infer<typeof FalseClassSchema>;

export const FunctionSchema = z.object({
    "function": z.number().int(),
});
export type Function = z.infer<typeof FunctionSchema>;

export const GetSchema = z.object({
    "get": z.number().int(),
});
export type Get = z.infer<typeof GetSchema>;

export const GlobalSchema = z.object({
    "global": z.number().int(),
});
export type Global = z.infer<typeof GlobalSchema>;

export const GoSchema = z.object({
    "go": z.number().int(),
});
export type Go = z.infer<typeof GoSchema>;

export const GotoSchema = z.object({
    "goto": z.number().int(),
});
export type Goto = z.infer<typeof GotoSchema>;

export const GuardSchema = z.object({
    "guard": z.number().int(),
});
export type Guard = z.infer<typeof GuardSchema>;

export const HasOwnPropertySchema = z.object({
    "hasOwnProperty": z.number().int(),
});
export type HasOwnProperty = z.infer<typeof HasOwnPropertySchema>;

export const HashCodeSchema = z.object({
    "hashCode": z.number().int(),
});
export type HashCode = z.infer<typeof HashCodeSchema>;

export const HashableSchema = z.object({
    "Hashable": z.number().int(),
});
export type Hashable = z.infer<typeof HashableSchema>;

export const HasherSchema = z.object({
    "Hasher": z.number().int(),
});
export type Hasher = z.infer<typeof HasherSchema>;

export const IdSchema = z.object({
    "id": z.number().int(),
});
export type Id = z.infer<typeof IdSchema>;

export const IfSchema = z.object({
    "if": z.number().int(),
});
export type If = z.infer<typeof IfSchema>;

export const ImpSchema = z.object({
    "IMP": z.number().int(),
});
export type Imp = z.infer<typeof ImpSchema>;

export const ImplementsSchema = z.object({
    "implements": z.number().int(),
});
export type Implements = z.infer<typeof ImplementsSchema>;

export const ImplicitSchema = z.object({
    "implicit": z.number().int(),
});
export type Implicit = z.infer<typeof ImplicitSchema>;

export const ImportSchema = z.object({
    "import": z.number().int(),
});
export type Import = z.infer<typeof ImportSchema>;

export const InSchema = z.object({
    "in": z.number().int(),
});
export type In = z.infer<typeof InSchema>;

export const IndirectSchema = z.object({
    "indirect": z.number().int(),
});
export type Indirect = z.infer<typeof IndirectSchema>;

export const InfixSchema = z.object({
    "infix": z.number().int(),
});
export type Infix = z.infer<typeof InfixSchema>;

export const InitSchema = z.object({
    "init": z.number().int(),
});
export type Init = z.infer<typeof InitSchema>;

export const InlineSchema = z.object({
    "inline": z.number().int(),
});
export type Inline = z.infer<typeof InlineSchema>;

export const InoutSchema = z.object({
    "inout": z.number().int(),
});
export type Inout = z.infer<typeof InoutSchema>;

export const InstanceofSchema = z.object({
    "instanceof": z.number().int(),
});
export type Instanceof = z.infer<typeof InstanceofSchema>;

export const IntSchema = z.object({
    "int": z.number().int(),
});
export type Int = z.infer<typeof IntSchema>;

export const IntNodeSchema = z.object({
    "IntNode": z.number().int(),
});
export type IntNode = z.infer<typeof IntNodeSchema>;

export const InterfaceSchema = z.object({
    "interface": z.number().int(),
});
export type Interface = z.infer<typeof InterfaceSchema>;

export const InternalSchema = z.object({
    "internal": z.number().int(),
});
export type Internal = z.infer<typeof InternalSchema>;

export const IsSchema = z.object({
    "is": z.number().int(),
});
export type Is = z.infer<typeof IsSchema>;

export const IsoDateTimeOffsetConverterSchema = z.object({
    "IsoDateTimeOffsetConverter": z.number().int(),
});
export type IsoDateTimeOffsetConverter = z.infer<typeof IsoDateTimeOffsetConverterSchema>;

export const IterableSchema = z.object({
    "iterable": z.number().int(),
});
export type Iterable = z.infer<typeof IterableSchema>;

export const JdecSchema = z.object({
    "jdec": z.number().int(),
});
export type Jdec = z.infer<typeof JdecSchema>;

export const JencSchema = z.object({
    "jenc": z.number().int(),
});
export type Jenc = z.infer<typeof JencSchema>;

export const JpipeSchema = z.object({
    "jpipe": z.number().int(),
});
export type Jpipe = z.infer<typeof JpipeSchema>;

export const JsonSchema = z.object({
    "json": z.number().int(),
});
export type Json = z.infer<typeof JsonSchema>;

export const JsonAnySchema = z.object({
    "JSONAny": z.null(),
});
export type JsonAny = z.infer<typeof JsonAnySchema>;

export const JsonCodingKeySchema = z.object({
    "JSONCodingKey": z.number().int(),
});
export type JsonCodingKey = z.infer<typeof JsonCodingKeySchema>;

export const JsonConverterSchema = z.object({
    "json_converter": z.number().int(),
});
export type JsonConverter = z.infer<typeof JsonConverterSchema>;

export const JsonDecoderSchema = z.object({
    "JSONDecoder": z.number().int(),
});
export type JsonDecoder = z.infer<typeof JsonDecoderSchema>;

export const JsonEncoderSchema = z.object({
    "JSONEncoder": z.number().int(),
});
export type JsonEncoder = z.infer<typeof JsonEncoderSchema>;

export const JsonExceptionSchema = z.object({
    "JsonException": z.number().int(),
});
export type JsonException = z.infer<typeof JsonExceptionSchema>;

export const JsonGeneratorSchema = z.object({
    "JsonGenerator": z.number().int(),
});
export type JsonGenerator = z.infer<typeof JsonGeneratorSchema>;

export const JsonNodeSchema = z.object({
    "JsonNode": z.number().int(),
});
export type JsonNode = z.infer<typeof JsonNodeSchema>;

export const JsonNullSchema = z.object({
    "JSONNull": z.number().int(),
});
export type JsonNull = z.infer<typeof JsonNullSchema>;

export const JsonParserSchema = z.object({
    "JsonParser": z.number().int(),
});
export type JsonParser = z.infer<typeof JsonParserSchema>;

export const JsonReaderSchema = z.object({
    "JsonReader": z.number().int(),
});
export type JsonReader = z.infer<typeof JsonReaderSchema>;

export const JsonSerializerSchema = z.object({
    "json_serializer": z.number().int(),
});
export type JsonSerializer = z.infer<typeof JsonSerializerSchema>;

export const JsonTokenSchema = z.object({
    "json_token": z.number().int(),
});
export type JsonToken = z.infer<typeof JsonTokenSchema>;

export const JsonTokenTypeSchema = z.object({
    "JsonTokenType": z.number().int(),
});
export type JsonTokenType = z.infer<typeof JsonTokenTypeSchema>;

export const JsonWriterSchema = z.object({
    "json_writer": z.number().int(),
});
export type JsonWriter = z.infer<typeof JsonWriterSchema>;

export const LambdaSchema = z.object({
    "lambda": z.number().int(),
});
export type Lambda = z.infer<typeof LambdaSchema>;

export const LazySchema = z.object({
    "lazy": z.number().int(),
});
export type Lazy = z.infer<typeof LazySchema>;

export const LeftSchema = z.object({
    "left": z.number().int(),
});
export type Left = z.infer<typeof LeftSchema>;

export const LetSchema = z.object({
    "let": z.number().int(),
});
export type Let = z.infer<typeof LetSchema>;

export const ListSchema = z.object({
    "list": z.number().int(),
});
export type List = z.infer<typeof ListSchema>;

export const LocalDateSchema = z.object({
    "LocalDate": z.number().int(),
});
export type LocalDate = z.infer<typeof LocalDateSchema>;

export const LocaleSchema = z.object({
    "Locale": z.number().int(),
});
export type Locale = z.infer<typeof LocaleSchema>;

export const LockSchema = z.object({
    "lock": z.number().int(),
});
export type Lock = z.infer<typeof LockSchema>;

export const LongSchema = z.object({
    "long": z.number().int(),
});
export type Long = z.infer<typeof LongSchema>;

export const LongNodeSchema = z.object({
    "LongNode": z.number().int(),
});
export type LongNode = z.infer<typeof LongNodeSchema>;

export const MapSchema = z.object({
    "map": z.number().int(),
});
export type Map = z.infer<typeof MapSchema>;

export const MapEntrySchema = z.object({
    "MapEntry": z.number().int(),
});
export type MapEntry = z.infer<typeof MapEntrySchema>;

export const MarshalJsonSchema = z.object({
    "MarshalJSON": z.number().int(),
});
export type MarshalJson = z.infer<typeof MarshalJsonSchema>;

export const MetadataPropertyHandlingSchema = z.object({
    "metadata_property_handling": z.number().int(),
});
export type MetadataPropertyHandling = z.infer<typeof MetadataPropertyHandlingSchema>;

export const ModuleSchema = z.object({
    "module": z.number().int(),
});
export type Module = z.infer<typeof ModuleSchema>;

export const MutableSchema = z.object({
    "mutable": z.number().int(),
});
export type Mutable = z.infer<typeof MutableSchema>;

export const MutatingSchema = z.object({
    "mutating": z.number().int(),
});
export type Mutating = z.infer<typeof MutatingSchema>;

export const NamespaceSchema = z.object({
    "namespace": z.number().int(),
});
export type Namespace = z.infer<typeof NamespaceSchema>;

export const NativeSchema = z.object({
    "native": z.number().int(),
});
export type Native = z.infer<typeof NativeSchema>;

export const NewSchema = z.object({
    "new": z.number().int(),
});
export type New = z.infer<typeof NewSchema>;

export const NewtonsoftSchema = z.object({
    "newtonsoft": z.number().int(),
});
export type Newtonsoft = z.infer<typeof NewtonsoftSchema>;

export const NilSchema = z.object({
    "nil": z.number().int(),
});
export type Nil = z.infer<typeof NilSchema>;

export const NoSchema = z.object({
    "NO": z.number().int(),
});
export type No = z.infer<typeof NoSchema>;

export const NoSuchMethodSchema = z.object({
    "noSuchMethod": z.number().int(),
});
export type NoSuchMethod = z.infer<typeof NoSuchMethodSchema>;

export const NoexceptSchema = z.object({
    "noexcept": z.number().int(),
});
export type Noexcept = z.infer<typeof NoexceptSchema>;

export const NonatomicSchema = z.object({
    "nonatomic": z.number().int(),
});
export type Nonatomic = z.infer<typeof NonatomicSchema>;

export const NoneSchema = z.object({
    "None": z.number().int(),
});
export type None = z.infer<typeof NoneSchema>;

export const NonlocalSchema = z.object({
    "nonlocal": z.number().int(),
});
export type Nonlocal = z.infer<typeof NonlocalSchema>;

export const NonmutatingSchema = z.object({
    "nonmutating": z.number().int(),
});
export type Nonmutating = z.infer<typeof NonmutatingSchema>;

export const NotSchema = z.object({
    "not": z.number().int(),
});
export type Not = z.infer<typeof NotSchema>;

export const NotEqSchema = z.object({
    "not_eq": z.number().int(),
});
export type NotEq = z.infer<typeof NotEqSchema>;

export const NsErrorSchema = z.object({
    "NSError": z.number().int(),
});
export type NsError = z.infer<typeof NsErrorSchema>;

export const NsObjectSchema = z.object({
    "NSObject": z.number().int(),
});
export type NsObject = z.infer<typeof NsObjectSchema>;

export const NsStringSchema = z.object({
    "NSString": z.number().int(),
});
export type NsString = z.infer<typeof NsStringSchema>;

export const NullSchema = z.object({
    "NULL": z.number().int(),
});
export type Null = z.infer<typeof NullSchema>;

export const NullNodeSchema = z.object({
    "NullNode": z.number().int(),
});
export type NullNode = z.infer<typeof NullNodeSchema>;

export const NullptrSchema = z.object({
    "nullptr": z.number().int(),
});
export type Nullptr = z.infer<typeof NullptrSchema>;

export const NumberSchema = z.object({
    "number": z.number().int(),
});
export type Number = z.infer<typeof NumberSchema>;

export const NoneClassSchema = z.object({
    "none": z.number().int(),
});
export type NoneClass = z.infer<typeof NoneClassSchema>;

export const NullClassSchema = z.object({
    "null": z.number().int(),
});
export type NullClass = z.infer<typeof NullClassSchema>;

export const ProtocolClassSchema = z.object({
    "protocol": z.number().int(),
});
export type ProtocolClass = z.infer<typeof ProtocolClassSchema>;

export const ObjectClassSchema = z.object({
    "object": z.number().int(),
});
export type ObjectClass = z.infer<typeof ObjectClassSchema>;

export const ObjectMapperSchema = z.object({
    "ObjectMapper": z.number().int(),
});
export type ObjectMapper = z.infer<typeof ObjectMapperSchema>;

export const ObjectNodeSchema = z.object({
    "ObjectNode": z.number().int(),
});
export type ObjectNode = z.infer<typeof ObjectNodeSchema>;

export const ObjectReaderSchema = z.object({
    "ObjectReader": z.number().int(),
});
export type ObjectReader = z.infer<typeof ObjectReaderSchema>;

export const ObjectWriterSchema = z.object({
    "ObjectWriter": z.number().int(),
});
export type ObjectWriter = z.infer<typeof ObjectWriterSchema>;

export const OfSchema = z.object({
    "of": z.number().int(),
});
export type Of = z.infer<typeof OfSchema>;

export const OffsetDateTimeSchema = z.object({
    "OffsetDateTime": z.number().int(),
});
export type OffsetDateTime = z.infer<typeof OffsetDateTimeSchema>;

export const OffsetTimeSchema = z.object({
    "OffsetTime": z.number().int(),
});
export type OffsetTime = z.infer<typeof OffsetTimeSchema>;

export const OnewaySchema = z.object({
    "oneway": z.number().int(),
});
export type Oneway = z.infer<typeof OnewaySchema>;

export const OpenSchema = z.object({
    "open": z.number().int(),
});
export type Open = z.infer<typeof OpenSchema>;

export const OperatorSchema = z.object({
    "operator": z.number().int(),
});
export type Operator = z.infer<typeof OperatorSchema>;

export const OptionalSchema = z.object({
    "optional": z.number().int(),
});
export type Optional = z.infer<typeof OptionalSchema>;

export const OrSchema = z.object({
    "or": z.number().int(),
});
export type Or = z.infer<typeof OrSchema>;

export const OrEqSchema = z.object({
    "or_eq": z.number().int(),
});
export type OrEq = z.infer<typeof OrEqSchema>;

export const OutSchema = z.object({
    "out": z.number().int(),
});
export type Out = z.infer<typeof OutSchema>;

export const OverrideSchema = z.object({
    "override": z.number().int(),
});
export type Override = z.infer<typeof OverrideSchema>;

export const PackageSchema = z.object({
    "package": z.number().int(),
});
export type Package = z.infer<typeof PackageSchema>;

export const ParamsSchema = z.object({
    "params": z.number().int(),
});
export type Params = z.infer<typeof ParamsSchema>;

export const PassSchema = z.object({
    "pass": z.number().int(),
});
export type Pass = z.infer<typeof PassSchema>;

export const PortSchema = z.object({
    "port": z.number().int(),
});
export type Port = z.infer<typeof PortSchema>;

export const PostfixSchema = z.object({
    "postfix": z.number().int(),
});
export type Postfix = z.infer<typeof PostfixSchema>;

export const PrecedenceSchema = z.object({
    "precedence": z.number().int(),
});
export type Precedence = z.infer<typeof PrecedenceSchema>;

export const PrefixSchema = z.object({
    "prefix": z.number().int(),
});
export type Prefix = z.infer<typeof PrefixSchema>;

export const PrintSchema = z.object({
    "print": z.number().int(),
});
export type Print = z.infer<typeof PrintSchema>;

export const PrintMembersSchema = z.object({
    "printMembers": z.number().int(),
});
export type PrintMembers = z.infer<typeof PrintMembersSchema>;

export const PrintfSchema = z.object({
    "printf": z.number().int(),
});
export type Printf = z.infer<typeof PrintfSchema>;

export const PrivateSchema = z.object({
    "private": z.number().int(),
});
export type Private = z.infer<typeof PrivateSchema>;

export const ProtectedSchema = z.object({
    "protected": z.number().int(),
});
export type Protected = z.infer<typeof ProtectedSchema>;

export const ProtocolSchema = z.object({
    "Protocol": z.number().int(),
});
export type Protocol = z.infer<typeof ProtocolSchema>;

export const PublicSchema = z.object({
    "public": z.number().int(),
});
export type Public = z.infer<typeof PublicSchema>;

export const QuicktypeSchema = z.object({
    "quicktype": z.number().int(),
});
export type Quicktype = z.infer<typeof QuicktypeSchema>;

export const RaiseSchema = z.object({
    "raise": z.number().int(),
});
export type Raise = z.infer<typeof RaiseSchema>;

export const RangeSchema = z.object({
    "range": z.number().int(),
});
export type Range = z.infer<typeof RangeSchema>;

export const ReadonlySchema = z.object({
    "readonly": z.number().int(),
});
export type Readonly = z.infer<typeof ReadonlySchema>;

export const RefSchema = z.object({
    "ref": z.number().int(),
});
export type Ref = z.infer<typeof RefSchema>;

export const RegExpSchema = z.object({
    "RegExp": z.string().uuid(),
});
export type RegExp = z.infer<typeof RegExpSchema>;

export const RegisterSchema = z.object({
    "register": z.number().int(),
});
export type Register = z.infer<typeof RegisterSchema>;

export const ReinterpretCastSchema = z.object({
    "reinterpret_cast": z.number().int(),
});
export type ReinterpretCast = z.infer<typeof ReinterpretCastSchema>;

export const KSerializerSchema = z.object({
    "KSerializer": z.number().int(),
});
export type KSerializer = z.infer<typeof KSerializerSchema>;

export const SelfClassSchema = z.object({
    "self": z.number().int(),
});
export type SelfClass = z.infer<typeof SelfClassSchema>;

export const TrueClassSchema = z.object({
    "true": z.number().int(),
});
export type TrueClass = z.infer<typeof TrueClassSchema>;

export const PrimitiveKindSchema = z.object({
    "PrimitiveKind": z.number().int(),
});
export type PrimitiveKind = z.infer<typeof PrimitiveKindSchema>;

export const RepeatSchema = z.object({
    "repeat": z.number().int(),
});
export type Repeat = z.infer<typeof RepeatSchema>;

export const RequireSchema = z.object({
    "require": z.number().int(),
});
export type Require = z.infer<typeof RequireSchema>;

export const RequiredSchema = z.object({
    "required": z.number().int(),
});
export type Required = z.infer<typeof RequiredSchema>;

export const RequiresSchema = z.object({
    "requires": z.number().int(),
});
export type Requires = z.infer<typeof RequiresSchema>;

export const RestrictSchema = z.object({
    "restrict": z.number().int(),
});
export type Restrict = z.infer<typeof RestrictSchema>;

export const RetainSchema = z.object({
    "retain": z.number().int(),
});
export type Retain = z.infer<typeof RetainSchema>;

export const RethrowsSchema = z.object({
    "rethrows": z.number().int(),
});
export type Rethrows = z.infer<typeof RethrowsSchema>;

export const ReturnSchema = z.object({
    "return": z.number().int(),
});
export type Return = z.infer<typeof ReturnSchema>;

export const RightSchema = z.object({
    "right": z.number().int(),
});
export type Right = z.infer<typeof RightSchema>;

export const RuntimeTypeSchema = z.object({
    "runtimeType": z.number().int(),
});
export type RuntimeType = z.infer<typeof RuntimeTypeSchema>;

export const SSchema = z.object({
    "s": z.number().int(),
});
export type S = z.infer<typeof SSchema>;

export const SbyteSchema = z.object({
    "sbyte": z.number().int(),
});
export type Sbyte = z.infer<typeof SbyteSchema>;

export const SealedSchema = z.object({
    "sealed": z.number().int(),
});
export type Sealed = z.infer<typeof SealedSchema>;

export const SelSchema = z.object({
    "SEL": z.number().int(),
});
export type Sel = z.infer<typeof SelSchema>;

export const SelectSchema = z.object({
    "select": z.number().int(),
});
export type Select = z.infer<typeof SelectSchema>;

export const SelfSchema = z.object({
    "Self": z.number().int(),
});
export type Self = z.infer<typeof SelfSchema>;

export const SendableSchema = z.object({
    "Sendable": z.number().int(),
});
export type Sendable = z.infer<typeof SendableSchema>;

export const SerialDescriptorSchema = z.object({
    "SerialDescriptor": z.number().int(),
});
export type SerialDescriptor = z.infer<typeof SerialDescriptorSchema>;

export const SerialNameSchema = z.object({
    "SerialName": z.number().int(),
});
export type SerialName = z.infer<typeof SerialNameSchema>;

export const SerializableSchema = z.object({
    "Serializable": z.number().int(),
});
export type Serializable = z.infer<typeof SerializableSchema>;

export const SerializationFeatureSchema = z.object({
    "SerializationFeature": z.number().int(),
});
export type SerializationFeature = z.infer<typeof SerializationFeatureSchema>;

export const SerializeSchema = z.object({
    "serialize": z.number().int(),
});
export type Serialize = z.infer<typeof SerializeSchema>;

export const SerializerProviderSchema = z.object({
    "SerializerProvider": z.number().int(),
});
export type SerializerProvider = z.infer<typeof SerializerProviderSchema>;

export const SetSchema = z.object({
    "set": z.number().int(),
});
export type Set = z.infer<typeof SetSchema>;

export const ShortSchema = z.object({
    "short": z.number().int(),
});
export type Short = z.infer<typeof ShortSchema>;

export const SignedSchema = z.object({
    "signed": z.number().int(),
});
export type Signed = z.infer<typeof SignedSchema>;

export const SimpleModuleSchema = z.object({
    "SimpleModule": z.number().int(),
});
export type SimpleModule = z.infer<typeof SimpleModuleSchema>;

export const SizeofSchema = z.object({
    "sizeof": z.number().int(),
});
export type Sizeof = z.infer<typeof SizeofSchema>;

export const StackallocSchema = z.object({
    "stackalloc": z.number().int(),
});
export type Stackalloc = z.infer<typeof StackallocSchema>;

export const StandardsSchema = z.object({
    "Standards": z.number().int(),
});
export type Standards = z.infer<typeof StandardsSchema>;

export const StaticSchema = z.object({
    "static": z.number().int(),
});
export type Static = z.infer<typeof StaticSchema>;

export const StaticAssertSchema = z.object({
    "static_assert": z.number().int(),
});
export type StaticAssert = z.infer<typeof StaticAssertSchema>;

export const StaticCastSchema = z.object({
    "static_cast": z.number().int(),
});
export type StaticCast = z.infer<typeof StaticCastSchema>;

export const StdDeserializerSchema = z.object({
    "StdDeserializer": z.number().int(),
});
export type StdDeserializer = z.infer<typeof StdDeserializerSchema>;

export const StdSerializerSchema = z.object({
    "StdSerializer": z.number().int(),
});
export type StdSerializer = z.infer<typeof StdSerializerSchema>;

export const StrictfpSchema = z.object({
    "strictfp": z.number().int(),
});
export type Strictfp = z.infer<typeof StrictfpSchema>;

export const StringClassSchema = z.object({
    "string": z.number().int(),
});
export type StringClass = z.infer<typeof StringClassSchema>;

export const StructSchema = z.object({
    "struct": z.number().int(),
});
export type Struct = z.infer<typeof StructSchema>;

export const SubscriptSchema = z.object({
    "subscript": z.number().int(),
});
export type Subscript = z.infer<typeof SubscriptSchema>;

export const SuperSchema = z.object({
    "super": z.number().int(),
});
export type Super = z.infer<typeof SuperSchema>;

export const SwitchSchema = z.object({
    "switch": z.number().int(),
});
export type Switch = z.infer<typeof SwitchSchema>;

export const SymbolSchema = z.object({
    "symbol": z.number().int(),
});
export type Symbol = z.infer<typeof SymbolSchema>;

export const SynchronizedSchema = z.object({
    "synchronized": z.number().int(),
});
export type Synchronized = z.infer<typeof SynchronizedSchema>;

export const SystemSchema = z.object({
    "system": z.number().int(),
});
export type System = z.infer<typeof SystemSchema>;

export const TemplateSchema = z.object({
    "template": z.number().int(),
});
export type Template = z.infer<typeof TemplateSchema>;

export const TextNodeSchema = z.object({
    "TextNode": z.number().int(),
});
export type TextNode = z.infer<typeof TextNodeSchema>;

export const ThenSchema = z.object({
    "then": z.number().int(),
});
export type Then = z.infer<typeof ThenSchema>;

export const ThisSchema = z.object({
    "this": z.number().int(),
});
export type This = z.infer<typeof ThisSchema>;

export const ThreadLocalSchema = z.object({
    "thread_local": z.number().int(),
});
export type ThreadLocal = z.infer<typeof ThreadLocalSchema>;

export const ThrowSchema = z.object({
    "throw": z.number().int(),
});
export type Throw = z.infer<typeof ThrowSchema>;

export const ThrowsSchema = z.object({
    "throws": z.number().int(),
});
export type Throws = z.infer<typeof ThrowsSchema>;

export const TimeOnlySchema = z.object({
    "TimeOnly": z.number().int(),
});
export type TimeOnly = z.infer<typeof TimeOnlySchema>;

export const TimeOnlyConverterSchema = z.object({
    "TimeOnlyConverter": z.number().int(),
});
export type TimeOnlyConverter = z.infer<typeof TimeOnlyConverterSchema>;

export const TimeZoneSchema = z.object({
    "TimeZone": z.number().int(),
});
export type TimeZone = z.infer<typeof TimeZoneSchema>;

export const ToDictSchema = z.object({
    "to_dict": z.number().int(),
});
export type ToDict = z.infer<typeof ToDictSchema>;

export const ToJsonSchema = z.object({
    "to_json": z.number().int(),
});
export type ToJson = z.infer<typeof ToJsonSchema>;

export const ToStringSchema = z.object({
    "toString": z.number().int(),
});
export type ToString = z.infer<typeof ToStringSchema>;

export const TopLevelClassSchema = z.object({
    "top_level": z.number().int(),
});
export type TopLevelClass = z.infer<typeof TopLevelClassSchema>;

export const TransientSchema = z.object({
    "transient": z.number().int(),
});
export type Transient = z.infer<typeof TransientSchema>;

export const TrueSchema = z.object({
    "True": z.number().int(),
});
export type True = z.infer<typeof TrueSchema>;

export const TypeClassSchema = z.object({
    "type": z.number().int(),
});
export type TypeClass = z.infer<typeof TypeClassSchema>;

export const TrySchema = z.object({
    "try": z.number().int(),
});
export type Try = z.infer<typeof TrySchema>;

export const TypeSchema = z.object({
    "Type": z.number().int(),
});
export type Type = z.infer<typeof TypeSchema>;

export const TypealiasSchema = z.object({
    "typealias": z.number().int(),
});
export type Typealias = z.infer<typeof TypealiasSchema>;

export const TypedefSchema = z.object({
    "typedef": z.number().int(),
});
export type Typedef = z.infer<typeof TypedefSchema>;

export const TypeidSchema = z.object({
    "typeid": z.number().int(),
});
export type Typeid = z.infer<typeof TypeidSchema>;

export const TypenameSchema = z.object({
    "typename": z.number().int(),
});
export type Typename = z.infer<typeof TypenameSchema>;

export const TypeofSchema = z.object({
    "typeof": z.number().int(),
});
export type Typeof = z.infer<typeof TypeofSchema>;

export const UintSchema = z.object({
    "uint": z.number().int(),
});
export type Uint = z.infer<typeof UintSchema>;

export const UlongSchema = z.object({
    "ulong": z.number().int(),
});
export type Ulong = z.infer<typeof UlongSchema>;

export const UncheckedSchema = z.object({
    "unchecked": z.number().int(),
});
export type Unchecked = z.infer<typeof UncheckedSchema>;

export const UndefinedSchema = z.object({
    "undefined": z.number().int(),
});
export type Undefined = z.infer<typeof UndefinedSchema>;

export const UnionSchema = z.object({
    "union": z.number().int(),
});
export type Union = z.infer<typeof UnionSchema>;

export const UnmarshalJsonSchema = z.object({
    "UnmarshalJSON": z.number().int(),
});
export type UnmarshalJson = z.infer<typeof UnmarshalJsonSchema>;

export const UnownedSchema = z.object({
    "unowned": z.number().int(),
});
export type Unowned = z.infer<typeof UnownedSchema>;

export const UnsafeSchema = z.object({
    "unsafe": z.number().int(),
});
export type Unsafe = z.infer<typeof UnsafeSchema>;

export const UnsignedSchema = z.object({
    "unsigned": z.number().int(),
});
export type Unsigned = z.infer<typeof UnsignedSchema>;

export const UseSerializersSchema = z.object({
    "UseSerializers": z.number().int(),
});
export type UseSerializers = z.infer<typeof UseSerializersSchema>;

export const UshortSchema = z.object({
    "ushort": z.number().int(),
});
export type Ushort = z.infer<typeof UshortSchema>;

export const UsingSchema = z.object({
    "using": z.number().int(),
});
export type Using = z.infer<typeof UsingSchema>;

export const Utf8JsonReaderSchema = z.object({
    "Utf8JsonReader": z.number().int(),
});
export type Utf8JsonReader = z.infer<typeof Utf8JsonReaderSchema>;

export const Utf8JsonWriterSchema = z.object({
    "Utf8JsonWriter": z.number().int(),
});
export type Utf8JsonWriter = z.infer<typeof Utf8JsonWriterSchema>;

export const UuidSchema = z.object({
    "UUID": z.number().int(),
});
export type Uuid = z.infer<typeof UuidSchema>;

export const VarSchema = z.object({
    "var": z.number().int(),
});
export type Var = z.infer<typeof VarSchema>;

export const VirtualSchema = z.object({
    "virtual": z.number().int(),
});
export type Virtual = z.infer<typeof VirtualSchema>;

export const VoidSchema = z.object({
    "void": z.number().int(),
});
export type Void = z.infer<typeof VoidSchema>;

export const VolatileSchema = z.object({
    "volatile": z.number().int(),
});
export type Volatile = z.infer<typeof VolatileSchema>;

export const WcharTSchema = z.object({
    "wchar_t": z.number().int(),
});
export type WcharT = z.infer<typeof WcharTSchema>;

export const WeakSchema = z.object({
    "weak": z.number().int(),
});
export type Weak = z.infer<typeof WeakSchema>;

export const WhereSchema = z.object({
    "where": z.number().int(),
});
export type Where = z.infer<typeof WhereSchema>;

export const WhileSchema = z.object({
    "while": z.number().int(),
});
export type While = z.infer<typeof WhileSchema>;

export const WillSetSchema = z.object({
    "willSet": z.number().int(),
});
export type WillSet = z.infer<typeof WillSetSchema>;

export const WithSchema = z.object({
    "with": z.number().int(),
});
export type With = z.infer<typeof WithSchema>;

export const XorSchema = z.object({
    "xor": z.number().int(),
});
export type Xor = z.infer<typeof XorSchema>;

export const XorEqSchema = z.object({
    "xor_eq": z.number().int(),
});
export type XorEq = z.infer<typeof XorEqSchema>;

export const YesSchema = z.object({
    "YES": z.number().int(),
});
export type Yes = z.infer<typeof YesSchema>;

export const YieldSchema = z.object({
    "yield": z.number().int(),
});
export type Yield = z.infer<typeof YieldSchema>;

export const Obj1Schema = z.object({
    "abstract": AbstractSchema,
    "alignas": AlignasSchema,
    "alignof": AlignofSchema,
    "and": AndSchema,
    "and_eq": AndEqSchema,
    "Any": AnySchema,
    "array": ArrayClassSchema,
    "ArrayNode": ArrayNodeSchema,
    "as": AsSchema,
    "asm": AsmSchema,
    "assert": AssertSchema,
    "associatedtype": AssociatedtypeSchema,
    "associativity": AssociativitySchema,
    "async": AsyncSchema,
    "atomic": AtomicSchema,
    "atomic_cancel": AtomicCancelSchema,
    "atomic_commit": AtomicCommitSchema,
    "atomic_noexcept": AtomicNoexceptSchema,
    "auto": AutoSchema,
    "await": AwaitSchema,
    "base": BaseSchema,
    "bitand": BitandSchema,
    "bitor": BitorSchema,
    "BOOL": BoolSchema,
    "boolean": BooleanSchema,
    "BooleanNode": BooleanNodeSchema,
    "break": BreakSchema,
    "bycopy": BycopySchema,
    "byref": ByrefSchema,
    "byte": ByteSchema,
    "Calendar": CalendarSchema,
    "case": CaseSchema,
    "catch": CatchSchema,
    "chan": ChanSchema,
    "char": CharSchema,
    "char16_t": Char16TSchema,
    "char32_t": Char32TSchema,
    "checked": CheckedSchema,
    "Class": ClassClassSchema,
    "clone": CloneSchema,
    "co_await": CoAwaitSchema,
    "co_return": CoReturnSchema,
    "co_yield": CoYieldSchema,
    "Codable": CodableSchema,
    "CodingKey": CodingKeySchema,
    "CodingKeys": CodingKeysSchema,
    "compl": ComplSchema,
    "_Complex": ComplexSchema,
    "concept": ConceptSchema,
    "console": ConsoleSchema,
    "const": ConstSchema,
    "const_cast": ConstCastSchema,
    "constexpr": ConstexprSchema,
    "constructor": ConstructorSchema,
    "continue": ContinueSchema,
    "convenience": ConvenienceSchema,
    "convert": ConvertSchema,
    "converter": ConverterSchema,
    "dummy": z.number().int(),
    "_": EmptySchema,
    "_Imaginery": ImaginerySchema,
    "any": AnyClassSchema,
    "_Bool": BoolClassSchema,
    "class": Obj1ClassSchema,
    "bool": Obj1BoolSchema,
});
export type Obj1 = z.infer<typeof Obj1Schema>;

export const Obj2Schema = z.object({
    "CultureInfo": CultureInfoSchema,
    "date": DateClassSchema,
    "DateFormatter": DateFormatterSchema,
    "DateOnly": DateOnlySchema,
    "DateOnlyConverter": DateOnlyConverterSchema,
    "date_parse_handling": DateParseHandlingSchema,
    "DateTime": DateTimeSchema,
    "DateTimeStyles": DateTimeStylesSchema,
    "debugger": DebuggerSchema,
    "decimal": DecimalSchema,
    "declare": DeclareSchema,
    "decltype": DecltypeSchema,
    "decode_string": DecodeStringSchema,
    "Decoder": DecoderSchema,
    "DecodingError": DecodingErrorSchema,
    "def": DefSchema,
    "default": DefaultSchema,
    "defer": DeferSchema,
    "deinit": DeinitSchema,
    "del": DelSchema,
    "delegate": DelegateSchema,
    "delete": DeleteSchema,
    "DeserializationFeature": DeserializationFeatureSchema,
    "dict": DictSchema,
    "dictionary": DictionarySchema,
    "didSet": DidSetSchema,
    "do": DoSchema,
    "double": DoubleSchema,
    "DoubleNode": DoubleNodeSchema,
    "dummy": z.number().int(),
    "dynamic": DynamicSchema,
    "dynamic_cast": DynamicCastSchema,
    "elif": ElifSchema,
    "else": ElseSchema,
    "encode_quick_type": EncodeQuickTypeSchema,
    "Encoder": EncoderSchema,
    "enum": EnumSchema,
    "EnumValues": EnumValuesSchema,
    "equalityContract": EqualityContractSchema,
    "Equatable": EquatableSchema,
    "event": EventSchema,
    "except": ExceptSchema,
    "exception": ExceptionSchema,
    "explicit": ExplicitSchema,
    "export": ExportSchema,
    "exposing": ExposingSchema,
    "extends": ExtendsSchema,
    "extension": ExtensionSchema,
    "extern": ExternSchema,
    "fallthrough": FallthroughSchema,
    "False": FalseSchema,
    "fileprivate": FileprivateSchema,
    "final": FinalSchema,
    "finally": FinallySchema,
    "fixed": FixedSchema,
    "float": FloatSchema,
    "for": ForSchema,
    "foreach": ForeachSchema,
    "FormatException": FormatExceptionSchema,
    "friend": FriendSchema,
    "from": FromSchema,
    "from_dict": FromDictSchema,
    "from_json": FromJsonSchema,
    "func": FuncSchema,
    "false": FalseClassSchema,
});
export type Obj2 = z.infer<typeof Obj2Schema>;

export const Obj3Schema = z.object({
    "dummy": z.number().int(),
    "function": FunctionSchema,
    "get": GetSchema,
    "global": GlobalSchema,
    "go": GoSchema,
    "goto": GotoSchema,
    "guard": GuardSchema,
    "hasOwnProperty": HasOwnPropertySchema,
    "hashCode": HashCodeSchema,
    "Hashable": HashableSchema,
    "Hasher": HasherSchema,
    "id": IdSchema,
    "if": IfSchema,
    "IMP": ImpSchema,
    "implements": ImplementsSchema,
    "implicit": ImplicitSchema,
    "import": ImportSchema,
    "in": InSchema,
    "indirect": IndirectSchema,
    "infix": InfixSchema,
    "init": InitSchema,
    "inline": InlineSchema,
    "inout": InoutSchema,
    "instanceof": InstanceofSchema,
    "int": IntSchema,
    "IntNode": IntNodeSchema,
    "interface": InterfaceSchema,
    "internal": InternalSchema,
    "is": IsSchema,
    "IsoDateTimeOffsetConverter": IsoDateTimeOffsetConverterSchema,
    "iterable": IterableSchema,
    "jdec": JdecSchema,
    "jenc": JencSchema,
    "jpipe": JpipeSchema,
    "json": JsonSchema,
    "JSONAny": JsonAnySchema,
    "JSONCodingKey": JsonCodingKeySchema,
    "json_converter": JsonConverterSchema,
    "JSONDecoder": JsonDecoderSchema,
    "JSONEncoder": JsonEncoderSchema,
    "JsonException": JsonExceptionSchema,
    "JsonGenerator": JsonGeneratorSchema,
    "JsonNode": JsonNodeSchema,
    "JSONNull": JsonNullSchema,
    "JsonParser": JsonParserSchema,
    "JsonReader": JsonReaderSchema,
    "json_serializer": JsonSerializerSchema,
    "json_token": JsonTokenSchema,
    "JsonTokenType": JsonTokenTypeSchema,
    "json_writer": JsonWriterSchema,
    "lambda": LambdaSchema,
    "lazy": LazySchema,
    "left": LeftSchema,
    "let": LetSchema,
    "list": ListSchema,
    "LocalDate": LocalDateSchema,
    "Locale": LocaleSchema,
    "lock": LockSchema,
    "long": LongSchema,
    "LongNode": LongNodeSchema,
    "map": MapSchema,
    "MapEntry": MapEntrySchema,
    "MarshalJSON": MarshalJsonSchema,
    "metadata_property_handling": MetadataPropertyHandlingSchema,
    "module": ModuleSchema,
});
export type Obj3 = z.infer<typeof Obj3Schema>;

export const Obj4Schema = z.object({
    "dummy": z.number().int(),
    "mutable": MutableSchema,
    "mutating": MutatingSchema,
    "namespace": NamespaceSchema,
    "native": NativeSchema,
    "new": NewSchema,
    "newtonsoft": NewtonsoftSchema,
    "nil": NilSchema,
    "NO": NoSchema,
    "noSuchMethod": NoSuchMethodSchema,
    "noexcept": NoexceptSchema,
    "nonatomic": NonatomicSchema,
    "None": NoneSchema,
    "nonlocal": NonlocalSchema,
    "nonmutating": NonmutatingSchema,
    "not": NotSchema,
    "not_eq": NotEqSchema,
    "NSError": NsErrorSchema,
    "NSObject": NsObjectSchema,
    "NSString": NsStringSchema,
    "NULL": NullSchema,
    "NullNode": NullNodeSchema,
    "nullptr": NullptrSchema,
    "number": NumberSchema,
    "none": NoneClassSchema,
    "null": NullClassSchema,
    "protocol": ProtocolClassSchema,
    "object": ObjectClassSchema,
    "ObjectMapper": ObjectMapperSchema,
    "ObjectNode": ObjectNodeSchema,
    "ObjectReader": ObjectReaderSchema,
    "ObjectWriter": ObjectWriterSchema,
    "of": OfSchema,
    "OffsetDateTime": OffsetDateTimeSchema,
    "OffsetTime": OffsetTimeSchema,
    "oneway": OnewaySchema,
    "open": OpenSchema,
    "operator": OperatorSchema,
    "optional": OptionalSchema,
    "or": OrSchema,
    "or_eq": OrEqSchema,
    "out": OutSchema,
    "override": OverrideSchema,
    "package": PackageSchema,
    "params": ParamsSchema,
    "pass": PassSchema,
    "port": PortSchema,
    "postfix": PostfixSchema,
    "precedence": PrecedenceSchema,
    "prefix": PrefixSchema,
    "print": PrintSchema,
    "printMembers": PrintMembersSchema,
    "printf": PrintfSchema,
    "private": PrivateSchema,
    "protected": ProtectedSchema,
    "Protocol": ProtocolSchema,
    "public": PublicSchema,
    "quicktype": QuicktypeSchema,
    "raise": RaiseSchema,
    "range": RangeSchema,
    "readonly": ReadonlySchema,
    "ref": RefSchema,
    "RegExp": RegExpSchema,
    "register": RegisterSchema,
    "reinterpret_cast": ReinterpretCastSchema,
});
export type Obj4 = z.infer<typeof Obj4Schema>;

export const Obj5Schema = z.object({
    "dummy": z.number().int(),
    "KSerializer": KSerializerSchema,
    "self": SelfClassSchema,
    "true": TrueClassSchema,
    "PrimitiveKind": PrimitiveKindSchema,
    "repeat": RepeatSchema,
    "require": RequireSchema,
    "required": RequiredSchema,
    "requires": RequiresSchema,
    "restrict": RestrictSchema,
    "retain": RetainSchema,
    "rethrows": RethrowsSchema,
    "return": ReturnSchema,
    "right": RightSchema,
    "runtimeType": RuntimeTypeSchema,
    "s": SSchema,
    "sbyte": SbyteSchema,
    "sealed": SealedSchema,
    "SEL": SelSchema,
    "select": SelectSchema,
    "Self": SelfSchema,
    "Sendable": SendableSchema,
    "SerialDescriptor": SerialDescriptorSchema,
    "SerialName": SerialNameSchema,
    "Serializable": SerializableSchema,
    "SerializationFeature": SerializationFeatureSchema,
    "serialize": SerializeSchema,
    "SerializerProvider": SerializerProviderSchema,
    "set": SetSchema,
    "short": ShortSchema,
    "signed": SignedSchema,
    "SimpleModule": SimpleModuleSchema,
    "sizeof": SizeofSchema,
    "stackalloc": StackallocSchema,
    "Standards": StandardsSchema,
    "static": StaticSchema,
    "static_assert": StaticAssertSchema,
    "static_cast": StaticCastSchema,
    "StdDeserializer": StdDeserializerSchema,
    "StdSerializer": StdSerializerSchema,
    "strictfp": StrictfpSchema,
    "string": StringClassSchema,
    "struct": StructSchema,
    "subscript": SubscriptSchema,
    "super": SuperSchema,
    "switch": SwitchSchema,
    "symbol": SymbolSchema,
    "synchronized": SynchronizedSchema,
    "system": SystemSchema,
    "template": TemplateSchema,
    "TextNode": TextNodeSchema,
    "then": ThenSchema,
    "this": ThisSchema,
    "thread_local": ThreadLocalSchema,
    "throw": ThrowSchema,
    "throws": ThrowsSchema,
    "TimeOnly": TimeOnlySchema,
    "TimeOnlyConverter": TimeOnlyConverterSchema,
    "TimeZone": TimeZoneSchema,
    "to_dict": ToDictSchema,
    "to_json": ToJsonSchema,
    "toString": ToStringSchema,
    "top_level": TopLevelClassSchema,
    "transient": TransientSchema,
    "True": TrueSchema,
});
export type Obj5 = z.infer<typeof Obj5Schema>;

export const Obj6Schema = z.object({
    "dummy": z.number().int(),
    "type": TypeClassSchema,
    "try": TrySchema,
    "Type": TypeSchema,
    "typealias": TypealiasSchema,
    "typedef": TypedefSchema,
    "typeid": TypeidSchema,
    "typename": TypenameSchema,
    "typeof": TypeofSchema,
    "uint": UintSchema,
    "ulong": UlongSchema,
    "unchecked": UncheckedSchema,
    "undefined": UndefinedSchema,
    "union": UnionSchema,
    "UnmarshalJSON": UnmarshalJsonSchema,
    "unowned": UnownedSchema,
    "unsafe": UnsafeSchema,
    "unsigned": UnsignedSchema,
    "UseSerializers": UseSerializersSchema,
    "ushort": UshortSchema,
    "using": UsingSchema,
    "Utf8JsonReader": Utf8JsonReaderSchema,
    "Utf8JsonWriter": Utf8JsonWriterSchema,
    "UUID": UuidSchema,
    "var": VarSchema,
    "virtual": VirtualSchema,
    "void": VoidSchema,
    "volatile": VolatileSchema,
    "wchar_t": WcharTSchema,
    "weak": WeakSchema,
    "where": WhereSchema,
    "while": WhileSchema,
    "willSet": WillSetSchema,
    "with": WithSchema,
    "xor": XorSchema,
    "xor_eq": XorEqSchema,
    "YES": YesSchema,
    "yield": YieldSchema,
});
export type Obj6 = z.infer<typeof Obj6Schema>;

export const TopLevelSchema = z.object({
    "dummy": z.number().int(),
    "obj1": Obj1Schema,
    "obj2": Obj2Schema,
    "obj3": Obj3Schema,
    "obj4": Obj4Schema,
    "obj5": Obj5Schema,
    "obj6": Obj6Schema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
