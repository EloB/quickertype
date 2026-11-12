// @flow

// To parse this data:
//
//   const Convert = require("./TopLevel");
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export type TopLevel = {
    _?:                          UnionUnion;
    _Bool?:                      UnionBool;
    _Complex?:                   UnionComplex;
    _Imaginery?:                 UnionImaginery;
    abstract?:                   UnionAbstract;
    alignas?:                    UnionAlignas;
    alignof?:                    UnionAlignof;
    and?:                        UnionAnd;
    and_eq?:                     UnionAndEq;
    any?:                        UnionAnyUnion;
    Any?:                        UnionAny;
    array?:                      UnionArray;
    ArrayNode?:                  UnionArrayNode;
    as?:                         UnionAs;
    asm?:                        UnionASM;
    assert?:                     UnionAssert;
    associatedtype?:             UnionAssociatedtype;
    associativity?:              UnionAssociativity;
    async?:                      UnionAsync;
    atomic?:                     UnionAtomic;
    atomic_cancel?:              UnionAtomicCancel;
    atomic_commit?:              UnionAtomicCommit;
    atomic_noexcept?:            UnionAtomicNoexcept;
    auto?:                       UnionAuto;
    await?:                      UnionAwait;
    base?:                       UnionBase;
    bitand?:                     UnionBitand;
    bitor?:                      UnionBitor;
    BOOL?:                       UnionBOOL;
    bool?:                       UnionBoolUnion;
    boolean?:                    UnionBoolean;
    BooleanNode?:                UnionBooleanNode;
    break?:                      UnionBreak;
    bycopy?:                     UnionBycopy;
    byref?:                      UnionByref;
    byte?:                       UnionByte;
    Calendar?:                   UnionCalendar;
    case?:                       UnionCase;
    catch?:                      UnionCatch;
    chan?:                       UnionChan;
    char?:                       UnionChar;
    char16_t?:                   UnionChar16T;
    char32_t?:                   UnionChar32T;
    checked?:                    UnionChecked;
    class?:                      UnionClassUnion;
    Class?:                      UnionClass;
    clone?:                      UnionClone;
    co_await?:                   UnionCoAwait;
    co_return?:                  UnionCoReturn;
    co_yield?:                   UnionCoYield;
    Codable?:                    UnionCodable;
    CodingKey?:                  UnionCodingKey;
    CodingKeys?:                 UnionCodingKeys;
    compl?:                      UnionCompl;
    concept?:                    UnionConcept;
    console?:                    UnionConsole;
    const?:                      UnionConst;
    const_cast?:                 UnionConstCast;
    constexpr?:                  UnionConstexpr;
    constructor?:                UnionConstructor;
    continue?:                   UnionContinue;
    convenience?:                UnionConvenience;
    convert?:                    UnionConvert;
    converter?:                  UnionConverter;
    CultureInfo?:                UnionCultureInfo;
    date?:                       UnionDate;
    date_parse_handling?:        UnionDateParseHandling;
    DateFormatter?:              UnionDateFormatter;
    DateOnly?:                   UnionDateOnly;
    DateOnlyConverter?:          UnionDateOnlyConverter;
    DateTime?:                   UnionDateTime;
    DateTimeStyles?:             UnionDateTimeStyles;
    debugger?:                   UnionDebugger;
    decimal?:                    UnionDecimal;
    declare?:                    UnionDeclare;
    decltype?:                   UnionDecltype;
    decode_string?:              UnionDecodeString;
    Decoder?:                    UnionDecoder;
    DecodingError?:              UnionDecodingError;
    def?:                        UnionDef;
    default?:                    UnionDefault;
    defer?:                      UnionDefer;
    deinit?:                     UnionDeinit;
    del?:                        UnionDel;
    delegate?:                   UnionDelegate;
    delete?:                     UnionDelete;
    DeserializationFeature?:     UnionDeserializationFeature;
    dict?:                       UnionDict;
    dictionary?:                 UnionDictionary;
    didSet?:                     UnionDidSet;
    do?:                         UnionDo;
    double?:                     UnionDouble;
    DoubleNode?:                 UnionDoubleNode;
    dummy?:                      number;
    dynamic?:                    UnionDynamic;
    dynamic_cast?:               UnionDynamicCast;
    elif?:                       UnionElif;
    else?:                       UnionElse;
    encode_quick_type?:          UnionEncodeQuickType;
    Encoder?:                    UnionEncoder;
    enum?:                       UnionEnum;
    EnumValues?:                 UnionEnumValues;
    equalityContract?:           UnionEqualityContract;
    Equatable?:                  UnionEquatable;
    event?:                      UnionEvent;
    except?:                     UnionExcept;
    exception?:                  UnionException;
    explicit?:                   UnionExplicit;
    export?:                     UnionExport;
    exposing?:                   UnionExposing;
    extends?:                    UnionExtends;
    extension?:                  UnionExtension;
    extern?:                     UnionExtern;
    fallthrough?:                UnionFallthrough;
    false?:                      UnionFalseUnion;
    False?:                      UnionFalse;
    fileprivate?:                UnionFileprivate;
    final?:                      UnionFinal;
    finally?:                    UnionFinally;
    fixed?:                      UnionFixed;
    float?:                      UnionFloat;
    for?:                        UnionFor;
    foreach?:                    UnionForeach;
    FormatException?:            UnionFormatException;
    friend?:                     UnionFriend;
    from?:                       UnionFrom;
    from_dict?:                  UnionFromDict;
    from_json?:                  UnionFromJSON;
    func?:                       UnionFunc;
    function?:                   UnionFunction;
    get?:                        UnionGet;
    global?:                     UnionGlobal;
    go?:                         UnionGo;
    goto?:                       UnionGoto;
    guard?:                      UnionGuard;
    Hashable?:                   UnionHashable;
    hashCode?:                   UnionHashCode;
    Hasher?:                     UnionHasher;
    hasOwnProperty?:             UnionHasOwnProperty;
    id?:                         UnionID;
    if?:                         UnionIf;
    IMP?:                        UnionIMP;
    implements?:                 UnionImplements;
    implicit?:                   UnionImplicit;
    import?:                     UnionImport;
    in?:                         UnionIn;
    indirect?:                   UnionIndirect;
    infix?:                      UnionInfix;
    init?:                       UnionInit;
    inline?:                     UnionInline;
    inout?:                      UnionInout;
    instanceof?:                 UnionInstanceof;
    int?:                        UnionInt;
    interface?:                  UnionInterface;
    internal?:                   UnionInternal;
    IntNode?:                    UnionIntNode;
    is?:                         UnionIs;
    IsoDateTimeOffsetConverter?: UnionISODateTimeOffsetConverter;
    iterable?:                   UnionIterable;
    jdec?:                       UnionJdec;
    jenc?:                       UnionJenc;
    jpipe?:                      UnionJpipe;
    json?:                       UnionJSON;
    json_converter?:             UnionJSONConverter;
    json_serializer?:            UnionJSONSerializer;
    json_token?:                 UnionJSONToken;
    json_writer?:                UnionJSONWriter;
    JSONAny?:                    UnionJSONAny;
    JSONCodingKey?:              UnionJSONCodingKey;
    JSONDecoder?:                UnionJSONDecoder;
    JSONEncoder?:                UnionJSONEncoder;
    JsonException?:              UnionJSONException;
    JsonGenerator?:              UnionJSONGenerator;
    JsonNode?:                   UnionJSONNode;
    JSONNull?:                   UnionJSONNull;
    JsonParser?:                 UnionJSONParser;
    JsonReader?:                 UnionJSONReader;
    JsonTokenType?:              UnionJSONTokenType;
    KSerializer?:                UnionKSerializer;
    lambda?:                     UnionLambda;
    lazy?:                       UnionLazy;
    left?:                       UnionLeft;
    let?:                        UnionLet;
    list?:                       UnionList;
    LocalDate?:                  UnionLocalDate;
    Locale?:                     UnionLocale;
    lock?:                       UnionLock;
    long?:                       UnionLong;
    LongNode?:                   UnionLongNode;
    map?:                        UnionMap;
    MapEntry?:                   UnionMapEntry;
    MarshalJSON?:                UnionMarshalJSON;
    metadata_property_handling?: UnionMetadataPropertyHandling;
    module?:                     UnionModule;
    mutable?:                    UnionMutable;
    mutating?:                   UnionMutating;
    namespace?:                  UnionNamespace;
    native?:                     UnionNative;
    new?:                        UnionNew;
    newtonsoft?:                 UnionNewtonsoft;
    nil?:                        UnionNil;
    NO?:                         UnionNO;
    noexcept?:                   UnionNoexcept;
    nonatomic?:                  UnionNonatomic;
    none?:                       UnionNoneUnion;
    None?:                       UnionNone;
    nonlocal?:                   UnionNonlocal;
    nonmutating?:                UnionNonmutating;
    noSuchMethod?:               UnionNoSuchMethod;
    not?:                        UnionNot;
    not_eq?:                     UnionNotEq;
    NSError?:                    UnionNSError;
    NSObject?:                   UnionNSObject;
    NSString?:                   UnionNSString;
    NULL?:                       UnionNULL;
    null?:                       UnionNull;
    NullNode?:                   UnionNullNode;
    nullptr?:                    UnionNullptr;
    number?:                     UnionNumber;
    object?:                     UnionObject;
    ObjectMapper?:               UnionObjectMapper;
    ObjectNode?:                 UnionObjectNode;
    ObjectReader?:               UnionObjectReader;
    ObjectWriter?:               UnionObjectWriter;
    of?:                         UnionOf;
    OffsetDateTime?:             UnionOffsetDateTime;
    OffsetTime?:                 UnionOffsetTime;
    oneway?:                     UnionOneway;
    open?:                       UnionOpen;
    operator?:                   UnionOperator;
    optional?:                   UnionOptional;
    or?:                         UnionOr;
    or_eq?:                      UnionOrEq;
    out?:                        UnionOut;
    override?:                   UnionOverride;
    package?:                    UnionPackage;
    params?:                     UnionParams;
    pass?:                       UnionPass;
    port?:                       UnionPort;
    postfix?:                    UnionPostfix;
    precedence?:                 UnionPrecedence;
    prefix?:                     UnionPrefix;
    PrimitiveKind?:              UnionPrimitiveKind;
    print?:                      UnionPrint;
    printf?:                     UnionPrintf;
    printMembers?:               UnionPrintMembers;
    private?:                    UnionPrivate;
    protected?:                  UnionProtected;
    Protocol?:                   UnionProtocol;
    protocol?:                   UnionProtocolUnion;
    public?:                     UnionPublic;
    quicktype?:                  UnionQuicktype;
    raise?:                      UnionRaise;
    range?:                      UnionRange;
    readonly?:                   UnionReadonly;
    ref?:                        UnionRef;
    RegExp?:                     UnionRegExp;
    register?:                   UnionRegister;
    reinterpret_cast?:           UnionReinterpretCast;
    repeat?:                     UnionRepeat;
    require?:                    UnionRequire;
    required?:                   UnionRequired;
    requires?:                   UnionRequires;
    restrict?:                   UnionRestrict;
    retain?:                     UnionRetain;
    rethrows?:                   UnionRethrows;
    return?:                     UnionReturn;
    right?:                      UnionRight;
    runtimeType?:                UnionRuntimeType;
    s?:                          UnionS;
    sbyte?:                      UnionSbyte;
    sealed?:                     UnionSealed;
    SEL?:                        UnionSEL;
    select?:                     UnionSelect;
    Self?:                       UnionSelf;
    self?:                       UnionSelfUnion;
    Sendable?:                   UnionSendable;
    SerialDescriptor?:           UnionSerialDescriptor;
    Serializable?:               UnionSerializable;
    SerializationFeature?:       UnionSerializationFeature;
    serialize?:                  UnionSerialize;
    SerializerProvider?:         UnionSerializerProvider;
    SerialName?:                 UnionSerialName;
    set?:                        UnionSet;
    short?:                      UnionShort;
    signed?:                     UnionSigned;
    SimpleModule?:               UnionSimpleModule;
    sizeof?:                     UnionSizeof;
    stackalloc?:                 UnionStackalloc;
    Standards?:                  UnionStandards;
    static?:                     UnionStatic;
    static_assert?:              UnionStaticAssert;
    static_cast?:                UnionStaticCast;
    StdDeserializer?:            UnionStdDeserializer;
    StdSerializer?:              UnionStdSerializer;
    strictfp?:                   UnionStrictfp;
    string?:                     UnionString;
    struct?:                     UnionStruct;
    subscript?:                  UnionSubscript;
    super?:                      UnionSuper;
    switch?:                     UnionSwitch;
    symbol?:                     UnionSymbol;
    synchronized?:               UnionSynchronized;
    system?:                     UnionSystem;
    template?:                   UnionTemplate;
    TextNode?:                   UnionTextNode;
    then?:                       UnionThen;
    this?:                       UnionThis;
    thread_local?:               UnionThreadLocal;
    throw?:                      UnionThrow;
    throws?:                     UnionThrows;
    TimeOnly?:                   UnionTimeOnly;
    TimeOnlyConverter?:          UnionTimeOnlyConverter;
    TimeZone?:                   UnionTimeZone;
    to_dict?:                    UnionToDict;
    to_json?:                    UnionToJSON;
    top_level?:                  UnionTopLevel;
    toString?:                   UnionToString;
    transient?:                  UnionTransient;
    True?:                       UnionTrue;
    true?:                       UnionTrueUnion;
    try?:                        UnionTry;
    Type?:                       UnionType;
    type?:                       UnionTypeUnion;
    typealias?:                  UnionTypealias;
    typedef?:                    UnionTypedef;
    typeid?:                     UnionTypeid;
    typename?:                   UnionTypename;
    typeof?:                     UnionTypeof;
    uint?:                       UnionUint;
    ulong?:                      UnionUlong;
    unchecked?:                  UnionUnchecked;
    undefined?:                  UnionUndefined;
    union?:                      UnionUnionUnion;
    UnmarshalJSON?:              UnionUnmarshalJSON;
    unowned?:                    UnionUnowned;
    unsafe?:                     UnionUnsafe;
    unsigned?:                   UnionUnsigned;
    UseSerializers?:             UnionUseSerializers;
    ushort?:                     UnionUshort;
    using?:                      UnionUsing;
    Utf8JsonReader?:             UnionUtf8JSONReader;
    Utf8JsonWriter?:             UnionUtf8JSONWriter;
    UUID?:                       UnionUUID;
    var?:                        UnionVar;
    virtual?:                    UnionVirtual;
    void?:                       UnionVoid;
    volatile?:                   UnionVolatile;
    wchar_t?:                    UnionWcharT;
    weak?:                       UnionWeak;
    where?:                      UnionWhere;
    while?:                      UnionWhile;
    willSet?:                    UnionWillSet;
    with?:                       UnionWith;
    xor?:                        UnionXor;
    xor_eq?:                     UnionXorEq;
    YES?:                        UnionYES;
    yield?:                      UnionYield;
    [property: string]: mixed;
};

