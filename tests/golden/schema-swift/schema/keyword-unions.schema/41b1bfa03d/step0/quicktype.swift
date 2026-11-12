// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let empty: UnionUnion?
    let topLevelBool: UnionBool?
    let complex: UnionComplex?
    let imaginery: UnionImaginery?
    let abstract: UnionAbstract?
    let alignas: UnionAlignas?
    let alignof: UnionAlignof?
    let and: UnionAnd?
    let andEq: UnionAndEq?
    let topLevelAny: UnionAnyUnion?
    let any: UnionAny?
    let array: UnionArray?
    let arrayNode: UnionArrayNode?
    let topLevelAs: UnionAs?
    let asm: UnionASM?
    let assert: UnionAssert?
    let topLevelAssociatedtype: UnionAssociatedtype?
    let topLevelAssociativity: UnionAssociativity?
    let async: UnionAsync?
    let atomic: UnionAtomic?
    let atomicCancel: UnionAtomicCancel?
    let atomicCommit: UnionAtomicCommit?
    let atomicNoexcept: UnionAtomicNoexcept?
    let auto: UnionAuto?
    let topLevelAwait: UnionAwait?
    let base: UnionBase?
    let bitand: UnionBitand?
    let bitor: UnionBitor?
    let bool: UnionBOOL?
    let purpleBool: UnionBoolUnion?
    let boolean: UnionBoolean?
    let booleanNode: UnionBooleanNode?
    let topLevelBreak: UnionBreak?
    let bycopy: UnionBycopy?
    let byref: UnionByref?
    let byte: UnionByte?
    let calendar: UnionCalendar?
    let topLevelCase: UnionCase?
    let topLevelCatch: UnionCatch?
    let chan: UnionChan?
    let char: UnionChar?
    let char16T: UnionChar16T?
    let char32T: UnionChar32T?
    let checked: UnionChecked?
    let purpleClass: UnionClassUnion?
    let topLevelClass: UnionClass?
    let clone: UnionClone?
    let coAwait: UnionCoAwait?
    let coReturn: UnionCoReturn?
    let coYield: UnionCoYield?
    let codable: UnionCodable?
    let codingKey: UnionCodingKey?
    let codingKeys: UnionCodingKeys?
    let compl: UnionCompl?
    let concept: UnionConcept?
    let console: UnionConsole?
    let const: UnionConst?
    let constCast: UnionConstCast?
    let constexpr: UnionConstexpr?
    let constructor: UnionConstructor?
    let topLevelContinue: UnionContinue?
    let topLevelConvenience: UnionConvenience?
    let convert: UnionConvert?
    let converter: UnionConverter?
    let cultureInfo: UnionCultureInfo?
    let date: UnionDate?
    let dateParseHandling: UnionDateParseHandling?
    let dateFormatter: UnionDateFormatter?
    let dateOnly: UnionDateOnly?
    let dateOnlyConverter: UnionDateOnlyConverter?
    let dateTime: UnionDateTime?
    let dateTimeStyles: UnionDateTimeStyles?
    let debugger: UnionDebugger?
    let decimal: UnionDecimal?
    let declare: UnionDeclare?
    let decltype: UnionDecltype?
    let decodeString: UnionDecodeString?
    let decoder: UnionDecoder?
    let decodingError: UnionDecodingError?
    let def: UnionDef?
    let topLevelDefault: UnionDefault?
    let topLevelDefer: UnionDefer?
    let topLevelDeinit: UnionDeinit?
    let del: UnionDel?
    let delegate: UnionDelegate?
    let delete: UnionDelete?
    let deserializationFeature: UnionDeserializationFeature?
    let dict: UnionDict?
    let dictionary: UnionDictionary?
    let topLevelDidSet: UnionDidSet?
    let topLevelDo: UnionDo?
    let double: UnionDouble?
    let doubleNode: UnionDoubleNode?
    let dummy: Double?
    let topLevelDynamic: UnionDynamic?
    let dynamicCast: UnionDynamicCast?
    let elif: UnionElif?
    let topLevelElse: UnionElse?
    let encodeQuickType: UnionEncodeQuickType?
    let encoder: UnionEncoder?
    let topLevelEnum: UnionEnum?
    let enumValues: UnionEnumValues?
    let equalityContract: UnionEqualityContract?
    let equatable: UnionEquatable?
    let event: UnionEvent?
    let except: UnionExcept?
    let exception: UnionException?
    let explicit: UnionExplicit?
    let export: UnionExport?
    let exposing: UnionExposing?
    let extends: UnionExtends?
    let topLevelExtension: UnionExtension?
    let extern: UnionExtern?
    let topLevelFallthrough: UnionFallthrough?
    let purpleFalse: UnionFalseUnion?
    let topLevelFalse: UnionFalse?
    let topLevelFileprivate: UnionFileprivate?
    let topLevelFinal: UnionFinal?
    let finally: UnionFinally?
    let fixed: UnionFixed?
    let float: UnionFloat?
    let topLevelFor: UnionFor?
    let foreach: UnionForeach?
    let formatException: UnionFormatException?
    let friend: UnionFriend?
    let from: UnionFrom?
    let fromDict: UnionFromDict?
    let fromJSON: UnionFromJSON?
    let topLevelFunc: UnionFunc?
    let function: UnionFunction?
    let topLevelGet: UnionGet?
    let global: UnionGlobal?
    let go: UnionGo?
    let goto: UnionGoto?
    let topLevelGuard: UnionGuard?
    let hashable: UnionHashable?
    let hashCode: UnionHashCode?
    let hasher: UnionHasher?
    let hasOwnProperty: UnionHasOwnProperty?
    let id: UnionID?
    let topLevelIf: UnionIf?
    let imp: UnionIMP?
    let implements: UnionImplements?
    let implicit: UnionImplicit?
    let topLevelImport: UnionImport?
    let topLevelIn: UnionIn?
    let topLevelIndirect: UnionIndirect?
    let topLevelInfix: UnionInfix?
    let topLevelInit: UnionInit?
    let inline: UnionInline?
    let topLevelInout: UnionInout?
    let instanceof: UnionInstanceof?
    let int: UnionInt?
    let interface: UnionInterface?
    let topLevelInternal: UnionInternal?
    let intNode: UnionIntNode?
    let topLevelIs: UnionIs?
    let isoDateTimeOffsetConverter: UnionISODateTimeOffsetConverter?
    let iterable: UnionIterable?
    let jdec: UnionJdec?
    let jenc: UnionJenc?
    let jpipe: UnionJpipe?
    let topLevelJSON: UnionJSON?
    let jsonConverter: UnionJSONConverter?
    let jsonSerializer: UnionJSONSerializer?
    let jsonToken: UnionJSONToken?
    let jsonWriter: UnionJSONWriter?
    let jsonAny: UnionJSONAny?
    let jsonCodingKey: UnionJSONCodingKey?
    let jsonDecoder: UnionJSONDecoder?
    let jsonEncoder: UnionJSONEncoder?
    let jsonException: UnionJSONException?
    let jsonGenerator: UnionJSONGenerator?
    let jsonNode: UnionJSONNode?
    let jsonNull: UnionJSONNull?
    let jsonParser: UnionJSONParser?
    let jsonReader: UnionJSONReader?
    let jsonTokenType: UnionJSONTokenType?
    let kSerializer: UnionKSerializer?
    let lambda: UnionLambda?
    let topLevelLazy: UnionLazy?
    let topLevelLeft: UnionLeft?
    let topLevelLet: UnionLet?
    let list: UnionList?
    let localDate: UnionLocalDate?
    let locale: UnionLocale?
    let lock: UnionLock?
    let long: UnionLong?
    let longNode: UnionLongNode?
    let map: UnionMap?
    let mapEntry: UnionMapEntry?
    let marshalJSON: UnionMarshalJSON?
    let metadataPropertyHandling: UnionMetadataPropertyHandling?
    let module: UnionModule?
    let mutable: UnionMutable?
    let topLevelMutating: UnionMutating?
    let namespace: UnionNamespace?
    let native: UnionNative?
    let new: UnionNew?
    let newtonsoft: UnionNewtonsoft?
    let topLevelNil: UnionNil?
    let no: UnionNO?
    let noexcept: UnionNoexcept?
    let nonatomic: UnionNonatomic?
    let topLevelNone: UnionNoneUnion?
    let none: UnionNone?
    let nonlocal: UnionNonlocal?
    let topLevelNonmutating: UnionNonmutating?
    let noSuchMethod: UnionNoSuchMethod?
    let not: UnionNot?
    let notEq: UnionNotEq?
    let nsError: UnionNSError?
    let nsObject: UnionNSObject?
    let nsString: UnionNSString?
    let null: UnionNULL?
    let topLevelNull: UnionNull?
    let nullNode: UnionNullNode?
    let nullptr: UnionNullptr?
    let number: UnionNumber?
    let object: UnionObject?
    let objectMapper: UnionObjectMapper?
    let objectNode: UnionObjectNode?
    let objectReader: UnionObjectReader?
    let objectWriter: UnionObjectWriter?
    let of: UnionOf?
    let offsetDateTime: UnionOffsetDateTime?
    let offsetTime: UnionOffsetTime?
    let oneway: UnionOneway?
    let topLevelOpen: UnionOpen?
    let topLevelOperator: UnionOperator?
    let topLevelOptional: UnionOptional?
    let or: UnionOr?
    let orEq: UnionOrEq?
    let out: UnionOut?
    let topLevelOverride: UnionOverride?
    let package: UnionPackage?
    let params: UnionParams?
    let pass: UnionPass?
    let port: UnionPort?
    let topLevelPostfix: UnionPostfix?
    let topLevelPrecedence: UnionPrecedence?
    let topLevelPrefix: UnionPrefix?
    let primitiveKind: UnionPrimitiveKind?
    let print: UnionPrint?
    let printf: UnionPrintf?
    let printMembers: UnionPrintMembers?
    let topLevelPrivate: UnionPrivate?
    let protected: UnionProtected?
    let topLevelProtocol: UnionProtocol?
    let purpleProtocol: UnionProtocolUnion?
    let topLevelPublic: UnionPublic?
    let quicktype: UnionQuicktype?
    let raise: UnionRaise?
    let range: UnionRange?
    let readonly: UnionReadonly?
    let ref: UnionRef?
    let regExp: UnionRegExp?
    let register: UnionRegister?
    let reinterpretCast: UnionReinterpretCast?
    let topLevelRepeat: UnionRepeat?
    let require: UnionRequire?
    let topLevelRequired: UnionRequired?
    let requires: UnionRequires?
    let restrict: UnionRestrict?
    let retain: UnionRetain?
    let topLevelRethrows: UnionRethrows?
    let topLevelReturn: UnionReturn?
    let topLevelRight: UnionRight?
    let runtimeType: UnionRuntimeType?
    let s: UnionS?
    let sbyte: UnionSbyte?
    let sealed: UnionSealed?
    let sel: UnionSEL?
    let select: UnionSelect?
    let topLevelSelf: UnionSelf?
    let purpleSelf: UnionSelfUnion?
    let sendable: UnionSendable?
    let serialDescriptor: UnionSerialDescriptor?
    let serializable: UnionSerializable?
    let serializationFeature: UnionSerializationFeature?
    let serialize: UnionSerialize?
    let serializerProvider: UnionSerializerProvider?
    let serialName: UnionSerialName?
    let topLevelSet: UnionSet?
    let short: UnionShort?
    let signed: UnionSigned?
    let simpleModule: UnionSimpleModule?
    let sizeof: UnionSizeof?
    let stackalloc: UnionStackalloc?
    let standards: UnionStandards?
    let topLevelStatic: UnionStatic?
    let staticAssert: UnionStaticAssert?
    let staticCast: UnionStaticCast?
    let stdDeserializer: UnionStdDeserializer?
    let stdSerializer: UnionStdSerializer?
    let strictfp: UnionStrictfp?
    let string: UnionString?
    let topLevelStruct: UnionStruct?
    let topLevelSubscript: UnionSubscript?
    let topLevelSuper: UnionSuper?
    let topLevelSwitch: UnionSwitch?
    let symbol: UnionSymbol?
    let synchronized: UnionSynchronized?
    let system: UnionSystem?
    let template: UnionTemplate?
    let textNode: UnionTextNode?
    let then: UnionThen?
    let this: UnionThis?
    let threadLocal: UnionThreadLocal?
    let topLevelThrow: UnionThrow?
    let topLevelThrows: UnionThrows?
    let timeOnly: UnionTimeOnly?
    let timeOnlyConverter: UnionTimeOnlyConverter?
    let timeZone: UnionTimeZone?
    let toDict: UnionToDict?
    let toJSON: UnionToJSON?
    let topLevel: UnionTopLevel?
    let toString: UnionToString?
    let transient: UnionTransient?
    let topLevelTrue: UnionTrue?
    let purpleTrue: UnionTrueUnion?
    let topLevelTry: UnionTry?
    let type: UnionType?
    let topLevelType: UnionTypeUnion?
    let topLevelTypealias: UnionTypealias?
    let typedef: UnionTypedef?
    let typeid: UnionTypeid?
    let typename: UnionTypename?
    let typeof: UnionTypeof?
    let uint: UnionUint?
    let ulong: UnionUlong?
    let unchecked: UnionUnchecked?
    let undefined: UnionUndefined?
    let union: UnionUnionUnion?
    let unmarshalJSON: UnionUnmarshalJSON?
    let topLevelUnowned: UnionUnowned?
    let unsafe: UnionUnsafe?
    let unsigned: UnionUnsigned?
    let useSerializers: UnionUseSerializers?
    let ushort: UnionUshort?
    let using: UnionUsing?
    let utf8JSONReader: UnionUtf8JSONReader?
    let utf8JSONWriter: UnionUtf8JSONWriter?
    let uuid: UnionUUID?
    let topLevelVar: UnionVar?
    let virtual: UnionVirtual?
    let void: UnionVoid?
    let volatile: UnionVolatile?
    let wcharT: UnionWcharT?
    let topLevelWeak: UnionWeak?
    let topLevelWhere: UnionWhere?
    let topLevelWhile: UnionWhile?
    let topLevelWillSet: UnionWillSet?
    let with: UnionWith?
    let xor: UnionXor?
    let xorEq: UnionXorEq?
    let yes: UnionYES?
    let yield: UnionYield?

    enum CodingKeys: String, CodingKey {
        case empty = "_"
        case topLevelBool = "_Bool"
        case complex = "_Complex"
        case imaginery = "_Imaginery"
        case abstract = "abstract"
        case alignas = "alignas"
        case alignof = "alignof"
        case and = "and"
        case andEq = "and_eq"
        case topLevelAny = "any"
        case any = "Any"
        case array = "array"
        case arrayNode = "ArrayNode"
        case topLevelAs = "as"
        case asm = "asm"
        case assert = "assert"
        case topLevelAssociatedtype = "associatedtype"
        case topLevelAssociativity = "associativity"
        case async = "async"
        case atomic = "atomic"
        case atomicCancel = "atomic_cancel"
        case atomicCommit = "atomic_commit"
        case atomicNoexcept = "atomic_noexcept"
        case auto = "auto"
        case topLevelAwait = "await"
        case base = "base"
        case bitand = "bitand"
        case bitor = "bitor"
        case bool = "BOOL"
        case purpleBool = "bool"
        case boolean = "boolean"
        case booleanNode = "BooleanNode"
        case topLevelBreak = "break"
        case bycopy = "bycopy"
        case byref = "byref"
        case byte = "byte"
        case calendar = "Calendar"
        case topLevelCase = "case"
        case topLevelCatch = "catch"
        case chan = "chan"
        case char = "char"
        case char16T = "char16_t"
        case char32T = "char32_t"
        case checked = "checked"
        case purpleClass = "class"
        case topLevelClass = "Class"
        case clone = "clone"
        case coAwait = "co_await"
        case coReturn = "co_return"
        case coYield = "co_yield"
        case codable = "Codable"
        case codingKey = "CodingKey"
        case codingKeys = "CodingKeys"
        case compl = "compl"
        case concept = "concept"
        case console = "console"
        case const = "const"
        case constCast = "const_cast"
        case constexpr = "constexpr"
        case constructor = "constructor"
        case topLevelContinue = "continue"
        case topLevelConvenience = "convenience"
        case convert = "convert"
        case converter = "converter"
        case cultureInfo = "CultureInfo"
        case date = "date"
        case dateParseHandling = "date_parse_handling"
        case dateFormatter = "DateFormatter"
        case dateOnly = "DateOnly"
        case dateOnlyConverter = "DateOnlyConverter"
        case dateTime = "DateTime"
        case dateTimeStyles = "DateTimeStyles"
        case debugger = "debugger"
        case decimal = "decimal"
        case declare = "declare"
        case decltype = "decltype"
        case decodeString = "decode_string"
        case decoder = "Decoder"
        case decodingError = "DecodingError"
        case def = "def"
        case topLevelDefault = "default"
        case topLevelDefer = "defer"
        case topLevelDeinit = "deinit"
        case del = "del"
        case delegate = "delegate"
        case delete = "delete"
        case deserializationFeature = "DeserializationFeature"
        case dict = "dict"
        case dictionary = "dictionary"
        case topLevelDidSet = "didSet"
        case topLevelDo = "do"
        case double = "double"
        case doubleNode = "DoubleNode"
        case dummy = "dummy"
        case topLevelDynamic = "dynamic"
        case dynamicCast = "dynamic_cast"
        case elif = "elif"
        case topLevelElse = "else"
        case encodeQuickType = "encode_quick_type"
        case encoder = "Encoder"
        case topLevelEnum = "enum"
        case enumValues = "EnumValues"
        case equalityContract = "equalityContract"
        case equatable = "Equatable"
        case event = "event"
        case except = "except"
        case exception = "exception"
        case explicit = "explicit"
        case export = "export"
        case exposing = "exposing"
        case extends = "extends"
        case topLevelExtension = "extension"
        case extern = "extern"
        case topLevelFallthrough = "fallthrough"
        case purpleFalse = "false"
        case topLevelFalse = "False"
        case topLevelFileprivate = "fileprivate"
        case topLevelFinal = "final"
        case finally = "finally"
        case fixed = "fixed"
        case float = "float"
        case topLevelFor = "for"
        case foreach = "foreach"
        case formatException = "FormatException"
        case friend = "friend"
        case from = "from"
        case fromDict = "from_dict"
        case fromJSON = "from_json"
        case topLevelFunc = "func"
        case function = "function"
        case topLevelGet = "get"
        case global = "global"
        case go = "go"
        case goto = "goto"
        case topLevelGuard = "guard"
        case hashable = "Hashable"
        case hashCode = "hashCode"
        case hasher = "Hasher"
        case hasOwnProperty = "hasOwnProperty"
        case id = "id"
        case topLevelIf = "if"
        case imp = "IMP"
        case implements = "implements"
        case implicit = "implicit"
        case topLevelImport = "import"
        case topLevelIn = "in"
        case topLevelIndirect = "indirect"
        case topLevelInfix = "infix"
        case topLevelInit = "init"
        case inline = "inline"
        case topLevelInout = "inout"
        case instanceof = "instanceof"
        case int = "int"
        case interface = "interface"
        case topLevelInternal = "internal"
        case intNode = "IntNode"
        case topLevelIs = "is"
        case isoDateTimeOffsetConverter = "IsoDateTimeOffsetConverter"
        case iterable = "iterable"
        case jdec = "jdec"
        case jenc = "jenc"
        case jpipe = "jpipe"
        case topLevelJSON = "json"
        case jsonConverter = "json_converter"
        case jsonSerializer = "json_serializer"
        case jsonToken = "json_token"
        case jsonWriter = "json_writer"
        case jsonAny = "JSONAny"
        case jsonCodingKey = "JSONCodingKey"
        case jsonDecoder = "JSONDecoder"
        case jsonEncoder = "JSONEncoder"
        case jsonException = "JsonException"
        case jsonGenerator = "JsonGenerator"
        case jsonNode = "JsonNode"
        case jsonNull = "JSONNull"
        case jsonParser = "JsonParser"
        case jsonReader = "JsonReader"
        case jsonTokenType = "JsonTokenType"
        case kSerializer = "KSerializer"
        case lambda = "lambda"
        case topLevelLazy = "lazy"
        case topLevelLeft = "left"
        case topLevelLet = "let"
        case list = "list"
        case localDate = "LocalDate"
        case locale = "Locale"
        case lock = "lock"
        case long = "long"
        case longNode = "LongNode"
        case map = "map"
        case mapEntry = "MapEntry"
        case marshalJSON = "MarshalJSON"
        case metadataPropertyHandling = "metadata_property_handling"
        case module = "module"
        case mutable = "mutable"
        case topLevelMutating = "mutating"
        case namespace = "namespace"
        case native = "native"
        case new = "new"
        case newtonsoft = "newtonsoft"
        case topLevelNil = "nil"
        case no = "NO"
        case noexcept = "noexcept"
        case nonatomic = "nonatomic"
        case topLevelNone = "none"
        case none = "None"
        case nonlocal = "nonlocal"
        case topLevelNonmutating = "nonmutating"
        case noSuchMethod = "noSuchMethod"
        case not = "not"
        case notEq = "not_eq"
        case nsError = "NSError"
        case nsObject = "NSObject"
        case nsString = "NSString"
        case null = "NULL"
        case topLevelNull = "null"
        case nullNode = "NullNode"
        case nullptr = "nullptr"
        case number = "number"
        case object = "object"
        case objectMapper = "ObjectMapper"
        case objectNode = "ObjectNode"
        case objectReader = "ObjectReader"
        case objectWriter = "ObjectWriter"
        case of = "of"
        case offsetDateTime = "OffsetDateTime"
        case offsetTime = "OffsetTime"
        case oneway = "oneway"
        case topLevelOpen = "open"
        case topLevelOperator = "operator"
        case topLevelOptional = "optional"
        case or = "or"
        case orEq = "or_eq"
        case out = "out"
        case topLevelOverride = "override"
        case package = "package"
        case params = "params"
        case pass = "pass"
        case port = "port"
        case topLevelPostfix = "postfix"
        case topLevelPrecedence = "precedence"
        case topLevelPrefix = "prefix"
        case primitiveKind = "PrimitiveKind"
        case print = "print"
        case printf = "printf"
        case printMembers = "printMembers"
        case topLevelPrivate = "private"
        case protected = "protected"
        case topLevelProtocol = "Protocol"
        case purpleProtocol = "protocol"
        case topLevelPublic = "public"
        case quicktype = "quicktype"
        case raise = "raise"
        case range = "range"
        case readonly = "readonly"
        case ref = "ref"
        case regExp = "RegExp"
        case register = "register"
        case reinterpretCast = "reinterpret_cast"
        case topLevelRepeat = "repeat"
        case require = "require"
        case topLevelRequired = "required"
        case requires = "requires"
        case restrict = "restrict"
        case retain = "retain"
        case topLevelRethrows = "rethrows"
        case topLevelReturn = "return"
        case topLevelRight = "right"
        case runtimeType = "runtimeType"
        case s = "s"
        case sbyte = "sbyte"
        case sealed = "sealed"
        case sel = "SEL"
        case select = "select"
        case topLevelSelf = "Self"
        case purpleSelf = "self"
        case sendable = "Sendable"
        case serialDescriptor = "SerialDescriptor"
        case serializable = "Serializable"
        case serializationFeature = "SerializationFeature"
        case serialize = "serialize"
        case serializerProvider = "SerializerProvider"
        case serialName = "SerialName"
        case topLevelSet = "set"
        case short = "short"
        case signed = "signed"
        case simpleModule = "SimpleModule"
        case sizeof = "sizeof"
        case stackalloc = "stackalloc"
        case standards = "Standards"
        case topLevelStatic = "static"
        case staticAssert = "static_assert"
        case staticCast = "static_cast"
        case stdDeserializer = "StdDeserializer"
        case stdSerializer = "StdSerializer"
        case strictfp = "strictfp"
        case string = "string"
        case topLevelStruct = "struct"
        case topLevelSubscript = "subscript"
        case topLevelSuper = "super"
        case topLevelSwitch = "switch"
        case symbol = "symbol"
        case synchronized = "synchronized"
        case system = "system"
        case template = "template"
        case textNode = "TextNode"
        case then = "then"
        case this = "this"
        case threadLocal = "thread_local"
        case topLevelThrow = "throw"
        case topLevelThrows = "throws"
        case timeOnly = "TimeOnly"
        case timeOnlyConverter = "TimeOnlyConverter"
        case timeZone = "TimeZone"
        case toDict = "to_dict"
        case toJSON = "to_json"
        case topLevel = "top_level"
        case toString = "toString"
        case transient = "transient"
        case topLevelTrue = "True"
        case purpleTrue = "true"
        case topLevelTry = "try"
        case type = "Type"
        case topLevelType = "type"
        case topLevelTypealias = "typealias"
        case typedef = "typedef"
        case typeid = "typeid"
        case typename = "typename"
        case typeof = "typeof"
        case uint = "uint"
        case ulong = "ulong"
        case unchecked = "unchecked"
        case undefined = "undefined"
        case union = "union"
        case unmarshalJSON = "UnmarshalJSON"
        case topLevelUnowned = "unowned"
        case unsafe = "unsafe"
        case unsigned = "unsigned"
        case useSerializers = "UseSerializers"
        case ushort = "ushort"
        case using = "using"
        case utf8JSONReader = "Utf8JsonReader"
        case utf8JSONWriter = "Utf8JsonWriter"
        case uuid = "UUID"
        case topLevelVar = "var"
        case virtual = "virtual"
        case void = "void"
        case volatile = "volatile"
        case wcharT = "wchar_t"
        case topLevelWeak = "weak"
        case topLevelWhere = "where"
        case topLevelWhile = "while"
        case topLevelWillSet = "willSet"
        case with = "with"
        case xor = "xor"
        case xorEq = "xor_eq"
        case yes = "YES"
        case yield = "yield"
    }
}

