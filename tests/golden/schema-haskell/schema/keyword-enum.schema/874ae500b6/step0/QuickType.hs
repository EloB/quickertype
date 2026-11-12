{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , EnumEnum (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { enumQuickType :: Maybe EnumEnum
    } deriving (Show)

data EnumEnum
    = PurpleEnumEnum
    | BoolEnumEnum
    | ComplexEnumEnum
    | ImagineryEnumEnum
    | AbstractEnumEnum
    | AlignasEnumEnum
    | AlignofEnumEnum
    | AndEnumEnum
    | AndEqEnumEnum
    | AnyEnumEnum
    | PurpleAnyEnumEnum
    | ArrayNodeEnumEnum
    | ArrayEnumEnum
    | AsEnumEnum
    | ASMEnumEnum
    | AssertEnumEnum
    | AssociatedtypeEnumEnum
    | AssociativityEnumEnum
    | AsyncEnumEnum
    | AtomicEnumEnum
    | AtomicCancelEnumEnum
    | AtomicCommitEnumEnum
    | AtomicNoexceptEnumEnum
    | AutoEnumEnum
    | AwaitEnumEnum
    | BaseEnumEnum
    | BitandEnumEnum
    | BitorEnumEnum
    | BOOLEnumEnum
    | PurpleBoolEnumEnum
    | BooleanEnumEnum
    | BooleanNodeEnumEnum
    | BreakEnumEnum
    | BycopyEnumEnum
    | ByrefEnumEnum
    | ByteEnumEnum
    | CalendarEnumEnum
    | CaseEnumEnum
    | CatchEnumEnum
    | ChanEnumEnum
    | CharEnumEnum
    | Char16TEnumEnum
    | Char32TEnumEnum
    | CheckedEnumEnum
    | ClassEnumEnum
    | PurpleClassEnumEnum
    | CloneEnumEnum
    | CoAwaitEnumEnum
    | CoReturnEnumEnum
    | CoYieldEnumEnum
    | CodableEnumEnum
    | CodingKeyEnumEnum
    | CodingKeysEnumEnum
    | ComplEnumEnum
    | ConceptEnumEnum
    | ConsoleEnumEnum
    | ConstEnumEnum
    | ConstCastEnumEnum
    | ConstexprEnumEnum
    | ConstructorEnumEnum
    | ContinueEnumEnum
    | ConvenienceEnumEnum
    | ConvertEnumEnum
    | ConverterEnumEnum
    | CultureInfoEnumEnum
    | DateEnumEnum
    | DateParseHandlingEnumEnum
    | DateFormatterEnumEnum
    | DateOnlyEnumEnum
    | DateOnlyConverterEnumEnum
    | DateTimeEnumEnum
    | DateTimeStylesEnumEnum
    | DebuggerEnumEnum
    | DecimalEnumEnum
    | DeclareEnumEnum
    | DeserializationFeatureEnumEnum
    | DecltypeEnumEnum
    | DecodeStringEnumEnum
    | DecoderEnumEnum
    | DecodingErrorEnumEnum
    | DefEnumEnum
    | DefaultEnumEnum
    | DeferEnumEnum
    | DeinitEnumEnum
    | DelEnumEnum
    | DelegateEnumEnum
    | DeleteEnumEnum
    | DictEnumEnum
    | DictionaryEnumEnum
    | DidSetEnumEnum
    | DoEnumEnum
    | DoubleEnumEnum
    | DoubleNodeEnumEnum
    | DynamicEnumEnum
    | DynamicCastEnumEnum
    | ElifEnumEnum
    | ElseEnumEnum
    | EncodeQuickTypeEnumEnum
    | EncoderEnumEnum
    | EnumEnumEnum
    | EnumValuesEnumEnum
    | EquatableEnumEnum
    | EqualityContractEnumEnum
    | EventEnumEnum
    | ExceptEnumEnum
    | ExceptionEnumEnum
    | ExplicitEnumEnum
    | ExportEnumEnum
    | ExposingEnumEnum
    | ExtendsEnumEnum
    | ExtensionEnumEnum
    | ExternEnumEnum
    | FallthroughEnumEnum
    | FalseEnumEnum
    | PurpleFalseEnumEnum
    | FileprivateEnumEnum
    | FinalEnumEnum
    | FinallyEnumEnum
    | FixedEnumEnum
    | FloatEnumEnum
    | ForEnumEnum
    | ForeachEnumEnum
    | FormatExceptionEnumEnum
    | FriendEnumEnum
    | FromEnumEnum
    | FromDictEnumEnum
    | FromJSONEnumEnum
    | FuncEnumEnum
    | FunctionEnumEnum
    | GetEnumEnum
    | GlobalEnumEnum
    | GoEnumEnum
    | GotoEnumEnum
    | GuardEnumEnum
    | HashableEnumEnum
    | HashCodeEnumEnum
    | HasherEnumEnum
    | HasOwnPropertyEnumEnum
    | IDEnumEnum
    | IfEnumEnum
    | IMPEnumEnum
    | ImplementsEnumEnum
    | ImplicitEnumEnum
    | ImportEnumEnum
    | InEnumEnum
    | IndirectEnumEnum
    | InfixEnumEnum
    | InitEnumEnum
    | InlineEnumEnum
    | InoutEnumEnum
    | InstanceofEnumEnum
    | IntEnumEnum
    | IntNodeEnumEnum
    | InterfaceEnumEnum
    | InternalEnumEnum
    | ISODateTimeOffsetConverterEnumEnum
    | IterableEnumEnum
    | IsEnumEnum
    | JdecEnumEnum
    | JencEnumEnum
    | JpipeEnumEnum
    | JSONEnumEnum
    | JSONConverterEnumEnum
    | JSONSerializerEnumEnum
    | JSONTokenEnumEnum
    | JSONWriterEnumEnum
    | JSONAnyEnumEnum
    | JSONCodingKeyEnumEnum
    | JSONDecoderEnumEnum
    | JSONEncoderEnumEnum
    | JSONExceptionEnumEnum
    | JSONGeneratorEnumEnum
    | JSONNodeEnumEnum
    | JSONNullEnumEnum
    | JSONParserEnumEnum
    | JSONReaderEnumEnum
    | JSONTokenTypeEnumEnum
    | LambdaEnumEnum
    | LazyEnumEnum
    | LeftEnumEnum
    | LetEnumEnum
    | ListEnumEnum
    | LocalDateEnumEnum
    | LongNodeEnumEnum
    | LocaleEnumEnum
    | LockEnumEnum
    | LongEnumEnum
    | MapEnumEnum
    | MarshalJSONEnumEnum
    | MapEntryEnumEnum
    | MetadataPropertyHandlingEnumEnum
    | ModuleEnumEnum
    | MutableEnumEnum
    | MutatingEnumEnum
    | NamespaceEnumEnum
    | NativeEnumEnum
    | NewEnumEnum
    | NewtonsoftEnumEnum
    | NilEnumEnum
    | NullNodeEnumEnum
    | NOEnumEnum
    | NoexceptEnumEnum
    | NonatomicEnumEnum
    | NoneEnumEnum
    | PurpleNoneEnumEnum
    | NonlocalEnumEnum
    | NonmutatingEnumEnum
    | NSObjectEnumEnum
    | NoSuchMethodEnumEnum
    | NotEnumEnum
    | NotEqEnumEnum
    | NSErrorEnumEnum
    | NSStringEnumEnum
    | NULLEnumEnum
    | NullEnumEnum
    | NullptrEnumEnum
    | NumberEnumEnum
    | ObjectEnumEnum
    | OffsetDateTimeEnumEnum
    | OffsetTimeEnumEnum
    | ObjectNodeEnumEnum
    | ObjectMapperEnumEnum
    | ObjectReaderEnumEnum
    | ObjectWriterEnumEnum
    | OfEnumEnum
    | OnewayEnumEnum
    | OpenEnumEnum
    | OperatorEnumEnum
    | OptionalEnumEnum
    | OrEnumEnum
    | OrEqEnumEnum
    | OutEnumEnum
    | OverrideEnumEnum
    | PackageEnumEnum
    | ParamsEnumEnum
    | PassEnumEnum
    | PortEnumEnum
    | PostfixEnumEnum
    | PrecedenceEnumEnum
    | PrefixEnumEnum
    | PrintEnumEnum
    | PrintfEnumEnum
    | PrintMembersEnumEnum
    | PrivateEnumEnum
    | ProtectedEnumEnum
    | ProtocolEnumEnum
    | PurpleProtocolEnumEnum
    | PublicEnumEnum
    | QuicktypeEnumEnum
    | RaiseEnumEnum
    | RangeEnumEnum
    | ReadonlyEnumEnum
    | RefEnumEnum
    | RegExpEnumEnum
    | RegisterEnumEnum
    | ReinterpretCastEnumEnum
    | RepeatEnumEnum
    | RequireEnumEnum
    | RequiredEnumEnum
    | RequiresEnumEnum
    | RestrictEnumEnum
    | RetainEnumEnum
    | RethrowsEnumEnum
    | ReturnEnumEnum
    | RightEnumEnum
    | RuntimeTypeEnumEnum
    | SEnumEnum
    | SbyteEnumEnum
    | SealedEnumEnum
    | SELEnumEnum
    | SelectEnumEnum
    | SelfEnumEnum
    | SerializableEnumEnum
    | PurpleSelfEnumEnum
    | SendableEnumEnum
    | SerializeEnumEnum
    | SerialNameEnumEnum
    | KSerializerEnumEnum
    | PrimitiveKindEnumEnum
    | SerialDescriptorEnumEnum
    | SerializationFeatureEnumEnum
    | SerializerProviderEnumEnum
    | SetEnumEnum
    | ShortEnumEnum
    | SignedEnumEnum
    | SimpleModuleEnumEnum
    | SizeofEnumEnum
    | StackallocEnumEnum
    | StandardsEnumEnum
    | StaticEnumEnum
    | StaticAssertEnumEnum
    | StaticCastEnumEnum
    | StdDeserializerEnumEnum
    | StdSerializerEnumEnum
    | StrictfpEnumEnum
    | StringEnumEnum
    | StructEnumEnum
    | SubscriptEnumEnum
    | SuperEnumEnum
    | SwitchEnumEnum
    | SymbolEnumEnum
    | SynchronizedEnumEnum
    | SystemEnumEnum
    | TemplateEnumEnum
    | ThenEnumEnum
    | ThisEnumEnum
    | TextNodeEnumEnum
    | ThreadLocalEnumEnum
    | ThrowEnumEnum
    | ThrowsEnumEnum
    | TimeOnlyEnumEnum
    | TimeOnlyConverterEnumEnum
    | TimeZoneEnumEnum
    | ToJSONEnumEnum
    | TopLevelEnumEnum
    | ToStringEnumEnum
    | ToDictEnumEnum
    | TransientEnumEnum
    | TrueEnumEnum
    | PurpleTrueEnumEnum
    | TryEnumEnum
    | TypeEnumEnum
    | PurpleTypeEnumEnum
    | TypealiasEnumEnum
    | TypedefEnumEnum
    | TypeidEnumEnum
    | TypenameEnumEnum
    | TypeofEnumEnum
    | UintEnumEnum
    | UlongEnumEnum
    | UncheckedEnumEnum
    | UndefinedEnumEnum
    | UnionEnumEnum
    | UnmarshalJSONEnumEnum
    | UseSerializersEnumEnum
    | UnownedEnumEnum
    | UnsafeEnumEnum
    | UnsignedEnumEnum
    | UshortEnumEnum
    | UsingEnumEnum
    | Utf8JSONReaderEnumEnum
    | Utf8JSONWriterEnumEnum
    | UUIDEnumEnum
    | VarEnumEnum
    | VirtualEnumEnum
    | VoidEnumEnum
    | VolatileEnumEnum
    | WcharTEnumEnum
    | WeakEnumEnum
    | WhereEnumEnum
    | WhileEnumEnum
    | WillSetEnumEnum
    | WithEnumEnum
    | XorEnumEnum
    | XorEqEnumEnum
    | YESEnumEnum
    | YieldEnumEnum
    | DummyEnumEnum
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType enumQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("enum" .=) <$> enumQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "enum"

instance ToJSON EnumEnum where
    toJSON PurpleEnumEnum = "_"
    toJSON BoolEnumEnum = "_Bool"
    toJSON ComplexEnumEnum = "_Complex"
    toJSON ImagineryEnumEnum = "_Imaginery"
    toJSON AbstractEnumEnum = "abstract"
    toJSON AlignasEnumEnum = "alignas"
    toJSON AlignofEnumEnum = "alignof"
    toJSON AndEnumEnum = "and"
    toJSON AndEqEnumEnum = "and_eq"
    toJSON AnyEnumEnum = "any"
    toJSON PurpleAnyEnumEnum = "Any"
    toJSON ArrayNodeEnumEnum = "ArrayNode"
    toJSON ArrayEnumEnum = "array"
    toJSON AsEnumEnum = "as"
    toJSON ASMEnumEnum = "asm"
    toJSON AssertEnumEnum = "assert"
    toJSON AssociatedtypeEnumEnum = "associatedtype"
    toJSON AssociativityEnumEnum = "associativity"
    toJSON AsyncEnumEnum = "async"
    toJSON AtomicEnumEnum = "atomic"
    toJSON AtomicCancelEnumEnum = "atomic_cancel"
    toJSON AtomicCommitEnumEnum = "atomic_commit"
    toJSON AtomicNoexceptEnumEnum = "atomic_noexcept"
    toJSON AutoEnumEnum = "auto"
    toJSON AwaitEnumEnum = "await"
    toJSON BaseEnumEnum = "base"
    toJSON BitandEnumEnum = "bitand"
    toJSON BitorEnumEnum = "bitor"
    toJSON BOOLEnumEnum = "BOOL"
    toJSON PurpleBoolEnumEnum = "bool"
    toJSON BooleanEnumEnum = "boolean"
    toJSON BooleanNodeEnumEnum = "BooleanNode"
    toJSON BreakEnumEnum = "break"
    toJSON BycopyEnumEnum = "bycopy"
    toJSON ByrefEnumEnum = "byref"
    toJSON ByteEnumEnum = "byte"
    toJSON CalendarEnumEnum = "Calendar"
    toJSON CaseEnumEnum = "case"
    toJSON CatchEnumEnum = "catch"
    toJSON ChanEnumEnum = "chan"
    toJSON CharEnumEnum = "char"
    toJSON Char16TEnumEnum = "char16_t"
    toJSON Char32TEnumEnum = "char32_t"
    toJSON CheckedEnumEnum = "checked"
    toJSON ClassEnumEnum = "class"
    toJSON PurpleClassEnumEnum = "Class"
    toJSON CloneEnumEnum = "clone"
    toJSON CoAwaitEnumEnum = "co_await"
    toJSON CoReturnEnumEnum = "co_return"
    toJSON CoYieldEnumEnum = "co_yield"
    toJSON CodableEnumEnum = "Codable"
    toJSON CodingKeyEnumEnum = "CodingKey"
    toJSON CodingKeysEnumEnum = "CodingKeys"
    toJSON ComplEnumEnum = "compl"
    toJSON ConceptEnumEnum = "concept"
    toJSON ConsoleEnumEnum = "console"
    toJSON ConstEnumEnum = "const"
    toJSON ConstCastEnumEnum = "const_cast"
    toJSON ConstexprEnumEnum = "constexpr"
    toJSON ConstructorEnumEnum = "constructor"
    toJSON ContinueEnumEnum = "continue"
    toJSON ConvenienceEnumEnum = "convenience"
    toJSON ConvertEnumEnum = "convert"
    toJSON ConverterEnumEnum = "converter"
    toJSON CultureInfoEnumEnum = "CultureInfo"
    toJSON DateEnumEnum = "date"
    toJSON DateParseHandlingEnumEnum = "date_parse_handling"
    toJSON DateFormatterEnumEnum = "DateFormatter"
    toJSON DateOnlyEnumEnum = "DateOnly"
    toJSON DateOnlyConverterEnumEnum = "DateOnlyConverter"
    toJSON DateTimeEnumEnum = "DateTime"
    toJSON DateTimeStylesEnumEnum = "DateTimeStyles"
    toJSON DebuggerEnumEnum = "debugger"
    toJSON DecimalEnumEnum = "decimal"
    toJSON DeclareEnumEnum = "declare"
    toJSON DeserializationFeatureEnumEnum = "DeserializationFeature"
    toJSON DecltypeEnumEnum = "decltype"
    toJSON DecodeStringEnumEnum = "decode_string"
    toJSON DecoderEnumEnum = "Decoder"
    toJSON DecodingErrorEnumEnum = "DecodingError"
    toJSON DefEnumEnum = "def"
    toJSON DefaultEnumEnum = "default"
    toJSON DeferEnumEnum = "defer"
    toJSON DeinitEnumEnum = "deinit"
    toJSON DelEnumEnum = "del"
    toJSON DelegateEnumEnum = "delegate"
    toJSON DeleteEnumEnum = "delete"
    toJSON DictEnumEnum = "dict"
    toJSON DictionaryEnumEnum = "dictionary"
    toJSON DidSetEnumEnum = "didSet"
    toJSON DoEnumEnum = "do"
    toJSON DoubleEnumEnum = "double"
    toJSON DoubleNodeEnumEnum = "DoubleNode"
    toJSON DynamicEnumEnum = "dynamic"
    toJSON DynamicCastEnumEnum = "dynamic_cast"
    toJSON ElifEnumEnum = "elif"
    toJSON ElseEnumEnum = "else"
    toJSON EncodeQuickTypeEnumEnum = "encode_quick_type"
    toJSON EncoderEnumEnum = "Encoder"
    toJSON EnumEnumEnum = "enum"
    toJSON EnumValuesEnumEnum = "EnumValues"
    toJSON EquatableEnumEnum = "Equatable"
    toJSON EqualityContractEnumEnum = "equalityContract"
    toJSON EventEnumEnum = "event"
    toJSON ExceptEnumEnum = "except"
    toJSON ExceptionEnumEnum = "exception"
    toJSON ExplicitEnumEnum = "explicit"
    toJSON ExportEnumEnum = "export"
    toJSON ExposingEnumEnum = "exposing"
    toJSON ExtendsEnumEnum = "extends"
    toJSON ExtensionEnumEnum = "extension"
    toJSON ExternEnumEnum = "extern"
    toJSON FallthroughEnumEnum = "fallthrough"
    toJSON FalseEnumEnum = "false"
    toJSON PurpleFalseEnumEnum = "False"
    toJSON FileprivateEnumEnum = "fileprivate"
    toJSON FinalEnumEnum = "final"
    toJSON FinallyEnumEnum = "finally"
    toJSON FixedEnumEnum = "fixed"
    toJSON FloatEnumEnum = "float"
    toJSON ForEnumEnum = "for"
    toJSON ForeachEnumEnum = "foreach"
    toJSON FormatExceptionEnumEnum = "FormatException"
    toJSON FriendEnumEnum = "friend"
    toJSON FromEnumEnum = "from"
    toJSON FromDictEnumEnum = "from_dict"
    toJSON FromJSONEnumEnum = "from_json"
    toJSON FuncEnumEnum = "func"
    toJSON FunctionEnumEnum = "function"
    toJSON GetEnumEnum = "get"
    toJSON GlobalEnumEnum = "global"
    toJSON GoEnumEnum = "go"
    toJSON GotoEnumEnum = "goto"
    toJSON GuardEnumEnum = "guard"
    toJSON HashableEnumEnum = "Hashable"
    toJSON HashCodeEnumEnum = "hashCode"
    toJSON HasherEnumEnum = "Hasher"
    toJSON HasOwnPropertyEnumEnum = "hasOwnProperty"
    toJSON IDEnumEnum = "id"
    toJSON IfEnumEnum = "if"
    toJSON IMPEnumEnum = "IMP"
    toJSON ImplementsEnumEnum = "implements"
    toJSON ImplicitEnumEnum = "implicit"
    toJSON ImportEnumEnum = "import"
    toJSON InEnumEnum = "in"
    toJSON IndirectEnumEnum = "indirect"
    toJSON InfixEnumEnum = "infix"
    toJSON InitEnumEnum = "init"
    toJSON InlineEnumEnum = "inline"
    toJSON InoutEnumEnum = "inout"
    toJSON InstanceofEnumEnum = "instanceof"
    toJSON IntEnumEnum = "int"
    toJSON IntNodeEnumEnum = "IntNode"
    toJSON InterfaceEnumEnum = "interface"
    toJSON InternalEnumEnum = "internal"
    toJSON ISODateTimeOffsetConverterEnumEnum = "IsoDateTimeOffsetConverter"
    toJSON IterableEnumEnum = "iterable"
    toJSON IsEnumEnum = "is"
    toJSON JdecEnumEnum = "jdec"
    toJSON JencEnumEnum = "jenc"
    toJSON JpipeEnumEnum = "jpipe"
    toJSON JSONEnumEnum = "json"
    toJSON JSONConverterEnumEnum = "json_converter"
    toJSON JSONSerializerEnumEnum = "json_serializer"
    toJSON JSONTokenEnumEnum = "json_token"
    toJSON JSONWriterEnumEnum = "json_writer"
    toJSON JSONAnyEnumEnum = "JSONAny"
    toJSON JSONCodingKeyEnumEnum = "JSONCodingKey"
    toJSON JSONDecoderEnumEnum = "JSONDecoder"
    toJSON JSONEncoderEnumEnum = "JSONEncoder"
    toJSON JSONExceptionEnumEnum = "JsonException"
    toJSON JSONGeneratorEnumEnum = "JsonGenerator"
    toJSON JSONNodeEnumEnum = "JsonNode"
    toJSON JSONNullEnumEnum = "JSONNull"
    toJSON JSONParserEnumEnum = "JsonParser"
    toJSON JSONReaderEnumEnum = "JsonReader"
    toJSON JSONTokenTypeEnumEnum = "JsonTokenType"
    toJSON LambdaEnumEnum = "lambda"
    toJSON LazyEnumEnum = "lazy"
    toJSON LeftEnumEnum = "left"
    toJSON LetEnumEnum = "let"
    toJSON ListEnumEnum = "list"
    toJSON LocalDateEnumEnum = "LocalDate"
    toJSON LongNodeEnumEnum = "LongNode"
    toJSON LocaleEnumEnum = "Locale"
    toJSON LockEnumEnum = "lock"
    toJSON LongEnumEnum = "long"
    toJSON MapEnumEnum = "map"
    toJSON MarshalJSONEnumEnum = "MarshalJSON"
    toJSON MapEntryEnumEnum = "MapEntry"
    toJSON MetadataPropertyHandlingEnumEnum = "metadata_property_handling"
    toJSON ModuleEnumEnum = "module"
    toJSON MutableEnumEnum = "mutable"
    toJSON MutatingEnumEnum = "mutating"
    toJSON NamespaceEnumEnum = "namespace"
    toJSON NativeEnumEnum = "native"
    toJSON NewEnumEnum = "new"
    toJSON NewtonsoftEnumEnum = "newtonsoft"
    toJSON NilEnumEnum = "nil"
    toJSON NullNodeEnumEnum = "NullNode"
    toJSON NOEnumEnum = "NO"
    toJSON NoexceptEnumEnum = "noexcept"
    toJSON NonatomicEnumEnum = "nonatomic"
    toJSON NoneEnumEnum = "none"
    toJSON PurpleNoneEnumEnum = "None"
    toJSON NonlocalEnumEnum = "nonlocal"
    toJSON NonmutatingEnumEnum = "nonmutating"
    toJSON NSObjectEnumEnum = "NSObject"
    toJSON NoSuchMethodEnumEnum = "noSuchMethod"
    toJSON NotEnumEnum = "not"
    toJSON NotEqEnumEnum = "not_eq"
    toJSON NSErrorEnumEnum = "NSError"
    toJSON NSStringEnumEnum = "NSString"
    toJSON NULLEnumEnum = "NULL"
    toJSON NullEnumEnum = "null"
    toJSON NullptrEnumEnum = "nullptr"
    toJSON NumberEnumEnum = "number"
    toJSON ObjectEnumEnum = "object"
    toJSON OffsetDateTimeEnumEnum = "OffsetDateTime"
    toJSON OffsetTimeEnumEnum = "OffsetTime"
    toJSON ObjectNodeEnumEnum = "ObjectNode"
    toJSON ObjectMapperEnumEnum = "ObjectMapper"
    toJSON ObjectReaderEnumEnum = "ObjectReader"
    toJSON ObjectWriterEnumEnum = "ObjectWriter"
    toJSON OfEnumEnum = "of"
    toJSON OnewayEnumEnum = "oneway"
    toJSON OpenEnumEnum = "open"
    toJSON OperatorEnumEnum = "operator"
    toJSON OptionalEnumEnum = "optional"
    toJSON OrEnumEnum = "or"
    toJSON OrEqEnumEnum = "or_eq"
    toJSON OutEnumEnum = "out"
    toJSON OverrideEnumEnum = "override"
    toJSON PackageEnumEnum = "package"
    toJSON ParamsEnumEnum = "params"
    toJSON PassEnumEnum = "pass"
    toJSON PortEnumEnum = "port"
    toJSON PostfixEnumEnum = "postfix"
    toJSON PrecedenceEnumEnum = "precedence"
    toJSON PrefixEnumEnum = "prefix"
    toJSON PrintEnumEnum = "print"
    toJSON PrintfEnumEnum = "printf"
    toJSON PrintMembersEnumEnum = "printMembers"
    toJSON PrivateEnumEnum = "private"
    toJSON ProtectedEnumEnum = "protected"
    toJSON ProtocolEnumEnum = "Protocol"
    toJSON PurpleProtocolEnumEnum = "protocol"
    toJSON PublicEnumEnum = "public"
    toJSON QuicktypeEnumEnum = "quicktype"
    toJSON RaiseEnumEnum = "raise"
    toJSON RangeEnumEnum = "range"
    toJSON ReadonlyEnumEnum = "readonly"
    toJSON RefEnumEnum = "ref"
    toJSON RegExpEnumEnum = "RegExp"
    toJSON RegisterEnumEnum = "register"
    toJSON ReinterpretCastEnumEnum = "reinterpret_cast"
    toJSON RepeatEnumEnum = "repeat"
    toJSON RequireEnumEnum = "require"
    toJSON RequiredEnumEnum = "required"
    toJSON RequiresEnumEnum = "requires"
    toJSON RestrictEnumEnum = "restrict"
    toJSON RetainEnumEnum = "retain"
    toJSON RethrowsEnumEnum = "rethrows"
    toJSON ReturnEnumEnum = "return"
    toJSON RightEnumEnum = "right"
    toJSON RuntimeTypeEnumEnum = "runtimeType"
    toJSON SEnumEnum = "s"
    toJSON SbyteEnumEnum = "sbyte"
    toJSON SealedEnumEnum = "sealed"
    toJSON SELEnumEnum = "SEL"
    toJSON SelectEnumEnum = "select"
    toJSON SelfEnumEnum = "Self"
    toJSON SerializableEnumEnum = "Serializable"
    toJSON PurpleSelfEnumEnum = "self"
    toJSON SendableEnumEnum = "Sendable"
    toJSON SerializeEnumEnum = "serialize"
    toJSON SerialNameEnumEnum = "SerialName"
    toJSON KSerializerEnumEnum = "KSerializer"
    toJSON PrimitiveKindEnumEnum = "PrimitiveKind"
    toJSON SerialDescriptorEnumEnum = "SerialDescriptor"
    toJSON SerializationFeatureEnumEnum = "SerializationFeature"
    toJSON SerializerProviderEnumEnum = "SerializerProvider"
    toJSON SetEnumEnum = "set"
    toJSON ShortEnumEnum = "short"
    toJSON SignedEnumEnum = "signed"
    toJSON SimpleModuleEnumEnum = "SimpleModule"
    toJSON SizeofEnumEnum = "sizeof"
    toJSON StackallocEnumEnum = "stackalloc"
    toJSON StandardsEnumEnum = "Standards"
    toJSON StaticEnumEnum = "static"
    toJSON StaticAssertEnumEnum = "static_assert"
    toJSON StaticCastEnumEnum = "static_cast"
    toJSON StdDeserializerEnumEnum = "StdDeserializer"
    toJSON StdSerializerEnumEnum = "StdSerializer"
    toJSON StrictfpEnumEnum = "strictfp"
    toJSON StringEnumEnum = "string"
    toJSON StructEnumEnum = "struct"
    toJSON SubscriptEnumEnum = "subscript"
    toJSON SuperEnumEnum = "super"
    toJSON SwitchEnumEnum = "switch"
    toJSON SymbolEnumEnum = "symbol"
    toJSON SynchronizedEnumEnum = "synchronized"
    toJSON SystemEnumEnum = "system"
    toJSON TemplateEnumEnum = "template"
    toJSON ThenEnumEnum = "then"
    toJSON ThisEnumEnum = "this"
    toJSON TextNodeEnumEnum = "TextNode"
    toJSON ThreadLocalEnumEnum = "thread_local"
    toJSON ThrowEnumEnum = "throw"
    toJSON ThrowsEnumEnum = "throws"
    toJSON TimeOnlyEnumEnum = "TimeOnly"
    toJSON TimeOnlyConverterEnumEnum = "TimeOnlyConverter"
    toJSON TimeZoneEnumEnum = "TimeZone"
    toJSON ToJSONEnumEnum = "to_json"
    toJSON TopLevelEnumEnum = "top_level"
    toJSON ToStringEnumEnum = "toString"
    toJSON ToDictEnumEnum = "to_dict"
    toJSON TransientEnumEnum = "transient"
    toJSON TrueEnumEnum = "True"
    toJSON PurpleTrueEnumEnum = "true"
    toJSON TryEnumEnum = "try"
    toJSON TypeEnumEnum = "Type"
    toJSON PurpleTypeEnumEnum = "type"
    toJSON TypealiasEnumEnum = "typealias"
    toJSON TypedefEnumEnum = "typedef"
    toJSON TypeidEnumEnum = "typeid"
    toJSON TypenameEnumEnum = "typename"
    toJSON TypeofEnumEnum = "typeof"
    toJSON UintEnumEnum = "uint"
    toJSON UlongEnumEnum = "ulong"
    toJSON UncheckedEnumEnum = "unchecked"
    toJSON UndefinedEnumEnum = "undefined"
    toJSON UnionEnumEnum = "union"
    toJSON UnmarshalJSONEnumEnum = "UnmarshalJSON"
    toJSON UseSerializersEnumEnum = "UseSerializers"
    toJSON UnownedEnumEnum = "unowned"
    toJSON UnsafeEnumEnum = "unsafe"
    toJSON UnsignedEnumEnum = "unsigned"
    toJSON UshortEnumEnum = "ushort"
    toJSON UsingEnumEnum = "using"
    toJSON Utf8JSONReaderEnumEnum = "Utf8JsonReader"
    toJSON Utf8JSONWriterEnumEnum = "Utf8JsonWriter"
    toJSON UUIDEnumEnum = "UUID"
    toJSON VarEnumEnum = "var"
    toJSON VirtualEnumEnum = "virtual"
    toJSON VoidEnumEnum = "void"
    toJSON VolatileEnumEnum = "volatile"
    toJSON WcharTEnumEnum = "wchar_t"
    toJSON WeakEnumEnum = "weak"
    toJSON WhereEnumEnum = "where"
    toJSON WhileEnumEnum = "while"
    toJSON WillSetEnumEnum = "willSet"
    toJSON WithEnumEnum = "with"
    toJSON XorEnumEnum = "xor"
    toJSON XorEqEnumEnum = "xor_eq"
    toJSON YESEnumEnum = "YES"
    toJSON YieldEnumEnum = "yield"
    toJSON DummyEnumEnum = "dummy"

instance FromJSON EnumEnum where
    parseJSON = withText "EnumEnum" parseText
        where
            parseText "_" = return PurpleEnumEnum
            parseText "_Bool" = return BoolEnumEnum
            parseText "_Complex" = return ComplexEnumEnum
            parseText "_Imaginery" = return ImagineryEnumEnum
            parseText "abstract" = return AbstractEnumEnum
            parseText "alignas" = return AlignasEnumEnum
            parseText "alignof" = return AlignofEnumEnum
            parseText "and" = return AndEnumEnum
            parseText "and_eq" = return AndEqEnumEnum
            parseText "any" = return AnyEnumEnum
            parseText "Any" = return PurpleAnyEnumEnum
            parseText "ArrayNode" = return ArrayNodeEnumEnum
            parseText "array" = return ArrayEnumEnum
            parseText "as" = return AsEnumEnum
            parseText "asm" = return ASMEnumEnum
            parseText "assert" = return AssertEnumEnum
            parseText "associatedtype" = return AssociatedtypeEnumEnum
            parseText "associativity" = return AssociativityEnumEnum
            parseText "async" = return AsyncEnumEnum
            parseText "atomic" = return AtomicEnumEnum
            parseText "atomic_cancel" = return AtomicCancelEnumEnum
            parseText "atomic_commit" = return AtomicCommitEnumEnum
            parseText "atomic_noexcept" = return AtomicNoexceptEnumEnum
            parseText "auto" = return AutoEnumEnum
            parseText "await" = return AwaitEnumEnum
            parseText "base" = return BaseEnumEnum
            parseText "bitand" = return BitandEnumEnum
            parseText "bitor" = return BitorEnumEnum
            parseText "BOOL" = return BOOLEnumEnum
            parseText "bool" = return PurpleBoolEnumEnum
            parseText "boolean" = return BooleanEnumEnum
            parseText "BooleanNode" = return BooleanNodeEnumEnum
            parseText "break" = return BreakEnumEnum
            parseText "bycopy" = return BycopyEnumEnum
            parseText "byref" = return ByrefEnumEnum
            parseText "byte" = return ByteEnumEnum
            parseText "Calendar" = return CalendarEnumEnum
            parseText "case" = return CaseEnumEnum
            parseText "catch" = return CatchEnumEnum
            parseText "chan" = return ChanEnumEnum
            parseText "char" = return CharEnumEnum
            parseText "char16_t" = return Char16TEnumEnum
            parseText "char32_t" = return Char32TEnumEnum
            parseText "checked" = return CheckedEnumEnum
            parseText "class" = return ClassEnumEnum
            parseText "Class" = return PurpleClassEnumEnum
            parseText "clone" = return CloneEnumEnum
            parseText "co_await" = return CoAwaitEnumEnum
            parseText "co_return" = return CoReturnEnumEnum
            parseText "co_yield" = return CoYieldEnumEnum
            parseText "Codable" = return CodableEnumEnum
            parseText "CodingKey" = return CodingKeyEnumEnum
            parseText "CodingKeys" = return CodingKeysEnumEnum
            parseText "compl" = return ComplEnumEnum
            parseText "concept" = return ConceptEnumEnum
            parseText "console" = return ConsoleEnumEnum
            parseText "const" = return ConstEnumEnum
            parseText "const_cast" = return ConstCastEnumEnum
            parseText "constexpr" = return ConstexprEnumEnum
            parseText "constructor" = return ConstructorEnumEnum
            parseText "continue" = return ContinueEnumEnum
            parseText "convenience" = return ConvenienceEnumEnum
            parseText "convert" = return ConvertEnumEnum
            parseText "converter" = return ConverterEnumEnum
            parseText "CultureInfo" = return CultureInfoEnumEnum
            parseText "date" = return DateEnumEnum
            parseText "date_parse_handling" = return DateParseHandlingEnumEnum
            parseText "DateFormatter" = return DateFormatterEnumEnum
            parseText "DateOnly" = return DateOnlyEnumEnum
            parseText "DateOnlyConverter" = return DateOnlyConverterEnumEnum
            parseText "DateTime" = return DateTimeEnumEnum
            parseText "DateTimeStyles" = return DateTimeStylesEnumEnum
            parseText "debugger" = return DebuggerEnumEnum
            parseText "decimal" = return DecimalEnumEnum
            parseText "declare" = return DeclareEnumEnum
            parseText "DeserializationFeature" = return DeserializationFeatureEnumEnum
            parseText "decltype" = return DecltypeEnumEnum
            parseText "decode_string" = return DecodeStringEnumEnum
            parseText "Decoder" = return DecoderEnumEnum
            parseText "DecodingError" = return DecodingErrorEnumEnum
            parseText "def" = return DefEnumEnum
            parseText "default" = return DefaultEnumEnum
            parseText "defer" = return DeferEnumEnum
            parseText "deinit" = return DeinitEnumEnum
            parseText "del" = return DelEnumEnum
            parseText "delegate" = return DelegateEnumEnum
            parseText "delete" = return DeleteEnumEnum
            parseText "dict" = return DictEnumEnum
            parseText "dictionary" = return DictionaryEnumEnum
            parseText "didSet" = return DidSetEnumEnum
            parseText "do" = return DoEnumEnum
            parseText "double" = return DoubleEnumEnum
            parseText "DoubleNode" = return DoubleNodeEnumEnum
            parseText "dynamic" = return DynamicEnumEnum
            parseText "dynamic_cast" = return DynamicCastEnumEnum
            parseText "elif" = return ElifEnumEnum
            parseText "else" = return ElseEnumEnum
            parseText "encode_quick_type" = return EncodeQuickTypeEnumEnum
            parseText "Encoder" = return EncoderEnumEnum
            parseText "enum" = return EnumEnumEnum
            parseText "EnumValues" = return EnumValuesEnumEnum
            parseText "Equatable" = return EquatableEnumEnum
            parseText "equalityContract" = return EqualityContractEnumEnum
            parseText "event" = return EventEnumEnum
            parseText "except" = return ExceptEnumEnum
            parseText "exception" = return ExceptionEnumEnum
            parseText "explicit" = return ExplicitEnumEnum
            parseText "export" = return ExportEnumEnum
            parseText "exposing" = return ExposingEnumEnum
            parseText "extends" = return ExtendsEnumEnum
            parseText "extension" = return ExtensionEnumEnum
            parseText "extern" = return ExternEnumEnum
            parseText "fallthrough" = return FallthroughEnumEnum
            parseText "false" = return FalseEnumEnum
            parseText "False" = return PurpleFalseEnumEnum
            parseText "fileprivate" = return FileprivateEnumEnum
            parseText "final" = return FinalEnumEnum
            parseText "finally" = return FinallyEnumEnum
            parseText "fixed" = return FixedEnumEnum
            parseText "float" = return FloatEnumEnum
            parseText "for" = return ForEnumEnum
            parseText "foreach" = return ForeachEnumEnum
            parseText "FormatException" = return FormatExceptionEnumEnum
            parseText "friend" = return FriendEnumEnum
            parseText "from" = return FromEnumEnum
            parseText "from_dict" = return FromDictEnumEnum
            parseText "from_json" = return FromJSONEnumEnum
            parseText "func" = return FuncEnumEnum
            parseText "function" = return FunctionEnumEnum
            parseText "get" = return GetEnumEnum
            parseText "global" = return GlobalEnumEnum
            parseText "go" = return GoEnumEnum
            parseText "goto" = return GotoEnumEnum
            parseText "guard" = return GuardEnumEnum
            parseText "Hashable" = return HashableEnumEnum
            parseText "hashCode" = return HashCodeEnumEnum
            parseText "Hasher" = return HasherEnumEnum
            parseText "hasOwnProperty" = return HasOwnPropertyEnumEnum
            parseText "id" = return IDEnumEnum
            parseText "if" = return IfEnumEnum
            parseText "IMP" = return IMPEnumEnum
            parseText "implements" = return ImplementsEnumEnum
            parseText "implicit" = return ImplicitEnumEnum
            parseText "import" = return ImportEnumEnum
            parseText "in" = return InEnumEnum
            parseText "indirect" = return IndirectEnumEnum
            parseText "infix" = return InfixEnumEnum
            parseText "init" = return InitEnumEnum
            parseText "inline" = return InlineEnumEnum
            parseText "inout" = return InoutEnumEnum
            parseText "instanceof" = return InstanceofEnumEnum
            parseText "int" = return IntEnumEnum
            parseText "IntNode" = return IntNodeEnumEnum
            parseText "interface" = return InterfaceEnumEnum
            parseText "internal" = return InternalEnumEnum
            parseText "IsoDateTimeOffsetConverter" = return ISODateTimeOffsetConverterEnumEnum
            parseText "iterable" = return IterableEnumEnum
            parseText "is" = return IsEnumEnum
            parseText "jdec" = return JdecEnumEnum
            parseText "jenc" = return JencEnumEnum
            parseText "jpipe" = return JpipeEnumEnum
            parseText "json" = return JSONEnumEnum
            parseText "json_converter" = return JSONConverterEnumEnum
            parseText "json_serializer" = return JSONSerializerEnumEnum
            parseText "json_token" = return JSONTokenEnumEnum
            parseText "json_writer" = return JSONWriterEnumEnum
            parseText "JSONAny" = return JSONAnyEnumEnum
            parseText "JSONCodingKey" = return JSONCodingKeyEnumEnum
            parseText "JSONDecoder" = return JSONDecoderEnumEnum
            parseText "JSONEncoder" = return JSONEncoderEnumEnum
            parseText "JsonException" = return JSONExceptionEnumEnum
            parseText "JsonGenerator" = return JSONGeneratorEnumEnum
            parseText "JsonNode" = return JSONNodeEnumEnum
            parseText "JSONNull" = return JSONNullEnumEnum
            parseText "JsonParser" = return JSONParserEnumEnum
            parseText "JsonReader" = return JSONReaderEnumEnum
            parseText "JsonTokenType" = return JSONTokenTypeEnumEnum
            parseText "lambda" = return LambdaEnumEnum
            parseText "lazy" = return LazyEnumEnum
            parseText "left" = return LeftEnumEnum
            parseText "let" = return LetEnumEnum
            parseText "list" = return ListEnumEnum
            parseText "LocalDate" = return LocalDateEnumEnum
            parseText "LongNode" = return LongNodeEnumEnum
            parseText "Locale" = return LocaleEnumEnum
            parseText "lock" = return LockEnumEnum
            parseText "long" = return LongEnumEnum
            parseText "map" = return MapEnumEnum
            parseText "MarshalJSON" = return MarshalJSONEnumEnum
            parseText "MapEntry" = return MapEntryEnumEnum
            parseText "metadata_property_handling" = return MetadataPropertyHandlingEnumEnum
            parseText "module" = return ModuleEnumEnum
            parseText "mutable" = return MutableEnumEnum
            parseText "mutating" = return MutatingEnumEnum
            parseText "namespace" = return NamespaceEnumEnum
            parseText "native" = return NativeEnumEnum
            parseText "new" = return NewEnumEnum
            parseText "newtonsoft" = return NewtonsoftEnumEnum
            parseText "nil" = return NilEnumEnum
            parseText "NullNode" = return NullNodeEnumEnum
            parseText "NO" = return NOEnumEnum
            parseText "noexcept" = return NoexceptEnumEnum
            parseText "nonatomic" = return NonatomicEnumEnum
            parseText "none" = return NoneEnumEnum
            parseText "None" = return PurpleNoneEnumEnum
            parseText "nonlocal" = return NonlocalEnumEnum
            parseText "nonmutating" = return NonmutatingEnumEnum
            parseText "NSObject" = return NSObjectEnumEnum
            parseText "noSuchMethod" = return NoSuchMethodEnumEnum
            parseText "not" = return NotEnumEnum
            parseText "not_eq" = return NotEqEnumEnum
            parseText "NSError" = return NSErrorEnumEnum
            parseText "NSString" = return NSStringEnumEnum
            parseText "NULL" = return NULLEnumEnum
            parseText "null" = return NullEnumEnum
            parseText "nullptr" = return NullptrEnumEnum
            parseText "number" = return NumberEnumEnum
            parseText "object" = return ObjectEnumEnum
            parseText "OffsetDateTime" = return OffsetDateTimeEnumEnum
            parseText "OffsetTime" = return OffsetTimeEnumEnum
            parseText "ObjectNode" = return ObjectNodeEnumEnum
            parseText "ObjectMapper" = return ObjectMapperEnumEnum
            parseText "ObjectReader" = return ObjectReaderEnumEnum
            parseText "ObjectWriter" = return ObjectWriterEnumEnum
            parseText "of" = return OfEnumEnum
            parseText "oneway" = return OnewayEnumEnum
            parseText "open" = return OpenEnumEnum
            parseText "operator" = return OperatorEnumEnum
            parseText "optional" = return OptionalEnumEnum
            parseText "or" = return OrEnumEnum
            parseText "or_eq" = return OrEqEnumEnum
            parseText "out" = return OutEnumEnum
            parseText "override" = return OverrideEnumEnum
            parseText "package" = return PackageEnumEnum
            parseText "params" = return ParamsEnumEnum
            parseText "pass" = return PassEnumEnum
            parseText "port" = return PortEnumEnum
            parseText "postfix" = return PostfixEnumEnum
            parseText "precedence" = return PrecedenceEnumEnum
            parseText "prefix" = return PrefixEnumEnum
            parseText "print" = return PrintEnumEnum
            parseText "printf" = return PrintfEnumEnum
            parseText "printMembers" = return PrintMembersEnumEnum
            parseText "private" = return PrivateEnumEnum
            parseText "protected" = return ProtectedEnumEnum
            parseText "Protocol" = return ProtocolEnumEnum
            parseText "protocol" = return PurpleProtocolEnumEnum
            parseText "public" = return PublicEnumEnum
            parseText "quicktype" = return QuicktypeEnumEnum
            parseText "raise" = return RaiseEnumEnum
            parseText "range" = return RangeEnumEnum
            parseText "readonly" = return ReadonlyEnumEnum
            parseText "ref" = return RefEnumEnum
            parseText "RegExp" = return RegExpEnumEnum
            parseText "register" = return RegisterEnumEnum
            parseText "reinterpret_cast" = return ReinterpretCastEnumEnum
            parseText "repeat" = return RepeatEnumEnum
            parseText "require" = return RequireEnumEnum
            parseText "required" = return RequiredEnumEnum
            parseText "requires" = return RequiresEnumEnum
            parseText "restrict" = return RestrictEnumEnum
            parseText "retain" = return RetainEnumEnum
            parseText "rethrows" = return RethrowsEnumEnum
            parseText "return" = return ReturnEnumEnum
            parseText "right" = return RightEnumEnum
            parseText "runtimeType" = return RuntimeTypeEnumEnum
            parseText "s" = return SEnumEnum
            parseText "sbyte" = return SbyteEnumEnum
            parseText "sealed" = return SealedEnumEnum
            parseText "SEL" = return SELEnumEnum
            parseText "select" = return SelectEnumEnum
            parseText "Self" = return SelfEnumEnum
            parseText "Serializable" = return SerializableEnumEnum
            parseText "self" = return PurpleSelfEnumEnum
            parseText "Sendable" = return SendableEnumEnum
            parseText "serialize" = return SerializeEnumEnum
            parseText "SerialName" = return SerialNameEnumEnum
            parseText "KSerializer" = return KSerializerEnumEnum
            parseText "PrimitiveKind" = return PrimitiveKindEnumEnum
            parseText "SerialDescriptor" = return SerialDescriptorEnumEnum
            parseText "SerializationFeature" = return SerializationFeatureEnumEnum
            parseText "SerializerProvider" = return SerializerProviderEnumEnum
            parseText "set" = return SetEnumEnum
            parseText "short" = return ShortEnumEnum
            parseText "signed" = return SignedEnumEnum
            parseText "SimpleModule" = return SimpleModuleEnumEnum
            parseText "sizeof" = return SizeofEnumEnum
            parseText "stackalloc" = return StackallocEnumEnum
            parseText "Standards" = return StandardsEnumEnum
            parseText "static" = return StaticEnumEnum
            parseText "static_assert" = return StaticAssertEnumEnum
            parseText "static_cast" = return StaticCastEnumEnum
            parseText "StdDeserializer" = return StdDeserializerEnumEnum
            parseText "StdSerializer" = return StdSerializerEnumEnum
            parseText "strictfp" = return StrictfpEnumEnum
            parseText "string" = return StringEnumEnum
            parseText "struct" = return StructEnumEnum
            parseText "subscript" = return SubscriptEnumEnum
            parseText "super" = return SuperEnumEnum
            parseText "switch" = return SwitchEnumEnum
            parseText "symbol" = return SymbolEnumEnum
            parseText "synchronized" = return SynchronizedEnumEnum
            parseText "system" = return SystemEnumEnum
            parseText "template" = return TemplateEnumEnum
            parseText "then" = return ThenEnumEnum
            parseText "this" = return ThisEnumEnum
            parseText "TextNode" = return TextNodeEnumEnum
            parseText "thread_local" = return ThreadLocalEnumEnum
            parseText "throw" = return ThrowEnumEnum
            parseText "throws" = return ThrowsEnumEnum
            parseText "TimeOnly" = return TimeOnlyEnumEnum
            parseText "TimeOnlyConverter" = return TimeOnlyConverterEnumEnum
            parseText "TimeZone" = return TimeZoneEnumEnum
            parseText "to_json" = return ToJSONEnumEnum
            parseText "top_level" = return TopLevelEnumEnum
            parseText "toString" = return ToStringEnumEnum
            parseText "to_dict" = return ToDictEnumEnum
            parseText "transient" = return TransientEnumEnum
            parseText "True" = return TrueEnumEnum
            parseText "true" = return PurpleTrueEnumEnum
            parseText "try" = return TryEnumEnum
            parseText "Type" = return TypeEnumEnum
            parseText "type" = return PurpleTypeEnumEnum
            parseText "typealias" = return TypealiasEnumEnum
            parseText "typedef" = return TypedefEnumEnum
            parseText "typeid" = return TypeidEnumEnum
            parseText "typename" = return TypenameEnumEnum
            parseText "typeof" = return TypeofEnumEnum
            parseText "uint" = return UintEnumEnum
            parseText "ulong" = return UlongEnumEnum
            parseText "unchecked" = return UncheckedEnumEnum
            parseText "undefined" = return UndefinedEnumEnum
            parseText "union" = return UnionEnumEnum
            parseText "UnmarshalJSON" = return UnmarshalJSONEnumEnum
            parseText "UseSerializers" = return UseSerializersEnumEnum
            parseText "unowned" = return UnownedEnumEnum
            parseText "unsafe" = return UnsafeEnumEnum
            parseText "unsigned" = return UnsignedEnumEnum
            parseText "ushort" = return UshortEnumEnum
            parseText "using" = return UsingEnumEnum
            parseText "Utf8JsonReader" = return Utf8JSONReaderEnumEnum
            parseText "Utf8JsonWriter" = return Utf8JSONWriterEnumEnum
            parseText "UUID" = return UUIDEnumEnum
            parseText "var" = return VarEnumEnum
            parseText "virtual" = return VirtualEnumEnum
            parseText "void" = return VoidEnumEnum
            parseText "volatile" = return VolatileEnumEnum
            parseText "wchar_t" = return WcharTEnumEnum
            parseText "weak" = return WeakEnumEnum
            parseText "where" = return WhereEnumEnum
            parseText "while" = return WhileEnumEnum
            parseText "willSet" = return WillSetEnumEnum
            parseText "with" = return WithEnumEnum
            parseText "xor" = return XorEnumEnum
            parseText "xor_eq" = return XorEqEnumEnum
            parseText "YES" = return YESEnumEnum
            parseText "yield" = return YieldEnumEnum
            parseText "dummy" = return DummyEnumEnum