export type UnionAny = Any | number;

export type Any = {
};

export type UnionArrayNode = ArrayNode | number;

export type ArrayNode = {
};

export type UnionBOOL = Bool | number;

export type Bool = {
};

export type UnionBooleanNode = BooleanNode | number;

export type BooleanNode = {
};

export type UnionCalendar = Calendar | number;

export type Calendar = {
};

export type UnionClass = ClassClass | number;

export type ClassClass = {
};

export type UnionCodable = Codable | number;

export type Codable = {
};

export type UnionCodingKey = CodingKey | number;

export type CodingKey = {
};

export type UnionCodingKeys = CodingKeys | number;

export type CodingKeys = {
};

export type UnionCultureInfo = CultureInfo | number;

export type CultureInfo = {
};

export type UnionDateFormatter = DateFormatter | number;

export type DateFormatter = {
};

export type UnionDateOnly = DateOnly | number;

export type DateOnly = {
};

export type UnionDateOnlyConverter = DateOnlyConverter | number;

export type DateOnlyConverter = {
};

export type UnionDateTime = DateTime | number;

export type DateTime = {
};

export type UnionDateTimeStyles = DateTimeStyles | number;

export type DateTimeStyles = {
};

export type UnionDecoder = Decoder | number;

export type Decoder = {
};

export type UnionDecodingError = DecodingError | number;

export type DecodingError = {
};

export type UnionDeserializationFeature = DeserializationFeature | number;

export type DeserializationFeature = {
};

export type UnionDoubleNode = DoubleNode | number;

export type DoubleNode = {
};

export type UnionEncoder = Encoder | number;

export type Encoder = {
};

export type UnionEnumValues = EnumValues | number;

export type EnumValues = {
};

export type UnionEquatable = Equatable | number;

export type Equatable = {
};

export type UnionFalse = False | number;

export type False = {
};

export type UnionFormatException = FormatException | number;

export type FormatException = {
};

export type UnionHashable = Hashable | number;

export type Hashable = {
};

export type UnionHasher = Hasher | number;

export type Hasher = {
};

export type UnionIMP = Imp | number;

export type Imp = {
};

export type UnionIntNode = IntNode | number;

export type IntNode = {
};

export type UnionISODateTimeOffsetConverter = ISODateTimeOffsetConverter | number;

export type ISODateTimeOffsetConverter = {
};

export type UnionJSONAny = JSONAny | number;

export type JSONAny = {
};

export type UnionJSONCodingKey = JSONCodingKey | number;

export type JSONCodingKey = {
};

export type UnionJSONDecoder = JSONDecoder | number;

export type JSONDecoder = {
};

export type UnionJSONEncoder = JSONEncoder | number;

export type JSONEncoder = {
};

export type UnionJSONNull = JSONNull | number;

export type JSONNull = {
};

export type UnionJSONException = JSONException | number;

export type JSONException = {
};

export type UnionJSONGenerator = JSONGenerator | number;

export type JSONGenerator = {
};

export type UnionJSONNode = JSONNode | number;

export type JSONNode = {
};

export type UnionJSONParser = JSONParser | number;

export type JSONParser = {
};

export type UnionJSONReader = JSONReader | number;

export type JSONReader = {
};

export type UnionJSONTokenType = JSONTokenType | number;

export type JSONTokenType = {
};

export type UnionKSerializer = KSerializer | number;

export type KSerializer = {
};

export type UnionLocalDate = LocalDate | number;

export type LocalDate = {
};

export type UnionLocale = Locale | number;

export type Locale = {
};

export type UnionLongNode = LongNode | number;

export type LongNode = {
};

export type UnionMapEntry = MapEntry | number;

export type MapEntry = {
};

export type UnionMarshalJSON = MarshalJSON | number;

export type MarshalJSON = {
};

export type UnionNO = No | number;

export type No = {
};

export type UnionNSError = NSError | number;

export type NSError = {
};

export type UnionNSObject = NSObject | number;

export type NSObject = {
};

export type UnionNSString = NSString | number;

export type NSString = {
};

export type UnionNULL = Null | number;

export type Null = {
};

export type UnionNone = None | number;

export type None = {
};

export type UnionNullNode = NullNode | number;

export type NullNode = {
};

export type UnionObjectMapper = ObjectMapper | number;

export type ObjectMapper = {
};

export type UnionObjectNode = ObjectNode | number;

export type ObjectNode = {
};

export type UnionObjectReader = ObjectReader | number;

export type ObjectReader = {
};

export type UnionObjectWriter = ObjectWriter | number;

export type ObjectWriter = {
};

export type UnionOffsetDateTime = OffsetDateTime | number;

export type OffsetDateTime = {
};

export type UnionOffsetTime = OffsetTime | number;

export type OffsetTime = {
};

export type UnionPrimitiveKind = PrimitiveKind | number;

export type PrimitiveKind = {
};

export type UnionProtocol = Protocol | number;

export type Protocol = {
};

export type UnionRegExp = RegExpClass | number;

export type RegExpClass = {
};

export type UnionSEL = Sel | number;

export type Sel = {
};

export type UnionSelf = Self | number;

export type Self = {
};

export type UnionSendable = Sendable | number;

export type Sendable = {
};

export type UnionSerialDescriptor = SerialDescriptor | number;

export type SerialDescriptor = {
};

export type UnionSerialName = SerialName | number;

export type SerialName = {
};

export type UnionSerializable = Serializable | number;

export type Serializable = {
};

export type UnionSerializationFeature = SerializationFeature | number;

export type SerializationFeature = {
};

export type UnionSerializerProvider = SerializerProvider | number;

export type SerializerProvider = {
};

export type UnionSimpleModule = SimpleModule | number;

export type SimpleModule = {
};

export type UnionStandards = Standards | number;

export type Standards = {
};

export type UnionStdDeserializer = StdDeserializer | number;

export type StdDeserializer = {
};

export type UnionStdSerializer = StdSerializer | number;

export type StdSerializer = {
};

export type UnionTextNode = TextNode | number;

export type TextNode = {
};

export type UnionTimeOnly = TimeOnly | number;

export type TimeOnly = {
};

export type UnionTimeOnlyConverter = TimeOnlyConverter | number;

export type TimeOnlyConverter = {
};

export type UnionTimeZone = TimeZone | number;

export type TimeZone = {
};

export type UnionTrue = True | number;

export type True = {
};

export type UnionType = Type | number;

export type Type = {
};

export type UnionUUID = UUID | number;

export type UUID = {
};

export type UnionUnmarshalJSON = UnmarshalJSON | number;

export type UnmarshalJSON = {
};

export type UnionUseSerializers = UseSerializers | number;

export type UseSerializers = {
};

export type UnionUtf8JSONReader = Utf8JSONReader | number;

export type Utf8JSONReader = {
};

export type UnionUtf8JSONWriter = Utf8JSONWriter | number;

export type Utf8JSONWriter = {
};

export type UnionYES = Yes | number;

export type Yes = {
};

export type UnionUnion = Empty | number;

export type Empty = {
};

export type UnionBool = BoolClass | number;

export type BoolClass = {
};

export type UnionComplex = Complex | number;

export type Complex = {
};

export type UnionImaginery = Imaginery | number;

export type Imaginery = {
};

export type UnionAbstract = Abstract | number;

export type Abstract = {
};

export type UnionAlignas = Alignas | number;

export type Alignas = {
};

export type UnionAlignof = Alignof | number;

export type Alignof = {
};

export type UnionAnd = And | number;

export type And = {
};

export type UnionAndEq = AndEq | number;

export type AndEq = {
};

export type UnionAnyUnion = AnyClass | number;

export type AnyClass = {
};

export type UnionArray = ArrayClass | number;

export type ArrayClass = {
};

export type UnionAs = As | number;

export type As = {
};

export type UnionASM = ASM | number;

export type ASM = {
};

export type UnionAssert = Assert | number;

export type Assert = {
};

export type UnionAssociatedtype = Associatedtype | number;

export type Associatedtype = {
};

export type UnionAssociativity = Associativity | number;

export type Associativity = {
};

export type UnionAsync = Async | number;

export type Async = {
};

export type UnionAtomic = Atomic | number;

export type Atomic = {
};

export type UnionAtomicCancel = AtomicCancel | number;

export type AtomicCancel = {
};

export type UnionAtomicCommit = AtomicCommit | number;

export type AtomicCommit = {
};

export type UnionAtomicNoexcept = AtomicNoexcept | number;

export type AtomicNoexcept = {
};

export type UnionAuto = Auto | number;

export type Auto = {
};

export type UnionAwait = Await | number;

export type Await = {
};

export type UnionBase = Base | number;

export type Base = {
};

export type UnionBitand = Bitand | number;

export type Bitand = {
};

export type UnionBitor = Bitor | number;

export type Bitor = {
};

export type UnionBoolUnion = UnionBoolBool | number;

export type UnionBoolBool = {
};

export type UnionBoolean = Boolean | number;

export type Boolean = {
};

export type UnionBreak = Break | number;

export type Break = {
};

export type UnionBycopy = Bycopy | number;

export type Bycopy = {
};

export type UnionByref = Byref | number;

export type Byref = {
};

export type UnionByte = Byte | number;

export type Byte = {
};

export type UnionCase = Case | number;

export type Case = {
};

export type UnionCatch = Catch | number;

export type Catch = {
};

export type UnionChan = Chan | number;

export type Chan = {
};

export type UnionChar = Char | number;

export type Char = {
};

export type UnionChar16T = Char16T | number;

export type Char16T = {
};

export type UnionChar32T = Char32T | number;

export type Char32T = {
};

export type UnionChecked = Checked | number;

export type Checked = {
};