// MARK: TopLevel convenience initializers and mutators

extension TopLevel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        empty: UnionUnion?? = nil,
        topLevelBool: UnionBool?? = nil,
        complex: UnionComplex?? = nil,
        imaginery: UnionImaginery?? = nil,
        abstract: UnionAbstract?? = nil,
        alignas: UnionAlignas?? = nil,
        alignof: UnionAlignof?? = nil,
        and: UnionAnd?? = nil,
        andEq: UnionAndEq?? = nil,
        topLevelAny: UnionAnyUnion?? = nil,
        any: UnionAny?? = nil,
        array: UnionArray?? = nil,
        arrayNode: UnionArrayNode?? = nil,
        topLevelAs: UnionAs?? = nil,
        asm: UnionASM?? = nil,
        assert: UnionAssert?? = nil,
        topLevelAssociatedtype: UnionAssociatedtype?? = nil,
        topLevelAssociativity: UnionAssociativity?? = nil,
        async: UnionAsync?? = nil,
        atomic: UnionAtomic?? = nil,
        atomicCancel: UnionAtomicCancel?? = nil,
        atomicCommit: UnionAtomicCommit?? = nil,
        atomicNoexcept: UnionAtomicNoexcept?? = nil,
        auto: UnionAuto?? = nil,
        topLevelAwait: UnionAwait?? = nil,
        base: UnionBase?? = nil,
        bitand: UnionBitand?? = nil,
        bitor: UnionBitor?? = nil,
        bool: UnionBOOL?? = nil,
        purpleBool: UnionBoolUnion?? = nil,
        boolean: UnionBoolean?? = nil,
        booleanNode: UnionBooleanNode?? = nil,
        topLevelBreak: UnionBreak?? = nil,
        bycopy: UnionBycopy?? = nil,
        byref: UnionByref?? = nil,
        byte: UnionByte?? = nil,
        calendar: UnionCalendar?? = nil,
        topLevelCase: UnionCase?? = nil,
        topLevelCatch: UnionCatch?? = nil,
        chan: UnionChan?? = nil,
        char: UnionChar?? = nil,
        char16T: UnionChar16T?? = nil,
        char32T: UnionChar32T?? = nil,
        checked: UnionChecked?? = nil,
        purpleClass: UnionClassUnion?? = nil,
        topLevelClass: UnionClass?? = nil,
        clone: UnionClone?? = nil,
        coAwait: UnionCoAwait?? = nil,
        coReturn: UnionCoReturn?? = nil,
        coYield: UnionCoYield?? = nil,
        codable: UnionCodable?? = nil,
        codingKey: UnionCodingKey?? = nil,
        codingKeys: UnionCodingKeys?? = nil,
        compl: UnionCompl?? = nil,
        concept: UnionConcept?? = nil,
        console: UnionConsole?? = nil,
        const: UnionConst?? = nil,
        constCast: UnionConstCast?? = nil,
        constexpr: UnionConstexpr?? = nil,
        constructor: UnionConstructor?? = nil,
        topLevelContinue: UnionContinue?? = nil,
        topLevelConvenience: UnionConvenience?? = nil,
        convert: UnionConvert?? = nil,
        converter: UnionConverter?? = nil,
        cultureInfo: UnionCultureInfo?? = nil,
        date: UnionDate?? = nil,
        dateParseHandling: UnionDateParseHandling?? = nil,
        dateFormatter: UnionDateFormatter?? = nil,
        dateOnly: UnionDateOnly?? = nil,
        dateOnlyConverter: UnionDateOnlyConverter?? = nil,
        dateTime: UnionDateTime?? = nil,
        dateTimeStyles: UnionDateTimeStyles?? = nil,
        debugger: UnionDebugger?? = nil,
        decimal: UnionDecimal?? = nil,
        declare: UnionDeclare?? = nil,
        decltype: UnionDecltype?? = nil,
        decodeString: UnionDecodeString?? = nil,
        decoder: UnionDecoder?? = nil,
        decodingError: UnionDecodingError?? = nil,
        def: UnionDef?? = nil,
        topLevelDefault: UnionDefault?? = nil,
        topLevelDefer: UnionDefer?? = nil,
        topLevelDeinit: UnionDeinit?? = nil,
        del: UnionDel?? = nil,
        delegate: UnionDelegate?? = nil,
        delete: UnionDelete?? = nil,
        deserializationFeature: UnionDeserializationFeature?? = nil,
        dict: UnionDict?? = nil,
        dictionary: UnionDictionary?? = nil,
        topLevelDidSet: UnionDidSet?? = nil,
        topLevelDo: UnionDo?? = nil,
        double: UnionDouble?? = nil,
        doubleNode: UnionDoubleNode?? = nil,
        dummy: Double?? = nil,
        topLevelDynamic: UnionDynamic?? = nil,
        dynamicCast: UnionDynamicCast?? = nil,
        elif: UnionElif?? = nil,
        topLevelElse: UnionElse?? = nil,
        encodeQuickType: UnionEncodeQuickType?? = nil,
        encoder: UnionEncoder?? = nil,
        topLevelEnum: UnionEnum?? = nil,
        enumValues: UnionEnumValues?? = nil,
        equalityContract: UnionEqualityContract?? = nil,
        equatable: UnionEquatable?? = nil,
        event: UnionEvent?? = nil,
        except: UnionExcept?? = nil,
        exception: UnionException?? = nil,
        explicit: UnionExplicit?? = nil,
        export: UnionExport?? = nil,
        exposing: UnionExposing?? = nil,
        extends: UnionExtends?? = nil,
        topLevelExtension: UnionExtension?? = nil,
        extern: UnionExtern?? = nil,
        topLevelFallthrough: UnionFallthrough?? = nil,
        purpleFalse: UnionFalseUnion?? = nil,
        topLevelFalse: UnionFalse?? = nil,
        topLevelFileprivate: UnionFileprivate?? = nil,
        topLevelFinal: UnionFinal?? = nil,
        finally: UnionFinally?? = nil,
        fixed: UnionFixed?? = nil,
        float: UnionFloat?? = nil,
        topLevelFor: UnionFor?? = nil,
        foreach: UnionForeach?? = nil,
        formatException: UnionFormatException?? = nil,
        friend: UnionFriend?? = nil,
        from: UnionFrom?? = nil,
        fromDict: UnionFromDict?? = nil,
        fromJSON: UnionFromJSON?? = nil,
        topLevelFunc: UnionFunc?? = nil,
        function: UnionFunction?? = nil,
        topLevelGet: UnionGet?? = nil,
        global: UnionGlobal?? = nil,
        go: UnionGo?? = nil,
        goto: UnionGoto?? = nil,
        topLevelGuard: UnionGuard?? = nil,
        hashable: UnionHashable?? = nil,
        hashCode: UnionHashCode?? = nil,
        hasher: UnionHasher?? = nil,
        hasOwnProperty: UnionHasOwnProperty?? = nil,
        id: UnionID?? = nil,
        topLevelIf: UnionIf?? = nil,
        imp: UnionIMP?? = nil,
        implements: UnionImplements?? = nil,
        implicit: UnionImplicit?? = nil,
        topLevelImport: UnionImport?? = nil,
        topLevelIn: UnionIn?? = nil,
        topLevelIndirect: UnionIndirect?? = nil,
        topLevelInfix: UnionInfix?? = nil,
        topLevelInit: UnionInit?? = nil,
        inline: UnionInline?? = nil,
        topLevelInout: UnionInout?? = nil,
        instanceof: UnionInstanceof?? = nil,
        int: UnionInt?? = nil,
        interface: UnionInterface?? = nil,
        topLevelInternal: UnionInternal?? = nil,
        intNode: UnionIntNode?? = nil,
        topLevelIs: UnionIs?? = nil,
        isoDateTimeOffsetConverter: UnionISODateTimeOffsetConverter?? = nil,
        iterable: UnionIterable?? = nil,
        jdec: UnionJdec?? = nil,
        jenc: UnionJenc?? = nil,
        jpipe: UnionJpipe?? = nil,
        topLevelJSON: UnionJSON?? = nil,
        jsonConverter: UnionJSONConverter?? = nil,
        jsonSerializer: UnionJSONSerializer?? = nil,
        jsonToken: UnionJSONToken?? = nil,
        jsonWriter: UnionJSONWriter?? = nil,
        jsonAny: UnionJSONAny?? = nil,
        jsonCodingKey: UnionJSONCodingKey?? = nil,
        jsonDecoder: UnionJSONDecoder?? = nil,
        jsonEncoder: UnionJSONEncoder?? = nil,
        jsonException: UnionJSONException?? = nil,
        jsonGenerator: UnionJSONGenerator?? = nil,
        jsonNode: UnionJSONNode?? = nil,
        jsonNull: UnionJSONNull?? = nil,
        jsonParser: UnionJSONParser?? = nil,
        jsonReader: UnionJSONReader?? = nil,
        jsonTokenType: UnionJSONTokenType?? = nil,
        kSerializer: UnionKSerializer?? = nil,
        lambda: UnionLambda?? = nil,
        topLevelLazy: UnionLazy?? = nil,
        topLevelLeft: UnionLeft?? = nil,
        topLevelLet: UnionLet?? = nil,
        list: UnionList?? = nil,
        localDate: UnionLocalDate?? = nil,
        locale: UnionLocale?? = nil,
        lock: UnionLock?? = nil,
        long: UnionLong?? = nil,
        longNode: UnionLongNode?? = nil,
        map: UnionMap?? = nil,
        mapEntry: UnionMapEntry?? = nil,
        marshalJSON: UnionMarshalJSON?? = nil,
        metadataPropertyHandling: UnionMetadataPropertyHandling?? = nil,
        module: UnionModule?? = nil,
        mutable: UnionMutable?? = nil,
        topLevelMutating: UnionMutating?? = nil,
        namespace: UnionNamespace?? = nil,
        native: UnionNative?? = nil,
        new: UnionNew?? = nil,
        newtonsoft: UnionNewtonsoft?? = nil,
        topLevelNil: UnionNil?? = nil,
        no: UnionNO?? = nil,
        noexcept: UnionNoexcept?? = nil,
        nonatomic: UnionNonatomic?? = nil,
        topLevelNone: UnionNoneUnion?? = nil,
        none: UnionNone?? = nil,
        nonlocal: UnionNonlocal?? = nil,
        topLevelNonmutating: UnionNonmutating?? = nil,
        noSuchMethod: UnionNoSuchMethod?? = nil,
        not: UnionNot?? = nil,
        notEq: UnionNotEq?? = nil,
        nsError: UnionNSError?? = nil,
        nsObject: UnionNSObject?? = nil,
        nsString: UnionNSString?? = nil,
        null: UnionNULL?? = nil,
        topLevelNull: UnionNull?? = nil,
        nullNode: UnionNullNode?? = nil,
        nullptr: UnionNullptr?? = nil,
        number: UnionNumber?? = nil,
        object: UnionObject?? = nil,
        objectMapper: UnionObjectMapper?? = nil,
        objectNode: UnionObjectNode?? = nil,
        objectReader: UnionObjectReader?? = nil,
        objectWriter: UnionObjectWriter?? = nil,
        of: UnionOf?? = nil,
        offsetDateTime: UnionOffsetDateTime?? = nil,
        offsetTime: UnionOffsetTime?? = nil,
        oneway: UnionOneway?? = nil,
        topLevelOpen: UnionOpen?? = nil,
        topLevelOperator: UnionOperator?? = nil,
        topLevelOptional: UnionOptional?? = nil,
        or: UnionOr?? = nil,
        orEq: UnionOrEq?? = nil,
        out: UnionOut?? = nil,
        topLevelOverride: UnionOverride?? = nil,
        package: UnionPackage?? = nil,
        params: UnionParams?? = nil,
        pass: UnionPass?? = nil,
        port: UnionPort?? = nil,
        topLevelPostfix: UnionPostfix?? = nil,
        topLevelPrecedence: UnionPrecedence?? = nil,
        topLevelPrefix: UnionPrefix?? = nil,
        primitiveKind: UnionPrimitiveKind?? = nil,
        print: UnionPrint?? = nil,
        printf: UnionPrintf?? = nil,
        printMembers: UnionPrintMembers?? = nil,
        topLevelPrivate: UnionPrivate?? = nil,
        protected: UnionProtected?? = nil,
        topLevelProtocol: UnionProtocol?? = nil,
        purpleProtocol: UnionProtocolUnion?? = nil,
        topLevelPublic: UnionPublic?? = nil,
        quicktype: UnionQuicktype?? = nil,
        raise: UnionRaise?? = nil,
        range: UnionRange?? = nil,
        readonly: UnionReadonly?? = nil,
        ref: UnionRef?? = nil,
        regExp: UnionRegExp?? = nil,
        register: UnionRegister?? = nil,
        reinterpretCast: UnionReinterpretCast?? = nil,
        topLevelRepeat: UnionRepeat?? = nil,
        require: UnionRequire?? = nil,
        topLevelRequired: UnionRequired?? = nil,
        requires: UnionRequires?? = nil,
        restrict: UnionRestrict?? = nil,
        retain: UnionRetain?? = nil,
        topLevelRethrows: UnionRethrows?? = nil,
        topLevelReturn: UnionReturn?? = nil,
        topLevelRight: UnionRight?? = nil,
        runtimeType: UnionRuntimeType?? = nil,
        s: UnionS?? = nil,
        sbyte: UnionSbyte?? = nil,
        sealed: UnionSealed?? = nil,
        sel: UnionSEL?? = nil,
        select: UnionSelect?? = nil,
        topLevelSelf: UnionSelf?? = nil,
        purpleSelf: UnionSelfUnion?? = nil,
        sendable: UnionSendable?? = nil,
        serialDescriptor: UnionSerialDescriptor?? = nil,
        serializable: UnionSerializable?? = nil,
        serializationFeature: UnionSerializationFeature?? = nil,
        serialize: UnionSerialize?? = nil,
        serializerProvider: UnionSerializerProvider?? = nil,
        serialName: UnionSerialName?? = nil,
        topLevelSet: UnionSet?? = nil,
        short: UnionShort?? = nil,
        signed: UnionSigned?? = nil,
        simpleModule: UnionSimpleModule?? = nil,
        sizeof: UnionSizeof?? = nil,
        stackalloc: UnionStackalloc?? = nil,
        standards: UnionStandards?? = nil,
        topLevelStatic: UnionStatic?? = nil,
        staticAssert: UnionStaticAssert?? = nil,
        staticCast: UnionStaticCast?? = nil,
        stdDeserializer: UnionStdDeserializer?? = nil,
        stdSerializer: UnionStdSerializer?? = nil,
        strictfp: UnionStrictfp?? = nil,
        string: UnionString?? = nil,
        topLevelStruct: UnionStruct?? = nil,
        topLevelSubscript: UnionSubscript?? = nil,
        topLevelSuper: UnionSuper?? = nil,
        topLevelSwitch: UnionSwitch?? = nil,
        symbol: UnionSymbol?? = nil,
        synchronized: UnionSynchronized?? = nil,
        system: UnionSystem?? = nil,
        template: UnionTemplate?? = nil,
        textNode: UnionTextNode?? = nil,
        then: UnionThen?? = nil,
        this: UnionThis?? = nil,
        threadLocal: UnionThreadLocal?? = nil,
        topLevelThrow: UnionThrow?? = nil,
        topLevelThrows: UnionThrows?? = nil,
        timeOnly: UnionTimeOnly?? = nil,
        timeOnlyConverter: UnionTimeOnlyConverter?? = nil,
        timeZone: UnionTimeZone?? = nil,
        toDict: UnionToDict?? = nil,
        toJSON: UnionToJSON?? = nil,
        topLevel: UnionTopLevel?? = nil,
        toString: UnionToString?? = nil,
        transient: UnionTransient?? = nil,
        topLevelTrue: UnionTrue?? = nil,
        purpleTrue: UnionTrueUnion?? = nil,
        topLevelTry: UnionTry?? = nil,
        type: UnionType?? = nil,
        topLevelType: UnionTypeUnion?? = nil,
        topLevelTypealias: UnionTypealias?? = nil,
        typedef: UnionTypedef?? = nil,
        typeid: UnionTypeid?? = nil,
        typename: UnionTypename?? = nil,
        typeof: UnionTypeof?? = nil,
        uint: UnionUint?? = nil,
        ulong: UnionUlong?? = nil,
        unchecked: UnionUnchecked?? = nil,
        undefined: UnionUndefined?? = nil,
        union: UnionUnionUnion?? = nil,
        unmarshalJSON: UnionUnmarshalJSON?? = nil,
        topLevelUnowned: UnionUnowned?? = nil,
        unsafe: UnionUnsafe?? = nil,
        unsigned: UnionUnsigned?? = nil,
        useSerializers: UnionUseSerializers?? = nil,
        ushort: UnionUshort?? = nil,
        using: UnionUsing?? = nil,
        utf8JSONReader: UnionUtf8JSONReader?? = nil,
        utf8JSONWriter: UnionUtf8JSONWriter?? = nil,
        uuid: UnionUUID?? = nil,
        topLevelVar: UnionVar?? = nil,
        virtual: UnionVirtual?? = nil,
        void: UnionVoid?? = nil,
        volatile: UnionVolatile?? = nil,
        wcharT: UnionWcharT?? = nil,
        topLevelWeak: UnionWeak?? = nil,
        topLevelWhere: UnionWhere?? = nil,
        topLevelWhile: UnionWhile?? = nil,
        topLevelWillSet: UnionWillSet?? = nil,
        with: UnionWith?? = nil,
        xor: UnionXor?? = nil,
        xorEq: UnionXorEq?? = nil,
        yes: UnionYES?? = nil,
        yield: UnionYield?? = nil
    ) -> TopLevel {
        return TopLevel(
            empty: empty ?? self.empty,
            topLevelBool: topLevelBool ?? self.topLevelBool,
            complex: complex ?? self.complex,
            imaginery: imaginery ?? self.imaginery,
            abstract: abstract ?? self.abstract,
            alignas: alignas ?? self.alignas,
            alignof: alignof ?? self.alignof,
            and: and ?? self.and,
            andEq: andEq ?? self.andEq,
            topLevelAny: topLevelAny ?? self.topLevelAny,
            any: any ?? self.any,
            array: array ?? self.array,
            arrayNode: arrayNode ?? self.arrayNode,
            topLevelAs: topLevelAs ?? self.topLevelAs,
            asm: asm ?? self.asm,
            assert: assert ?? self.assert,
            topLevelAssociatedtype: topLevelAssociatedtype ?? self.topLevelAssociatedtype,
            topLevelAssociativity: topLevelAssociativity ?? self.topLevelAssociativity,
            async: async ?? self.async,
            atomic: atomic ?? self.atomic,
            atomicCancel: atomicCancel ?? self.atomicCancel,
            atomicCommit: atomicCommit ?? self.atomicCommit,
            atomicNoexcept: atomicNoexcept ?? self.atomicNoexcept,
            auto: auto ?? self.auto,
            topLevelAwait: topLevelAwait ?? self.topLevelAwait,
            base: base ?? self.base,
            bitand: bitand ?? self.bitand,
            bitor: bitor ?? self.bitor,
            bool: bool ?? self.bool,
            purpleBool: purpleBool ?? self.purpleBool,
            boolean: boolean ?? self.boolean,
            booleanNode: booleanNode ?? self.booleanNode,
            topLevelBreak: topLevelBreak ?? self.topLevelBreak,
            bycopy: bycopy ?? self.bycopy,
            byref: byref ?? self.byref,
            byte: byte ?? self.byte,
            calendar: calendar ?? self.calendar,
            topLevelCase: topLevelCase ?? self.topLevelCase,
            topLevelCatch: topLevelCatch ?? self.topLevelCatch,
            chan: chan ?? self.chan,
            char: char ?? self.char,
            char16T: char16T ?? self.char16T,
            char32T: char32T ?? self.char32T,
            checked: checked ?? self.checked,
            purpleClass: purpleClass ?? self.purpleClass,
            topLevelClass: topLevelClass ?? self.topLevelClass,
            clone: clone ?? self.clone,
            coAwait: coAwait ?? self.coAwait,
            coReturn: coReturn ?? self.coReturn,
            coYield: coYield ?? self.coYield,
            codable: codable ?? self.codable,
            codingKey: codingKey ?? self.codingKey,
            codingKeys: codingKeys ?? self.codingKeys,
            compl: compl ?? self.compl,
            concept: concept ?? self.concept,
            console: console ?? self.console,
            const: const ?? self.const,
            constCast: constCast ?? self.constCast,
            constexpr: constexpr ?? self.constexpr,
            constructor: constructor ?? self.constructor,
            topLevelContinue: topLevelContinue ?? self.topLevelContinue,
            topLevelConvenience: topLevelConvenience ?? self.topLevelConvenience,
            convert: convert ?? self.convert,
            converter: converter ?? self.converter,
            cultureInfo: cultureInfo ?? self.cultureInfo,
            date: date ?? self.date,
            dateParseHandling: dateParseHandling ?? self.dateParseHandling,
            dateFormatter: dateFormatter ?? self.dateFormatter,
            dateOnly: dateOnly ?? self.dateOnly,
            dateOnlyConverter: dateOnlyConverter ?? self.dateOnlyConverter,
            dateTime: dateTime ?? self.dateTime,
            dateTimeStyles: dateTimeStyles ?? self.dateTimeStyles,
            debugger: debugger ?? self.debugger,
            decimal: decimal ?? self.decimal,
            declare: declare ?? self.declare,
            decltype: decltype ?? self.decltype,
            decodeString: decodeString ?? self.decodeString,
            decoder: decoder ?? self.decoder,
            decodingError: decodingError ?? self.decodingError,
            def: def ?? self.def,
            topLevelDefault: topLevelDefault ?? self.topLevelDefault,
            topLevelDefer: topLevelDefer ?? self.topLevelDefer,
            topLevelDeinit: topLevelDeinit ?? self.topLevelDeinit,
            del: del ?? self.del,
            delegate: delegate ?? self.delegate,
            delete: delete ?? self.delete,
            deserializationFeature: deserializationFeature ?? self.deserializationFeature,
            dict: dict ?? self.dict,
            dictionary: dictionary ?? self.dictionary,
            topLevelDidSet: topLevelDidSet ?? self.topLevelDidSet,
            topLevelDo: topLevelDo ?? self.topLevelDo,
            double: double ?? self.double,
            doubleNode: doubleNode ?? self.doubleNode,
            dummy: dummy ?? self.dummy,
            topLevelDynamic: topLevelDynamic ?? self.topLevelDynamic,
            dynamicCast: dynamicCast ?? self.dynamicCast,
            elif: elif ?? self.elif,
            topLevelElse: topLevelElse ?? self.topLevelElse,
            encodeQuickType: encodeQuickType ?? self.encodeQuickType,
            encoder: encoder ?? self.encoder,
            topLevelEnum: topLevelEnum ?? self.topLevelEnum,
            enumValues: enumValues ?? self.enumValues,
            equalityContract: equalityContract ?? self.equalityContract,
            equatable: equatable ?? self.equatable,
            event: event ?? self.event,
            except: except ?? self.except,
            exception: exception ?? self.exception,
            explicit: explicit ?? self.explicit,
            export: export ?? self.export,
            exposing: exposing ?? self.exposing,
            extends: extends ?? self.extends,
            topLevelExtension: topLevelExtension ?? self.topLevelExtension,
            extern: extern ?? self.extern,
            topLevelFallthrough: topLevelFallthrough ?? self.topLevelFallthrough,
            purpleFalse: purpleFalse ?? self.purpleFalse,
            topLevelFalse: topLevelFalse ?? self.topLevelFalse,
            topLevelFileprivate: topLevelFileprivate ?? self.topLevelFileprivate,
            topLevelFinal: topLevelFinal ?? self.topLevelFinal,
            finally: finally ?? self.finally,
            fixed: fixed ?? self.fixed,
            float: float ?? self.float,
            topLevelFor: topLevelFor ?? self.topLevelFor,
            foreach: foreach ?? self.foreach,
            formatException: formatException ?? self.formatException,
            friend: friend ?? self.friend,
            from: from ?? self.from,
            fromDict: fromDict ?? self.fromDict,
            fromJSON: fromJSON ?? self.fromJSON,
            topLevelFunc: topLevelFunc ?? self.topLevelFunc,
            function: function ?? self.function,
            topLevelGet: topLevelGet ?? self.topLevelGet,
            global: global ?? self.global,
            go: go ?? self.go,
            goto: goto ?? self.goto,
            topLevelGuard: topLevelGuard ?? self.topLevelGuard,
            hashable: hashable ?? self.hashable,
            hashCode: hashCode ?? self.hashCode,
            hasher: hasher ?? self.hasher,
            hasOwnProperty: hasOwnProperty ?? self.hasOwnProperty,
            id: id ?? self.id,
            topLevelIf: topLevelIf ?? self.topLevelIf,
            imp: imp ?? self.imp,
            implements: implements ?? self.implements,
            implicit: implicit ?? self.implicit,
            topLevelImport: topLevelImport ?? self.topLevelImport,
            topLevelIn: topLevelIn ?? self.topLevelIn,
            topLevelIndirect: topLevelIndirect ?? self.topLevelIndirect,
            topLevelInfix: topLevelInfix ?? self.topLevelInfix,
            topLevelInit: topLevelInit ?? self.topLevelInit,
            inline: inline ?? self.inline,
            topLevelInout: topLevelInout ?? self.topLevelInout,
            instanceof: instanceof ?? self.instanceof,
            int: int ?? self.int,
            interface: interface ?? self.interface,
            topLevelInternal: topLevelInternal ?? self.topLevelInternal,
            intNode: intNode ?? self.intNode,
            topLevelIs: topLevelIs ?? self.topLevelIs,
            isoDateTimeOffsetConverter: isoDateTimeOffsetConverter ?? self.isoDateTimeOffsetConverter,
            iterable: iterable ?? self.iterable,
            jdec: jdec ?? self.jdec,
            jenc: jenc ?? self.jenc,
            jpipe: jpipe ?? self.jpipe,
            topLevelJSON: topLevelJSON ?? self.topLevelJSON,
            jsonConverter: jsonConverter ?? self.jsonConverter,
            jsonSerializer: jsonSerializer ?? self.jsonSerializer,
            jsonToken: jsonToken ?? self.jsonToken,
            jsonWriter: jsonWriter ?? self.jsonWriter,
            jsonAny: jsonAny ?? self.jsonAny,
            jsonCodingKey: jsonCodingKey ?? self.jsonCodingKey,
            jsonDecoder: jsonDecoder ?? self.jsonDecoder,
            jsonEncoder: jsonEncoder ?? self.jsonEncoder,
            jsonException: jsonException ?? self.jsonException,
            jsonGenerator: jsonGenerator ?? self.jsonGenerator,
            jsonNode: jsonNode ?? self.jsonNode,
            jsonNull: jsonNull ?? self.jsonNull,
            jsonParser: jsonParser ?? self.jsonParser,
            jsonReader: jsonReader ?? self.jsonReader,
            jsonTokenType: jsonTokenType ?? self.jsonTokenType,
            kSerializer: kSerializer ?? self.kSerializer,
            lambda: lambda ?? self.lambda,
            topLevelLazy: topLevelLazy ?? self.topLevelLazy,
            topLevelLeft: topLevelLeft ?? self.topLevelLeft,
            topLevelLet: topLevelLet ?? self.topLevelLet,
            list: list ?? self.list,
            localDate: localDate ?? self.localDate,
            locale: locale ?? self.locale,
            lock: lock ?? self.lock,
            long: long ?? self.long,
            longNode: longNode ?? self.longNode,
            map: map ?? self.map,
            mapEntry: mapEntry ?? self.mapEntry,
            marshalJSON: marshalJSON ?? self.marshalJSON,
            metadataPropertyHandling: metadataPropertyHandling ?? self.metadataPropertyHandling,
            module: module ?? self.module,
            mutable: mutable ?? self.mutable,
            topLevelMutating: topLevelMutating ?? self.topLevelMutating,
            namespace: namespace ?? self.namespace,
            native: native ?? self.native,
            new: new ?? self.new,
            newtonsoft: newtonsoft ?? self.newtonsoft,
            topLevelNil: topLevelNil ?? self.topLevelNil,
            no: no ?? self.no,
            noexcept: noexcept ?? self.noexcept,
            nonatomic: nonatomic ?? self.nonatomic,
            topLevelNone: topLevelNone ?? self.topLevelNone,
            none: none ?? self.none,
            nonlocal: nonlocal ?? self.nonlocal,
            topLevelNonmutating: topLevelNonmutating ?? self.topLevelNonmutating,
            noSuchMethod: noSuchMethod ?? self.noSuchMethod,
            not: not ?? self.not,
            notEq: notEq ?? self.notEq,
            nsError: nsError ?? self.nsError,
            nsObject: nsObject ?? self.nsObject,
            nsString: nsString ?? self.nsString,
            null: null ?? self.null,
            topLevelNull: topLevelNull ?? self.topLevelNull,
            nullNode: nullNode ?? self.nullNode,
            nullptr: nullptr ?? self.nullptr,
            number: number ?? self.number,
            object: object ?? self.object,
            objectMapper: objectMapper ?? self.objectMapper,
            objectNode: objectNode ?? self.objectNode,
            objectReader: objectReader ?? self.objectReader,
            objectWriter: objectWriter ?? self.objectWriter,
            of: of ?? self.of,
            offsetDateTime: offsetDateTime ?? self.offsetDateTime,
            offsetTime: offsetTime ?? self.offsetTime,
            oneway: oneway ?? self.oneway,
            topLevelOpen: topLevelOpen ?? self.topLevelOpen,
            topLevelOperator: topLevelOperator ?? self.topLevelOperator,
            topLevelOptional: topLevelOptional ?? self.topLevelOptional,
            or: or ?? self.or,
            orEq: orEq ?? self.orEq,
            out: out ?? self.out,
            topLevelOverride: topLevelOverride ?? self.topLevelOverride,
            package: package ?? self.package,
            params: params ?? self.params,
            pass: pass ?? self.pass,
            port: port ?? self.port,
            topLevelPostfix: topLevelPostfix ?? self.topLevelPostfix,
            topLevelPrecedence: topLevelPrecedence ?? self.topLevelPrecedence,
            topLevelPrefix: topLevelPrefix ?? self.topLevelPrefix,
            primitiveKind: primitiveKind ?? self.primitiveKind,
            print: print ?? self.print,
            printf: printf ?? self.printf,
            printMembers: printMembers ?? self.printMembers,
            topLevelPrivate: topLevelPrivate ?? self.topLevelPrivate,
            protected: protected ?? self.protected,
            topLevelProtocol: topLevelProtocol ?? self.topLevelProtocol,
            purpleProtocol: purpleProtocol ?? self.purpleProtocol,
            topLevelPublic: topLevelPublic ?? self.topLevelPublic,
            quicktype: quicktype ?? self.quicktype,
            raise: raise ?? self.raise,
            range: range ?? self.range,
            readonly: readonly ?? self.readonly,
            ref: ref ?? self.ref,
            regExp: regExp ?? self.regExp,
            register: register ?? self.register,
            reinterpretCast: reinterpretCast ?? self.reinterpretCast,
            topLevelRepeat: topLevelRepeat ?? self.topLevelRepeat,
            require: require ?? self.require,
            topLevelRequired: topLevelRequired ?? self.topLevelRequired,
            requires: requires ?? self.requires,
            restrict: restrict ?? self.restrict,
            retain: retain ?? self.retain,
            topLevelRethrows: topLevelRethrows ?? self.topLevelRethrows,
            topLevelReturn: topLevelReturn ?? self.topLevelReturn,
            topLevelRight: topLevelRight ?? self.topLevelRight,
            runtimeType: runtimeType ?? self.runtimeType,
            s: s ?? self.s,
            sbyte: sbyte ?? self.sbyte,
            sealed: sealed ?? self.sealed,
            sel: sel ?? self.sel,
            select: select ?? self.select,
            topLevelSelf: topLevelSelf ?? self.topLevelSelf,
            purpleSelf: purpleSelf ?? self.purpleSelf,
            sendable: sendable ?? self.sendable,
            serialDescriptor: serialDescriptor ?? self.serialDescriptor,
            serializable: serializable ?? self.serializable,
            serializationFeature: serializationFeature ?? self.serializationFeature,
            serialize: serialize ?? self.serialize,
            serializerProvider: serializerProvider ?? self.serializerProvider,
            serialName: serialName ?? self.serialName,
            topLevelSet: topLevelSet ?? self.topLevelSet,
            short: short ?? self.short,
            signed: signed ?? self.signed,
            simpleModule: simpleModule ?? self.simpleModule,
            sizeof: sizeof ?? self.sizeof,
            stackalloc: stackalloc ?? self.stackalloc,
            standards: standards ?? self.standards,
            topLevelStatic: topLevelStatic ?? self.topLevelStatic,
            staticAssert: staticAssert ?? self.staticAssert,
            staticCast: staticCast ?? self.staticCast,
            stdDeserializer: stdDeserializer ?? self.stdDeserializer,
            stdSerializer: stdSerializer ?? self.stdSerializer,
            strictfp: strictfp ?? self.strictfp,
            string: string ?? self.string,
            topLevelStruct: topLevelStruct ?? self.topLevelStruct,
            topLevelSubscript: topLevelSubscript ?? self.topLevelSubscript,
            topLevelSuper: topLevelSuper ?? self.topLevelSuper,
            topLevelSwitch: topLevelSwitch ?? self.topLevelSwitch,
            symbol: symbol ?? self.symbol,
            synchronized: synchronized ?? self.synchronized,
            system: system ?? self.system,
            template: template ?? self.template,
            textNode: textNode ?? self.textNode,
            then: then ?? self.then,
            this: this ?? self.this,
            threadLocal: threadLocal ?? self.threadLocal,
            topLevelThrow: topLevelThrow ?? self.topLevelThrow,
            topLevelThrows: topLevelThrows ?? self.topLevelThrows,
            timeOnly: timeOnly ?? self.timeOnly,
            timeOnlyConverter: timeOnlyConverter ?? self.timeOnlyConverter,
            timeZone: timeZone ?? self.timeZone,
            toDict: toDict ?? self.toDict,
            toJSON: toJSON ?? self.toJSON,
            topLevel: topLevel ?? self.topLevel,
            toString: toString ?? self.toString,
            transient: transient ?? self.transient,
            topLevelTrue: topLevelTrue ?? self.topLevelTrue,
            purpleTrue: purpleTrue ?? self.purpleTrue,
            topLevelTry: topLevelTry ?? self.topLevelTry,
            type: type ?? self.type,
            topLevelType: topLevelType ?? self.topLevelType,
            topLevelTypealias: topLevelTypealias ?? self.topLevelTypealias,
            typedef: typedef ?? self.typedef,
            typeid: typeid ?? self.typeid,
            typename: typename ?? self.typename,
            typeof: typeof ?? self.typeof,
            uint: uint ?? self.uint,
            ulong: ulong ?? self.ulong,
            unchecked: unchecked ?? self.unchecked,
            undefined: undefined ?? self.undefined,
            union: union ?? self.union,
            unmarshalJSON: unmarshalJSON ?? self.unmarshalJSON,
            topLevelUnowned: topLevelUnowned ?? self.topLevelUnowned,
            unsafe: unsafe ?? self.unsafe,
            unsigned: unsigned ?? self.unsigned,
            useSerializers: useSerializers ?? self.useSerializers,
            ushort: ushort ?? self.ushort,
            using: using ?? self.using,
            utf8JSONReader: utf8JSONReader ?? self.utf8JSONReader,
            utf8JSONWriter: utf8JSONWriter ?? self.utf8JSONWriter,
            uuid: uuid ?? self.uuid,
            topLevelVar: topLevelVar ?? self.topLevelVar,
            virtual: virtual ?? self.virtual,
            void: void ?? self.void,
            volatile: volatile ?? self.volatile,
            wcharT: wcharT ?? self.wcharT,
            topLevelWeak: topLevelWeak ?? self.topLevelWeak,
            topLevelWhere: topLevelWhere ?? self.topLevelWhere,
            topLevelWhile: topLevelWhile ?? self.topLevelWhile,
            topLevelWillSet: topLevelWillSet ?? self.topLevelWillSet,
            with: with ?? self.with,
            xor: xor ?? self.xor,
            xorEq: xorEq ?? self.xorEq,
            yes: yes ?? self.yes,
            yield: yield ?? self.yield
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAbstract: Codable {
    case abstract(Abstract)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Abstract.self) {
            self = .abstract(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAbstract.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAbstract"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .abstract(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Abstract
struct Abstract: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Abstract convenience initializers and mutators

extension Abstract {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Abstract.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Abstract {
        return Abstract(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAlignas: Codable {
    case alignas(Alignas)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Alignas.self) {
            self = .alignas(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAlignas.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAlignas"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .alignas(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Alignas
struct Alignas: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Alignas convenience initializers and mutators

extension Alignas {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Alignas.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Alignas {
        return Alignas(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAlignof: Codable {
    case alignof(Alignof)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Alignof.self) {
            self = .alignof(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAlignof.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAlignof"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .alignof(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Alignof
struct Alignof: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Alignof convenience initializers and mutators

extension Alignof {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Alignof.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Alignof {
        return Alignof(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAnd: Codable {
    case and(And)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(And.self) {
            self = .and(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAnd.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAnd"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .and(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - And
struct And: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: And convenience initializers and mutators

extension And {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(And.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> And {
        return And(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAndEq: Codable {
    case andEq(AndEq)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(AndEq.self) {
            self = .andEq(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAndEq.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAndEq"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .andEq(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - AndEq
struct AndEq: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: AndEq convenience initializers and mutators

extension AndEq {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AndEq.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> AndEq {
        return AndEq(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAny: Codable {
    case anyClass(AnyClass)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(AnyClass.self) {
            self = .anyClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAny.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAny"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .anyClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - AnyClass
struct AnyClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: AnyClass convenience initializers and mutators

extension AnyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AnyClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> AnyClass {
        return AnyClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionArray: Codable {
    case array(Array)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Array.self) {
            self = .array(x)
            return
        }
        throw DecodingError.typeMismatch(UnionArray.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionArray"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .array(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Array
struct Array: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Array convenience initializers and mutators

extension Array {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Array.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Array {
        return Array(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionArrayNode: Codable {
    case arrayNode(ArrayNode)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ArrayNode.self) {
            self = .arrayNode(x)
            return
        }
        throw DecodingError.typeMismatch(UnionArrayNode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionArrayNode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .arrayNode(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ArrayNode
struct ArrayNode: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ArrayNode convenience initializers and mutators

extension ArrayNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ArrayNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ArrayNode {
        return ArrayNode(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionASM: Codable {
    case asm(ASM)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ASM.self) {
            self = .asm(x)
            return
        }
        throw DecodingError.typeMismatch(UnionASM.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionASM"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .asm(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ASM
struct ASM: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ASM convenience initializers and mutators

extension ASM {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ASM.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ASM {
        return ASM(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAssert: Codable {
    case assert(Assert)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Assert.self) {
            self = .assert(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAssert.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAssert"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .assert(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Assert
struct Assert: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Assert convenience initializers and mutators

extension Assert {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Assert.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Assert {
        return Assert(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAsync: Codable {
    case async(Async)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Async.self) {
            self = .async(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAsync.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAsync"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .async(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Async
struct Async: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Async convenience initializers and mutators

extension Async {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Async.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Async {
        return Async(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAtomic: Codable {
    case atomic(Atomic)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Atomic.self) {
            self = .atomic(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAtomic.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAtomic"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .atomic(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Atomic
struct Atomic: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Atomic convenience initializers and mutators

extension Atomic {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Atomic.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Atomic {
        return Atomic(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAtomicCancel: Codable {
    case atomicCancel(AtomicCancel)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(AtomicCancel.self) {
            self = .atomicCancel(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAtomicCancel.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAtomicCancel"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .atomicCancel(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - AtomicCancel
struct AtomicCancel: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: AtomicCancel convenience initializers and mutators

extension AtomicCancel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AtomicCancel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> AtomicCancel {
        return AtomicCancel(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAtomicCommit: Codable {
    case atomicCommit(AtomicCommit)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(AtomicCommit.self) {
            self = .atomicCommit(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAtomicCommit.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAtomicCommit"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .atomicCommit(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - AtomicCommit
struct AtomicCommit: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: AtomicCommit convenience initializers and mutators

extension AtomicCommit {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AtomicCommit.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> AtomicCommit {
        return AtomicCommit(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAtomicNoexcept: Codable {
    case atomicNoexcept(AtomicNoexcept)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(AtomicNoexcept.self) {
            self = .atomicNoexcept(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAtomicNoexcept.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAtomicNoexcept"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .atomicNoexcept(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - AtomicNoexcept
struct AtomicNoexcept: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: AtomicNoexcept convenience initializers and mutators

extension AtomicNoexcept {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AtomicNoexcept.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> AtomicNoexcept {
        return AtomicNoexcept(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAuto: Codable {
    case auto(Auto)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Auto.self) {
            self = .auto(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAuto.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAuto"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .auto(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Auto
struct Auto: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Auto convenience initializers and mutators

extension Auto {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Auto.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Auto {
        return Auto(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionBase: Codable {
    case base(Base)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Base.self) {
            self = .base(x)
            return
        }
        throw DecodingError.typeMismatch(UnionBase.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionBase"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .base(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Base
struct Base: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Base convenience initializers and mutators

extension Base {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Base.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Base {
        return Base(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionBitand: Codable {
    case bitand(Bitand)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Bitand.self) {
            self = .bitand(x)
            return
        }
        throw DecodingError.typeMismatch(UnionBitand.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionBitand"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bitand(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Bitand
struct Bitand: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Bitand convenience initializers and mutators

extension Bitand {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Bitand.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Bitand {
        return Bitand(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionBitor: Codable {
    case bitor(Bitor)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Bitor.self) {
            self = .bitor(x)
            return
        }
        throw DecodingError.typeMismatch(UnionBitor.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionBitor"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bitor(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Bitor
struct Bitor: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Bitor convenience initializers and mutators

extension Bitor {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Bitor.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Bitor {
        return Bitor(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionBOOL: Codable {
    case boolClass(BOOLClass)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(BOOLClass.self) {
            self = .boolClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionBOOL.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionBOOL"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .boolClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - BOOLClass
struct BOOLClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: BOOLClass convenience initializers and mutators

extension BOOLClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BOOLClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> BOOLClass {
        return BOOLClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionBoolean: Codable {
    case boolean(Boolean)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Boolean.self) {
            self = .boolean(x)
            return
        }
        throw DecodingError.typeMismatch(UnionBoolean.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionBoolean"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .boolean(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Boolean
struct Boolean: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Boolean convenience initializers and mutators

extension Boolean {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Boolean.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Boolean {
        return Boolean(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionBooleanNode: Codable {
    case booleanNode(BooleanNode)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(BooleanNode.self) {
            self = .booleanNode(x)
            return
        }
        throw DecodingError.typeMismatch(UnionBooleanNode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionBooleanNode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .booleanNode(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - BooleanNode
struct BooleanNode: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: BooleanNode convenience initializers and mutators

extension BooleanNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BooleanNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> BooleanNode {
        return BooleanNode(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionBycopy: Codable {
    case bycopy(Bycopy)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Bycopy.self) {
            self = .bycopy(x)
            return
        }
        throw DecodingError.typeMismatch(UnionBycopy.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionBycopy"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bycopy(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Bycopy
struct Bycopy: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Bycopy convenience initializers and mutators

extension Bycopy {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Bycopy.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Bycopy {
        return Bycopy(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionByref: Codable {
    case byref(Byref)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Byref.self) {
            self = .byref(x)
            return
        }
        throw DecodingError.typeMismatch(UnionByref.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionByref"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .byref(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Byref
struct Byref: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Byref convenience initializers and mutators

extension Byref {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Byref.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Byref {
        return Byref(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionByte: Codable {
    case byte(Byte)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Byte.self) {
            self = .byte(x)
            return
        }
        throw DecodingError.typeMismatch(UnionByte.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionByte"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .byte(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Byte
struct Byte: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Byte convenience initializers and mutators

extension Byte {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Byte.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Byte {
        return Byte(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionCalendar: Codable {
    case calendarClass(CalendarClass)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(CalendarClass.self) {
            self = .calendarClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionCalendar.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionCalendar"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .calendarClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - CalendarClass
struct CalendarClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: CalendarClass convenience initializers and mutators

extension CalendarClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CalendarClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> CalendarClass {
        return CalendarClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionChan: Codable {
    case chan(Chan)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Chan.self) {
            self = .chan(x)
            return
        }
        throw DecodingError.typeMismatch(UnionChan.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionChan"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .chan(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Chan
struct Chan: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Chan convenience initializers and mutators

extension Chan {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Chan.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Chan {
        return Chan(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionChar: Codable {
    case char(Char)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Char.self) {
            self = .char(x)
            return
        }
        throw DecodingError.typeMismatch(UnionChar.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionChar"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .char(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Char
struct Char: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Char convenience initializers and mutators

extension Char {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Char.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Char {
        return Char(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionChar16T: Codable {
    case char16T(Char16T)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Char16T.self) {
            self = .char16T(x)
            return
        }
        throw DecodingError.typeMismatch(UnionChar16T.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionChar16T"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .char16T(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Char16T
struct Char16T: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Char16T convenience initializers and mutators

extension Char16T {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Char16T.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Char16T {
        return Char16T(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionChar32T: Codable {
    case char32T(Char32T)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Char32T.self) {
            self = .char32T(x)
            return
        }
        throw DecodingError.typeMismatch(UnionChar32T.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionChar32T"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .char32T(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Char32T
struct Char32T: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Char32T convenience initializers and mutators

extension Char32T {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Char32T.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Char32T {
        return Char32T(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionChecked: Codable {
    case checked(Checked)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Checked.self) {
            self = .checked(x)
            return
        }
        throw DecodingError.typeMismatch(UnionChecked.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionChecked"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .checked(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Checked
struct Checked: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Checked convenience initializers and mutators

extension Checked {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Checked.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Checked {
        return Checked(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionClone: Codable {
    case clone(Clone)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Clone.self) {
            self = .clone(x)
            return
        }
        throw DecodingError.typeMismatch(UnionClone.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionClone"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .clone(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Clone
struct Clone: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Clone convenience initializers and mutators

extension Clone {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Clone.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Clone {
        return Clone(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionCoAwait: Codable {
    case coAwait(CoAwait)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(CoAwait.self) {
            self = .coAwait(x)
            return
        }
        throw DecodingError.typeMismatch(UnionCoAwait.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionCoAwait"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .coAwait(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - CoAwait
struct CoAwait: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: CoAwait convenience initializers and mutators

extension CoAwait {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CoAwait.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> CoAwait {
        return CoAwait(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionCoReturn: Codable {
    case coReturn(CoReturn)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(CoReturn.self) {
            self = .coReturn(x)
            return
        }
        throw DecodingError.typeMismatch(UnionCoReturn.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionCoReturn"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .coReturn(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - CoReturn
struct CoReturn: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: CoReturn convenience initializers and mutators

extension CoReturn {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CoReturn.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> CoReturn {
        return CoReturn(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionCoYield: Codable {
    case coYield(CoYield)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(CoYield.self) {
            self = .coYield(x)
            return
        }
        throw DecodingError.typeMismatch(UnionCoYield.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionCoYield"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .coYield(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - CoYield
struct CoYield: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: CoYield convenience initializers and mutators

extension CoYield {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CoYield.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> CoYield {
        return CoYield(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionCodable: Codable {
    case codableClass(CodableClass)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(CodableClass.self) {
            self = .codableClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionCodable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionCodable"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .codableClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - CodableClass
struct CodableClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: CodableClass convenience initializers and mutators

extension CodableClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CodableClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> CodableClass {
        return CodableClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionCodingKey: Codable {
    case codingKeyClass(CodingKeyClass)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(CodingKeyClass.self) {
            self = .codingKeyClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionCodingKey.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionCodingKey"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .codingKeyClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - CodingKeyClass
struct CodingKeyClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: CodingKeyClass convenience initializers and mutators

extension CodingKeyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CodingKeyClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> CodingKeyClass {
        return CodingKeyClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionCodingKeys: Codable {
    case codingKeysClass(CodingKeysClass)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(CodingKeysClass.self) {
            self = .codingKeysClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionCodingKeys.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionCodingKeys"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .codingKeysClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - CodingKeysClass
struct CodingKeysClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: CodingKeysClass convenience initializers and mutators

extension CodingKeysClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CodingKeysClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> CodingKeysClass {
        return CodingKeysClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionCompl: Codable {
    case compl(Compl)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Compl.self) {
            self = .compl(x)
            return
        }
        throw DecodingError.typeMismatch(UnionCompl.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionCompl"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .compl(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Compl
struct Compl: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Compl convenience initializers and mutators

extension Compl {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Compl.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Compl {
        return Compl(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionComplex: Codable {
    case complex(Complex)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Complex.self) {
            self = .complex(x)
            return
        }
        throw DecodingError.typeMismatch(UnionComplex.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionComplex"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .complex(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Complex
struct Complex: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Complex convenience initializers and mutators

extension Complex {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Complex.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Complex {
        return Complex(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionConcept: Codable {
    case concept(Concept)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Concept.self) {
            self = .concept(x)
            return
        }
        throw DecodingError.typeMismatch(UnionConcept.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionConcept"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .concept(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Concept
struct Concept: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Concept convenience initializers and mutators

extension Concept {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Concept.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Concept {
        return Concept(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionConsole: Codable {
    case console(Console)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Console.self) {
            self = .console(x)
            return
        }
        throw DecodingError.typeMismatch(UnionConsole.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionConsole"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .console(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Console
struct Console: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Console convenience initializers and mutators

extension Console {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Console.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Console {
        return Console(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionConst: Codable {
    case const(Const)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Const.self) {
            self = .const(x)
            return
        }
        throw DecodingError.typeMismatch(UnionConst.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionConst"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .const(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Const
struct Const: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Const convenience initializers and mutators

extension Const {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Const.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Const {
        return Const(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionConstCast: Codable {
    case constCast(ConstCast)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ConstCast.self) {
            self = .constCast(x)
            return
        }
        throw DecodingError.typeMismatch(UnionConstCast.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionConstCast"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .constCast(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ConstCast
struct ConstCast: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ConstCast convenience initializers and mutators

extension ConstCast {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ConstCast.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ConstCast {
        return ConstCast(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionConstexpr: Codable {
    case constexpr(Constexpr)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Constexpr.self) {
            self = .constexpr(x)
            return
        }
        throw DecodingError.typeMismatch(UnionConstexpr.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionConstexpr"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .constexpr(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Constexpr
struct Constexpr: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Constexpr convenience initializers and mutators

extension Constexpr {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Constexpr.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Constexpr {
        return Constexpr(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionConstructor: Codable {
    case constructor(Constructor)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Constructor.self) {
            self = .constructor(x)
            return
        }
        throw DecodingError.typeMismatch(UnionConstructor.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionConstructor"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .constructor(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Constructor
struct Constructor: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Constructor convenience initializers and mutators

extension Constructor {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Constructor.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Constructor {
        return Constructor(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionConvert: Codable {
    case convert(Convert)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Convert.self) {
            self = .convert(x)
            return
        }
        throw DecodingError.typeMismatch(UnionConvert.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionConvert"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .convert(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Convert
struct Convert: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Convert convenience initializers and mutators

extension Convert {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Convert.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Convert {
        return Convert(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionConverter: Codable {
    case converter(Converter)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Converter.self) {
            self = .converter(x)
            return
        }
        throw DecodingError.typeMismatch(UnionConverter.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionConverter"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .converter(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Converter
struct Converter: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Converter convenience initializers and mutators

extension Converter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Converter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Converter {
        return Converter(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionCultureInfo: Codable {
    case cultureInfo(CultureInfo)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(CultureInfo.self) {
            self = .cultureInfo(x)
            return
        }
        throw DecodingError.typeMismatch(UnionCultureInfo.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionCultureInfo"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .cultureInfo(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - CultureInfo
struct CultureInfo: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: CultureInfo convenience initializers and mutators

extension CultureInfo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CultureInfo.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> CultureInfo {
        return CultureInfo(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDate: Codable {
    case dateClass(DateClass)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DateClass.self) {
            self = .dateClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDate.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDate"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DateClass
struct DateClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DateClass convenience initializers and mutators

extension DateClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DateClass {
        return DateClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDateFormatter: Codable {
    case dateFormatterClass(DateFormatterClass)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DateFormatterClass.self) {
            self = .dateFormatterClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDateFormatter.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDateFormatter"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateFormatterClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DateFormatterClass
struct DateFormatterClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DateFormatterClass convenience initializers and mutators

extension DateFormatterClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateFormatterClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DateFormatterClass {
        return DateFormatterClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDateOnly: Codable {
    case dateOnly(DateOnly)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DateOnly.self) {
            self = .dateOnly(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDateOnly.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDateOnly"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateOnly(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DateOnly
struct DateOnly: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DateOnly convenience initializers and mutators

extension DateOnly {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateOnly.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DateOnly {
        return DateOnly(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDateOnlyConverter: Codable {
    case dateOnlyConverter(DateOnlyConverter)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DateOnlyConverter.self) {
            self = .dateOnlyConverter(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDateOnlyConverter.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDateOnlyConverter"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateOnlyConverter(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DateOnlyConverter
struct DateOnlyConverter: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DateOnlyConverter convenience initializers and mutators

extension DateOnlyConverter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateOnlyConverter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DateOnlyConverter {
        return DateOnlyConverter(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDateParseHandling: Codable {
    case dateParseHandling(DateParseHandling)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DateParseHandling.self) {
            self = .dateParseHandling(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDateParseHandling.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDateParseHandling"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateParseHandling(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DateParseHandling
struct DateParseHandling: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DateParseHandling convenience initializers and mutators

extension DateParseHandling {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateParseHandling.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DateParseHandling {
        return DateParseHandling(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDateTime: Codable {
    case dateTime(DateTime)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DateTime.self) {
            self = .dateTime(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDateTime.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDateTime"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateTime(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DateTime
struct DateTime: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DateTime convenience initializers and mutators

extension DateTime {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateTime.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DateTime {
        return DateTime(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDateTimeStyles: Codable {
    case dateTimeStyles(DateTimeStyles)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DateTimeStyles.self) {
            self = .dateTimeStyles(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDateTimeStyles.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDateTimeStyles"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateTimeStyles(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DateTimeStyles
struct DateTimeStyles: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DateTimeStyles convenience initializers and mutators

extension DateTimeStyles {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateTimeStyles.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DateTimeStyles {
        return DateTimeStyles(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDebugger: Codable {
    case debugger(Debugger)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Debugger.self) {
            self = .debugger(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDebugger.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDebugger"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .debugger(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Debugger
struct Debugger: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Debugger convenience initializers and mutators

extension Debugger {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Debugger.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Debugger {
        return Debugger(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDecimal: Codable {
    case decimal(Decimal)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Decimal.self) {
            self = .decimal(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDecimal.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDecimal"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .decimal(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Decimal
struct Decimal: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Decimal convenience initializers and mutators

extension Decimal {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Decimal.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Decimal {
        return Decimal(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDeclare: Codable {
    case declare(Declare)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Declare.self) {
            self = .declare(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDeclare.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDeclare"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .declare(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Declare
struct Declare: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Declare convenience initializers and mutators

extension Declare {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Declare.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Declare {
        return Declare(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDecltype: Codable {
    case decltype(Decltype)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Decltype.self) {
            self = .decltype(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDecltype.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDecltype"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .decltype(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Decltype
struct Decltype: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Decltype convenience initializers and mutators

extension Decltype {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Decltype.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Decltype {
        return Decltype(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDecodeString: Codable {
    case decodeString(DecodeString)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DecodeString.self) {
            self = .decodeString(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDecodeString.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDecodeString"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .decodeString(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DecodeString
struct DecodeString: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DecodeString convenience initializers and mutators

extension DecodeString {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DecodeString.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DecodeString {
        return DecodeString(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDecoder: Codable {
    case decoderClass(DecoderClass)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DecoderClass.self) {
            self = .decoderClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDecoder.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDecoder"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .decoderClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DecoderClass
struct DecoderClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DecoderClass convenience initializers and mutators

extension DecoderClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DecoderClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DecoderClass {
        return DecoderClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDecodingError: Codable {
    case decodingErrorClass(DecodingErrorClass)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DecodingErrorClass.self) {
            self = .decodingErrorClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDecodingError.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDecodingError"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .decodingErrorClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DecodingErrorClass
struct DecodingErrorClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DecodingErrorClass convenience initializers and mutators

extension DecodingErrorClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DecodingErrorClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DecodingErrorClass {
        return DecodingErrorClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDef: Codable {
    case def(Def)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Def.self) {
            self = .def(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDef.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDef"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .def(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Def
struct Def: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Def convenience initializers and mutators

extension Def {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Def.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Def {
        return Def(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDel: Codable {
    case del(Del)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Del.self) {
            self = .del(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDel.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDel"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .del(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Del
struct Del: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Del convenience initializers and mutators

extension Del {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Del.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Del {
        return Del(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDelegate: Codable {
    case delegate(Delegate)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Delegate.self) {
            self = .delegate(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDelegate.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDelegate"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .delegate(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Delegate
struct Delegate: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Delegate convenience initializers and mutators

extension Delegate {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Delegate.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Delegate {
        return Delegate(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDelete: Codable {
    case delete(Delete)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Delete.self) {
            self = .delete(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDelete.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDelete"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .delete(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Delete
struct Delete: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Delete convenience initializers and mutators

extension Delete {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Delete.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Delete {
        return Delete(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDeserializationFeature: Codable {
    case deserializationFeature(DeserializationFeature)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DeserializationFeature.self) {
            self = .deserializationFeature(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDeserializationFeature.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDeserializationFeature"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .deserializationFeature(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DeserializationFeature
struct DeserializationFeature: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DeserializationFeature convenience initializers and mutators

extension DeserializationFeature {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DeserializationFeature.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DeserializationFeature {
        return DeserializationFeature(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDict: Codable {
    case dict(Dict)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Dict.self) {
            self = .dict(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDict.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDict"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dict(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Dict
struct Dict: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Dict convenience initializers and mutators

extension Dict {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Dict.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Dict {
        return Dict(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDictionary: Codable {
    case dictionary(Dictionary)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Dictionary.self) {
            self = .dictionary(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDictionary.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDictionary"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dictionary(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Dictionary
struct Dictionary: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Dictionary convenience initializers and mutators

extension Dictionary {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Dictionary.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Dictionary {
        return Dictionary(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDouble: Codable {
    case double(Double)
    case doubleClass(DoubleClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DoubleClass.self) {
            self = .doubleClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDouble.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDouble"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .doubleClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DoubleClass
struct DoubleClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DoubleClass convenience initializers and mutators

extension DoubleClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DoubleClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DoubleClass {
        return DoubleClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDoubleNode: Codable {
    case double(Double)
    case doubleNode(DoubleNode)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DoubleNode.self) {
            self = .doubleNode(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDoubleNode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDoubleNode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .doubleNode(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DoubleNode
struct DoubleNode: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DoubleNode convenience initializers and mutators

extension DoubleNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DoubleNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DoubleNode {
        return DoubleNode(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDynamicCast: Codable {
    case double(Double)
    case dynamicCast(DynamicCast)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DynamicCast.self) {
            self = .dynamicCast(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDynamicCast.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDynamicCast"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .dynamicCast(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DynamicCast
struct DynamicCast: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DynamicCast convenience initializers and mutators

extension DynamicCast {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DynamicCast.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DynamicCast {
        return DynamicCast(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionElif: Codable {
    case double(Double)
    case elif(Elif)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Elif.self) {
            self = .elif(x)
            return
        }
        throw DecodingError.typeMismatch(UnionElif.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionElif"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .elif(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Elif
struct Elif: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Elif convenience initializers and mutators

extension Elif {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Elif.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Elif {
        return Elif(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUnion: Codable {
    case double(Double)
    case empty(Empty)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Empty.self) {
            self = .empty(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .empty(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Empty
struct Empty: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Empty convenience initializers and mutators

extension Empty {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Empty.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Empty {
        return Empty(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionEncodeQuickType: Codable {
    case double(Double)
    case encodeQuickType(EncodeQuickType)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(EncodeQuickType.self) {
            self = .encodeQuickType(x)
            return
        }
        throw DecodingError.typeMismatch(UnionEncodeQuickType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionEncodeQuickType"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .encodeQuickType(let x):
            try container.encode(x)
        }
    }
}

// MARK: - EncodeQuickType
struct EncodeQuickType: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: EncodeQuickType convenience initializers and mutators

extension EncodeQuickType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EncodeQuickType.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> EncodeQuickType {
        return EncodeQuickType(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionEncoder: Codable {
    case double(Double)
    case encoderClass(EncoderClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(EncoderClass.self) {
            self = .encoderClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionEncoder.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionEncoder"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .encoderClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - EncoderClass
struct EncoderClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: EncoderClass convenience initializers and mutators

extension EncoderClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EncoderClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> EncoderClass {
        return EncoderClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionEnumValues: Codable {
    case double(Double)
    case enumValues(EnumValues)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(EnumValues.self) {
            self = .enumValues(x)
            return
        }
        throw DecodingError.typeMismatch(UnionEnumValues.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionEnumValues"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .enumValues(let x):
            try container.encode(x)
        }
    }
}

// MARK: - EnumValues
struct EnumValues: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: EnumValues convenience initializers and mutators

extension EnumValues {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EnumValues.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> EnumValues {
        return EnumValues(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionEqualityContract: Codable {
    case double(Double)
    case equalityContract(EqualityContract)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(EqualityContract.self) {
            self = .equalityContract(x)
            return
        }
        throw DecodingError.typeMismatch(UnionEqualityContract.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionEqualityContract"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .equalityContract(let x):
            try container.encode(x)
        }
    }
}

// MARK: - EqualityContract
struct EqualityContract: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: EqualityContract convenience initializers and mutators

extension EqualityContract {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EqualityContract.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> EqualityContract {
        return EqualityContract(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionEquatable: Codable {
    case double(Double)
    case equatable(Equatable)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Equatable.self) {
            self = .equatable(x)
            return
        }
        throw DecodingError.typeMismatch(UnionEquatable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionEquatable"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .equatable(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Equatable
struct Equatable: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Equatable convenience initializers and mutators

extension Equatable {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Equatable.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Equatable {
        return Equatable(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionEvent: Codable {
    case double(Double)
    case event(Event)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Event.self) {
            self = .event(x)
            return
        }
        throw DecodingError.typeMismatch(UnionEvent.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionEvent"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .event(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Event
struct Event: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Event convenience initializers and mutators

extension Event {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Event.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Event {
        return Event(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionExcept: Codable {
    case double(Double)
    case except(Except)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Except.self) {
            self = .except(x)
            return
        }
        throw DecodingError.typeMismatch(UnionExcept.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionExcept"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .except(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Except
struct Except: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Except convenience initializers and mutators

extension Except {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Except.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Except {
        return Except(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionException: Codable {
    case double(Double)
    case exception(Exception)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Exception.self) {
            self = .exception(x)
            return
        }
        throw DecodingError.typeMismatch(UnionException.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionException"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .exception(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Exception
struct Exception: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Exception convenience initializers and mutators

extension Exception {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Exception.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Exception {
        return Exception(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionExplicit: Codable {
    case double(Double)
    case explicit(Explicit)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Explicit.self) {
            self = .explicit(x)
            return
        }
        throw DecodingError.typeMismatch(UnionExplicit.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionExplicit"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .explicit(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Explicit
struct Explicit: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Explicit convenience initializers and mutators

extension Explicit {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Explicit.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Explicit {
        return Explicit(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionExport: Codable {
    case double(Double)
    case export(Export)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Export.self) {
            self = .export(x)
            return
        }
        throw DecodingError.typeMismatch(UnionExport.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionExport"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .export(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Export
struct Export: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Export convenience initializers and mutators

extension Export {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Export.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Export {
        return Export(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionExposing: Codable {
    case double(Double)
    case exposing(Exposing)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Exposing.self) {
            self = .exposing(x)
            return
        }
        throw DecodingError.typeMismatch(UnionExposing.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionExposing"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .exposing(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Exposing
struct Exposing: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Exposing convenience initializers and mutators

extension Exposing {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Exposing.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Exposing {
        return Exposing(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionExtends: Codable {
    case double(Double)
    case extends(Extends)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Extends.self) {
            self = .extends(x)
            return
        }
        throw DecodingError.typeMismatch(UnionExtends.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionExtends"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .extends(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Extends
struct Extends: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Extends convenience initializers and mutators

extension Extends {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Extends.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Extends {
        return Extends(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionExtern: Codable {
    case double(Double)
    case extern(Extern)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Extern.self) {
            self = .extern(x)
            return
        }
        throw DecodingError.typeMismatch(UnionExtern.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionExtern"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .extern(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Extern
struct Extern: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Extern convenience initializers and mutators

extension Extern {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Extern.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Extern {
        return Extern(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFinally: Codable {
    case double(Double)
    case finally(Finally)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Finally.self) {
            self = .finally(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFinally.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFinally"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .finally(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Finally
struct Finally: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Finally convenience initializers and mutators

extension Finally {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Finally.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Finally {
        return Finally(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFixed: Codable {
    case double(Double)
    case fixed(Fixed)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Fixed.self) {
            self = .fixed(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFixed.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFixed"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .fixed(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Fixed
struct Fixed: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Fixed convenience initializers and mutators

extension Fixed {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Fixed.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Fixed {
        return Fixed(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFloat: Codable {
    case double(Double)
    case float(Float)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Float.self) {
            self = .float(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFloat.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFloat"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .float(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Float
struct Float: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Float convenience initializers and mutators

extension Float {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Float.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Float {
        return Float(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionForeach: Codable {
    case double(Double)
    case foreach(Foreach)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Foreach.self) {
            self = .foreach(x)
            return
        }
        throw DecodingError.typeMismatch(UnionForeach.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionForeach"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .foreach(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Foreach
struct Foreach: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Foreach convenience initializers and mutators

extension Foreach {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Foreach.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Foreach {
        return Foreach(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFormatException: Codable {
    case double(Double)
    case formatException(FormatException)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(FormatException.self) {
            self = .formatException(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFormatException.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFormatException"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .formatException(let x):
            try container.encode(x)
        }
    }
}

// MARK: - FormatException
struct FormatException: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: FormatException convenience initializers and mutators

extension FormatException {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FormatException.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> FormatException {
        return FormatException(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFriend: Codable {
    case double(Double)
    case friend(Friend)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Friend.self) {
            self = .friend(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFriend.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFriend"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .friend(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Friend
struct Friend: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Friend convenience initializers and mutators

extension Friend {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Friend.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Friend {
        return Friend(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFrom: Codable {
    case double(Double)
    case from(From)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(From.self) {
            self = .from(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFrom.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFrom"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .from(let x):
            try container.encode(x)
        }
    }
}

// MARK: - From
struct From: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: From convenience initializers and mutators

extension From {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(From.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> From {
        return From(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFromDict: Codable {
    case double(Double)
    case fromDict(FromDict)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(FromDict.self) {
            self = .fromDict(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFromDict.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFromDict"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .fromDict(let x):
            try container.encode(x)
        }
    }
}

// MARK: - FromDict
struct FromDict: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: FromDict convenience initializers and mutators

extension FromDict {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FromDict.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> FromDict {
        return FromDict(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFromJSON: Codable {
    case double(Double)
    case fromJSON(FromJSON)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(FromJSON.self) {
            self = .fromJSON(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFromJSON.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFromJSON"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .fromJSON(let x):
            try container.encode(x)
        }
    }
}

// MARK: - FromJSON
struct FromJSON: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: FromJSON convenience initializers and mutators

extension FromJSON {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FromJSON.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> FromJSON {
        return FromJSON(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFunction: Codable {
    case double(Double)
    case function(Function)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Function.self) {
            self = .function(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFunction.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFunction"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .function(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Function
struct Function: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Function convenience initializers and mutators

extension Function {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Function.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Function {
        return Function(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionGlobal: Codable {
    case double(Double)
    case global(Global)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Global.self) {
            self = .global(x)
            return
        }
        throw DecodingError.typeMismatch(UnionGlobal.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionGlobal"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .global(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Global
struct Global: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Global convenience initializers and mutators

extension Global {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Global.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Global {
        return Global(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionGo: Codable {
    case double(Double)
    case go(Go)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Go.self) {
            self = .go(x)
            return
        }
        throw DecodingError.typeMismatch(UnionGo.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionGo"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .go(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Go
struct Go: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Go convenience initializers and mutators

extension Go {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Go.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Go {
        return Go(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionGoto: Codable {
    case double(Double)
    case goto(Goto)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Goto.self) {
            self = .goto(x)
            return
        }
        throw DecodingError.typeMismatch(UnionGoto.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionGoto"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .goto(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Goto
struct Goto: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Goto convenience initializers and mutators

extension Goto {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Goto.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Goto {
        return Goto(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionHasOwnProperty: Codable {
    case double(Double)
    case hasOwnProperty(HasOwnProperty)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(HasOwnProperty.self) {
            self = .hasOwnProperty(x)
            return
        }
        throw DecodingError.typeMismatch(UnionHasOwnProperty.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionHasOwnProperty"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .hasOwnProperty(let x):
            try container.encode(x)
        }
    }
}

// MARK: - HasOwnProperty
struct HasOwnProperty: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: HasOwnProperty convenience initializers and mutators

extension HasOwnProperty {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HasOwnProperty.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> HasOwnProperty {
        return HasOwnProperty(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionHashCode: Codable {
    case double(Double)
    case hashCode(HashCode)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(HashCode.self) {
            self = .hashCode(x)
            return
        }
        throw DecodingError.typeMismatch(UnionHashCode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionHashCode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .hashCode(let x):
            try container.encode(x)
        }
    }
}

// MARK: - HashCode
struct HashCode: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: HashCode convenience initializers and mutators

extension HashCode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HashCode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> HashCode {
        return HashCode(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionHashable: Codable {
    case double(Double)
    case hashableClass(HashableClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(HashableClass.self) {
            self = .hashableClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionHashable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionHashable"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .hashableClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - HashableClass
struct HashableClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: HashableClass convenience initializers and mutators

extension HashableClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HashableClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> HashableClass {
        return HashableClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionHasher: Codable {
    case double(Double)
    case hasherClass(HasherClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(HasherClass.self) {
            self = .hasherClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionHasher.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionHasher"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .hasherClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - HasherClass
struct HasherClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: HasherClass convenience initializers and mutators

extension HasherClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HasherClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> HasherClass {
        return HasherClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionID: Codable {
    case double(Double)
    case id(ID)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ID.self) {
            self = .id(x)
            return
        }
        throw DecodingError.typeMismatch(UnionID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionID"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .id(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ID
struct ID: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ID convenience initializers and mutators

extension ID {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ID.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ID {
        return ID(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionImaginery: Codable {
    case double(Double)
    case imaginery(Imaginery)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Imaginery.self) {
            self = .imaginery(x)
            return
        }
        throw DecodingError.typeMismatch(UnionImaginery.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionImaginery"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .imaginery(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Imaginery
struct Imaginery: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Imaginery convenience initializers and mutators

extension Imaginery {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Imaginery.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Imaginery {
        return Imaginery(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionIMP: Codable {
    case double(Double)
    case imp(Imp)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Imp.self) {
            self = .imp(x)
            return
        }
        throw DecodingError.typeMismatch(UnionIMP.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionIMP"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .imp(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Imp
struct Imp: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Imp convenience initializers and mutators

extension Imp {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Imp.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Imp {
        return Imp(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionImplements: Codable {
    case double(Double)
    case implements(Implements)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Implements.self) {
            self = .implements(x)
            return
        }
        throw DecodingError.typeMismatch(UnionImplements.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionImplements"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .implements(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Implements
struct Implements: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Implements convenience initializers and mutators

extension Implements {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Implements.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Implements {
        return Implements(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionImplicit: Codable {
    case double(Double)
    case implicit(Implicit)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Implicit.self) {
            self = .implicit(x)
            return
        }
        throw DecodingError.typeMismatch(UnionImplicit.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionImplicit"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .implicit(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Implicit
struct Implicit: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Implicit convenience initializers and mutators

extension Implicit {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Implicit.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Implicit {
        return Implicit(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionInline: Codable {
    case double(Double)
    case inline(Inline)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Inline.self) {
            self = .inline(x)
            return
        }
        throw DecodingError.typeMismatch(UnionInline.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionInline"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .inline(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Inline
struct Inline: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Inline convenience initializers and mutators

extension Inline {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Inline.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Inline {
        return Inline(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionInstanceof: Codable {
    case double(Double)
    case instanceof(Instanceof)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Instanceof.self) {
            self = .instanceof(x)
            return
        }
        throw DecodingError.typeMismatch(UnionInstanceof.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionInstanceof"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .instanceof(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Instanceof
struct Instanceof: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Instanceof convenience initializers and mutators

extension Instanceof {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Instanceof.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Instanceof {
        return Instanceof(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionInt: Codable {
    case double(Double)
    case intClass(IntClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(IntClass.self) {
            self = .intClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionInt"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .intClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - IntClass
struct IntClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: IntClass convenience initializers and mutators

extension IntClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IntClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> IntClass {
        return IntClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionIntNode: Codable {
    case double(Double)
    case intNode(IntNode)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(IntNode.self) {
            self = .intNode(x)
            return
        }
        throw DecodingError.typeMismatch(UnionIntNode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionIntNode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .intNode(let x):
            try container.encode(x)
        }
    }
}

// MARK: - IntNode
struct IntNode: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: IntNode convenience initializers and mutators

extension IntNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IntNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> IntNode {
        return IntNode(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionInterface: Codable {
    case double(Double)
    case interface(Interface)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Interface.self) {
            self = .interface(x)
            return
        }
        throw DecodingError.typeMismatch(UnionInterface.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionInterface"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .interface(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Interface
struct Interface: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Interface convenience initializers and mutators

extension Interface {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Interface.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Interface {
        return Interface(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionISODateTimeOffsetConverter: Codable {
    case double(Double)
    case isoDateTimeOffsetConverter(ISODateTimeOffsetConverter)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ISODateTimeOffsetConverter.self) {
            self = .isoDateTimeOffsetConverter(x)
            return
        }
        throw DecodingError.typeMismatch(UnionISODateTimeOffsetConverter.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionISODateTimeOffsetConverter"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .isoDateTimeOffsetConverter(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ISODateTimeOffsetConverter
struct ISODateTimeOffsetConverter: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ISODateTimeOffsetConverter convenience initializers and mutators

extension ISODateTimeOffsetConverter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ISODateTimeOffsetConverter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ISODateTimeOffsetConverter {
        return ISODateTimeOffsetConverter(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionIterable: Codable {
    case double(Double)
    case iterable(Iterable)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Iterable.self) {
            self = .iterable(x)
            return
        }
        throw DecodingError.typeMismatch(UnionIterable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionIterable"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .iterable(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Iterable
struct Iterable: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Iterable convenience initializers and mutators

extension Iterable {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Iterable.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Iterable {
        return Iterable(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJdec: Codable {
    case double(Double)
    case jdec(Jdec)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Jdec.self) {
            self = .jdec(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJdec.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJdec"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jdec(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Jdec
struct Jdec: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Jdec convenience initializers and mutators

extension Jdec {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Jdec.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Jdec {
        return Jdec(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJenc: Codable {
    case double(Double)
    case jenc(Jenc)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Jenc.self) {
            self = .jenc(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJenc.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJenc"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jenc(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Jenc
struct Jenc: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Jenc convenience initializers and mutators

extension Jenc {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Jenc.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Jenc {
        return Jenc(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJpipe: Codable {
    case double(Double)
    case jpipe(Jpipe)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Jpipe.self) {
            self = .jpipe(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJpipe.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJpipe"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jpipe(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Jpipe
struct Jpipe: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Jpipe convenience initializers and mutators

extension Jpipe {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Jpipe.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Jpipe {
        return Jpipe(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONAny: Codable {
    case double(Double)
    case jsonAnyClass(JSONAnyClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONAnyClass.self) {
            self = .jsonAnyClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONAny.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONAny"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonAnyClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONAnyClass
struct JSONAnyClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONAnyClass convenience initializers and mutators

extension JSONAnyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONAnyClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONAnyClass {
        return JSONAnyClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONCodingKey: Codable {
    case double(Double)
    case jsonCodingKeyClass(JSONCodingKeyClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONCodingKeyClass.self) {
            self = .jsonCodingKeyClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONCodingKey.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONCodingKey"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonCodingKeyClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONCodingKeyClass
struct JSONCodingKeyClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONCodingKeyClass convenience initializers and mutators

extension JSONCodingKeyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONCodingKeyClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONCodingKeyClass {
        return JSONCodingKeyClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONConverter: Codable {
    case double(Double)
    case jsonConverter(JSONConverter)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONConverter.self) {
            self = .jsonConverter(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONConverter.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONConverter"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonConverter(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONConverter
struct JSONConverter: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONConverter convenience initializers and mutators

extension JSONConverter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONConverter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONConverter {
        return JSONConverter(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONDecoder: Codable {
    case double(Double)
    case jsonDecoderClass(JSONDecoderClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONDecoderClass.self) {
            self = .jsonDecoderClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONDecoder.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONDecoder"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonDecoderClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONDecoderClass
struct JSONDecoderClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONDecoderClass convenience initializers and mutators

extension JSONDecoderClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONDecoderClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONDecoderClass {
        return JSONDecoderClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONEncoder: Codable {
    case double(Double)
    case jsonEncoderClass(JSONEncoderClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONEncoderClass.self) {
            self = .jsonEncoderClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONEncoder.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONEncoder"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonEncoderClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONEncoderClass
struct JSONEncoderClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONEncoderClass convenience initializers and mutators

extension JSONEncoderClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONEncoderClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONEncoderClass {
        return JSONEncoderClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONException: Codable {
    case double(Double)
    case jsonException(JSONException)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONException.self) {
            self = .jsonException(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONException.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONException"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonException(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONException
struct JSONException: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONException convenience initializers and mutators

extension JSONException {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONException.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONException {
        return JSONException(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONGenerator: Codable {
    case double(Double)
    case jsonGenerator(JSONGenerator)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONGenerator.self) {
            self = .jsonGenerator(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONGenerator.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONGenerator"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonGenerator(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONGenerator
struct JSONGenerator: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONGenerator convenience initializers and mutators

extension JSONGenerator {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONGenerator.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONGenerator {
        return JSONGenerator(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONNode: Codable {
    case double(Double)
    case jsonNode(JSONNode)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONNode.self) {
            self = .jsonNode(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONNode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONNode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonNode(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONNode
struct JSONNode: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONNode convenience initializers and mutators

extension JSONNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONNode {
        return JSONNode(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONNull: Codable {
    case double(Double)
    case jsonNullClass(JSONNullClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONNullClass.self) {
            self = .jsonNullClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONNull"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonNullClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONNullClass
struct JSONNullClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONNullClass convenience initializers and mutators

extension JSONNullClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONNullClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONNullClass {
        return JSONNullClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONParser: Codable {
    case double(Double)
    case jsonParser(JSONParser)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONParser.self) {
            self = .jsonParser(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONParser.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONParser"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonParser(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONParser
struct JSONParser: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONParser convenience initializers and mutators

extension JSONParser {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONParser.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONParser {
        return JSONParser(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONReader: Codable {
    case double(Double)
    case jsonReader(JSONReader)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONReader.self) {
            self = .jsonReader(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONReader.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONReader"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonReader(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONReader
struct JSONReader: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONReader convenience initializers and mutators

extension JSONReader {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONReader.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONReader {
        return JSONReader(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONSerializer: Codable {
    case double(Double)
    case jsonSerializer(JSONSerializer)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONSerializer.self) {
            self = .jsonSerializer(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONSerializer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONSerializer"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonSerializer(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONSerializer
struct JSONSerializer: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONSerializer convenience initializers and mutators

extension JSONSerializer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONSerializer.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONSerializer {
        return JSONSerializer(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONToken: Codable {
    case double(Double)
    case jsonToken(JSONToken)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONToken.self) {
            self = .jsonToken(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONToken.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONToken"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonToken(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONToken
struct JSONToken: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONToken convenience initializers and mutators

extension JSONToken {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONToken.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONToken {
        return JSONToken(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONTokenType: Codable {
    case double(Double)
    case jsonTokenType(JSONTokenType)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONTokenType.self) {
            self = .jsonTokenType(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONTokenType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONTokenType"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonTokenType(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONTokenType
struct JSONTokenType: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONTokenType convenience initializers and mutators

extension JSONTokenType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONTokenType.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONTokenType {
        return JSONTokenType(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSONWriter: Codable {
    case double(Double)
    case jsonWriter(JSONWriter)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSONWriter.self) {
            self = .jsonWriter(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSONWriter.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSONWriter"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .jsonWriter(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSONWriter
struct JSONWriter: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSONWriter convenience initializers and mutators

extension JSONWriter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONWriter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSONWriter {
        return JSONWriter(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionKSerializer: Codable {
    case double(Double)
    case kSerializer(KSerializer)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(KSerializer.self) {
            self = .kSerializer(x)
            return
        }
        throw DecodingError.typeMismatch(UnionKSerializer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionKSerializer"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .kSerializer(let x):
            try container.encode(x)
        }
    }
}

// MARK: - KSerializer
struct KSerializer: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: KSerializer convenience initializers and mutators

extension KSerializer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(KSerializer.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> KSerializer {
        return KSerializer(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionLambda: Codable {
    case double(Double)
    case lambda(Lambda)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Lambda.self) {
            self = .lambda(x)
            return
        }
        throw DecodingError.typeMismatch(UnionLambda.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionLambda"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .lambda(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Lambda
struct Lambda: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Lambda convenience initializers and mutators

extension Lambda {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Lambda.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Lambda {
        return Lambda(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionList: Codable {
    case double(Double)
    case list(List)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(List.self) {
            self = .list(x)
            return
        }
        throw DecodingError.typeMismatch(UnionList.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionList"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .list(let x):
            try container.encode(x)
        }
    }
}

// MARK: - List
struct List: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: List convenience initializers and mutators

extension List {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(List.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> List {
        return List(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionLocalDate: Codable {
    case double(Double)
    case localDate(LocalDate)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(LocalDate.self) {
            self = .localDate(x)
            return
        }
        throw DecodingError.typeMismatch(UnionLocalDate.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionLocalDate"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .localDate(let x):
            try container.encode(x)
        }
    }
}

// MARK: - LocalDate
struct LocalDate: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: LocalDate convenience initializers and mutators

extension LocalDate {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LocalDate.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> LocalDate {
        return LocalDate(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionLocale: Codable {
    case double(Double)
    case localeClass(LocaleClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(LocaleClass.self) {
            self = .localeClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionLocale.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionLocale"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .localeClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - LocaleClass
struct LocaleClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: LocaleClass convenience initializers and mutators

extension LocaleClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LocaleClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> LocaleClass {
        return LocaleClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionLock: Codable {
    case double(Double)
    case lock(Lock)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Lock.self) {
            self = .lock(x)
            return
        }
        throw DecodingError.typeMismatch(UnionLock.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionLock"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .lock(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Lock
struct Lock: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Lock convenience initializers and mutators

extension Lock {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Lock.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Lock {
        return Lock(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionLong: Codable {
    case double(Double)
    case long(Long)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Long.self) {
            self = .long(x)
            return
        }
        throw DecodingError.typeMismatch(UnionLong.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionLong"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .long(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Long
struct Long: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Long convenience initializers and mutators

extension Long {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Long.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Long {
        return Long(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionLongNode: Codable {
    case double(Double)
    case longNode(LongNode)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(LongNode.self) {
            self = .longNode(x)
            return
        }
        throw DecodingError.typeMismatch(UnionLongNode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionLongNode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .longNode(let x):
            try container.encode(x)
        }
    }
}

// MARK: - LongNode
struct LongNode: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: LongNode convenience initializers and mutators

extension LongNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LongNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> LongNode {
        return LongNode(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionMap: Codable {
    case double(Double)
    case map(Map)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Map.self) {
            self = .map(x)
            return
        }
        throw DecodingError.typeMismatch(UnionMap.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionMap"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .map(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Map
struct Map: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Map convenience initializers and mutators

extension Map {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Map.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Map {
        return Map(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionMapEntry: Codable {
    case double(Double)
    case mapEntry(MapEntry)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(MapEntry.self) {
            self = .mapEntry(x)
            return
        }
        throw DecodingError.typeMismatch(UnionMapEntry.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionMapEntry"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .mapEntry(let x):
            try container.encode(x)
        }
    }
}

// MARK: - MapEntry
struct MapEntry: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: MapEntry convenience initializers and mutators

extension MapEntry {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MapEntry.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> MapEntry {
        return MapEntry(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionMarshalJSON: Codable {
    case double(Double)
    case marshalJSON(MarshalJSON)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(MarshalJSON.self) {
            self = .marshalJSON(x)
            return
        }
        throw DecodingError.typeMismatch(UnionMarshalJSON.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionMarshalJSON"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .marshalJSON(let x):
            try container.encode(x)
        }
    }
}

// MARK: - MarshalJSON
struct MarshalJSON: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: MarshalJSON convenience initializers and mutators

extension MarshalJSON {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MarshalJSON.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> MarshalJSON {
        return MarshalJSON(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionMetadataPropertyHandling: Codable {
    case double(Double)
    case metadataPropertyHandling(MetadataPropertyHandling)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(MetadataPropertyHandling.self) {
            self = .metadataPropertyHandling(x)
            return
        }
        throw DecodingError.typeMismatch(UnionMetadataPropertyHandling.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionMetadataPropertyHandling"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .metadataPropertyHandling(let x):
            try container.encode(x)
        }
    }
}

// MARK: - MetadataPropertyHandling
struct MetadataPropertyHandling: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: MetadataPropertyHandling convenience initializers and mutators

extension MetadataPropertyHandling {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MetadataPropertyHandling.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> MetadataPropertyHandling {
        return MetadataPropertyHandling(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionModule: Codable {
    case double(Double)
    case module(Module)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Module.self) {
            self = .module(x)
            return
        }
        throw DecodingError.typeMismatch(UnionModule.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionModule"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .module(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Module
struct Module: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Module convenience initializers and mutators

extension Module {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Module.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Module {
        return Module(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionMutable: Codable {
    case double(Double)
    case mutable(Mutable)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Mutable.self) {
            self = .mutable(x)
            return
        }
        throw DecodingError.typeMismatch(UnionMutable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionMutable"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .mutable(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Mutable
struct Mutable: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Mutable convenience initializers and mutators

extension Mutable {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Mutable.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Mutable {
        return Mutable(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNamespace: Codable {
    case double(Double)
    case namespace(Namespace)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Namespace.self) {
            self = .namespace(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNamespace.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNamespace"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .namespace(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Namespace
struct Namespace: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Namespace convenience initializers and mutators

extension Namespace {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Namespace.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Namespace {
        return Namespace(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNative: Codable {
    case double(Double)
    case native(Native)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Native.self) {
            self = .native(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNative.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNative"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .native(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Native
struct Native: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Native convenience initializers and mutators

extension Native {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Native.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Native {
        return Native(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNew: Codable {
    case double(Double)
    case new(New)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(New.self) {
            self = .new(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNew.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNew"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .new(let x):
            try container.encode(x)
        }
    }
}

// MARK: - New
struct New: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: New convenience initializers and mutators

extension New {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(New.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> New {
        return New(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNewtonsoft: Codable {
    case double(Double)
    case newtonsoft(Newtonsoft)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Newtonsoft.self) {
            self = .newtonsoft(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNewtonsoft.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNewtonsoft"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .newtonsoft(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Newtonsoft
struct Newtonsoft: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Newtonsoft convenience initializers and mutators

extension Newtonsoft {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Newtonsoft.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Newtonsoft {
        return Newtonsoft(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNO: Codable {
    case double(Double)
    case no(No)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(No.self) {
            self = .no(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNO.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNO"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .no(let x):
            try container.encode(x)
        }
    }
}

// MARK: - No
struct No: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: No convenience initializers and mutators

extension No {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(No.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> No {
        return No(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNoSuchMethod: Codable {
    case double(Double)
    case noSuchMethod(NoSuchMethod)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(NoSuchMethod.self) {
            self = .noSuchMethod(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNoSuchMethod.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNoSuchMethod"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .noSuchMethod(let x):
            try container.encode(x)
        }
    }
}

// MARK: - NoSuchMethod
struct NoSuchMethod: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: NoSuchMethod convenience initializers and mutators

extension NoSuchMethod {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NoSuchMethod.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> NoSuchMethod {
        return NoSuchMethod(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNoexcept: Codable {
    case double(Double)
    case noexcept(Noexcept)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Noexcept.self) {
            self = .noexcept(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNoexcept.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNoexcept"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .noexcept(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Noexcept
struct Noexcept: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Noexcept convenience initializers and mutators

extension Noexcept {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Noexcept.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Noexcept {
        return Noexcept(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNonatomic: Codable {
    case double(Double)
    case nonatomic(Nonatomic)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Nonatomic.self) {
            self = .nonatomic(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNonatomic.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNonatomic"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .nonatomic(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Nonatomic
struct Nonatomic: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Nonatomic convenience initializers and mutators

extension Nonatomic {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Nonatomic.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Nonatomic {
        return Nonatomic(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNone: Codable {
    case double(Double)
    case none(None)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(None.self) {
            self = .none(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNone.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNone"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .none(let x):
            try container.encode(x)
        }
    }
}

// MARK: - None
struct None: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: None convenience initializers and mutators

extension None {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(None.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> None {
        return None(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNonlocal: Codable {
    case double(Double)
    case nonlocal(Nonlocal)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Nonlocal.self) {
            self = .nonlocal(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNonlocal.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNonlocal"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .nonlocal(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Nonlocal
struct Nonlocal: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Nonlocal convenience initializers and mutators

extension Nonlocal {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Nonlocal.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Nonlocal {
        return Nonlocal(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNot: Codable {
    case double(Double)
    case not(Not)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Not.self) {
            self = .not(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNot.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNot"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .not(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Not
struct Not: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Not convenience initializers and mutators

extension Not {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Not.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Not {
        return Not(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNotEq: Codable {
    case double(Double)
    case notEq(NotEq)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(NotEq.self) {
            self = .notEq(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNotEq.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNotEq"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .notEq(let x):
            try container.encode(x)
        }
    }
}

// MARK: - NotEq
struct NotEq: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: NotEq convenience initializers and mutators

extension NotEq {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NotEq.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> NotEq {
        return NotEq(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNSError: Codable {
    case double(Double)
    case nsErrorClass(NSErrorClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(NSErrorClass.self) {
            self = .nsErrorClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNSError.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNSError"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .nsErrorClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - NSErrorClass
struct NSErrorClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: NSErrorClass convenience initializers and mutators

extension NSErrorClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NSErrorClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> NSErrorClass {
        return NSErrorClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNSObject: Codable {
    case double(Double)
    case nsObject(NSObject)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(NSObject.self) {
            self = .nsObject(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNSObject.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNSObject"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .nsObject(let x):
            try container.encode(x)
        }
    }
}

// MARK: - NSObject
struct NSObject: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: NSObject convenience initializers and mutators

extension NSObject {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NSObject.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> NSObject {
        return NSObject(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNSString: Codable {
    case double(Double)
    case nsString(NSString)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(NSString.self) {
            self = .nsString(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNSString.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNSString"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .nsString(let x):
            try container.encode(x)
        }
    }
}

// MARK: - NSString
struct NSString: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: NSString convenience initializers and mutators

extension NSString {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NSString.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> NSString {
        return NSString(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNULL: Codable {
    case double(Double)
    case null(Null)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Null.self) {
            self = .null(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNULL.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNULL"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .null(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Null
struct Null: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Null convenience initializers and mutators

extension Null {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Null.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Null {
        return Null(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNullNode: Codable {
    case double(Double)
    case nullNode(NullNode)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(NullNode.self) {
            self = .nullNode(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNullNode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNullNode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .nullNode(let x):
            try container.encode(x)
        }
    }
}

// MARK: - NullNode
struct NullNode: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: NullNode convenience initializers and mutators

extension NullNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NullNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> NullNode {
        return NullNode(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNullptr: Codable {
    case double(Double)
    case nullptr(Nullptr)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Nullptr.self) {
            self = .nullptr(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNullptr.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNullptr"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .nullptr(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Nullptr
struct Nullptr: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Nullptr convenience initializers and mutators

extension Nullptr {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Nullptr.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Nullptr {
        return Nullptr(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNumber: Codable {
    case double(Double)
    case number(Number)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Number.self) {
            self = .number(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNumber.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNumber"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .number(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Number
struct Number: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Number convenience initializers and mutators

extension Number {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Number.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Number {
        return Number(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionObject: Codable {
    case double(Double)
    case object(Object)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Object.self) {
            self = .object(x)
            return
        }
        throw DecodingError.typeMismatch(UnionObject.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionObject"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .object(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Object
struct Object: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Object convenience initializers and mutators

extension Object {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Object.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Object {
        return Object(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionObjectMapper: Codable {
    case double(Double)
    case objectMapper(ObjectMapper)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ObjectMapper.self) {
            self = .objectMapper(x)
            return
        }
        throw DecodingError.typeMismatch(UnionObjectMapper.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionObjectMapper"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .objectMapper(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ObjectMapper
struct ObjectMapper: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ObjectMapper convenience initializers and mutators

extension ObjectMapper {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ObjectMapper.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ObjectMapper {
        return ObjectMapper(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionObjectNode: Codable {
    case double(Double)
    case objectNode(ObjectNode)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ObjectNode.self) {
            self = .objectNode(x)
            return
        }
        throw DecodingError.typeMismatch(UnionObjectNode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionObjectNode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .objectNode(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ObjectNode
struct ObjectNode: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ObjectNode convenience initializers and mutators

extension ObjectNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ObjectNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ObjectNode {
        return ObjectNode(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionObjectReader: Codable {
    case double(Double)
    case objectReader(ObjectReader)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ObjectReader.self) {
            self = .objectReader(x)
            return
        }
        throw DecodingError.typeMismatch(UnionObjectReader.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionObjectReader"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .objectReader(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ObjectReader
struct ObjectReader: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ObjectReader convenience initializers and mutators

extension ObjectReader {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ObjectReader.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ObjectReader {
        return ObjectReader(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionObjectWriter: Codable {
    case double(Double)
    case objectWriter(ObjectWriter)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ObjectWriter.self) {
            self = .objectWriter(x)
            return
        }
        throw DecodingError.typeMismatch(UnionObjectWriter.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionObjectWriter"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .objectWriter(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ObjectWriter
struct ObjectWriter: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ObjectWriter convenience initializers and mutators

extension ObjectWriter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ObjectWriter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ObjectWriter {
        return ObjectWriter(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionOf: Codable {
    case double(Double)
    case of(Of)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Of.self) {
            self = .of(x)
            return
        }
        throw DecodingError.typeMismatch(UnionOf.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionOf"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .of(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Of
struct Of: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Of convenience initializers and mutators

extension Of {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Of.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Of {
        return Of(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionOffsetDateTime: Codable {
    case double(Double)
    case offsetDateTime(OffsetDateTime)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(OffsetDateTime.self) {
            self = .offsetDateTime(x)
            return
        }
        throw DecodingError.typeMismatch(UnionOffsetDateTime.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionOffsetDateTime"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .offsetDateTime(let x):
            try container.encode(x)
        }
    }
}

// MARK: - OffsetDateTime
struct OffsetDateTime: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: OffsetDateTime convenience initializers and mutators

extension OffsetDateTime {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OffsetDateTime.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> OffsetDateTime {
        return OffsetDateTime(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionOffsetTime: Codable {
    case double(Double)
    case offsetTime(OffsetTime)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(OffsetTime.self) {
            self = .offsetTime(x)
            return
        }
        throw DecodingError.typeMismatch(UnionOffsetTime.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionOffsetTime"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .offsetTime(let x):
            try container.encode(x)
        }
    }
}

// MARK: - OffsetTime
struct OffsetTime: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: OffsetTime convenience initializers and mutators

extension OffsetTime {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OffsetTime.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> OffsetTime {
        return OffsetTime(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionOneway: Codable {
    case double(Double)
    case oneway(Oneway)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Oneway.self) {
            self = .oneway(x)
            return
        }
        throw DecodingError.typeMismatch(UnionOneway.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionOneway"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .oneway(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Oneway
struct Oneway: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Oneway convenience initializers and mutators

extension Oneway {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Oneway.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Oneway {
        return Oneway(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionOr: Codable {
    case double(Double)
    case or(Or)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Or.self) {
            self = .or(x)
            return
        }
        throw DecodingError.typeMismatch(UnionOr.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionOr"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .or(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Or
struct Or: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Or convenience initializers and mutators

extension Or {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Or.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Or {
        return Or(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionOrEq: Codable {
    case double(Double)
    case orEq(OrEq)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(OrEq.self) {
            self = .orEq(x)
            return
        }
        throw DecodingError.typeMismatch(UnionOrEq.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionOrEq"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .orEq(let x):
            try container.encode(x)
        }
    }
}

// MARK: - OrEq
struct OrEq: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: OrEq convenience initializers and mutators

extension OrEq {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OrEq.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> OrEq {
        return OrEq(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionOut: Codable {
    case double(Double)
    case out(Out)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Out.self) {
            self = .out(x)
            return
        }
        throw DecodingError.typeMismatch(UnionOut.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionOut"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .out(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Out
struct Out: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Out convenience initializers and mutators

extension Out {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Out.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Out {
        return Out(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionPackage: Codable {
    case double(Double)
    case package(Package)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Package.self) {
            self = .package(x)
            return
        }
        throw DecodingError.typeMismatch(UnionPackage.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionPackage"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .package(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Package
struct Package: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Package convenience initializers and mutators

extension Package {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Package.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Package {
        return Package(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionParams: Codable {
    case double(Double)
    case params(Params)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Params.self) {
            self = .params(x)
            return
        }
        throw DecodingError.typeMismatch(UnionParams.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionParams"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .params(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Params
struct Params: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Params convenience initializers and mutators

extension Params {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Params.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Params {
        return Params(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionPass: Codable {
    case double(Double)
    case pass(Pass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Pass.self) {
            self = .pass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionPass.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionPass"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .pass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Pass
struct Pass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Pass convenience initializers and mutators

extension Pass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Pass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Pass {
        return Pass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionPort: Codable {
    case double(Double)
    case port(Port)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Port.self) {
            self = .port(x)
            return
        }
        throw DecodingError.typeMismatch(UnionPort.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionPort"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .port(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Port
struct Port: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Port convenience initializers and mutators

extension Port {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Port.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Port {
        return Port(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionPrimitiveKind: Codable {
    case double(Double)
    case primitiveKind(PrimitiveKind)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(PrimitiveKind.self) {
            self = .primitiveKind(x)
            return
        }
        throw DecodingError.typeMismatch(UnionPrimitiveKind.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionPrimitiveKind"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .primitiveKind(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PrimitiveKind
struct PrimitiveKind: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: PrimitiveKind convenience initializers and mutators

extension PrimitiveKind {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PrimitiveKind.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> PrimitiveKind {
        return PrimitiveKind(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionPrint: Codable {
    case double(Double)
    case print(Print)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Print.self) {
            self = .print(x)
            return
        }
        throw DecodingError.typeMismatch(UnionPrint.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionPrint"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .print(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Print
struct Print: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Print convenience initializers and mutators

extension Print {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Print.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Print {
        return Print(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionPrintMembers: Codable {
    case double(Double)
    case printMembers(PrintMembers)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(PrintMembers.self) {
            self = .printMembers(x)
            return
        }
        throw DecodingError.typeMismatch(UnionPrintMembers.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionPrintMembers"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .printMembers(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PrintMembers
struct PrintMembers: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: PrintMembers convenience initializers and mutators

extension PrintMembers {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PrintMembers.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> PrintMembers {
        return PrintMembers(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionPrintf: Codable {
    case double(Double)
    case printf(Printf)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Printf.self) {
            self = .printf(x)
            return
        }
        throw DecodingError.typeMismatch(UnionPrintf.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionPrintf"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .printf(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Printf
struct Printf: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Printf convenience initializers and mutators

extension Printf {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Printf.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Printf {
        return Printf(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionProtected: Codable {
    case double(Double)
    case protected(Protected)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Protected.self) {
            self = .protected(x)
            return
        }
        throw DecodingError.typeMismatch(UnionProtected.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionProtected"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .protected(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Protected
struct Protected: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Protected convenience initializers and mutators

extension Protected {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Protected.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Protected {
        return Protected(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionBoolUnion: Codable {
    case double(Double)
    case unionBoolBool(UnionBoolBool)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(UnionBoolBool.self) {
            self = .unionBoolBool(x)
            return
        }
        throw DecodingError.typeMismatch(UnionBoolUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionBoolUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .unionBoolBool(let x):
            try container.encode(x)
        }
    }
}

// MARK: - UnionBoolBool
struct UnionBoolBool: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: UnionBoolBool convenience initializers and mutators

extension UnionBoolBool {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UnionBoolBool.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> UnionBoolBool {
        return UnionBoolBool(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionClassUnion: Codable {
    case classClass(ClassClass)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ClassClass.self) {
            self = .classClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionClassUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionClassUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .classClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ClassClass
struct ClassClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ClassClass convenience initializers and mutators

extension ClassClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ClassClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ClassClass {
        return ClassClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFalseUnion: Codable {
    case double(Double)
    case falseClass(FalseClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(FalseClass.self) {
            self = .falseClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFalseUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFalseUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .falseClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - FalseClass
struct FalseClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: FalseClass convenience initializers and mutators

extension FalseClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FalseClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> FalseClass {
        return FalseClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionProtocolUnion: Codable {
    case double(Double)
    case unionProtocolProtocol(UnionProtocolProtocol)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(UnionProtocolProtocol.self) {
            self = .unionProtocolProtocol(x)
            return
        }
        throw DecodingError.typeMismatch(UnionProtocolUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionProtocolUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .unionProtocolProtocol(let x):
            try container.encode(x)
        }
    }
}

// MARK: - UnionProtocolProtocol
struct UnionProtocolProtocol: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: UnionProtocolProtocol convenience initializers and mutators

extension UnionProtocolProtocol {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UnionProtocolProtocol.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> UnionProtocolProtocol {
        return UnionProtocolProtocol(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSelfUnion: Codable {
    case double(Double)
    case unionSelfSelf(UnionSelfSelf)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(UnionSelfSelf.self) {
            self = .unionSelfSelf(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSelfUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSelfUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .unionSelfSelf(let x):
            try container.encode(x)
        }
    }
}

// MARK: - UnionSelfSelf
struct UnionSelfSelf: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: UnionSelfSelf convenience initializers and mutators

extension UnionSelfSelf {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UnionSelfSelf.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> UnionSelfSelf {
        return UnionSelfSelf(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTrueUnion: Codable {
    case double(Double)
    case trueClass(TrueClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(TrueClass.self) {
            self = .trueClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTrueUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTrueUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .trueClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - TrueClass
struct TrueClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: TrueClass convenience initializers and mutators

extension TrueClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TrueClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> TrueClass {
        return TrueClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionQuicktype: Codable {
    case double(Double)
    case quicktype(Quicktype)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Quicktype.self) {
            self = .quicktype(x)
            return
        }
        throw DecodingError.typeMismatch(UnionQuicktype.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionQuicktype"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .quicktype(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Quicktype
struct Quicktype: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Quicktype convenience initializers and mutators

extension Quicktype {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Quicktype.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Quicktype {
        return Quicktype(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRaise: Codable {
    case double(Double)
    case raise(Raise)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Raise.self) {
            self = .raise(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRaise.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRaise"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .raise(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Raise
struct Raise: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Raise convenience initializers and mutators

extension Raise {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Raise.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Raise {
        return Raise(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRange: Codable {
    case double(Double)
    case range(Range)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Range.self) {
            self = .range(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRange.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRange"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .range(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Range
struct Range: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Range convenience initializers and mutators

extension Range {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Range.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Range {
        return Range(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionReadonly: Codable {
    case double(Double)
    case readonly(Readonly)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Readonly.self) {
            self = .readonly(x)
            return
        }
        throw DecodingError.typeMismatch(UnionReadonly.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionReadonly"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .readonly(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Readonly
struct Readonly: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Readonly convenience initializers and mutators

extension Readonly {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Readonly.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Readonly {
        return Readonly(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRef: Codable {
    case double(Double)
    case ref(Ref)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Ref.self) {
            self = .ref(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRef.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRef"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .ref(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Ref
struct Ref: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Ref convenience initializers and mutators

extension Ref {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Ref.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Ref {
        return Ref(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRegExp: Codable {
    case double(Double)
    case regExp(RegExp)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(RegExp.self) {
            self = .regExp(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRegExp.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRegExp"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .regExp(let x):
            try container.encode(x)
        }
    }
}

// MARK: - RegExp
struct RegExp: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: RegExp convenience initializers and mutators

extension RegExp {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RegExp.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> RegExp {
        return RegExp(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRegister: Codable {
    case double(Double)
    case register(Register)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Register.self) {
            self = .register(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRegister.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRegister"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .register(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Register
struct Register: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Register convenience initializers and mutators

extension Register {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Register.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Register {
        return Register(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionReinterpretCast: Codable {
    case double(Double)
    case reinterpretCast(ReinterpretCast)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ReinterpretCast.self) {
            self = .reinterpretCast(x)
            return
        }
        throw DecodingError.typeMismatch(UnionReinterpretCast.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionReinterpretCast"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .reinterpretCast(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ReinterpretCast
struct ReinterpretCast: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ReinterpretCast convenience initializers and mutators

extension ReinterpretCast {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ReinterpretCast.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ReinterpretCast {
        return ReinterpretCast(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRequire: Codable {
    case double(Double)
    case require(Require)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Require.self) {
            self = .require(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRequire.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRequire"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .require(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Require
struct Require: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Require convenience initializers and mutators

extension Require {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Require.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Require {
        return Require(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRequires: Codable {
    case double(Double)
    case requires(Requires)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Requires.self) {
            self = .requires(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRequires.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRequires"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .requires(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Requires
struct Requires: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Requires convenience initializers and mutators

extension Requires {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Requires.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Requires {
        return Requires(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRestrict: Codable {
    case double(Double)
    case restrict(Restrict)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Restrict.self) {
            self = .restrict(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRestrict.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRestrict"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .restrict(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Restrict
struct Restrict: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Restrict convenience initializers and mutators

extension Restrict {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Restrict.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Restrict {
        return Restrict(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRetain: Codable {
    case double(Double)
    case retain(Retain)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Retain.self) {
            self = .retain(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRetain.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRetain"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .retain(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Retain
struct Retain: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Retain convenience initializers and mutators

extension Retain {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Retain.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Retain {
        return Retain(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRuntimeType: Codable {
    case double(Double)
    case runtimeType(RuntimeType)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(RuntimeType.self) {
            self = .runtimeType(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRuntimeType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRuntimeType"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .runtimeType(let x):
            try container.encode(x)
        }
    }
}

// MARK: - RuntimeType
struct RuntimeType: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: RuntimeType convenience initializers and mutators

extension RuntimeType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RuntimeType.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> RuntimeType {
        return RuntimeType(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionS: Codable {
    case double(Double)
    case s(S)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(S.self) {
            self = .s(x)
            return
        }
        throw DecodingError.typeMismatch(UnionS.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionS"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .s(let x):
            try container.encode(x)
        }
    }
}

// MARK: - S
struct S: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: S convenience initializers and mutators

extension S {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(S.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> S {
        return S(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSbyte: Codable {
    case double(Double)
    case sbyte(Sbyte)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Sbyte.self) {
            self = .sbyte(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSbyte.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSbyte"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .sbyte(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Sbyte
struct Sbyte: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Sbyte convenience initializers and mutators

extension Sbyte {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Sbyte.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Sbyte {
        return Sbyte(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSealed: Codable {
    case double(Double)
    case sealed(Sealed)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Sealed.self) {
            self = .sealed(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSealed.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSealed"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .sealed(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Sealed
struct Sealed: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Sealed convenience initializers and mutators

extension Sealed {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Sealed.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Sealed {
        return Sealed(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSEL: Codable {
    case double(Double)
    case sel(Sel)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Sel.self) {
            self = .sel(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSEL.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSEL"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .sel(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Sel
struct Sel: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Sel convenience initializers and mutators

extension Sel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Sel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Sel {
        return Sel(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSelect: Codable {
    case double(Double)
    case select(Select)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Select.self) {
            self = .select(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSelect.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSelect"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .select(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Select
struct Select: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Select convenience initializers and mutators

extension Select {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Select.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Select {
        return Select(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSendable: Codable {
    case double(Double)
    case sendable(Sendable)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Sendable.self) {
            self = .sendable(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSendable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSendable"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .sendable(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Sendable
struct Sendable: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Sendable convenience initializers and mutators

extension Sendable {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Sendable.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Sendable {
        return Sendable(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSerialDescriptor: Codable {
    case double(Double)
    case serialDescriptor(SerialDescriptor)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(SerialDescriptor.self) {
            self = .serialDescriptor(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSerialDescriptor.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSerialDescriptor"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .serialDescriptor(let x):
            try container.encode(x)
        }
    }
}

// MARK: - SerialDescriptor
struct SerialDescriptor: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: SerialDescriptor convenience initializers and mutators

extension SerialDescriptor {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SerialDescriptor.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> SerialDescriptor {
        return SerialDescriptor(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSerialName: Codable {
    case double(Double)
    case serialName(SerialName)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(SerialName.self) {
            self = .serialName(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSerialName.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSerialName"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .serialName(let x):
            try container.encode(x)
        }
    }
}

// MARK: - SerialName
struct SerialName: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: SerialName convenience initializers and mutators

extension SerialName {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SerialName.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> SerialName {
        return SerialName(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSerializable: Codable {
    case double(Double)
    case serializable(Serializable)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Serializable.self) {
            self = .serializable(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSerializable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSerializable"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .serializable(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Serializable
struct Serializable: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Serializable convenience initializers and mutators

extension Serializable {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Serializable.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Serializable {
        return Serializable(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSerializationFeature: Codable {
    case double(Double)
    case serializationFeature(SerializationFeature)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(SerializationFeature.self) {
            self = .serializationFeature(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSerializationFeature.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSerializationFeature"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .serializationFeature(let x):
            try container.encode(x)
        }
    }
}

// MARK: - SerializationFeature
struct SerializationFeature: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: SerializationFeature convenience initializers and mutators

extension SerializationFeature {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SerializationFeature.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> SerializationFeature {
        return SerializationFeature(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSerialize: Codable {
    case double(Double)
    case serialize(Serialize)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Serialize.self) {
            self = .serialize(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSerialize.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSerialize"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .serialize(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Serialize
struct Serialize: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Serialize convenience initializers and mutators

extension Serialize {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Serialize.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Serialize {
        return Serialize(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSerializerProvider: Codable {
    case double(Double)
    case serializerProvider(SerializerProvider)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(SerializerProvider.self) {
            self = .serializerProvider(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSerializerProvider.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSerializerProvider"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .serializerProvider(let x):
            try container.encode(x)
        }
    }
}

// MARK: - SerializerProvider
struct SerializerProvider: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: SerializerProvider convenience initializers and mutators

extension SerializerProvider {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SerializerProvider.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> SerializerProvider {
        return SerializerProvider(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionShort: Codable {
    case double(Double)
    case short(Short)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Short.self) {
            self = .short(x)
            return
        }
        throw DecodingError.typeMismatch(UnionShort.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionShort"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .short(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Short
struct Short: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Short convenience initializers and mutators

extension Short {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Short.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Short {
        return Short(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSigned: Codable {
    case double(Double)
    case signed(Signed)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Signed.self) {
            self = .signed(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSigned.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSigned"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .signed(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Signed
struct Signed: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Signed convenience initializers and mutators

extension Signed {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Signed.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Signed {
        return Signed(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSimpleModule: Codable {
    case double(Double)
    case simpleModule(SimpleModule)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(SimpleModule.self) {
            self = .simpleModule(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSimpleModule.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSimpleModule"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .simpleModule(let x):
            try container.encode(x)
        }
    }
}

// MARK: - SimpleModule
struct SimpleModule: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: SimpleModule convenience initializers and mutators

extension SimpleModule {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SimpleModule.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> SimpleModule {
        return SimpleModule(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSizeof: Codable {
    case double(Double)
    case sizeof(Sizeof)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Sizeof.self) {
            self = .sizeof(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSizeof.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSizeof"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .sizeof(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Sizeof
struct Sizeof: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Sizeof convenience initializers and mutators

extension Sizeof {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Sizeof.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Sizeof {
        return Sizeof(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionStackalloc: Codable {
    case double(Double)
    case stackalloc(Stackalloc)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Stackalloc.self) {
            self = .stackalloc(x)
            return
        }
        throw DecodingError.typeMismatch(UnionStackalloc.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionStackalloc"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .stackalloc(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Stackalloc
struct Stackalloc: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Stackalloc convenience initializers and mutators

extension Stackalloc {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Stackalloc.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Stackalloc {
        return Stackalloc(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionStandards: Codable {
    case double(Double)
    case standards(Standards)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Standards.self) {
            self = .standards(x)
            return
        }
        throw DecodingError.typeMismatch(UnionStandards.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionStandards"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .standards(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Standards
struct Standards: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Standards convenience initializers and mutators

extension Standards {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Standards.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Standards {
        return Standards(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionStaticAssert: Codable {
    case double(Double)
    case staticAssert(StaticAssert)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(StaticAssert.self) {
            self = .staticAssert(x)
            return
        }
        throw DecodingError.typeMismatch(UnionStaticAssert.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionStaticAssert"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .staticAssert(let x):
            try container.encode(x)
        }
    }
}

// MARK: - StaticAssert
struct StaticAssert: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: StaticAssert convenience initializers and mutators

extension StaticAssert {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StaticAssert.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> StaticAssert {
        return StaticAssert(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionStaticCast: Codable {
    case double(Double)
    case staticCast(StaticCast)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(StaticCast.self) {
            self = .staticCast(x)
            return
        }
        throw DecodingError.typeMismatch(UnionStaticCast.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionStaticCast"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .staticCast(let x):
            try container.encode(x)
        }
    }
}

// MARK: - StaticCast
struct StaticCast: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: StaticCast convenience initializers and mutators

extension StaticCast {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StaticCast.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> StaticCast {
        return StaticCast(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionStdDeserializer: Codable {
    case double(Double)
    case stdDeserializer(StdDeserializer)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(StdDeserializer.self) {
            self = .stdDeserializer(x)
            return
        }
        throw DecodingError.typeMismatch(UnionStdDeserializer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionStdDeserializer"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .stdDeserializer(let x):
            try container.encode(x)
        }
    }
}

// MARK: - StdDeserializer
struct StdDeserializer: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: StdDeserializer convenience initializers and mutators

extension StdDeserializer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StdDeserializer.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> StdDeserializer {
        return StdDeserializer(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionStdSerializer: Codable {
    case double(Double)
    case stdSerializer(StdSerializer)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(StdSerializer.self) {
            self = .stdSerializer(x)
            return
        }
        throw DecodingError.typeMismatch(UnionStdSerializer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionStdSerializer"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .stdSerializer(let x):
            try container.encode(x)
        }
    }
}

// MARK: - StdSerializer
struct StdSerializer: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: StdSerializer convenience initializers and mutators

extension StdSerializer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StdSerializer.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> StdSerializer {
        return StdSerializer(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionStrictfp: Codable {
    case double(Double)
    case strictfp(Strictfp)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Strictfp.self) {
            self = .strictfp(x)
            return
        }
        throw DecodingError.typeMismatch(UnionStrictfp.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionStrictfp"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .strictfp(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Strictfp
struct Strictfp: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Strictfp convenience initializers and mutators

extension Strictfp {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Strictfp.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Strictfp {
        return Strictfp(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionString: Codable {
    case double(Double)
    case stringClass(StringClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(StringClass.self) {
            self = .stringClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionString.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionString"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .stringClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - StringClass
struct StringClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: StringClass convenience initializers and mutators

extension StringClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StringClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> StringClass {
        return StringClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSymbol: Codable {
    case double(Double)
    case symbol(Symbol)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Symbol.self) {
            self = .symbol(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSymbol.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSymbol"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .symbol(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Symbol
struct Symbol: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Symbol convenience initializers and mutators

extension Symbol {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Symbol.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Symbol {
        return Symbol(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSynchronized: Codable {
    case double(Double)
    case synchronized(Synchronized)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Synchronized.self) {
            self = .synchronized(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSynchronized.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSynchronized"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .synchronized(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Synchronized
struct Synchronized: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Synchronized convenience initializers and mutators

extension Synchronized {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Synchronized.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Synchronized {
        return Synchronized(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSystem: Codable {
    case double(Double)
    case system(System)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(System.self) {
            self = .system(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSystem.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSystem"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .system(let x):
            try container.encode(x)
        }
    }
}

// MARK: - System
struct System: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: System convenience initializers and mutators

extension System {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(System.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> System {
        return System(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTemplate: Codable {
    case double(Double)
    case template(Template)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Template.self) {
            self = .template(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTemplate.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTemplate"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .template(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Template
struct Template: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Template convenience initializers and mutators

extension Template {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Template.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Template {
        return Template(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTextNode: Codable {
    case double(Double)
    case textNode(TextNode)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(TextNode.self) {
            self = .textNode(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTextNode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTextNode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .textNode(let x):
            try container.encode(x)
        }
    }
}

// MARK: - TextNode
struct TextNode: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: TextNode convenience initializers and mutators

extension TextNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TextNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> TextNode {
        return TextNode(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionThen: Codable {
    case double(Double)
    case then(Then)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Then.self) {
            self = .then(x)
            return
        }
        throw DecodingError.typeMismatch(UnionThen.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionThen"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .then(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Then
struct Then: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Then convenience initializers and mutators

extension Then {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Then.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Then {
        return Then(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionThis: Codable {
    case double(Double)
    case this(This)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(This.self) {
            self = .this(x)
            return
        }
        throw DecodingError.typeMismatch(UnionThis.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionThis"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .this(let x):
            try container.encode(x)
        }
    }
}

// MARK: - This
struct This: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: This convenience initializers and mutators

extension This {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(This.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> This {
        return This(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionThreadLocal: Codable {
    case double(Double)
    case threadLocal(ThreadLocal)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ThreadLocal.self) {
            self = .threadLocal(x)
            return
        }
        throw DecodingError.typeMismatch(UnionThreadLocal.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionThreadLocal"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .threadLocal(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ThreadLocal
struct ThreadLocal: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ThreadLocal convenience initializers and mutators

extension ThreadLocal {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ThreadLocal.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ThreadLocal {
        return ThreadLocal(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTimeOnly: Codable {
    case double(Double)
    case timeOnly(TimeOnly)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(TimeOnly.self) {
            self = .timeOnly(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTimeOnly.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTimeOnly"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .timeOnly(let x):
            try container.encode(x)
        }
    }
}

// MARK: - TimeOnly
struct TimeOnly: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: TimeOnly convenience initializers and mutators

extension TimeOnly {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TimeOnly.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> TimeOnly {
        return TimeOnly(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTimeOnlyConverter: Codable {
    case double(Double)
    case timeOnlyConverter(TimeOnlyConverter)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(TimeOnlyConverter.self) {
            self = .timeOnlyConverter(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTimeOnlyConverter.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTimeOnlyConverter"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .timeOnlyConverter(let x):
            try container.encode(x)
        }
    }
}

// MARK: - TimeOnlyConverter
struct TimeOnlyConverter: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: TimeOnlyConverter convenience initializers and mutators

extension TimeOnlyConverter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TimeOnlyConverter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> TimeOnlyConverter {
        return TimeOnlyConverter(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTimeZone: Codable {
    case double(Double)
    case timeZoneClass(TimeZoneClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(TimeZoneClass.self) {
            self = .timeZoneClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTimeZone.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTimeZone"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .timeZoneClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - TimeZoneClass
struct TimeZoneClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: TimeZoneClass convenience initializers and mutators

extension TimeZoneClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TimeZoneClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> TimeZoneClass {
        return TimeZoneClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionToDict: Codable {
    case double(Double)
    case toDict(ToDict)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ToDict.self) {
            self = .toDict(x)
            return
        }
        throw DecodingError.typeMismatch(UnionToDict.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionToDict"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .toDict(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ToDict
struct ToDict: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ToDict convenience initializers and mutators

extension ToDict {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ToDict.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ToDict {
        return ToDict(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionToJSON: Codable {
    case double(Double)
    case toJSON(ToJSON)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ToJSON.self) {
            self = .toJSON(x)
            return
        }
        throw DecodingError.typeMismatch(UnionToJSON.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionToJSON"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .toJSON(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ToJSON
struct ToJSON: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ToJSON convenience initializers and mutators

extension ToJSON {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ToJSON.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ToJSON {
        return ToJSON(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionToString: Codable {
    case double(Double)
    case toString(ToString)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ToString.self) {
            self = .toString(x)
            return
        }
        throw DecodingError.typeMismatch(UnionToString.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionToString"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .toString(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ToString
struct ToString: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ToString convenience initializers and mutators

extension ToString {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ToString.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ToString {
        return ToString(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTopLevel: Codable {
    case double(Double)
    case topLevelClass(TopLevelClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(TopLevelClass.self) {
            self = .topLevelClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTopLevel.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTopLevel"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .topLevelClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - TopLevelClass
struct TopLevelClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: TopLevelClass convenience initializers and mutators

extension TopLevelClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevelClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> TopLevelClass {
        return TopLevelClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAnyUnion: Codable {
    case double(Double)
    case unionAnyAny(UnionAnyAny)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(UnionAnyAny.self) {
            self = .unionAnyAny(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAnyUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAnyUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .unionAnyAny(let x):
            try container.encode(x)
        }
    }
}

// MARK: - UnionAnyAny
struct UnionAnyAny: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: UnionAnyAny convenience initializers and mutators

extension UnionAnyAny {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UnionAnyAny.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> UnionAnyAny {
        return UnionAnyAny(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAs: Codable {
    case double(Double)
    case purpleAs(As)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(As.self) {
            self = .purpleAs(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAs.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAs"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleAs(let x):
            try container.encode(x)
        }
    }
}

// MARK: - As
struct As: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: As convenience initializers and mutators

extension As {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(As.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> As {
        return As(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAssociatedtype: Codable {
    case double(Double)
    case purpleAssociatedtype(Associatedtype)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Associatedtype.self) {
            self = .purpleAssociatedtype(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAssociatedtype.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAssociatedtype"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleAssociatedtype(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Associatedtype
struct Associatedtype: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Associatedtype convenience initializers and mutators

extension Associatedtype {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Associatedtype.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Associatedtype {
        return Associatedtype(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAssociativity: Codable {
    case double(Double)
    case purpleAssociativity(Associativity)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Associativity.self) {
            self = .purpleAssociativity(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAssociativity.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAssociativity"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleAssociativity(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Associativity
struct Associativity: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Associativity convenience initializers and mutators

extension Associativity {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Associativity.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Associativity {
        return Associativity(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionAwait: Codable {
    case double(Double)
    case purpleAwait(Await)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Await.self) {
            self = .purpleAwait(x)
            return
        }
        throw DecodingError.typeMismatch(UnionAwait.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionAwait"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleAwait(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Await
struct Await: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Await convenience initializers and mutators

extension Await {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Await.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Await {
        return Await(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionBool: Codable {
    case boolClass(BoolClass)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(BoolClass.self) {
            self = .boolClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionBool.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionBool"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .boolClass(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

// MARK: - BoolClass
struct BoolClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: BoolClass convenience initializers and mutators

extension BoolClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BoolClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> BoolClass {
        return BoolClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionBreak: Codable {
    case double(Double)
    case purpleBreak(Break)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Break.self) {
            self = .purpleBreak(x)
            return
        }
        throw DecodingError.typeMismatch(UnionBreak.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionBreak"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleBreak(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Break
struct Break: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Break convenience initializers and mutators

extension Break {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Break.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Break {
        return Break(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionCase: Codable {
    case double(Double)
    case purpleCase(Case)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Case.self) {
            self = .purpleCase(x)
            return
        }
        throw DecodingError.typeMismatch(UnionCase.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionCase"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleCase(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Case
struct Case: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Case convenience initializers and mutators

extension Case {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Case.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Case {
        return Case(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionCatch: Codable {
    case double(Double)
    case purpleCatch(Catch)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Catch.self) {
            self = .purpleCatch(x)
            return
        }
        throw DecodingError.typeMismatch(UnionCatch.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionCatch"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleCatch(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Catch
struct Catch: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Catch convenience initializers and mutators

extension Catch {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Catch.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Catch {
        return Catch(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionClass: Codable {
    case double(Double)
    case purpleClass(Class)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Class.self) {
            self = .purpleClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionClass.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionClass"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Class
struct Class: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Class convenience initializers and mutators

extension Class {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Class.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Class {
        return Class(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionContinue: Codable {
    case double(Double)
    case purpleContinue(Continue)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Continue.self) {
            self = .purpleContinue(x)
            return
        }
        throw DecodingError.typeMismatch(UnionContinue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionContinue"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleContinue(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Continue
struct Continue: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Continue convenience initializers and mutators

extension Continue {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Continue.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Continue {
        return Continue(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionConvenience: Codable {
    case double(Double)
    case purpleConvenience(Convenience)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Convenience.self) {
            self = .purpleConvenience(x)
            return
        }
        throw DecodingError.typeMismatch(UnionConvenience.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionConvenience"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleConvenience(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Convenience
struct Convenience: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Convenience convenience initializers and mutators

extension Convenience {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Convenience.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Convenience {
        return Convenience(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDefault: Codable {
    case double(Double)
    case purpleDefault(Default)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Default.self) {
            self = .purpleDefault(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDefault.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDefault"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleDefault(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Default
struct Default: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Default convenience initializers and mutators

extension Default {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Default.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Default {
        return Default(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDefer: Codable {
    case double(Double)
    case purpleDefer(Defer)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Defer.self) {
            self = .purpleDefer(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDefer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDefer"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleDefer(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Defer
struct Defer: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Defer convenience initializers and mutators

extension Defer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Defer.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Defer {
        return Defer(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDeinit: Codable {
    case double(Double)
    case purpleDeinit(Deinit)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Deinit.self) {
            self = .purpleDeinit(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDeinit.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDeinit"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleDeinit(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Deinit
struct Deinit: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Deinit convenience initializers and mutators

extension Deinit {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Deinit.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Deinit {
        return Deinit(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDidSet: Codable {
    case double(Double)
    case purpleDidSet(DidSet)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DidSet.self) {
            self = .purpleDidSet(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDidSet.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDidSet"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleDidSet(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DidSet
struct DidSet: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: DidSet convenience initializers and mutators

extension DidSet {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DidSet.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> DidSet {
        return DidSet(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDo: Codable {
    case double(Double)
    case purpleDo(Do)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Do.self) {
            self = .purpleDo(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDo.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDo"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleDo(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Do
struct Do: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Do convenience initializers and mutators

extension Do {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Do.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Do {
        return Do(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionDynamic: Codable {
    case double(Double)
    case purpleDynamic(Dynamic)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Dynamic.self) {
            self = .purpleDynamic(x)
            return
        }
        throw DecodingError.typeMismatch(UnionDynamic.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionDynamic"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleDynamic(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Dynamic
struct Dynamic: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Dynamic convenience initializers and mutators

extension Dynamic {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Dynamic.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Dynamic {
        return Dynamic(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionElse: Codable {
    case double(Double)
    case purpleElse(Else)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Else.self) {
            self = .purpleElse(x)
            return
        }
        throw DecodingError.typeMismatch(UnionElse.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionElse"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleElse(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Else
struct Else: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Else convenience initializers and mutators

extension Else {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Else.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Else {
        return Else(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionEnum: Codable {
    case double(Double)
    case purpleEnum(Enum)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Enum.self) {
            self = .purpleEnum(x)
            return
        }
        throw DecodingError.typeMismatch(UnionEnum.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionEnum"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleEnum(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Enum
struct Enum: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Enum convenience initializers and mutators

extension Enum {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Enum.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Enum {
        return Enum(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionExtension: Codable {
    case double(Double)
    case purpleExtension(Extension)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Extension.self) {
            self = .purpleExtension(x)
            return
        }
        throw DecodingError.typeMismatch(UnionExtension.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionExtension"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleExtension(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Extension
struct Extension: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Extension convenience initializers and mutators

extension Extension {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Extension.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Extension {
        return Extension(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFallthrough: Codable {
    case double(Double)
    case purpleFallthrough(Fallthrough)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Fallthrough.self) {
            self = .purpleFallthrough(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFallthrough.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFallthrough"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleFallthrough(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Fallthrough
struct Fallthrough: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Fallthrough convenience initializers and mutators

extension Fallthrough {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Fallthrough.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Fallthrough {
        return Fallthrough(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFalse: Codable {
    case double(Double)
    case purpleFalse(False)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(False.self) {
            self = .purpleFalse(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFalse.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFalse"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleFalse(let x):
            try container.encode(x)
        }
    }
}

// MARK: - False
struct False: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: False convenience initializers and mutators

extension False {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(False.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> False {
        return False(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFileprivate: Codable {
    case double(Double)
    case purpleFileprivate(Fileprivate)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Fileprivate.self) {
            self = .purpleFileprivate(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFileprivate.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFileprivate"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleFileprivate(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Fileprivate
struct Fileprivate: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Fileprivate convenience initializers and mutators

extension Fileprivate {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Fileprivate.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Fileprivate {
        return Fileprivate(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFinal: Codable {
    case double(Double)
    case purpleFinal(Final)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Final.self) {
            self = .purpleFinal(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFinal.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFinal"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleFinal(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Final
struct Final: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Final convenience initializers and mutators

extension Final {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Final.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Final {
        return Final(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFor: Codable {
    case double(Double)
    case purpleFor(For)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(For.self) {
            self = .purpleFor(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFor.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFor"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleFor(let x):
            try container.encode(x)
        }
    }
}

// MARK: - For
struct For: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: For convenience initializers and mutators

extension For {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(For.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> For {
        return For(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionFunc: Codable {
    case double(Double)
    case purpleFunc(Func)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Func.self) {
            self = .purpleFunc(x)
            return
        }
        throw DecodingError.typeMismatch(UnionFunc.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionFunc"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleFunc(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Func
struct Func: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Func convenience initializers and mutators

extension Func {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Func.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Func {
        return Func(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionGet: Codable {
    case double(Double)
    case purpleGet(Get)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Get.self) {
            self = .purpleGet(x)
            return
        }
        throw DecodingError.typeMismatch(UnionGet.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionGet"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleGet(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Get
struct Get: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Get convenience initializers and mutators

extension Get {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Get.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Get {
        return Get(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionGuard: Codable {
    case double(Double)
    case purpleGuard(Guard)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Guard.self) {
            self = .purpleGuard(x)
            return
        }
        throw DecodingError.typeMismatch(UnionGuard.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionGuard"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleGuard(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Guard
struct Guard: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Guard convenience initializers and mutators

extension Guard {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Guard.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Guard {
        return Guard(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionIf: Codable {
    case double(Double)
    case purpleIf(If)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(If.self) {
            self = .purpleIf(x)
            return
        }
        throw DecodingError.typeMismatch(UnionIf.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionIf"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleIf(let x):
            try container.encode(x)
        }
    }
}

// MARK: - If
struct If: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: If convenience initializers and mutators

extension If {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(If.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> If {
        return If(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionImport: Codable {
    case double(Double)
    case purpleImport(Import)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Import.self) {
            self = .purpleImport(x)
            return
        }
        throw DecodingError.typeMismatch(UnionImport.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionImport"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleImport(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Import
struct Import: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Import convenience initializers and mutators

extension Import {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Import.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Import {
        return Import(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionIn: Codable {
    case double(Double)
    case purpleIn(In)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(In.self) {
            self = .purpleIn(x)
            return
        }
        throw DecodingError.typeMismatch(UnionIn.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionIn"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleIn(let x):
            try container.encode(x)
        }
    }
}

// MARK: - In
struct In: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: In convenience initializers and mutators

extension In {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(In.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> In {
        return In(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionIndirect: Codable {
    case double(Double)
    case purpleIndirect(Indirect)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Indirect.self) {
            self = .purpleIndirect(x)
            return
        }
        throw DecodingError.typeMismatch(UnionIndirect.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionIndirect"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleIndirect(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Indirect
struct Indirect: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Indirect convenience initializers and mutators

extension Indirect {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Indirect.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Indirect {
        return Indirect(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionInfix: Codable {
    case double(Double)
    case purpleInfix(Infix)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Infix.self) {
            self = .purpleInfix(x)
            return
        }
        throw DecodingError.typeMismatch(UnionInfix.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionInfix"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleInfix(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Infix
struct Infix: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Infix convenience initializers and mutators

extension Infix {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Infix.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Infix {
        return Infix(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionInit: Codable {
    case double(Double)
    case purpleInit(Init)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Init.self) {
            self = .purpleInit(x)
            return
        }
        throw DecodingError.typeMismatch(UnionInit.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionInit"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleInit(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Init
struct Init: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Init convenience initializers and mutators

extension Init {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Init.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Init {
        return Init(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionInout: Codable {
    case double(Double)
    case purpleInout(Inout)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Inout.self) {
            self = .purpleInout(x)
            return
        }
        throw DecodingError.typeMismatch(UnionInout.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionInout"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleInout(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Inout
struct Inout: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Inout convenience initializers and mutators

extension Inout {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Inout.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Inout {
        return Inout(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionInternal: Codable {
    case double(Double)
    case purpleInternal(Internal)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Internal.self) {
            self = .purpleInternal(x)
            return
        }
        throw DecodingError.typeMismatch(UnionInternal.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionInternal"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleInternal(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Internal
struct Internal: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Internal convenience initializers and mutators

extension Internal {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Internal.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Internal {
        return Internal(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionIs: Codable {
    case double(Double)
    case purpleIs(Is)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Is.self) {
            self = .purpleIs(x)
            return
        }
        throw DecodingError.typeMismatch(UnionIs.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionIs"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleIs(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Is
struct Is: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Is convenience initializers and mutators

extension Is {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Is.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Is {
        return Is(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionJSON: Codable {
    case double(Double)
    case json(JSON)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(JSON.self) {
            self = .json(x)
            return
        }
        throw DecodingError.typeMismatch(UnionJSON.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionJSON"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .json(let x):
            try container.encode(x)
        }
    }
}

// MARK: - JSON
struct JSON: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: JSON convenience initializers and mutators

extension JSON {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSON.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> JSON {
        return JSON(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionLazy: Codable {
    case double(Double)
    case purpleLazy(Lazy)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Lazy.self) {
            self = .purpleLazy(x)
            return
        }
        throw DecodingError.typeMismatch(UnionLazy.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionLazy"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleLazy(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Lazy
struct Lazy: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Lazy convenience initializers and mutators

extension Lazy {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Lazy.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Lazy {
        return Lazy(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionLeft: Codable {
    case double(Double)
    case purpleLeft(Left)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Left.self) {
            self = .purpleLeft(x)
            return
        }
        throw DecodingError.typeMismatch(UnionLeft.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionLeft"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleLeft(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Left
struct Left: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Left convenience initializers and mutators

extension Left {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Left.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Left {
        return Left(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionLet: Codable {
    case double(Double)
    case purpleLet(Let)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Let.self) {
            self = .purpleLet(x)
            return
        }
        throw DecodingError.typeMismatch(UnionLet.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionLet"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleLet(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Let
struct Let: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Let convenience initializers and mutators

extension Let {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Let.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Let {
        return Let(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionMutating: Codable {
    case double(Double)
    case purpleMutating(Mutating)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Mutating.self) {
            self = .purpleMutating(x)
            return
        }
        throw DecodingError.typeMismatch(UnionMutating.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionMutating"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleMutating(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Mutating
struct Mutating: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Mutating convenience initializers and mutators

extension Mutating {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Mutating.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Mutating {
        return Mutating(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNil: Codable {
    case double(Double)
    case purpleNil(Nil)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Nil.self) {
            self = .purpleNil(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNil.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNil"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleNil(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Nil
struct Nil: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Nil convenience initializers and mutators

extension Nil {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Nil.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Nil {
        return Nil(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNoneUnion: Codable {
    case double(Double)
    case noneClass(NoneClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(NoneClass.self) {
            self = .noneClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNoneUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNoneUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .noneClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - NoneClass
struct NoneClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: NoneClass convenience initializers and mutators

extension NoneClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NoneClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> NoneClass {
        return NoneClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNonmutating: Codable {
    case double(Double)
    case purpleNonmutating(Nonmutating)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Nonmutating.self) {
            self = .purpleNonmutating(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNonmutating.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNonmutating"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleNonmutating(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Nonmutating
struct Nonmutating: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Nonmutating convenience initializers and mutators

extension Nonmutating {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Nonmutating.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Nonmutating {
        return Nonmutating(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionNull: Codable {
    case double(Double)
    case nullClass(NullClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(NullClass.self) {
            self = .nullClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionNull"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .nullClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - NullClass
struct NullClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: NullClass convenience initializers and mutators

extension NullClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NullClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> NullClass {
        return NullClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionOpen: Codable {
    case double(Double)
    case purpleOpen(Open)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Open.self) {
            self = .purpleOpen(x)
            return
        }
        throw DecodingError.typeMismatch(UnionOpen.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionOpen"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleOpen(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Open
struct Open: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Open convenience initializers and mutators

extension Open {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Open.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Open {
        return Open(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionOperator: Codable {
    case double(Double)
    case purpleOperator(Operator)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Operator.self) {
            self = .purpleOperator(x)
            return
        }
        throw DecodingError.typeMismatch(UnionOperator.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionOperator"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleOperator(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Operator
struct Operator: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Operator convenience initializers and mutators

extension Operator {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Operator.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Operator {
        return Operator(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionOptional: Codable {
    case double(Double)
    case purpleOptional(Optional)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Optional.self) {
            self = .purpleOptional(x)
            return
        }
        throw DecodingError.typeMismatch(UnionOptional.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionOptional"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleOptional(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Optional
struct Optional: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Optional convenience initializers and mutators

extension Optional {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Optional.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Optional {
        return Optional(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionOverride: Codable {
    case double(Double)
    case purpleOverride(Override)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Override.self) {
            self = .purpleOverride(x)
            return
        }
        throw DecodingError.typeMismatch(UnionOverride.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionOverride"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleOverride(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Override
struct Override: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Override convenience initializers and mutators

extension Override {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Override.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Override {
        return Override(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionPostfix: Codable {
    case double(Double)
    case purplePostfix(Postfix)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Postfix.self) {
            self = .purplePostfix(x)
            return
        }
        throw DecodingError.typeMismatch(UnionPostfix.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionPostfix"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purplePostfix(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Postfix
struct Postfix: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Postfix convenience initializers and mutators

extension Postfix {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Postfix.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Postfix {
        return Postfix(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionPrecedence: Codable {
    case double(Double)
    case purplePrecedence(Precedence)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Precedence.self) {
            self = .purplePrecedence(x)
            return
        }
        throw DecodingError.typeMismatch(UnionPrecedence.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionPrecedence"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purplePrecedence(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Precedence
struct Precedence: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Precedence convenience initializers and mutators

extension Precedence {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Precedence.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Precedence {
        return Precedence(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionPrefix: Codable {
    case double(Double)
    case purplePrefix(Prefix)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Prefix.self) {
            self = .purplePrefix(x)
            return
        }
        throw DecodingError.typeMismatch(UnionPrefix.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionPrefix"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purplePrefix(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Prefix
struct Prefix: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Prefix convenience initializers and mutators

extension Prefix {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Prefix.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Prefix {
        return Prefix(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionPrivate: Codable {
    case double(Double)
    case purplePrivate(Private)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Private.self) {
            self = .purplePrivate(x)
            return
        }
        throw DecodingError.typeMismatch(UnionPrivate.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionPrivate"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purplePrivate(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Private
struct Private: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Private convenience initializers and mutators

extension Private {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Private.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Private {
        return Private(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionProtocol: Codable {
    case double(Double)
    case protocolClass(ProtocolClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ProtocolClass.self) {
            self = .protocolClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionProtocol.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionProtocol"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .protocolClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ProtocolClass
struct ProtocolClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: ProtocolClass convenience initializers and mutators

extension ProtocolClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ProtocolClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> ProtocolClass {
        return ProtocolClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionPublic: Codable {
    case double(Double)
    case purplePublic(Public)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Public.self) {
            self = .purplePublic(x)
            return
        }
        throw DecodingError.typeMismatch(UnionPublic.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionPublic"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purplePublic(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Public
struct Public: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Public convenience initializers and mutators

extension Public {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Public.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Public {
        return Public(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRepeat: Codable {
    case double(Double)
    case purpleRepeat(Repeat)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Repeat.self) {
            self = .purpleRepeat(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRepeat.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRepeat"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleRepeat(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Repeat
struct Repeat: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Repeat convenience initializers and mutators

extension Repeat {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Repeat.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Repeat {
        return Repeat(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRequired: Codable {
    case double(Double)
    case purpleRequired(Required)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Required.self) {
            self = .purpleRequired(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRequired.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRequired"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleRequired(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Required
struct Required: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Required convenience initializers and mutators

extension Required {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Required.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Required {
        return Required(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRethrows: Codable {
    case double(Double)
    case purpleRethrows(Rethrows)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Rethrows.self) {
            self = .purpleRethrows(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRethrows.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRethrows"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleRethrows(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Rethrows
struct Rethrows: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Rethrows convenience initializers and mutators

extension Rethrows {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Rethrows.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Rethrows {
        return Rethrows(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionReturn: Codable {
    case double(Double)
    case purpleReturn(Return)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Return.self) {
            self = .purpleReturn(x)
            return
        }
        throw DecodingError.typeMismatch(UnionReturn.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionReturn"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleReturn(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Return
struct Return: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Return convenience initializers and mutators

extension Return {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Return.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Return {
        return Return(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionRight: Codable {
    case double(Double)
    case purpleRight(Right)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Right.self) {
            self = .purpleRight(x)
            return
        }
        throw DecodingError.typeMismatch(UnionRight.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionRight"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleRight(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Right
struct Right: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Right convenience initializers and mutators

extension Right {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Right.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Right {
        return Right(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSelf: Codable {
    case double(Double)
    case selfClass(SelfClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(SelfClass.self) {
            self = .selfClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSelf.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSelf"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .selfClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: SelfClass convenience initializers and mutators

extension SelfClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SelfClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> SelfClass {
        return SelfClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSet: Codable {
    case double(Double)
    case purpleSet(Set)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Set.self) {
            self = .purpleSet(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSet.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSet"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleSet(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Set
struct Set: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Set convenience initializers and mutators

extension Set {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Set.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Set {
        return Set(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionStatic: Codable {
    case double(Double)
    case purpleStatic(Static)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Static.self) {
            self = .purpleStatic(x)
            return
        }
        throw DecodingError.typeMismatch(UnionStatic.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionStatic"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleStatic(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Static
struct Static: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Static convenience initializers and mutators

extension Static {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Static.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Static {
        return Static(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionStruct: Codable {
    case double(Double)
    case purpleStruct(Struct)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Struct.self) {
            self = .purpleStruct(x)
            return
        }
        throw DecodingError.typeMismatch(UnionStruct.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionStruct"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleStruct(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Struct
struct Struct: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Struct convenience initializers and mutators

extension Struct {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Struct.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Struct {
        return Struct(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSubscript: Codable {
    case double(Double)
    case purpleSubscript(Subscript)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Subscript.self) {
            self = .purpleSubscript(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSubscript.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSubscript"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleSubscript(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Subscript
struct Subscript: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Subscript convenience initializers and mutators

extension Subscript {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Subscript.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Subscript {
        return Subscript(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSuper: Codable {
    case double(Double)
    case purpleSuper(Super)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Super.self) {
            self = .purpleSuper(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSuper.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSuper"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleSuper(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Super
struct Super: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Super convenience initializers and mutators

extension Super {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Super.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Super {
        return Super(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionSwitch: Codable {
    case double(Double)
    case purpleSwitch(Switch)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Switch.self) {
            self = .purpleSwitch(x)
            return
        }
        throw DecodingError.typeMismatch(UnionSwitch.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionSwitch"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleSwitch(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Switch
struct Switch: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Switch convenience initializers and mutators

extension Switch {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Switch.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Switch {
        return Switch(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionThrow: Codable {
    case double(Double)
    case purpleThrow(Throw)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Throw.self) {
            self = .purpleThrow(x)
            return
        }
        throw DecodingError.typeMismatch(UnionThrow.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionThrow"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleThrow(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Throw
struct Throw: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Throw convenience initializers and mutators

extension Throw {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Throw.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Throw {
        return Throw(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionThrows: Codable {
    case double(Double)
    case purpleThrows(Throws)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Throws.self) {
            self = .purpleThrows(x)
            return
        }
        throw DecodingError.typeMismatch(UnionThrows.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionThrows"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleThrows(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Throws
struct Throws: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Throws convenience initializers and mutators

extension Throws {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Throws.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Throws {
        return Throws(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTrue: Codable {
    case double(Double)
    case purpleTrue(True)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(True.self) {
            self = .purpleTrue(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTrue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTrue"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleTrue(let x):
            try container.encode(x)
        }
    }
}

// MARK: - True
struct True: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: True convenience initializers and mutators

extension True {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(True.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> True {
        return True(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTry: Codable {
    case double(Double)
    case purpleTry(Try)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Try.self) {
            self = .purpleTry(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTry.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTry"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleTry(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Try
struct Try: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Try convenience initializers and mutators

extension Try {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Try.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Try {
        return Try(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTypeUnion: Codable {
    case double(Double)
    case unionTypeType(UnionTypeType)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(UnionTypeType.self) {
            self = .unionTypeType(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTypeUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTypeUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .unionTypeType(let x):
            try container.encode(x)
        }
    }
}

// MARK: - UnionTypeType
struct UnionTypeType: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: UnionTypeType convenience initializers and mutators

extension UnionTypeType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UnionTypeType.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> UnionTypeType {
        return UnionTypeType(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTypealias: Codable {
    case double(Double)
    case purpleTypealias(Typealias)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Typealias.self) {
            self = .purpleTypealias(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTypealias.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTypealias"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleTypealias(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Typealias
struct Typealias: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Typealias convenience initializers and mutators

extension Typealias {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Typealias.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Typealias {
        return Typealias(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUnowned: Codable {
    case double(Double)
    case purpleUnowned(Unowned)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Unowned.self) {
            self = .purpleUnowned(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUnowned.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUnowned"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleUnowned(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Unowned
struct Unowned: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Unowned convenience initializers and mutators

extension Unowned {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Unowned.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Unowned {
        return Unowned(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionVar: Codable {
    case double(Double)
    case purpleVar(Var)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Var.self) {
            self = .purpleVar(x)
            return
        }
        throw DecodingError.typeMismatch(UnionVar.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionVar"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleVar(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Var
struct Var: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Var convenience initializers and mutators

extension Var {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Var.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Var {
        return Var(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionWeak: Codable {
    case double(Double)
    case purpleWeak(Weak)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Weak.self) {
            self = .purpleWeak(x)
            return
        }
        throw DecodingError.typeMismatch(UnionWeak.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionWeak"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleWeak(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Weak
struct Weak: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Weak convenience initializers and mutators

extension Weak {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Weak.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Weak {
        return Weak(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionWhere: Codable {
    case double(Double)
    case purpleWhere(Where)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Where.self) {
            self = .purpleWhere(x)
            return
        }
        throw DecodingError.typeMismatch(UnionWhere.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionWhere"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleWhere(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Where
struct Where: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Where convenience initializers and mutators

extension Where {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Where.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Where {
        return Where(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionWhile: Codable {
    case double(Double)
    case purpleWhile(While)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(While.self) {
            self = .purpleWhile(x)
            return
        }
        throw DecodingError.typeMismatch(UnionWhile.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionWhile"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleWhile(let x):
            try container.encode(x)
        }
    }
}

// MARK: - While
struct While: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: While convenience initializers and mutators

extension While {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(While.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> While {
        return While(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionWillSet: Codable {
    case double(Double)
    case purpleWillSet(WillSet)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(WillSet.self) {
            self = .purpleWillSet(x)
            return
        }
        throw DecodingError.typeMismatch(UnionWillSet.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionWillSet"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .purpleWillSet(let x):
            try container.encode(x)
        }
    }
}

// MARK: - WillSet
struct WillSet: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: WillSet convenience initializers and mutators

extension WillSet {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(WillSet.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> WillSet {
        return WillSet(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTransient: Codable {
    case double(Double)
    case transient(Transient)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Transient.self) {
            self = .transient(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTransient.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTransient"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .transient(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Transient
struct Transient: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Transient convenience initializers and mutators

extension Transient {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Transient.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Transient {
        return Transient(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionType: Codable {
    case double(Double)
    case typeClass(TypeClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(TypeClass.self) {
            self = .typeClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionType"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .typeClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - TypeClass
struct TypeClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: TypeClass convenience initializers and mutators

extension TypeClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TypeClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> TypeClass {
        return TypeClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTypedef: Codable {
    case double(Double)
    case typedef(Typedef)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Typedef.self) {
            self = .typedef(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTypedef.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTypedef"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .typedef(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Typedef
struct Typedef: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Typedef convenience initializers and mutators

extension Typedef {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Typedef.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Typedef {
        return Typedef(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTypeid: Codable {
    case double(Double)
    case typeid(Typeid)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Typeid.self) {
            self = .typeid(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTypeid.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTypeid"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .typeid(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Typeid
struct Typeid: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Typeid convenience initializers and mutators

extension Typeid {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Typeid.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Typeid {
        return Typeid(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTypename: Codable {
    case double(Double)
    case typename(Typename)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Typename.self) {
            self = .typename(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTypename.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTypename"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .typename(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Typename
struct Typename: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Typename convenience initializers and mutators

extension Typename {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Typename.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Typename {
        return Typename(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionTypeof: Codable {
    case double(Double)
    case typeof(Typeof)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Typeof.self) {
            self = .typeof(x)
            return
        }
        throw DecodingError.typeMismatch(UnionTypeof.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionTypeof"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .typeof(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Typeof
struct Typeof: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Typeof convenience initializers and mutators

extension Typeof {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Typeof.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Typeof {
        return Typeof(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUint: Codable {
    case double(Double)
    case uint(Uint)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Uint.self) {
            self = .uint(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUint.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUint"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .uint(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Uint
struct Uint: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Uint convenience initializers and mutators

extension Uint {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Uint.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Uint {
        return Uint(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUlong: Codable {
    case double(Double)
    case ulong(Ulong)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Ulong.self) {
            self = .ulong(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUlong.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUlong"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .ulong(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Ulong
struct Ulong: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Ulong convenience initializers and mutators

extension Ulong {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Ulong.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Ulong {
        return Ulong(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUnchecked: Codable {
    case double(Double)
    case unchecked(Unchecked)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Unchecked.self) {
            self = .unchecked(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUnchecked.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUnchecked"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .unchecked(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Unchecked
struct Unchecked: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Unchecked convenience initializers and mutators

extension Unchecked {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Unchecked.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Unchecked {
        return Unchecked(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUndefined: Codable {
    case double(Double)
    case undefined(Undefined)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Undefined.self) {
            self = .undefined(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUndefined.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUndefined"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .undefined(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Undefined
struct Undefined: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Undefined convenience initializers and mutators

extension Undefined {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Undefined.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Undefined {
        return Undefined(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUnionUnion: Codable {
    case double(Double)
    case union(Union)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Union.self) {
            self = .union(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUnionUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUnionUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .union(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Union
struct Union: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Union convenience initializers and mutators

extension Union {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Union.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Union {
        return Union(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUnmarshalJSON: Codable {
    case double(Double)
    case unmarshalJSON(UnmarshalJSON)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(UnmarshalJSON.self) {
            self = .unmarshalJSON(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUnmarshalJSON.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUnmarshalJSON"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .unmarshalJSON(let x):
            try container.encode(x)
        }
    }
}

// MARK: - UnmarshalJSON
struct UnmarshalJSON: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: UnmarshalJSON convenience initializers and mutators

extension UnmarshalJSON {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UnmarshalJSON.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> UnmarshalJSON {
        return UnmarshalJSON(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUnsafe: Codable {
    case double(Double)
    case unsafe(Unsafe)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Unsafe.self) {
            self = .unsafe(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUnsafe.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUnsafe"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .unsafe(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Unsafe
struct Unsafe: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Unsafe convenience initializers and mutators

extension Unsafe {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Unsafe.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Unsafe {
        return Unsafe(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUnsigned: Codable {
    case double(Double)
    case unsigned(Unsigned)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Unsigned.self) {
            self = .unsigned(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUnsigned.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUnsigned"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .unsigned(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Unsigned
struct Unsigned: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Unsigned convenience initializers and mutators

extension Unsigned {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Unsigned.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Unsigned {
        return Unsigned(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUseSerializers: Codable {
    case double(Double)
    case useSerializers(UseSerializers)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(UseSerializers.self) {
            self = .useSerializers(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUseSerializers.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUseSerializers"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .useSerializers(let x):
            try container.encode(x)
        }
    }
}

// MARK: - UseSerializers
struct UseSerializers: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: UseSerializers convenience initializers and mutators

extension UseSerializers {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UseSerializers.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> UseSerializers {
        return UseSerializers(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUshort: Codable {
    case double(Double)
    case ushort(Ushort)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Ushort.self) {
            self = .ushort(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUshort.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUshort"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .ushort(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Ushort
struct Ushort: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Ushort convenience initializers and mutators

extension Ushort {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Ushort.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Ushort {
        return Ushort(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUsing: Codable {
    case double(Double)
    case using(Using)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Using.self) {
            self = .using(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUsing.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUsing"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .using(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Using
struct Using: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Using convenience initializers and mutators

extension Using {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Using.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Using {
        return Using(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUtf8JSONReader: Codable {
    case double(Double)
    case utf8JSONReader(Utf8JSONReader)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Utf8JSONReader.self) {
            self = .utf8JSONReader(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUtf8JSONReader.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUtf8JSONReader"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .utf8JSONReader(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Utf8JSONReader
struct Utf8JSONReader: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Utf8JSONReader convenience initializers and mutators

extension Utf8JSONReader {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Utf8JSONReader.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Utf8JSONReader {
        return Utf8JSONReader(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUtf8JSONWriter: Codable {
    case double(Double)
    case utf8JSONWriter(Utf8JSONWriter)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Utf8JSONWriter.self) {
            self = .utf8JSONWriter(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUtf8JSONWriter.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUtf8JSONWriter"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .utf8JSONWriter(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Utf8JSONWriter
struct Utf8JSONWriter: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Utf8JSONWriter convenience initializers and mutators

extension Utf8JSONWriter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Utf8JSONWriter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Utf8JSONWriter {
        return Utf8JSONWriter(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionUUID: Codable {
    case double(Double)
    case uuidClass(UUIDClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(UUIDClass.self) {
            self = .uuidClass(x)
            return
        }
        throw DecodingError.typeMismatch(UnionUUID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionUUID"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .uuidClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - UUIDClass
struct UUIDClass: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: UUIDClass convenience initializers and mutators

extension UUIDClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UUIDClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> UUIDClass {
        return UUIDClass(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionVirtual: Codable {
    case double(Double)
    case virtual(Virtual)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Virtual.self) {
            self = .virtual(x)
            return
        }
        throw DecodingError.typeMismatch(UnionVirtual.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionVirtual"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .virtual(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Virtual
struct Virtual: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Virtual convenience initializers and mutators

extension Virtual {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Virtual.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Virtual {
        return Virtual(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionVoid: Codable {
    case double(Double)
    case void(Void)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Void.self) {
            self = .void(x)
            return
        }
        throw DecodingError.typeMismatch(UnionVoid.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionVoid"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .void(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Void
struct Void: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Void convenience initializers and mutators

extension Void {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Void.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Void {
        return Void(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionVolatile: Codable {
    case double(Double)
    case volatile(Volatile)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Volatile.self) {
            self = .volatile(x)
            return
        }
        throw DecodingError.typeMismatch(UnionVolatile.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionVolatile"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .volatile(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Volatile
struct Volatile: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Volatile convenience initializers and mutators

extension Volatile {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Volatile.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Volatile {
        return Volatile(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionWcharT: Codable {
    case double(Double)
    case wcharT(WcharT)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(WcharT.self) {
            self = .wcharT(x)
            return
        }
        throw DecodingError.typeMismatch(UnionWcharT.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionWcharT"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .wcharT(let x):
            try container.encode(x)
        }
    }
}

// MARK: - WcharT
struct WcharT: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: WcharT convenience initializers and mutators

extension WcharT {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(WcharT.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> WcharT {
        return WcharT(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionWith: Codable {
    case double(Double)
    case with(With)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(With.self) {
            self = .with(x)
            return
        }
        throw DecodingError.typeMismatch(UnionWith.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionWith"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .with(let x):
            try container.encode(x)
        }
    }
}

// MARK: - With
struct With: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: With convenience initializers and mutators

extension With {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(With.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> With {
        return With(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionXor: Codable {
    case double(Double)
    case xor(Xor)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Xor.self) {
            self = .xor(x)
            return
        }
        throw DecodingError.typeMismatch(UnionXor.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionXor"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .xor(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Xor
struct Xor: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Xor convenience initializers and mutators

extension Xor {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Xor.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Xor {
        return Xor(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionXorEq: Codable {
    case double(Double)
    case xorEq(XorEq)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(XorEq.self) {
            self = .xorEq(x)
            return
        }
        throw DecodingError.typeMismatch(UnionXorEq.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionXorEq"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .xorEq(let x):
            try container.encode(x)
        }
    }
}

// MARK: - XorEq
struct XorEq: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: XorEq convenience initializers and mutators

extension XorEq {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(XorEq.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> XorEq {
        return XorEq(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionYES: Codable {
    case double(Double)
    case yes(Yes)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Yes.self) {
            self = .yes(x)
            return
        }
        throw DecodingError.typeMismatch(UnionYES.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionYES"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .yes(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Yes
struct Yes: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Yes convenience initializers and mutators

extension Yes {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Yes.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Yes {
        return Yes(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum UnionYield: Codable {
    case double(Double)
    case yield(Yield)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Yield.self) {
            self = .yield(x)
            return
        }
        throw DecodingError.typeMismatch(UnionYield.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnionYield"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .yield(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Yield
struct Yield: Codable {
    private enum K: String, CodingKey { case unused }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: K.self)
    }
    init() {
    }
}

// MARK: Yield convenience initializers and mutators

extension Yield {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Yield.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> Yield {
        return Yield(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
        let container = try decoder.singleValueContainer()
        let dateStr = try container.decode(String.self)

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        throw DecodingError.typeMismatch(Date.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not decode date"))
    })
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
    encoder.dateEncodingStrategy = .formatted(formatter)
    return encoder
}