export type UnionClassUnion = UnionClassClass | number;

export type UnionClassClass = {
};

export type UnionClone = Clone | number;

export type Clone = {
};

export type UnionCoAwait = CoAwait | number;

export type CoAwait = {
};

export type UnionCoReturn = CoReturn | number;

export type CoReturn = {
};

export type UnionCoYield = CoYield | number;

export type CoYield = {
};

export type UnionCompl = Compl | number;

export type Compl = {
};

export type UnionConcept = Concept | number;

export type Concept = {
};

export type UnionConsole = Console | number;

export type Console = {
};

export type UnionConst = Const | number;

export type Const = {
};

export type UnionConstCast = ConstCast | number;

export type ConstCast = {
};

export type UnionConstexpr = Constexpr | number;

export type Constexpr = {
};

export type UnionConstructor = Constructor | number;

export type Constructor = {
};

export type UnionContinue = Continue | number;

export type Continue = {
};

export type UnionConvenience = Convenience | number;

export type Convenience = {
};

export type UnionConvert = Convert | number;

export type Convert = {
};

export type UnionConverter = Converter | number;

export type Converter = {
};

export type UnionDate = DateClass | number;

export type DateClass = {
};

export type UnionDateParseHandling = DateParseHandling | number;

export type DateParseHandling = {
};

export type UnionDebugger = Debugger | number;

export type Debugger = {
};

export type UnionDecimal = Decimal | number;

export type Decimal = {
};

export type UnionDeclare = Declare | number;

export type Declare = {
};

export type UnionDecltype = Decltype | number;

export type Decltype = {
};

export type UnionDecodeString = DecodeString | number;

export type DecodeString = {
};

export type UnionDef = Def | number;

export type Def = {
};

export type UnionDefault = Default | number;

export type Default = {
};

export type UnionDefer = Defer | number;

export type Defer = {
};

export type UnionDeinit = Deinit | number;

export type Deinit = {
};

export type UnionDel = Del | number;

export type Del = {
};

export type UnionDelegate = Delegate | number;

export type Delegate = {
};

export type UnionDelete = Delete | number;

export type Delete = {
};

export type UnionDict = Dict | number;

export type Dict = {
};

export type UnionDictionary = Dictionary | number;

export type Dictionary = {
};

export type UnionDidSet = DidSet | number;

export type DidSet = {
};

export type UnionDo = Do | number;

export type Do = {
};

export type UnionDouble = Double | number;

export type Double = {
};

export type UnionDynamic = Dynamic | number;

export type Dynamic = {
};

export type UnionDynamicCast = DynamicCast | number;

export type DynamicCast = {
};

export type UnionElif = Elif | number;

export type Elif = {
};

export type UnionElse = Else | number;

export type Else = {
};

export type UnionEncodeQuickType = EncodeQuickType | number;

export type EncodeQuickType = {
};

export type UnionEnum = Enum | number;

export type Enum = {
};

export type UnionEqualityContract = EqualityContract | number;

export type EqualityContract = {
};

export type UnionEvent = Event | number;

export type Event = {
};

export type UnionExcept = Except | number;

export type Except = {
};

export type UnionException = Exception | number;

export type Exception = {
};

export type UnionExplicit = Explicit | number;

export type Explicit = {
};

export type UnionExport = Export | number;

export type Export = {
};

export type UnionExposing = Exposing | number;

export type Exposing = {
};

export type UnionExtends = Extends | number;

export type Extends = {
};

export type UnionExtension = Extension | number;

export type Extension = {
};

export type UnionExtern = Extern | number;

export type Extern = {
};

export type UnionFallthrough = Fallthrough | number;

export type Fallthrough = {
};

export type UnionFalseUnion = FalseClass | number;

export type FalseClass = {
};

export type UnionFileprivate = Fileprivate | number;

export type Fileprivate = {
};

export type UnionFinal = Final | number;

export type Final = {
};

export type UnionFinally = Finally | number;

export type Finally = {
};

export type UnionFixed = Fixed | number;

export type Fixed = {
};

export type UnionFloat = Float | number;

export type Float = {
};

export type UnionFor = For | number;

export type For = {
};

export type UnionForeach = Foreach | number;

export type Foreach = {
};

export type UnionFriend = Friend | number;

export type Friend = {
};

export type UnionFrom = From | number;

export type From = {
};

export type UnionFromDict = FromDict | number;

export type FromDict = {
};

export type UnionFromJSON = FromJSON | number;

export type FromJSON = {
};

export type UnionFunc = Func | number;

export type Func = {
};

export type UnionFunction = Function | number;

export type Function = {
};

export type UnionGet = Get | number;

export type Get = {
};

export type UnionGlobal = Global | number;

export type Global = {
};

export type UnionGo = Go | number;

export type Go = {
};

export type UnionGoto = Goto | number;

export type Goto = {
};

export type UnionGuard = Guard | number;

export type Guard = {
};

export type UnionHasOwnProperty = HasOwnProperty | number;

export type HasOwnProperty = {
};

export type UnionHashCode = HashCode | number;

export type HashCode = {
};

export type UnionID = ID | number;

export type ID = {
};

export type UnionIf = If | number;

export type If = {
};

export type UnionImplements = Implements | number;

export type Implements = {
};

export type UnionImplicit = Implicit | number;

export type Implicit = {
};

export type UnionImport = Import | number;

export type Import = {
};

export type UnionIn = In | number;

export type In = {
};

export type UnionIndirect = Indirect | number;

export type Indirect = {
};

export type UnionInfix = Infix | number;

export type Infix = {
};

export type UnionInit = Init | number;

export type Init = {
};

export type UnionInline = Inline | number;

export type Inline = {
};

export type UnionInout = Inout | number;

export type Inout = {
};

export type UnionInstanceof = Instanceof | number;

export type Instanceof = {
};

export type UnionInt = Int | number;

export type Int = {
};

export type UnionInterface = Interface | number;

export type Interface = {
};

export type UnionInternal = Internal | number;

export type Internal = {
};

export type UnionIs = Is | number;

export type Is = {
};

export type UnionIterable = Iterable | number;

export type Iterable = {
};

export type UnionJdec = Jdec | number;

export type Jdec = {
};

export type UnionJenc = Jenc | number;

export type Jenc = {
};

export type UnionJpipe = Jpipe | number;

export type Jpipe = {
};

export type UnionJSON = JSONClass | number;

export type JSONClass = {
};

export type UnionJSONConverter = JSONConverter | number;

export type JSONConverter = {
};

export type UnionJSONSerializer = JSONSerializer | number;

export type JSONSerializer = {
};

export type UnionJSONToken = JSONToken | number;

export type JSONToken = {
};

export type UnionJSONWriter = JSONWriter | number;

export type JSONWriter = {
};

export type UnionLambda = Lambda | number;

export type Lambda = {
};

export type UnionLazy = Lazy | number;

export type Lazy = {
};

export type UnionLeft = Left | number;

export type Left = {
};

export type UnionLet = Let | number;

export type Let = {
};

export type UnionList = List | number;

export type List = {
};

export type UnionLock = Lock | number;

export type Lock = {
};

export type UnionLong = Long | number;

export type Long = {
};

export type UnionMap = Map | number;

export type Map = {
};

export type UnionMetadataPropertyHandling = MetadataPropertyHandling | number;

export type MetadataPropertyHandling = {
};

export type UnionModule = Module | number;

export type Module = {
};

export type UnionMutable = Mutable | number;

export type Mutable = {
};

export type UnionMutating = Mutating | number;

export type Mutating = {
};

export type UnionNamespace = Namespace | number;

export type Namespace = {
};

export type UnionNative = Native | number;

export type Native = {
};

export type UnionNew = New | number;

export type New = {
};

export type UnionNewtonsoft = Newtonsoft | number;

export type Newtonsoft = {
};

export type UnionNil = Nil | number;

export type Nil = {
};

export type UnionNoSuchMethod = NoSuchMethod | number;

export type NoSuchMethod = {
};

export type UnionNoexcept = Noexcept | number;

export type Noexcept = {
};

export type UnionNonatomic = Nonatomic | number;

export type Nonatomic = {
};

export type UnionNoneUnion = NoneClass | number;

export type NoneClass = {
};

export type UnionNonlocal = Nonlocal | number;

export type Nonlocal = {
};

export type UnionNonmutating = Nonmutating | number;

export type Nonmutating = {
};

export type UnionNot = Not | number;

export type Not = {
};

export type UnionNotEq = NotEq | number;

export type NotEq = {
};

export type UnionNull = NullClass | number;

export type NullClass = {
};

export type UnionNullptr = Nullptr | number;

export type Nullptr = {
};

export type UnionNumber = Number | number;

export type Number = {
};

export type UnionObject = ObjectClass | number;

export type ObjectClass = {
};

export type UnionOf = Of | number;

export type Of = {
};

export type UnionOneway = Oneway | number;

export type Oneway = {
};

export type UnionOpen = Open | number;

export type Open = {
};

export type UnionOperator = Operator | number;

export type Operator = {
};

export type UnionOptional = Optional | number;

export type Optional = {
};

export type UnionOr = Or | number;

export type Or = {
};

export type UnionOrEq = OrEq | number;

export type OrEq = {
};

export type UnionOut = Out | number;

export type Out = {
};

export type UnionOverride = Override | number;

export type Override = {
};

export type UnionPackage = Package | number;

export type Package = {
};

export type UnionParams = Params | number;

export type Params = {
};

export type UnionPass = Pass | number;

export type Pass = {
};

export type UnionPort = Port | number;

export type Port = {
};

export type UnionPostfix = Postfix | number;

export type Postfix = {
};

export type UnionPrecedence = Precedence | number;

export type Precedence = {
};

export type UnionPrefix = Prefix | number;

export type Prefix = {
};

export type UnionPrint = Print | number;

export type Print = {
};

export type UnionPrintMembers = PrintMembers | number;

export type PrintMembers = {
};

export type UnionPrintf = Printf | number;

export type Printf = {
};

export type UnionPrivate = Private | number;

export type Private = {
};

export type UnionProtected = Protected | number;

export type Protected = {
};

export type UnionProtocolUnion = ProtocolClass | number;

export type ProtocolClass = {
};

export type UnionPublic = Public | number;

export type Public = {
};

export type UnionQuicktype = Quicktype | number;

export type Quicktype = {
};

export type UnionRaise = Raise | number;

export type Raise = {
};

export type UnionRange = Range | number;

export type Range = {
};

export type UnionReadonly = Readonly | number;

export type Readonly = {
};

export type UnionRef = Ref | number;

export type Ref = {
};

export type UnionRegister = Register | number;

export type Register = {
};

export type UnionReinterpretCast = ReinterpretCast | number;

export type ReinterpretCast = {
};

export type UnionRepeat = Repeat | number;

export type Repeat = {
};

export type UnionRequire = Require | number;

export type Require = {
};

export type UnionRequired = Required | number;

export type Required = {
};

export type UnionRequires = Requires | number;

export type Requires = {
};

export type UnionRestrict = Restrict | number;

export type Restrict = {
};

export type UnionRetain = Retain | number;

export type Retain = {
};

export type UnionRethrows = Rethrows | number;

export type Rethrows = {
};

export type UnionReturn = Return | number;

export type Return = {
};

export type UnionRight = Right | number;

export type Right = {
};

export type UnionRuntimeType = RuntimeType | number;

export type RuntimeType = {
};

export type UnionS = S | number;

export type S = {
};

export type UnionSbyte = Sbyte | number;

export type Sbyte = {
};

export type UnionSealed = Sealed | number;

export type Sealed = {
};

export type UnionSelect = Select | number;

export type Select = {
};

export type UnionSelfUnion = SelfClass | number;

export type SelfClass = {
};

export type UnionSerialize = Serialize | number;

export type Serialize = {
};

export type UnionSet = Set | number;

export type Set = {
};

export type UnionShort = Short | number;

export type Short = {
};

export type UnionSigned = Signed | number;

export type Signed = {
};

export type UnionSizeof = Sizeof | number;

export type Sizeof = {
};

export type UnionStackalloc = Stackalloc | number;

export type Stackalloc = {
};

export type UnionStatic = Static | number;

export type Static = {
};

export type UnionStaticAssert = StaticAssert | number;

export type StaticAssert = {
};

export type UnionStaticCast = StaticCast | number;

export type StaticCast = {
};

export type UnionStrictfp = Strictfp | number;

export type Strictfp = {
};

export type UnionString = StringClass | number;

export type StringClass = {
};

export type UnionStruct = Struct | number;

export type Struct = {
};

export type UnionSubscript = Subscript | number;

export type Subscript = {
};

export type UnionSuper = Super | number;

export type Super = {
};

export type UnionSwitch = Switch | number;

export type Switch = {
};

export type UnionSymbol = Symbol | number;

export type Symbol = {
};

export type UnionSynchronized = Synchronized | number;

export type Synchronized = {
};

export type UnionSystem = System | number;

export type System = {
};

export type UnionTemplate = Template | number;

export type Template = {
};

export type UnionThen = Then | number;

export type Then = {
};

export type UnionThis = This | number;

export type This = {
};

export type UnionThreadLocal = ThreadLocal | number;

export type ThreadLocal = {
};

export type UnionThrow = Throw | number;

export type Throw = {
};

export type UnionThrows = Throws | number;

export type Throws = {
};

export type UnionToString = ToString | number;

export type ToString = {
};

export type UnionToDict = ToDict | number;

export type ToDict = {
};

export type UnionToJSON = ToJSON | number;

export type ToJSON = {
};

export type UnionTopLevel = TopLevelClass | number;

export type TopLevelClass = {
};

export type UnionTransient = Transient | number;

export type Transient = {
};

export type UnionTrueUnion = TrueClass | number;

export type TrueClass = {
};

export type UnionTry = Try | number;

export type Try = {
};

export type UnionTypeUnion = TypeClass | number;

export type TypeClass = {
};

export type UnionTypealias = Typealias | number;

export type Typealias = {
};

export type UnionTypedef = Typedef | number;

export type Typedef = {
};

export type UnionTypeid = Typeid | number;

export type Typeid = {
};

export type UnionTypename = Typename | number;

export type Typename = {
};

export type UnionTypeof = Typeof | number;

export type Typeof = {
};

export type UnionUint = Uint | number;

export type Uint = {
};

export type UnionUlong = Ulong | number;

export type Ulong = {
};

export type UnionUnchecked = Unchecked | number;

export type Unchecked = {
};

export type UnionUndefined = Undefined | number;

export type Undefined = {
};

export type UnionUnionUnion = Union | number;

export type Union = {
};

export type UnionUnowned = Unowned | number;

export type Unowned = {
};

export type UnionUnsafe = Unsafe | number;

export type Unsafe = {
};

export type UnionUnsigned = Unsigned | number;

export type Unsigned = {
};

export type UnionUshort = Ushort | number;

export type Ushort = {
};

export type UnionUsing = Using | number;

export type Using = {
};

export type UnionVar = Var | number;

export type Var = {
};

export type UnionVirtual = Virtual | number;

export type Virtual = {
};

export type UnionVoid = Void | number;

export type Void = {
};

export type UnionVolatile = Volatile | number;

export type Volatile = {
};

export type UnionWcharT = WcharT | number;

export type WcharT = {
};

export type UnionWeak = Weak | number;

export type Weak = {
};

export type UnionWhere = Where | number;

export type Where = {
};

export type UnionWhile = While | number;

export type While = {
};

export type UnionWillSet = WillSet | number;

export type WillSet = {
};

export type UnionWith = With | number;

export type With = {
};

export type UnionXor = Xor | number;

export type Xor = {
};

export type UnionXorEq = XorEq | number;

export type XorEq = {
};

export type UnionYield = Yield | number;

export type Yield = {
};

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
function toTopLevel(json: string): TopLevel {
    return cast(JSON.parse(json), r("TopLevel"));
}

function topLevelToJson(value: TopLevel): string {
    return JSON.stringify(uncast(value, r("TopLevel")), null, 2);
}

function invalidValue(typ: any, val: any, key: any, parent: any = '') {
    const prettyTyp = prettyTypeName(typ);
    const parentText = parent ? ` on ${parent}` : '';
    const keyText = key ? ` for key "${key}"` : '';
    throw Error(`Invalid value${keyText}${parentText}. Expected ${prettyTyp} but got ${JSON.stringify(val)}`);
}

function prettyTypeName(typ: any): string {
    if (Array.isArray(typ)) {
        if (typ.length === 2 && typ[0] === undefined) {
            return `an optional ${prettyTypeName(typ[1])}`;
        } else {
            return `one of [${typ.map(a => { return prettyTypeName(a); }).join(", ")}]`;
        }
    } else if (typeof typ === "object" && typ.literal !== undefined) {
        return typ.literal;
    } else {
        return typeof typ;
    }
}

function jsonToJSProps(typ: any): any {
    if (typ.jsonToJS === undefined) {
        const map: any = {};
        typ.props.forEach((p: any) => map[p.json] = { key: p.js, typ: p.typ });
        typ.jsonToJS = map;
    }
    return typ.jsonToJS;
}

function jsToJSONProps(typ: any): any {
    if (typ.jsToJSON === undefined) {
        const map: any = {};
        typ.props.forEach((p: any) => map[p.js] = { key: p.json, typ: p.typ });
        typ.jsToJSON = map;
    }
    return typ.jsToJSON;
}

function transform(val: any, typ: any, getProps: any, key: any = '', parent: any = ''): any {
    function transformPrimitive(typ: string, val: any): any {
        if (typeof typ === typeof val) return val;
        return invalidValue(typ, val, key, parent);
    }

    function transformUnion(typs: any[], val: any): any {
        // val must validate against one typ in typs
        const l = typs.length;
        for (let i = 0; i < l; i++) {
            const typ = typs[i];
            try {
                return transform(val, typ, getProps);
            } catch (_) {}
        }
        return invalidValue(typs, val, key, parent);
    }

    function transformEnum(cases: string[], val: any): any {
        if (cases.indexOf(val) !== -1) return val;
        return invalidValue(cases.map(a => { return l(a); }), val, key, parent);
    }

    function transformArray(typ: any, val: any): any {
        // val must be an array with no invalid elements
        if (!Array.isArray(val)) return invalidValue(l("array"), val, key, parent);

        return val.map(el => transform(el, typ, getProps));
    }

    function transformDate(val: any): any {
        if (val === null) {
            return null;
        }
        const d = new Date(val);
        if (isNaN(d.valueOf())) {
            return invalidValue(l("Date"), val, key, parent);
        }
        return d;
    }

    function transformObject(props: { [k: string]: any }, additional: any, val: any): any {
        if (val === null || typeof val !== "object" || Array.isArray(val)) {
            return invalidValue(l(ref || "object"), val, key, parent);
        }
        const result: any = {};
        Object.getOwnPropertyNames(props).forEach(key => {
            const prop = props[key];
            const v = Object.prototype.hasOwnProperty.call(val, key) ? val[key] : undefined;
            result[prop.key] = transform(v, prop.typ, getProps, key, ref);
        });
        Object.getOwnPropertyNames(val).forEach(key => {
            if (!Object.prototype.hasOwnProperty.call(props, key)) {
                result[key] = transform(val[key], additional, getProps, key, ref);
            }
        });
        return result;
    }

    if (typ === "any") return val;
    if (typ === null) {
        if (val === null) return val;
        return invalidValue(typ, val, key, parent);
    }
    if (typ === false) return invalidValue(typ, val, key, parent);
    let ref: any = undefined;
    while (typeof typ === "object" && typ.ref !== undefined) {
        ref = typ.ref;
        typ = typeMap[typ.ref];
    }
    if (Array.isArray(typ)) return transformEnum(typ, val);
    if (typeof typ === "object") {
        return typ.hasOwnProperty("pattern")      ? typeof val === "string" && new RegExp(typ.pattern).test(val) ? val : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("string")       ? typeof val === "string" && (typ.min === undefined || Array.from(val).length >= typ.min) && (typ.max === undefined || Array.from(val).length <= typ.max) ? transform(val, typ.string, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("number")       ? typeof val === "number" && (typ.min === undefined || val >= typ.min) && (typ.max === undefined || val <= typ.max) ? transform(val, typ.number, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("integer")      ? typeof val === "number" && val % 1 === 0 ? val : invalidValue(l("integer"), val, key, parent)
            : typ.hasOwnProperty("unionMembers") ? transformUnion(typ.unionMembers, val)
            : typ.hasOwnProperty("arrayItems")    ? transformArray(typ.arrayItems, val)
            : typ.hasOwnProperty("props")         ? transformObject(getProps(typ), typ.additional, val)
            : invalidValue(typ, val, key, parent);
    }
    // Numbers can be parsed by Date but shouldn't be.
    if (typ === Date && (typeof val === "string" || val instanceof Date)) return transformDate(val);
    return transformPrimitive(typ, val);
}

function cast<T>(val: any, typ: any): T {
    return transform(val, typ, jsonToJSProps);
}

function uncast<T>(val: T, typ: any): any {
    return transform(val, typ, jsToJSONProps);
}

function l(typ: any) {
    return { literal: typ };
}

function a(typ: any) {
    return { arrayItems: typ };
}

function i(typ: any) {
    return { integer: typ };
}

function p(pattern: any) {
    return { pattern };
}

function s(typ: any, min: any, max: any) {
    return { string: typ, min, max };
}

function n(typ: any, min: any, max: any) {
    return { number: typ, min, max };
}

function u(...typs: any[]) {
    return { unionMembers: typs };
}

function o(props: any[], additional: any) {
    return { props, additional };
}

function m(additional: any) {
    const props: any[] = [];
    return { props, additional };
}

function r(name: string) {
    return { ref: name };
}

const typeMap: any = {
    "TopLevel": o([
        { json: "_", js: "_", typ: u(undefined, u(r("Empty"), 3.14)) },
        { json: "_Bool", js: "_Bool", typ: u(undefined, u(r("BoolClass"), 3.14)) },
        { json: "_Complex", js: "_Complex", typ: u(undefined, u(r("Complex"), 3.14)) },
        { json: "_Imaginery", js: "_Imaginery", typ: u(undefined, u(r("Imaginery"), 3.14)) },
        { json: "abstract", js: "abstract", typ: u(undefined, u(r("Abstract"), 3.14)) },
        { json: "alignas", js: "alignas", typ: u(undefined, u(r("Alignas"), 3.14)) },
        { json: "alignof", js: "alignof", typ: u(undefined, u(r("Alignof"), 3.14)) },
        { json: "and", js: "and", typ: u(undefined, u(r("And"), 3.14)) },
        { json: "and_eq", js: "and_eq", typ: u(undefined, u(r("AndEq"), 3.14)) },
        { json: "any", js: "any", typ: u(undefined, u(r("AnyClass"), 3.14)) },
        { json: "Any", js: "Any", typ: u(undefined, u(r("Any"), 3.14)) },
        { json: "array", js: "array", typ: u(undefined, u(r("ArrayClass"), 3.14)) },
        { json: "ArrayNode", js: "ArrayNode", typ: u(undefined, u(r("ArrayNode"), 3.14)) },
        { json: "as", js: "as", typ: u(undefined, u(r("As"), 3.14)) },
        { json: "asm", js: "asm", typ: u(undefined, u(r("ASM"), 3.14)) },
        { json: "assert", js: "assert", typ: u(undefined, u(r("Assert"), 3.14)) },
        { json: "associatedtype", js: "associatedtype", typ: u(undefined, u(r("Associatedtype"), 3.14)) },
        { json: "associativity", js: "associativity", typ: u(undefined, u(r("Associativity"), 3.14)) },
        { json: "async", js: "async", typ: u(undefined, u(r("Async"), 3.14)) },
        { json: "atomic", js: "atomic", typ: u(undefined, u(r("Atomic"), 3.14)) },
        { json: "atomic_cancel", js: "atomic_cancel", typ: u(undefined, u(r("AtomicCancel"), 3.14)) },
        { json: "atomic_commit", js: "atomic_commit", typ: u(undefined, u(r("AtomicCommit"), 3.14)) },
        { json: "atomic_noexcept", js: "atomic_noexcept", typ: u(undefined, u(r("AtomicNoexcept"), 3.14)) },
        { json: "auto", js: "auto", typ: u(undefined, u(r("Auto"), 3.14)) },
        { json: "await", js: "await", typ: u(undefined, u(r("Await"), 3.14)) },
        { json: "base", js: "base", typ: u(undefined, u(r("Base"), 3.14)) },
        { json: "bitand", js: "bitand", typ: u(undefined, u(r("Bitand"), 3.14)) },
        { json: "bitor", js: "bitor", typ: u(undefined, u(r("Bitor"), 3.14)) },
        { json: "BOOL", js: "BOOL", typ: u(undefined, u(r("Bool"), 3.14)) },
        { json: "bool", js: "bool", typ: u(undefined, u(r("UnionBoolBool"), 3.14)) },
        { json: "boolean", js: "boolean", typ: u(undefined, u(r("Boolean"), 3.14)) },
        { json: "BooleanNode", js: "BooleanNode", typ: u(undefined, u(r("BooleanNode"), 3.14)) },
        { json: "break", js: "break", typ: u(undefined, u(r("Break"), 3.14)) },
        { json: "bycopy", js: "bycopy", typ: u(undefined, u(r("Bycopy"), 3.14)) },
        { json: "byref", js: "byref", typ: u(undefined, u(r("Byref"), 3.14)) },
        { json: "byte", js: "byte", typ: u(undefined, u(r("Byte"), 3.14)) },
        { json: "Calendar", js: "Calendar", typ: u(undefined, u(r("Calendar"), 3.14)) },
        { json: "case", js: "case", typ: u(undefined, u(r("Case"), 3.14)) },
        { json: "catch", js: "catch", typ: u(undefined, u(r("Catch"), 3.14)) },
        { json: "chan", js: "chan", typ: u(undefined, u(r("Chan"), 3.14)) },
        { json: "char", js: "char", typ: u(undefined, u(r("Char"), 3.14)) },
        { json: "char16_t", js: "char16_t", typ: u(undefined, u(r("Char16T"), 3.14)) },
        { json: "char32_t", js: "char32_t", typ: u(undefined, u(r("Char32T"), 3.14)) },
        { json: "checked", js: "checked", typ: u(undefined, u(r("Checked"), 3.14)) },
        { json: "class", js: "class", typ: u(undefined, u(r("UnionClassClass"), 3.14)) },
        { json: "Class", js: "Class", typ: u(undefined, u(r("ClassClass"), 3.14)) },
        { json: "clone", js: "clone", typ: u(undefined, u(r("Clone"), 3.14)) },
        { json: "co_await", js: "co_await", typ: u(undefined, u(r("CoAwait"), 3.14)) },
        { json: "co_return", js: "co_return", typ: u(undefined, u(r("CoReturn"), 3.14)) },
        { json: "co_yield", js: "co_yield", typ: u(undefined, u(r("CoYield"), 3.14)) },
        { json: "Codable", js: "Codable", typ: u(undefined, u(r("Codable"), 3.14)) },
        { json: "CodingKey", js: "CodingKey", typ: u(undefined, u(r("CodingKey"), 3.14)) },
        { json: "CodingKeys", js: "CodingKeys", typ: u(undefined, u(r("CodingKeys"), 3.14)) },
        { json: "compl", js: "compl", typ: u(undefined, u(r("Compl"), 3.14)) },
        { json: "concept", js: "concept", typ: u(undefined, u(r("Concept"), 3.14)) },
        { json: "console", js: "console", typ: u(undefined, u(r("Console"), 3.14)) },
        { json: "const", js: "const", typ: u(undefined, u(r("Const"), 3.14)) },
        { json: "const_cast", js: "const_cast", typ: u(undefined, u(r("ConstCast"), 3.14)) },
        { json: "constexpr", js: "constexpr", typ: u(undefined, u(r("Constexpr"), 3.14)) },
        { json: "constructor", js: "constructor", typ: u(undefined, u(r("Constructor"), 3.14)) },
        { json: "continue", js: "continue", typ: u(undefined, u(r("Continue"), 3.14)) },
        { json: "convenience", js: "convenience", typ: u(undefined, u(r("Convenience"), 3.14)) },
        { json: "convert", js: "convert", typ: u(undefined, u(r("Convert"), 3.14)) },
        { json: "converter", js: "converter", typ: u(undefined, u(r("Converter"), 3.14)) },
        { json: "CultureInfo", js: "CultureInfo", typ: u(undefined, u(r("CultureInfo"), 3.14)) },
        { json: "date", js: "date", typ: u(undefined, u(r("DateClass"), 3.14)) },
        { json: "date_parse_handling", js: "date_parse_handling", typ: u(undefined, u(r("DateParseHandling"), 3.14)) },
        { json: "DateFormatter", js: "DateFormatter", typ: u(undefined, u(r("DateFormatter"), 3.14)) },
        { json: "DateOnly", js: "DateOnly", typ: u(undefined, u(r("DateOnly"), 3.14)) },
        { json: "DateOnlyConverter", js: "DateOnlyConverter", typ: u(undefined, u(r("DateOnlyConverter"), 3.14)) },
        { json: "DateTime", js: "DateTime", typ: u(undefined, u(r("DateTime"), 3.14)) },
        { json: "DateTimeStyles", js: "DateTimeStyles", typ: u(undefined, u(r("DateTimeStyles"), 3.14)) },
        { json: "debugger", js: "debugger", typ: u(undefined, u(r("Debugger"), 3.14)) },
        { json: "decimal", js: "decimal", typ: u(undefined, u(r("Decimal"), 3.14)) },
        { json: "declare", js: "declare", typ: u(undefined, u(r("Declare"), 3.14)) },
        { json: "decltype", js: "decltype", typ: u(undefined, u(r("Decltype"), 3.14)) },
        { json: "decode_string", js: "decode_string", typ: u(undefined, u(r("DecodeString"), 3.14)) },
        { json: "Decoder", js: "Decoder", typ: u(undefined, u(r("Decoder"), 3.14)) },
        { json: "DecodingError", js: "DecodingError", typ: u(undefined, u(r("DecodingError"), 3.14)) },
        { json: "def", js: "def", typ: u(undefined, u(r("Def"), 3.14)) },
        { json: "default", js: "default", typ: u(undefined, u(r("Default"), 3.14)) },
        { json: "defer", js: "defer", typ: u(undefined, u(r("Defer"), 3.14)) },
        { json: "deinit", js: "deinit", typ: u(undefined, u(r("Deinit"), 3.14)) },
        { json: "del", js: "del", typ: u(undefined, u(r("Del"), 3.14)) },
        { json: "delegate", js: "delegate", typ: u(undefined, u(r("Delegate"), 3.14)) },
        { json: "delete", js: "delete", typ: u(undefined, u(r("Delete"), 3.14)) },
        { json: "DeserializationFeature", js: "DeserializationFeature", typ: u(undefined, u(r("DeserializationFeature"), 3.14)) },
        { json: "dict", js: "dict", typ: u(undefined, u(r("Dict"), 3.14)) },
        { json: "dictionary", js: "dictionary", typ: u(undefined, u(r("Dictionary"), 3.14)) },
        { json: "didSet", js: "didSet", typ: u(undefined, u(r("DidSet"), 3.14)) },
        { json: "do", js: "do", typ: u(undefined, u(r("Do"), 3.14)) },
        { json: "double", js: "double", typ: u(undefined, u(r("Double"), 3.14)) },
        { json: "DoubleNode", js: "DoubleNode", typ: u(undefined, u(r("DoubleNode"), 3.14)) },
        { json: "dummy", js: "dummy", typ: u(undefined, 3.14) },
        { json: "dynamic", js: "dynamic", typ: u(undefined, u(r("Dynamic"), 3.14)) },
        { json: "dynamic_cast", js: "dynamic_cast", typ: u(undefined, u(r("DynamicCast"), 3.14)) },
        { json: "elif", js: "elif", typ: u(undefined, u(r("Elif"), 3.14)) },
        { json: "else", js: "else", typ: u(undefined, u(r("Else"), 3.14)) },
        { json: "encode_quick_type", js: "encode_quick_type", typ: u(undefined, u(r("EncodeQuickType"), 3.14)) },
        { json: "Encoder", js: "Encoder", typ: u(undefined, u(r("Encoder"), 3.14)) },
        { json: "enum", js: "enum", typ: u(undefined, u(r("Enum"), 3.14)) },
        { json: "EnumValues", js: "EnumValues", typ: u(undefined, u(r("EnumValues"), 3.14)) },
        { json: "equalityContract", js: "equalityContract", typ: u(undefined, u(r("EqualityContract"), 3.14)) },
        { json: "Equatable", js: "Equatable", typ: u(undefined, u(r("Equatable"), 3.14)) },
        { json: "event", js: "event", typ: u(undefined, u(r("Event"), 3.14)) },
        { json: "except", js: "except", typ: u(undefined, u(r("Except"), 3.14)) },
        { json: "exception", js: "exception", typ: u(undefined, u(r("Exception"), 3.14)) },
        { json: "explicit", js: "explicit", typ: u(undefined, u(r("Explicit"), 3.14)) },
        { json: "export", js: "export", typ: u(undefined, u(r("Export"), 3.14)) },
        { json: "exposing", js: "exposing", typ: u(undefined, u(r("Exposing"), 3.14)) },
        { json: "extends", js: "extends", typ: u(undefined, u(r("Extends"), 3.14)) },
        { json: "extension", js: "extension", typ: u(undefined, u(r("Extension"), 3.14)) },
        { json: "extern", js: "extern", typ: u(undefined, u(r("Extern"), 3.14)) },
        { json: "fallthrough", js: "fallthrough", typ: u(undefined, u(r("Fallthrough"), 3.14)) },
        { json: "false", js: "false", typ: u(undefined, u(r("FalseClass"), 3.14)) },
        { json: "False", js: "False", typ: u(undefined, u(r("False"), 3.14)) },
        { json: "fileprivate", js: "fileprivate", typ: u(undefined, u(r("Fileprivate"), 3.14)) },
        { json: "final", js: "final", typ: u(undefined, u(r("Final"), 3.14)) },
        { json: "finally", js: "finally", typ: u(undefined, u(r("Finally"), 3.14)) },
        { json: "fixed", js: "fixed", typ: u(undefined, u(r("Fixed"), 3.14)) },
        { json: "float", js: "float", typ: u(undefined, u(r("Float"), 3.14)) },
        { json: "for", js: "for", typ: u(undefined, u(r("For"), 3.14)) },
        { json: "foreach", js: "foreach", typ: u(undefined, u(r("Foreach"), 3.14)) },
        { json: "FormatException", js: "FormatException", typ: u(undefined, u(r("FormatException"), 3.14)) },
        { json: "friend", js: "friend", typ: u(undefined, u(r("Friend"), 3.14)) },
        { json: "from", js: "from", typ: u(undefined, u(r("From"), 3.14)) },
        { json: "from_dict", js: "from_dict", typ: u(undefined, u(r("FromDict"), 3.14)) },
        { json: "from_json", js: "from_json", typ: u(undefined, u(r("FromJSON"), 3.14)) },
        { json: "func", js: "func", typ: u(undefined, u(r("Func"), 3.14)) },
        { json: "function", js: "function", typ: u(undefined, u(r("Function"), 3.14)) },
        { json: "get", js: "get", typ: u(undefined, u(r("Get"), 3.14)) },
        { json: "global", js: "global", typ: u(undefined, u(r("Global"), 3.14)) },
        { json: "go", js: "go", typ: u(undefined, u(r("Go"), 3.14)) },
        { json: "goto", js: "goto", typ: u(undefined, u(r("Goto"), 3.14)) },
        { json: "guard", js: "guard", typ: u(undefined, u(r("Guard"), 3.14)) },
        { json: "Hashable", js: "Hashable", typ: u(undefined, u(r("Hashable"), 3.14)) },
        { json: "hashCode", js: "hashCode", typ: u(undefined, u(r("HashCode"), 3.14)) },
        { json: "Hasher", js: "Hasher", typ: u(undefined, u(r("Hasher"), 3.14)) },
        { json: "hasOwnProperty", js: "hasOwnProperty", typ: u(undefined, u(r("HasOwnProperty"), 3.14)) },
        { json: "id", js: "id", typ: u(undefined, u(r("ID"), 3.14)) },
        { json: "if", js: "if", typ: u(undefined, u(r("If"), 3.14)) },
        { json: "IMP", js: "IMP", typ: u(undefined, u(r("Imp"), 3.14)) },
        { json: "implements", js: "implements", typ: u(undefined, u(r("Implements"), 3.14)) },
        { json: "implicit", js: "implicit", typ: u(undefined, u(r("Implicit"), 3.14)) },
        { json: "import", js: "import", typ: u(undefined, u(r("Import"), 3.14)) },
        { json: "in", js: "in", typ: u(undefined, u(r("In"), 3.14)) },
        { json: "indirect", js: "indirect", typ: u(undefined, u(r("Indirect"), 3.14)) },
        { json: "infix", js: "infix", typ: u(undefined, u(r("Infix"), 3.14)) },
        { json: "init", js: "init", typ: u(undefined, u(r("Init"), 3.14)) },
        { json: "inline", js: "inline", typ: u(undefined, u(r("Inline"), 3.14)) },
        { json: "inout", js: "inout", typ: u(undefined, u(r("Inout"), 3.14)) },
        { json: "instanceof", js: "instanceof", typ: u(undefined, u(r("Instanceof"), 3.14)) },
        { json: "int", js: "int", typ: u(undefined, u(r("Int"), 3.14)) },
        { json: "interface", js: "interface", typ: u(undefined, u(r("Interface"), 3.14)) },
        { json: "internal", js: "internal", typ: u(undefined, u(r("Internal"), 3.14)) },
        { json: "IntNode", js: "IntNode", typ: u(undefined, u(r("IntNode"), 3.14)) },
        { json: "is", js: "is", typ: u(undefined, u(r("Is"), 3.14)) },
        { json: "IsoDateTimeOffsetConverter", js: "IsoDateTimeOffsetConverter", typ: u(undefined, u(r("ISODateTimeOffsetConverter"), 3.14)) },
        { json: "iterable", js: "iterable", typ: u(undefined, u(r("Iterable"), 3.14)) },
        { json: "jdec", js: "jdec", typ: u(undefined, u(r("Jdec"), 3.14)) },
        { json: "jenc", js: "jenc", typ: u(undefined, u(r("Jenc"), 3.14)) },
        { json: "jpipe", js: "jpipe", typ: u(undefined, u(r("Jpipe"), 3.14)) },
        { json: "json", js: "json", typ: u(undefined, u(r("JSONClass"), 3.14)) },
        { json: "json_converter", js: "json_converter", typ: u(undefined, u(r("JSONConverter"), 3.14)) },
        { json: "json_serializer", js: "json_serializer", typ: u(undefined, u(r("JSONSerializer"), 3.14)) },
        { json: "json_token", js: "json_token", typ: u(undefined, u(r("JSONToken"), 3.14)) },
        { json: "json_writer", js: "json_writer", typ: u(undefined, u(r("JSONWriter"), 3.14)) },
        { json: "JSONAny", js: "JSONAny", typ: u(undefined, u(r("JSONAny"), 3.14)) },
        { json: "JSONCodingKey", js: "JSONCodingKey", typ: u(undefined, u(r("JSONCodingKey"), 3.14)) },
        { json: "JSONDecoder", js: "JSONDecoder", typ: u(undefined, u(r("JSONDecoder"), 3.14)) },
        { json: "JSONEncoder", js: "JSONEncoder", typ: u(undefined, u(r("JSONEncoder"), 3.14)) },
        { json: "JsonException", js: "JsonException", typ: u(undefined, u(r("JSONException"), 3.14)) },
        { json: "JsonGenerator", js: "JsonGenerator", typ: u(undefined, u(r("JSONGenerator"), 3.14)) },
        { json: "JsonNode", js: "JsonNode", typ: u(undefined, u(r("JSONNode"), 3.14)) },
        { json: "JSONNull", js: "JSONNull", typ: u(undefined, u(r("JSONNull"), 3.14)) },
        { json: "JsonParser", js: "JsonParser", typ: u(undefined, u(r("JSONParser"), 3.14)) },
        { json: "JsonReader", js: "JsonReader", typ: u(undefined, u(r("JSONReader"), 3.14)) },
        { json: "JsonTokenType", js: "JsonTokenType", typ: u(undefined, u(r("JSONTokenType"), 3.14)) },
        { json: "KSerializer", js: "KSerializer", typ: u(undefined, u(r("KSerializer"), 3.14)) },
        { json: "lambda", js: "lambda", typ: u(undefined, u(r("Lambda"), 3.14)) },
        { json: "lazy", js: "lazy", typ: u(undefined, u(r("Lazy"), 3.14)) },
        { json: "left", js: "left", typ: u(undefined, u(r("Left"), 3.14)) },
        { json: "let", js: "let", typ: u(undefined, u(r("Let"), 3.14)) },
        { json: "list", js: "list", typ: u(undefined, u(r("List"), 3.14)) },
        { json: "LocalDate", js: "LocalDate", typ: u(undefined, u(r("LocalDate"), 3.14)) },
        { json: "Locale", js: "Locale", typ: u(undefined, u(r("Locale"), 3.14)) },
        { json: "lock", js: "lock", typ: u(undefined, u(r("Lock"), 3.14)) },
        { json: "long", js: "long", typ: u(undefined, u(r("Long"), 3.14)) },
        { json: "LongNode", js: "LongNode", typ: u(undefined, u(r("LongNode"), 3.14)) },
        { json: "map", js: "map", typ: u(undefined, u(r("Map"), 3.14)) },
        { json: "MapEntry", js: "MapEntry", typ: u(undefined, u(r("MapEntry"), 3.14)) },
        { json: "MarshalJSON", js: "MarshalJSON", typ: u(undefined, u(r("MarshalJSON"), 3.14)) },
        { json: "metadata_property_handling", js: "metadata_property_handling", typ: u(undefined, u(r("MetadataPropertyHandling"), 3.14)) },
        { json: "module", js: "module", typ: u(undefined, u(r("Module"), 3.14)) },
        { json: "mutable", js: "mutable", typ: u(undefined, u(r("Mutable"), 3.14)) },
        { json: "mutating", js: "mutating", typ: u(undefined, u(r("Mutating"), 3.14)) },
        { json: "namespace", js: "namespace", typ: u(undefined, u(r("Namespace"), 3.14)) },
        { json: "native", js: "native", typ: u(undefined, u(r("Native"), 3.14)) },
        { json: "new", js: "new", typ: u(undefined, u(r("New"), 3.14)) },
        { json: "newtonsoft", js: "newtonsoft", typ: u(undefined, u(r("Newtonsoft"), 3.14)) },
        { json: "nil", js: "nil", typ: u(undefined, u(r("Nil"), 3.14)) },
        { json: "NO", js: "NO", typ: u(undefined, u(r("No"), 3.14)) },
        { json: "noexcept", js: "noexcept", typ: u(undefined, u(r("Noexcept"), 3.14)) },
        { json: "nonatomic", js: "nonatomic", typ: u(undefined, u(r("Nonatomic"), 3.14)) },
        { json: "none", js: "none", typ: u(undefined, u(r("NoneClass"), 3.14)) },
        { json: "None", js: "None", typ: u(undefined, u(r("None"), 3.14)) },
        { json: "nonlocal", js: "nonlocal", typ: u(undefined, u(r("Nonlocal"), 3.14)) },
        { json: "nonmutating", js: "nonmutating", typ: u(undefined, u(r("Nonmutating"), 3.14)) },
        { json: "noSuchMethod", js: "noSuchMethod", typ: u(undefined, u(r("NoSuchMethod"), 3.14)) },
        { json: "not", js: "not", typ: u(undefined, u(r("Not"), 3.14)) },
        { json: "not_eq", js: "not_eq", typ: u(undefined, u(r("NotEq"), 3.14)) },
        { json: "NSError", js: "NSError", typ: u(undefined, u(r("NSError"), 3.14)) },
        { json: "NSObject", js: "NSObject", typ: u(undefined, u(r("NSObject"), 3.14)) },
        { json: "NSString", js: "NSString", typ: u(undefined, u(r("NSString"), 3.14)) },
        { json: "NULL", js: "NULL", typ: u(undefined, u(r("Null"), 3.14)) },
        { json: "null", js: "null", typ: u(undefined, u(r("NullClass"), 3.14)) },
        { json: "NullNode", js: "NullNode", typ: u(undefined, u(r("NullNode"), 3.14)) },
        { json: "nullptr", js: "nullptr", typ: u(undefined, u(r("Nullptr"), 3.14)) },
        { json: "number", js: "number", typ: u(undefined, u(r("Number"), 3.14)) },
        { json: "object", js: "object", typ: u(undefined, u(r("ObjectClass"), 3.14)) },
        { json: "ObjectMapper", js: "ObjectMapper", typ: u(undefined, u(r("ObjectMapper"), 3.14)) },
        { json: "ObjectNode", js: "ObjectNode", typ: u(undefined, u(r("ObjectNode"), 3.14)) },
        { json: "ObjectReader", js: "ObjectReader", typ: u(undefined, u(r("ObjectReader"), 3.14)) },
        { json: "ObjectWriter", js: "ObjectWriter", typ: u(undefined, u(r("ObjectWriter"), 3.14)) },
        { json: "of", js: "of", typ: u(undefined, u(r("Of"), 3.14)) },
        { json: "OffsetDateTime", js: "OffsetDateTime", typ: u(undefined, u(r("OffsetDateTime"), 3.14)) },
        { json: "OffsetTime", js: "OffsetTime", typ: u(undefined, u(r("OffsetTime"), 3.14)) },
        { json: "oneway", js: "oneway", typ: u(undefined, u(r("Oneway"), 3.14)) },
        { json: "open", js: "open", typ: u(undefined, u(r("Open"), 3.14)) },
        { json: "operator", js: "operator", typ: u(undefined, u(r("Operator"), 3.14)) },
        { json: "optional", js: "optional", typ: u(undefined, u(r("Optional"), 3.14)) },
        { json: "or", js: "or", typ: u(undefined, u(r("Or"), 3.14)) },
        { json: "or_eq", js: "or_eq", typ: u(undefined, u(r("OrEq"), 3.14)) },
        { json: "out", js: "out", typ: u(undefined, u(r("Out"), 3.14)) },
        { json: "override", js: "override", typ: u(undefined, u(r("Override"), 3.14)) },
        { json: "package", js: "package", typ: u(undefined, u(r("Package"), 3.14)) },
        { json: "params", js: "params", typ: u(undefined, u(r("Params"), 3.14)) },
        { json: "pass", js: "pass", typ: u(undefined, u(r("Pass"), 3.14)) },
        { json: "port", js: "port", typ: u(undefined, u(r("Port"), 3.14)) },
        { json: "postfix", js: "postfix", typ: u(undefined, u(r("Postfix"), 3.14)) },
        { json: "precedence", js: "precedence", typ: u(undefined, u(r("Precedence"), 3.14)) },
        { json: "prefix", js: "prefix", typ: u(undefined, u(r("Prefix"), 3.14)) },
        { json: "PrimitiveKind", js: "PrimitiveKind", typ: u(undefined, u(r("PrimitiveKind"), 3.14)) },
        { json: "print", js: "print", typ: u(undefined, u(r("Print"), 3.14)) },
        { json: "printf", js: "printf", typ: u(undefined, u(r("Printf"), 3.14)) },
        { json: "printMembers", js: "printMembers", typ: u(undefined, u(r("PrintMembers"), 3.14)) },
        { json: "private", js: "private", typ: u(undefined, u(r("Private"), 3.14)) },
        { json: "protected", js: "protected", typ: u(undefined, u(r("Protected"), 3.14)) },
        { json: "Protocol", js: "Protocol", typ: u(undefined, u(r("Protocol"), 3.14)) },
        { json: "protocol", js: "protocol", typ: u(undefined, u(r("ProtocolClass"), 3.14)) },
        { json: "public", js: "public", typ: u(undefined, u(r("Public"), 3.14)) },
        { json: "quicktype", js: "quicktype", typ: u(undefined, u(r("Quicktype"), 3.14)) },
        { json: "raise", js: "raise", typ: u(undefined, u(r("Raise"), 3.14)) },
        { json: "range", js: "range", typ: u(undefined, u(r("Range"), 3.14)) },
        { json: "readonly", js: "readonly", typ: u(undefined, u(r("Readonly"), 3.14)) },
        { json: "ref", js: "ref", typ: u(undefined, u(r("Ref"), 3.14)) },
        { json: "RegExp", js: "RegExp", typ: u(undefined, u(r("RegExpClass"), 3.14)) },
        { json: "register", js: "register", typ: u(undefined, u(r("Register"), 3.14)) },
        { json: "reinterpret_cast", js: "reinterpret_cast", typ: u(undefined, u(r("ReinterpretCast"), 3.14)) },
        { json: "repeat", js: "repeat", typ: u(undefined, u(r("Repeat"), 3.14)) },
        { json: "require", js: "require", typ: u(undefined, u(r("Require"), 3.14)) },
        { json: "required", js: "required", typ: u(undefined, u(r("Required"), 3.14)) },
        { json: "requires", js: "requires", typ: u(undefined, u(r("Requires"), 3.14)) },
        { json: "restrict", js: "restrict", typ: u(undefined, u(r("Restrict"), 3.14)) },
        { json: "retain", js: "retain", typ: u(undefined, u(r("Retain"), 3.14)) },
        { json: "rethrows", js: "rethrows", typ: u(undefined, u(r("Rethrows"), 3.14)) },
        { json: "return", js: "return", typ: u(undefined, u(r("Return"), 3.14)) },
        { json: "right", js: "right", typ: u(undefined, u(r("Right"), 3.14)) },
        { json: "runtimeType", js: "runtimeType", typ: u(undefined, u(r("RuntimeType"), 3.14)) },
        { json: "s", js: "s", typ: u(undefined, u(r("S"), 3.14)) },
        { json: "sbyte", js: "sbyte", typ: u(undefined, u(r("Sbyte"), 3.14)) },
        { json: "sealed", js: "sealed", typ: u(undefined, u(r("Sealed"), 3.14)) },
        { json: "SEL", js: "SEL", typ: u(undefined, u(r("Sel"), 3.14)) },
        { json: "select", js: "select", typ: u(undefined, u(r("Select"), 3.14)) },
        { json: "Self", js: "Self", typ: u(undefined, u(r("Self"), 3.14)) },
        { json: "self", js: "self", typ: u(undefined, u(r("SelfClass"), 3.14)) },
        { json: "Sendable", js: "Sendable", typ: u(undefined, u(r("Sendable"), 3.14)) },
        { json: "SerialDescriptor", js: "SerialDescriptor", typ: u(undefined, u(r("SerialDescriptor"), 3.14)) },
        { json: "Serializable", js: "Serializable", typ: u(undefined, u(r("Serializable"), 3.14)) },
        { json: "SerializationFeature", js: "SerializationFeature", typ: u(undefined, u(r("SerializationFeature"), 3.14)) },
        { json: "serialize", js: "serialize", typ: u(undefined, u(r("Serialize"), 3.14)) },
        { json: "SerializerProvider", js: "SerializerProvider", typ: u(undefined, u(r("SerializerProvider"), 3.14)) },
        { json: "SerialName", js: "SerialName", typ: u(undefined, u(r("SerialName"), 3.14)) },
        { json: "set", js: "set", typ: u(undefined, u(r("Set"), 3.14)) },
        { json: "short", js: "short", typ: u(undefined, u(r("Short"), 3.14)) },
        { json: "signed", js: "signed", typ: u(undefined, u(r("Signed"), 3.14)) },
        { json: "SimpleModule", js: "SimpleModule", typ: u(undefined, u(r("SimpleModule"), 3.14)) },
        { json: "sizeof", js: "sizeof", typ: u(undefined, u(r("Sizeof"), 3.14)) },
        { json: "stackalloc", js: "stackalloc", typ: u(undefined, u(r("Stackalloc"), 3.14)) },
        { json: "Standards", js: "Standards", typ: u(undefined, u(r("Standards"), 3.14)) },
        { json: "static", js: "static", typ: u(undefined, u(r("Static"), 3.14)) },
        { json: "static_assert", js: "static_assert", typ: u(undefined, u(r("StaticAssert"), 3.14)) },
        { json: "static_cast", js: "static_cast", typ: u(undefined, u(r("StaticCast"), 3.14)) },
        { json: "StdDeserializer", js: "StdDeserializer", typ: u(undefined, u(r("StdDeserializer"), 3.14)) },
        { json: "StdSerializer", js: "StdSerializer", typ: u(undefined, u(r("StdSerializer"), 3.14)) },
        { json: "strictfp", js: "strictfp", typ: u(undefined, u(r("Strictfp"), 3.14)) },
        { json: "string", js: "string", typ: u(undefined, u(r("StringClass"), 3.14)) },
        { json: "struct", js: "struct", typ: u(undefined, u(r("Struct"), 3.14)) },
        { json: "subscript", js: "subscript", typ: u(undefined, u(r("Subscript"), 3.14)) },
        { json: "super", js: "super", typ: u(undefined, u(r("Super"), 3.14)) },
        { json: "switch", js: "switch", typ: u(undefined, u(r("Switch"), 3.14)) },
        { json: "symbol", js: "symbol", typ: u(undefined, u(r("Symbol"), 3.14)) },
        { json: "synchronized", js: "synchronized", typ: u(undefined, u(r("Synchronized"), 3.14)) },
        { json: "system", js: "system", typ: u(undefined, u(r("System"), 3.14)) },
        { json: "template", js: "template", typ: u(undefined, u(r("Template"), 3.14)) },
        { json: "TextNode", js: "TextNode", typ: u(undefined, u(r("TextNode"), 3.14)) },
        { json: "then", js: "then", typ: u(undefined, u(r("Then"), 3.14)) },
        { json: "this", js: "this", typ: u(undefined, u(r("This"), 3.14)) },
        { json: "thread_local", js: "thread_local", typ: u(undefined, u(r("ThreadLocal"), 3.14)) },
        { json: "throw", js: "throw", typ: u(undefined, u(r("Throw"), 3.14)) },
        { json: "throws", js: "throws", typ: u(undefined, u(r("Throws"), 3.14)) },
        { json: "TimeOnly", js: "TimeOnly", typ: u(undefined, u(r("TimeOnly"), 3.14)) },
        { json: "TimeOnlyConverter", js: "TimeOnlyConverter", typ: u(undefined, u(r("TimeOnlyConverter"), 3.14)) },
        { json: "TimeZone", js: "TimeZone", typ: u(undefined, u(r("TimeZone"), 3.14)) },
        { json: "to_dict", js: "to_dict", typ: u(undefined, u(r("ToDict"), 3.14)) },
        { json: "to_json", js: "to_json", typ: u(undefined, u(r("ToJSON"), 3.14)) },
        { json: "top_level", js: "top_level", typ: u(undefined, u(r("TopLevelClass"), 3.14)) },
        { json: "toString", js: "toString", typ: u(undefined, u(r("ToString"), 3.14)) },
        { json: "transient", js: "transient", typ: u(undefined, u(r("Transient"), 3.14)) },
        { json: "True", js: "True", typ: u(undefined, u(r("True"), 3.14)) },
        { json: "true", js: "true", typ: u(undefined, u(r("TrueClass"), 3.14)) },
        { json: "try", js: "try", typ: u(undefined, u(r("Try"), 3.14)) },
        { json: "Type", js: "Type", typ: u(undefined, u(r("Type"), 3.14)) },
        { json: "type", js: "type", typ: u(undefined, u(r("TypeClass"), 3.14)) },
        { json: "typealias", js: "typealias", typ: u(undefined, u(r("Typealias"), 3.14)) },
        { json: "typedef", js: "typedef", typ: u(undefined, u(r("Typedef"), 3.14)) },
        { json: "typeid", js: "typeid", typ: u(undefined, u(r("Typeid"), 3.14)) },
        { json: "typename", js: "typename", typ: u(undefined, u(r("Typename"), 3.14)) },
        { json: "typeof", js: "typeof", typ: u(undefined, u(r("Typeof"), 3.14)) },
        { json: "uint", js: "uint", typ: u(undefined, u(r("Uint"), 3.14)) },
        { json: "ulong", js: "ulong", typ: u(undefined, u(r("Ulong"), 3.14)) },
        { json: "unchecked", js: "unchecked", typ: u(undefined, u(r("Unchecked"), 3.14)) },
        { json: "undefined", js: "undefined", typ: u(undefined, u(r("Undefined"), 3.14)) },
        { json: "union", js: "union", typ: u(undefined, u(r("Union"), 3.14)) },
        { json: "UnmarshalJSON", js: "UnmarshalJSON", typ: u(undefined, u(r("UnmarshalJSON"), 3.14)) },
        { json: "unowned", js: "unowned", typ: u(undefined, u(r("Unowned"), 3.14)) },
        { json: "unsafe", js: "unsafe", typ: u(undefined, u(r("Unsafe"), 3.14)) },
        { json: "unsigned", js: "unsigned", typ: u(undefined, u(r("Unsigned"), 3.14)) },
        { json: "UseSerializers", js: "UseSerializers", typ: u(undefined, u(r("UseSerializers"), 3.14)) },
        { json: "ushort", js: "ushort", typ: u(undefined, u(r("Ushort"), 3.14)) },
        { json: "using", js: "using", typ: u(undefined, u(r("Using"), 3.14)) },
        { json: "Utf8JsonReader", js: "Utf8JsonReader", typ: u(undefined, u(r("Utf8JSONReader"), 3.14)) },
        { json: "Utf8JsonWriter", js: "Utf8JsonWriter", typ: u(undefined, u(r("Utf8JSONWriter"), 3.14)) },
        { json: "UUID", js: "UUID", typ: u(undefined, u(r("UUID"), 3.14)) },
        { json: "var", js: "var", typ: u(undefined, u(r("Var"), 3.14)) },
        { json: "virtual", js: "virtual", typ: u(undefined, u(r("Virtual"), 3.14)) },
        { json: "void", js: "void", typ: u(undefined, u(r("Void"), 3.14)) },
        { json: "volatile", js: "volatile", typ: u(undefined, u(r("Volatile"), 3.14)) },
        { json: "wchar_t", js: "wchar_t", typ: u(undefined, u(r("WcharT"), 3.14)) },
        { json: "weak", js: "weak", typ: u(undefined, u(r("Weak"), 3.14)) },
        { json: "where", js: "where", typ: u(undefined, u(r("Where"), 3.14)) },
        { json: "while", js: "while", typ: u(undefined, u(r("While"), 3.14)) },
        { json: "willSet", js: "willSet", typ: u(undefined, u(r("WillSet"), 3.14)) },
        { json: "with", js: "with", typ: u(undefined, u(r("With"), 3.14)) },
        { json: "xor", js: "xor", typ: u(undefined, u(r("Xor"), 3.14)) },
        { json: "xor_eq", js: "xor_eq", typ: u(undefined, u(r("XorEq"), 3.14)) },
        { json: "YES", js: "YES", typ: u(undefined, u(r("Yes"), 3.14)) },
        { json: "yield", js: "yield", typ: u(undefined, u(r("Yield"), 3.14)) },
    ], "any"),
    "Any": o([
    ], false),
    "ArrayNode": o([
    ], false),
    "Bool": o([
    ], false),
    "BooleanNode": o([
    ], false),
    "Calendar": o([
    ], false),
    "ClassClass": o([
    ], false),
    "Codable": o([
    ], false),
    "CodingKey": o([
    ], false),
    "CodingKeys": o([
    ], false),
    "CultureInfo": o([
    ], false),
    "DateFormatter": o([
    ], false),
    "DateOnly": o([
    ], false),
    "DateOnlyConverter": o([
    ], false),
    "DateTime": o([
    ], false),
    "DateTimeStyles": o([
    ], false),
    "Decoder": o([
    ], false),
    "DecodingError": o([
    ], false),
    "DeserializationFeature": o([
    ], false),
    "DoubleNode": o([
    ], false),
    "Encoder": o([
    ], false),
    "EnumValues": o([
    ], false),
    "Equatable": o([
    ], false),
    "False": o([
    ], false),
    "FormatException": o([
    ], false),
    "Hashable": o([
    ], false),
    "Hasher": o([
    ], false),
    "Imp": o([
    ], false),
    "IntNode": o([
    ], false),
    "ISODateTimeOffsetConverter": o([
    ], false),
    "JSONAny": o([
    ], false),
    "JSONCodingKey": o([
    ], false),
    "JSONDecoder": o([
    ], false),
    "JSONEncoder": o([
    ], false),
    "JSONNull": o([
    ], false),
    "JSONException": o([
    ], false),
    "JSONGenerator": o([
    ], false),
    "JSONNode": o([
    ], false),
    "JSONParser": o([
    ], false),
    "JSONReader": o([
    ], false),
    "JSONTokenType": o([
    ], false),
    "KSerializer": o([
    ], false),
    "LocalDate": o([
    ], false),
    "Locale": o([
    ], false),
    "LongNode": o([
    ], false),
    "MapEntry": o([
    ], false),
    "MarshalJSON": o([
    ], false),
    "No": o([
    ], false),
    "NSError": o([
    ], false),
    "NSObject": o([
    ], false),
    "NSString": o([
    ], false),
    "Null": o([
    ], false),
    "None": o([
    ], false),
    "NullNode": o([
    ], false),
    "ObjectMapper": o([
    ], false),
    "ObjectNode": o([
    ], false),
    "ObjectReader": o([
    ], false),
    "ObjectWriter": o([
    ], false),
    "OffsetDateTime": o([
    ], false),
    "OffsetTime": o([
    ], false),
    "PrimitiveKind": o([
    ], false),
    "Protocol": o([
    ], false),
    "RegExpClass": o([
    ], false),
    "Sel": o([
    ], false),
    "Self": o([
    ], false),
    "Sendable": o([
    ], false),
    "SerialDescriptor": o([
    ], false),
    "SerialName": o([
    ], false),
    "Serializable": o([
    ], false),
    "SerializationFeature": o([
    ], false),
    "SerializerProvider": o([
    ], false),
    "SimpleModule": o([
    ], false),
    "Standards": o([
    ], false),
    "StdDeserializer": o([
    ], false),
    "StdSerializer": o([
    ], false),
    "TextNode": o([
    ], false),
    "TimeOnly": o([
    ], false),
    "TimeOnlyConverter": o([
    ], false),
    "TimeZone": o([
    ], false),
    "True": o([
    ], false),
    "Type": o([
    ], false),
    "UUID": o([
    ], false),
    "UnmarshalJSON": o([
    ], false),
    "UseSerializers": o([
    ], false),
    "Utf8JSONReader": o([
    ], false),
    "Utf8JSONWriter": o([
    ], false),
    "Yes": o([
    ], false),
    "Empty": o([
    ], false),
    "BoolClass": o([
    ], false),
    "Complex": o([
    ], false),
    "Imaginery": o([
    ], false),
    "Abstract": o([
    ], false),
    "Alignas": o([
    ], false),
    "Alignof": o([
    ], false),
    "And": o([
    ], false),
    "AndEq": o([
    ], false),
    "AnyClass": o([
    ], false),
    "ArrayClass": o([
    ], false),
    "As": o([
    ], false),
    "ASM": o([
    ], false),
    "Assert": o([
    ], false),
    "Associatedtype": o([
    ], false),
    "Associativity": o([
    ], false),
    "Async": o([
    ], false),
    "Atomic": o([
    ], false),
    "AtomicCancel": o([
    ], false),
    "AtomicCommit": o([
    ], false),
    "AtomicNoexcept": o([
    ], false),
    "Auto": o([
    ], false),
    "Await": o([
    ], false),
    "Base": o([
    ], false),
    "Bitand": o([
    ], false),
    "Bitor": o([
    ], false),
    "UnionBoolBool": o([
    ], false),
    "Boolean": o([
    ], false),
    "Break": o([
    ], false),
    "Bycopy": o([
    ], false),
    "Byref": o([
    ], false),
    "Byte": o([
    ], false),
    "Case": o([
    ], false),
    "Catch": o([
    ], false),
    "Chan": o([
    ], false),
    "Char": o([
    ], false),
    "Char16T": o([
    ], false),
    "Char32T": o([
    ], false),
    "Checked": o([
    ], false),
    "UnionClassClass": o([
    ], false),
    "Clone": o([
    ], false),
    "CoAwait": o([
    ], false),
    "CoReturn": o([
    ], false),
    "CoYield": o([
    ], false),
    "Compl": o([
    ], false),
    "Concept": o([
    ], false),
    "Console": o([
    ], false),
    "Const": o([
    ], false),
    "ConstCast": o([
    ], false),
    "Constexpr": o([
    ], false),
    "Constructor": o([
    ], false),
    "Continue": o([
    ], false),
    "Convenience": o([
    ], false),
    "Convert": o([
    ], false),
    "Converter": o([
    ], false),
    "DateClass": o([
    ], false),
    "DateParseHandling": o([
    ], false),
    "Debugger": o([
    ], false),
    "Decimal": o([
    ], false),
    "Declare": o([
    ], false),
    "Decltype": o([
    ], false),
    "DecodeString": o([
    ], false),
    "Def": o([
    ], false),
    "Default": o([
    ], false),
    "Defer": o([
    ], false),
    "Deinit": o([
    ], false),
    "Del": o([
    ], false),
    "Delegate": o([
    ], false),
    "Delete": o([
    ], false),
    "Dict": o([
    ], false),
    "Dictionary": o([
    ], false),
    "DidSet": o([
    ], false),
    "Do": o([
    ], false),
    "Double": o([
    ], false),
    "Dynamic": o([
    ], false),
    "DynamicCast": o([
    ], false),
    "Elif": o([
    ], false),
    "Else": o([
    ], false),
    "EncodeQuickType": o([
    ], false),
    "Enum": o([
    ], false),
    "EqualityContract": o([
    ], false),
    "Event": o([
    ], false),
    "Except": o([
    ], false),
    "Exception": o([
    ], false),
    "Explicit": o([
    ], false),
    "Export": o([
    ], false),
    "Exposing": o([
    ], false),
    "Extends": o([
    ], false),
    "Extension": o([
    ], false),
    "Extern": o([
    ], false),
    "Fallthrough": o([
    ], false),
    "FalseClass": o([
    ], false),
    "Fileprivate": o([
    ], false),
    "Final": o([
    ], false),
    "Finally": o([
    ], false),
    "Fixed": o([
    ], false),
    "Float": o([
    ], false),
    "For": o([
    ], false),
    "Foreach": o([
    ], false),
    "Friend": o([
    ], false),
    "From": o([
    ], false),
    "FromDict": o([
    ], false),
    "FromJSON": o([
    ], false),
    "Func": o([
    ], false),
    "Function": o([
    ], false),
    "Get": o([
    ], false),
    "Global": o([
    ], false),
    "Go": o([
    ], false),
    "Goto": o([
    ], false),
    "Guard": o([
    ], false),
    "HasOwnProperty": o([
    ], false),
    "HashCode": o([
    ], false),
    "ID": o([
    ], false),
    "If": o([
    ], false),
    "Implements": o([
    ], false),
    "Implicit": o([
    ], false),
    "Import": o([
    ], false),
    "In": o([
    ], false),
    "Indirect": o([
    ], false),
    "Infix": o([
    ], false),
    "Init": o([
    ], false),
    "Inline": o([
    ], false),
    "Inout": o([
    ], false),
    "Instanceof": o([
    ], false),
    "Int": o([
    ], false),
    "Interface": o([
    ], false),
    "Internal": o([
    ], false),
    "Is": o([
    ], false),
    "Iterable": o([
    ], false),
    "Jdec": o([
    ], false),
    "Jenc": o([
    ], false),
    "Jpipe": o([
    ], false),
    "JSONClass": o([
    ], false),
    "JSONConverter": o([
    ], false),
    "JSONSerializer": o([
    ], false),
    "JSONToken": o([
    ], false),
    "JSONWriter": o([
    ], false),
    "Lambda": o([
    ], false),
    "Lazy": o([
    ], false),
    "Left": o([
    ], false),
    "Let": o([
    ], false),
    "List": o([
    ], false),
    "Lock": o([
    ], false),
    "Long": o([
    ], false),
    "Map": o([
    ], false),
    "MetadataPropertyHandling": o([
    ], false),
    "Module": o([
    ], false),
    "Mutable": o([
    ], false),
    "Mutating": o([
    ], false),
    "Namespace": o([
    ], false),
    "Native": o([
    ], false),
    "New": o([
    ], false),
    "Newtonsoft": o([
    ], false),
    "Nil": o([
    ], false),
    "NoSuchMethod": o([
    ], false),
    "Noexcept": o([
    ], false),
    "Nonatomic": o([
    ], false),
    "NoneClass": o([
    ], false),
    "Nonlocal": o([
    ], false),
    "Nonmutating": o([
    ], false),
    "Not": o([
    ], false),
    "NotEq": o([
    ], false),
    "NullClass": o([
    ], false),
    "Nullptr": o([
    ], false),
    "Number": o([
    ], false),
    "ObjectClass": o([
    ], false),
    "Of": o([
    ], false),
    "Oneway": o([
    ], false),
    "Open": o([
    ], false),
    "Operator": o([
    ], false),
    "Optional": o([
    ], false),
    "Or": o([
    ], false),
    "OrEq": o([
    ], false),
    "Out": o([
    ], false),
    "Override": o([
    ], false),
    "Package": o([
    ], false),
    "Params": o([
    ], false),
    "Pass": o([
    ], false),
    "Port": o([
    ], false),
    "Postfix": o([
    ], false),
    "Precedence": o([
    ], false),
    "Prefix": o([
    ], false),
    "Print": o([
    ], false),
    "PrintMembers": o([
    ], false),
    "Printf": o([
    ], false),
    "Private": o([
    ], false),
    "Protected": o([
    ], false),
    "ProtocolClass": o([
    ], false),
    "Public": o([
    ], false),
    "Quicktype": o([
    ], false),
    "Raise": o([
    ], false),
    "Range": o([
    ], false),
    "Readonly": o([
    ], false),
    "Ref": o([
    ], false),
    "Register": o([
    ], false),
    "ReinterpretCast": o([
    ], false),
    "Repeat": o([
    ], false),
    "Require": o([
    ], false),
    "Required": o([
    ], false),
    "Requires": o([
    ], false),
    "Restrict": o([
    ], false),
    "Retain": o([
    ], false),
    "Rethrows": o([
    ], false),
    "Return": o([
    ], false),
    "Right": o([
    ], false),
    "RuntimeType": o([
    ], false),
    "S": o([
    ], false),
    "Sbyte": o([
    ], false),
    "Sealed": o([
    ], false),
    "Select": o([
    ], false),
    "SelfClass": o([
    ], false),
    "Serialize": o([
    ], false),
    "Set": o([
    ], false),
    "Short": o([
    ], false),
    "Signed": o([
    ], false),
    "Sizeof": o([
    ], false),
    "Stackalloc": o([
    ], false),
    "Static": o([
    ], false),
    "StaticAssert": o([
    ], false),
    "StaticCast": o([
    ], false),
    "Strictfp": o([
    ], false),
    "StringClass": o([
    ], false),
    "Struct": o([
    ], false),
    "Subscript": o([
    ], false),
    "Super": o([
    ], false),
    "Switch": o([
    ], false),
    "Symbol": o([
    ], false),
    "Synchronized": o([
    ], false),
    "System": o([
    ], false),
    "Template": o([
    ], false),
    "Then": o([
    ], false),
    "This": o([
    ], false),
    "ThreadLocal": o([
    ], false),
    "Throw": o([
    ], false),
    "Throws": o([
    ], false),
    "ToString": o([
    ], false),
    "ToDict": o([
    ], false),
    "ToJSON": o([
    ], false),
    "TopLevelClass": o([
    ], false),
    "Transient": o([
    ], false),
    "TrueClass": o([
    ], false),
    "Try": o([
    ], false),
    "TypeClass": o([
    ], false),
    "Typealias": o([
    ], false),
    "Typedef": o([
    ], false),
    "Typeid": o([
    ], false),
    "Typename": o([
    ], false),
    "Typeof": o([
    ], false),
    "Uint": o([
    ], false),
    "Ulong": o([
    ], false),
    "Unchecked": o([
    ], false),
    "Undefined": o([
    ], false),
    "Union": o([
    ], false),
    "Unowned": o([
    ], false),
    "Unsafe": o([
    ], false),
    "Unsigned": o([
    ], false),
    "Ushort": o([
    ], false),
    "Using": o([
    ], false),
    "Var": o([
    ], false),
    "Virtual": o([
    ], false),
    "Void": o([
    ], false),
    "Volatile": o([
    ], false),
    "WcharT": o([
    ], false),
    "Weak": o([
    ], false),
    "Where": o([
    ], false),
    "While": o([
    ], false),
    "WillSet": o([
    ], false),
    "With": o([
    ], false),
    "Xor": o([
    ], false),
    "XorEq": o([
    ], false),
    "Yield": o([
    ], false),
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
