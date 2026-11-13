// To parse this data:
//
//   import { Convert, TopLevel } from "./TopLevel";
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export interface TopLevel {
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
    [property: string]: unknown;
}

export type UnionAny = object | number;

export type UnionArrayNode = object | number;

export type UnionBOOL = object | number;

export type UnionBooleanNode = object | number;

export type UnionCalendar = object | number;

export type UnionClass = object | number;

export type UnionCodable = object | number;

export type UnionCodingKey = object | number;

export type UnionCodingKeys = object | number;

export type UnionCultureInfo = object | number;

export type UnionDateFormatter = object | number;

export type UnionDateOnly = object | number;

export type UnionDateOnlyConverter = object | number;

export type UnionDateTime = object | number;

export type UnionDateTimeStyles = object | number;

export type UnionDecoder = object | number;

export type UnionDecodingError = object | number;

export type UnionDeserializationFeature = object | number;

export type UnionDoubleNode = object | number;

export type UnionEncoder = object | number;

export type UnionEnumValues = object | number;

export type UnionEquatable = object | number;

export type UnionFalse = object | number;

export type UnionFormatException = object | number;

export type UnionHashable = object | number;

export type UnionHasher = object | number;

export type UnionIMP = object | number;

export type UnionIntNode = object | number;

export type UnionISODateTimeOffsetConverter = object | number;

export type UnionJSONAny = object | number;

export type UnionJSONCodingKey = object | number;

export type UnionJSONDecoder = object | number;

export type UnionJSONEncoder = object | number;

export type UnionJSONNull = object | number;

export type UnionJSONException = object | number;

export type UnionJSONGenerator = object | number;

export type UnionJSONNode = object | number;

export type UnionJSONParser = object | number;

export type UnionJSONReader = object | number;

export type UnionJSONTokenType = object | number;

export type UnionKSerializer = object | number;

export type UnionLocalDate = object | number;

export type UnionLocale = object | number;

export type UnionLongNode = object | number;

export type UnionMapEntry = object | number;

export type UnionMarshalJSON = object | number;

export type UnionNO = object | number;

export type UnionNSError = object | number;

export type UnionNSObject = object | number;

export type UnionNSString = object | number;

export type UnionNULL = object | number;

export type UnionNone = object | number;

export type UnionNullNode = object | number;

export type UnionObjectMapper = object | number;

export type UnionObjectNode = object | number;

export type UnionObjectReader = object | number;

export type UnionObjectWriter = object | number;

export type UnionOffsetDateTime = object | number;

export type UnionOffsetTime = object | number;

export type UnionPrimitiveKind = object | number;

export type UnionProtocol = object | number;

export type UnionRegExp = object | number;

export type UnionSEL = object | number;

export type UnionSelf = object | number;

export type UnionSendable = object | number;

export type UnionSerialDescriptor = object | number;

export type UnionSerialName = object | number;

export type UnionSerializable = object | number;

export type UnionSerializationFeature = object | number;

export type UnionSerializerProvider = object | number;

export type UnionSimpleModule = object | number;

export type UnionStandards = object | number;

export type UnionStdDeserializer = object | number;

export type UnionStdSerializer = object | number;

export type UnionTextNode = object | number;

export type UnionTimeOnly = object | number;

export type UnionTimeOnlyConverter = object | number;

export type UnionTimeZone = object | number;

export type UnionTrue = object | number;

export type UnionType = object | number;

export type UnionUUID = object | number;

export type UnionUnmarshalJSON = object | number;

export type UnionUseSerializers = object | number;

export type UnionUtf8JSONReader = object | number;

export type UnionUtf8JSONWriter = object | number;

export type UnionYES = object | number;

export type UnionUnion = object | number;

export type UnionBool = object | number;

export type UnionComplex = object | number;

export type UnionImaginery = object | number;

export type UnionAbstract = object | number;

export type UnionAlignas = object | number;

export type UnionAlignof = object | number;

export type UnionAnd = object | number;

export type UnionAndEq = object | number;

export type UnionAnyUnion = object | number;

export type UnionArray = object | number;

export type UnionAs = object | number;

export type UnionASM = object | number;

export type UnionAssert = object | number;

export type UnionAssociatedtype = object | number;

export type UnionAssociativity = object | number;

export type UnionAsync = object | number;

export type UnionAtomic = object | number;

export type UnionAtomicCancel = object | number;

export type UnionAtomicCommit = object | number;

export type UnionAtomicNoexcept = object | number;

export type UnionAuto = object | number;

export type UnionAwait = object | number;

export type UnionBase = object | number;

export type UnionBitand = object | number;

export type UnionBitor = object | number;

export type UnionBoolUnion = object | number;

export type UnionBoolean = object | number;

export type UnionBreak = object | number;

export type UnionBycopy = object | number;

export type UnionByref = object | number;

export type UnionByte = object | number;

export type UnionCase = object | number;

export type UnionCatch = object | number;

export type UnionChan = object | number;

export type UnionChar = object | number;

export type UnionChar16T = object | number;

export type UnionChar32T = object | number;

export type UnionChecked = object | number;

export type UnionClassUnion = object | number;

export type UnionClone = object | number;

export type UnionCoAwait = object | number;

export type UnionCoReturn = object | number;

export type UnionCoYield = object | number;

export type UnionCompl = object | number;

export type UnionConcept = object | number;

export type UnionConsole = object | number;

export type UnionConst = object | number;

export type UnionConstCast = object | number;

export type UnionConstexpr = object | number;

export type UnionConstructor = object | number;

export type UnionContinue = object | number;

export type UnionConvenience = object | number;

export type UnionConvert = object | number;

export type UnionConverter = object | number;

export type UnionDate = object | number;

export type UnionDateParseHandling = object | number;

export type UnionDebugger = object | number;

export type UnionDecimal = object | number;

export type UnionDeclare = object | number;

export type UnionDecltype = object | number;

export type UnionDecodeString = object | number;

export type UnionDef = object | number;

export type UnionDefault = object | number;

export type UnionDefer = object | number;

export type UnionDeinit = object | number;

export type UnionDel = object | number;

export type UnionDelegate = object | number;

export type UnionDelete = object | number;

export type UnionDict = object | number;

export type UnionDictionary = object | number;

export type UnionDidSet = object | number;

export type UnionDo = object | number;

export type UnionDouble = object | number;

export type UnionDynamic = object | number;

export type UnionDynamicCast = object | number;

export type UnionElif = object | number;

export type UnionElse = object | number;

export type UnionEncodeQuickType = object | number;

export type UnionEnum = object | number;

export type UnionEqualityContract = object | number;

export type UnionEvent = object | number;

export type UnionExcept = object | number;

export type UnionException = object | number;

export type UnionExplicit = object | number;

export type UnionExport = object | number;

export type UnionExposing = object | number;

export type UnionExtends = object | number;

export type UnionExtension = object | number;

export type UnionExtern = object | number;

export type UnionFallthrough = object | number;

export type UnionFalseUnion = object | number;

export type UnionFileprivate = object | number;

export type UnionFinal = object | number;

export type UnionFinally = object | number;

export type UnionFixed = object | number;

export type UnionFloat = object | number;

export type UnionFor = object | number;

export type UnionForeach = object | number;

export type UnionFriend = object | number;

export type UnionFrom = object | number;

export type UnionFromDict = object | number;

export type UnionFromJSON = object | number;

export type UnionFunc = object | number;

export type UnionFunction = object | number;

export type UnionGet = object | number;

export type UnionGlobal = object | number;

export type UnionGo = object | number;

export type UnionGoto = object | number;

export type UnionGuard = object | number;

export type UnionHasOwnProperty = object | number;

export type UnionHashCode = object | number;

export type UnionID = object | number;

export type UnionIf = object | number;

export type UnionImplements = object | number;

export type UnionImplicit = object | number;

export type UnionImport = object | number;

export type UnionIn = object | number;

export type UnionIndirect = object | number;

export type UnionInfix = object | number;

export type UnionInit = object | number;

export type UnionInline = object | number;

export type UnionInout = object | number;

export type UnionInstanceof = object | number;

export type UnionInt = object | number;

export type UnionInterface = object | number;

export type UnionInternal = object | number;

export type UnionIs = object | number;

export type UnionIterable = object | number;

export type UnionJdec = object | number;

export type UnionJenc = object | number;

export type UnionJpipe = object | number;

export type UnionJSON = object | number;

export type UnionJSONConverter = object | number;

export type UnionJSONSerializer = object | number;

export type UnionJSONToken = object | number;

export type UnionJSONWriter = object | number;

export type UnionLambda = object | number;

export type UnionLazy = object | number;

export type UnionLeft = object | number;

export type UnionLet = object | number;

export type UnionList = object | number;

export type UnionLock = object | number;

export type UnionLong = object | number;

export type UnionMap = object | number;

export type UnionMetadataPropertyHandling = object | number;

export type UnionModule = object | number;

export type UnionMutable = object | number;

export type UnionMutating = object | number;

export type UnionNamespace = object | number;

export type UnionNative = object | number;

export type UnionNew = object | number;

export type UnionNewtonsoft = object | number;

export type UnionNil = object | number;

export type UnionNoSuchMethod = object | number;

export type UnionNoexcept = object | number;

export type UnionNonatomic = object | number;

export type UnionNoneUnion = object | number;

export type UnionNonlocal = object | number;

export type UnionNonmutating = object | number;

export type UnionNot = object | number;

export type UnionNotEq = object | number;

export type UnionNull = object | number;

export type UnionNullptr = object | number;

export type UnionNumber = object | number;

export type UnionObject = object | number;

export type UnionOf = object | number;

export type UnionOneway = object | number;

export type UnionOpen = object | number;

export type UnionOperator = object | number;

export type UnionOptional = object | number;

export type UnionOr = object | number;

export type UnionOrEq = object | number;

export type UnionOut = object | number;

export type UnionOverride = object | number;

export type UnionPackage = object | number;

export type UnionParams = object | number;

export type UnionPass = object | number;

export type UnionPort = object | number;

export type UnionPostfix = object | number;

export type UnionPrecedence = object | number;

export type UnionPrefix = object | number;

export type UnionPrint = object | number;

export type UnionPrintMembers = object | number;

export type UnionPrintf = object | number;

export type UnionPrivate = object | number;

export type UnionProtected = object | number;

export type UnionProtocolUnion = object | number;

export type UnionPublic = object | number;

export type UnionQuicktype = object | number;

export type UnionRaise = object | number;

export type UnionRange = object | number;

export type UnionReadonly = object | number;

export type UnionRef = object | number;

export type UnionRegister = object | number;

export type UnionReinterpretCast = object | number;

export type UnionRepeat = object | number;

export type UnionRequire = object | number;

export type UnionRequired = object | number;

export type UnionRequires = object | number;

export type UnionRestrict = object | number;

export type UnionRetain = object | number;

export type UnionRethrows = object | number;

export type UnionReturn = object | number;

export type UnionRight = object | number;

export type UnionRuntimeType = object | number;

export type UnionS = object | number;

export type UnionSbyte = object | number;

export type UnionSealed = object | number;

export type UnionSelect = object | number;

export type UnionSelfUnion = object | number;

export type UnionSerialize = object | number;

export type UnionSet = object | number;

export type UnionShort = object | number;

export type UnionSigned = object | number;

export type UnionSizeof = object | number;

export type UnionStackalloc = object | number;

export type UnionStatic = object | number;

export type UnionStaticAssert = object | number;

export type UnionStaticCast = object | number;

export type UnionStrictfp = object | number;

export type UnionString = object | number;

export type UnionStruct = object | number;

export type UnionSubscript = object | number;

export type UnionSuper = object | number;

export type UnionSwitch = object | number;

export type UnionSymbol = object | number;

export type UnionSynchronized = object | number;

export type UnionSystem = object | number;

export type UnionTemplate = object | number;

export type UnionThen = object | number;

export type UnionThis = object | number;

export type UnionThreadLocal = object | number;

export type UnionThrow = object | number;

export type UnionThrows = object | number;

export type UnionToString = object | number;

export type UnionToDict = object | number;

export type UnionToJSON = object | number;

export type UnionTopLevel = object | number;

export type UnionTransient = object | number;

export type UnionTrueUnion = object | number;

export type UnionTry = object | number;

export type UnionTypeUnion = object | number;

export type UnionTypealias = object | number;

export type UnionTypedef = object | number;

export type UnionTypeid = object | number;

export type UnionTypename = object | number;

export type UnionTypeof = object | number;

export type UnionUint = object | number;

export type UnionUlong = object | number;

export type UnionUnchecked = object | number;

export type UnionUndefined = object | number;

export type UnionUnionUnion = object | number;

export type UnionUnowned = object | number;

export type UnionUnsafe = object | number;

export type UnionUnsigned = object | number;

export type UnionUshort = object | number;

export type UnionUsing = object | number;

export type UnionVar = object | number;

export type UnionVirtual = object | number;

export type UnionVoid = object | number;

export type UnionVolatile = object | number;

export type UnionWcharT = object | number;

export type UnionWeak = object | number;

export type UnionWhere = object | number;

export type UnionWhile = object | number;

export type UnionWillSet = object | number;

export type UnionWith = object | number;

export type UnionXor = object | number;

export type UnionXorEq = object | number;

export type UnionYield = object | number;

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
export class Convert {
    public static toTopLevel(json: string): TopLevel {
        return cast(JSON.parse(json), r("TopLevel"));
    }

    public static topLevelToJson(value: TopLevel): string {
        return JSON.stringify(uncast(value, r("TopLevel")), null, 2);
    }
}

function invalidValue(typ: any, val: any, key: any, parent: any = ''): never {
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
        { json: "_", js: "_", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "_Bool", js: "_Bool", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "_Complex", js: "_Complex", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "_Imaginery", js: "_Imaginery", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "abstract", js: "abstract", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "alignas", js: "alignas", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "alignof", js: "alignof", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "and", js: "and", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "and_eq", js: "and_eq", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "any", js: "any", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Any", js: "Any", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "array", js: "array", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "ArrayNode", js: "ArrayNode", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "as", js: "as", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "asm", js: "asm", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "assert", js: "assert", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "associatedtype", js: "associatedtype", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "associativity", js: "associativity", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "async", js: "async", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "atomic", js: "atomic", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "atomic_cancel", js: "atomic_cancel", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "atomic_commit", js: "atomic_commit", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "atomic_noexcept", js: "atomic_noexcept", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "auto", js: "auto", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "await", js: "await", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "base", js: "base", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "bitand", js: "bitand", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "bitor", js: "bitor", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "BOOL", js: "BOOL", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "bool", js: "bool", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "boolean", js: "boolean", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "BooleanNode", js: "BooleanNode", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "break", js: "break", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "bycopy", js: "bycopy", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "byref", js: "byref", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "byte", js: "byte", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Calendar", js: "Calendar", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "case", js: "case", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "catch", js: "catch", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "chan", js: "chan", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "char", js: "char", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "char16_t", js: "char16_t", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "char32_t", js: "char32_t", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "checked", js: "checked", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "class", js: "class", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Class", js: "Class", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "clone", js: "clone", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "co_await", js: "co_await", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "co_return", js: "co_return", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "co_yield", js: "co_yield", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Codable", js: "Codable", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "CodingKey", js: "CodingKey", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "CodingKeys", js: "CodingKeys", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "compl", js: "compl", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "concept", js: "concept", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "console", js: "console", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "const", js: "const", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "const_cast", js: "const_cast", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "constexpr", js: "constexpr", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "constructor", js: "constructor", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "continue", js: "continue", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "convenience", js: "convenience", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "convert", js: "convert", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "converter", js: "converter", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "CultureInfo", js: "CultureInfo", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "date", js: "date", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "date_parse_handling", js: "date_parse_handling", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "DateFormatter", js: "DateFormatter", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "DateOnly", js: "DateOnly", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "DateOnlyConverter", js: "DateOnlyConverter", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "DateTime", js: "DateTime", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "DateTimeStyles", js: "DateTimeStyles", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "debugger", js: "debugger", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "decimal", js: "decimal", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "declare", js: "declare", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "decltype", js: "decltype", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "decode_string", js: "decode_string", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Decoder", js: "Decoder", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "DecodingError", js: "DecodingError", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "def", js: "def", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "default", js: "default", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "defer", js: "defer", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "deinit", js: "deinit", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "del", js: "del", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "delegate", js: "delegate", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "delete", js: "delete", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "DeserializationFeature", js: "DeserializationFeature", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "dict", js: "dict", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "dictionary", js: "dictionary", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "didSet", js: "didSet", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "do", js: "do", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "double", js: "double", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "DoubleNode", js: "DoubleNode", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "dummy", js: "dummy", typ: u(undefined, 3.14) },
        { json: "dynamic", js: "dynamic", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "dynamic_cast", js: "dynamic_cast", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "elif", js: "elif", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "else", js: "else", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "encode_quick_type", js: "encode_quick_type", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Encoder", js: "Encoder", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "enum", js: "enum", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "EnumValues", js: "EnumValues", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "equalityContract", js: "equalityContract", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Equatable", js: "Equatable", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "event", js: "event", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "except", js: "except", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "exception", js: "exception", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "explicit", js: "explicit", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "export", js: "export", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "exposing", js: "exposing", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "extends", js: "extends", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "extension", js: "extension", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "extern", js: "extern", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "fallthrough", js: "fallthrough", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "false", js: "false", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "False", js: "False", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "fileprivate", js: "fileprivate", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "final", js: "final", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "finally", js: "finally", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "fixed", js: "fixed", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "float", js: "float", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "for", js: "for", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "foreach", js: "foreach", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "FormatException", js: "FormatException", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "friend", js: "friend", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "from", js: "from", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "from_dict", js: "from_dict", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "from_json", js: "from_json", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "func", js: "func", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "function", js: "function", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "get", js: "get", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "global", js: "global", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "go", js: "go", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "goto", js: "goto", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "guard", js: "guard", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Hashable", js: "Hashable", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "hashCode", js: "hashCode", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Hasher", js: "Hasher", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "hasOwnProperty", js: "hasOwnProperty", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "id", js: "id", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "if", js: "if", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "IMP", js: "IMP", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "implements", js: "implements", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "implicit", js: "implicit", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "import", js: "import", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "in", js: "in", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "indirect", js: "indirect", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "infix", js: "infix", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "init", js: "init", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "inline", js: "inline", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "inout", js: "inout", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "instanceof", js: "instanceof", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "int", js: "int", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "interface", js: "interface", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "internal", js: "internal", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "IntNode", js: "IntNode", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "is", js: "is", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "IsoDateTimeOffsetConverter", js: "IsoDateTimeOffsetConverter", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "iterable", js: "iterable", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "jdec", js: "jdec", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "jenc", js: "jenc", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "jpipe", js: "jpipe", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "json", js: "json", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "json_converter", js: "json_converter", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "json_serializer", js: "json_serializer", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "json_token", js: "json_token", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "json_writer", js: "json_writer", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "JSONAny", js: "JSONAny", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "JSONCodingKey", js: "JSONCodingKey", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "JSONDecoder", js: "JSONDecoder", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "JSONEncoder", js: "JSONEncoder", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "JsonException", js: "JsonException", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "JsonGenerator", js: "JsonGenerator", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "JsonNode", js: "JsonNode", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "JSONNull", js: "JSONNull", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "JsonParser", js: "JsonParser", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "JsonReader", js: "JsonReader", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "JsonTokenType", js: "JsonTokenType", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "KSerializer", js: "KSerializer", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "lambda", js: "lambda", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "lazy", js: "lazy", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "left", js: "left", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "let", js: "let", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "list", js: "list", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "LocalDate", js: "LocalDate", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Locale", js: "Locale", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "lock", js: "lock", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "long", js: "long", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "LongNode", js: "LongNode", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "map", js: "map", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "MapEntry", js: "MapEntry", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "MarshalJSON", js: "MarshalJSON", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "metadata_property_handling", js: "metadata_property_handling", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "module", js: "module", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "mutable", js: "mutable", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "mutating", js: "mutating", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "namespace", js: "namespace", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "native", js: "native", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "new", js: "new", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "newtonsoft", js: "newtonsoft", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "nil", js: "nil", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "NO", js: "NO", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "noexcept", js: "noexcept", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "nonatomic", js: "nonatomic", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "none", js: "none", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "None", js: "None", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "nonlocal", js: "nonlocal", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "nonmutating", js: "nonmutating", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "noSuchMethod", js: "noSuchMethod", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "not", js: "not", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "not_eq", js: "not_eq", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "NSError", js: "NSError", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "NSObject", js: "NSObject", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "NSString", js: "NSString", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "NULL", js: "NULL", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "null", js: "null", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "NullNode", js: "NullNode", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "nullptr", js: "nullptr", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "number", js: "number", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "object", js: "object", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "ObjectMapper", js: "ObjectMapper", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "ObjectNode", js: "ObjectNode", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "ObjectReader", js: "ObjectReader", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "ObjectWriter", js: "ObjectWriter", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "of", js: "of", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "OffsetDateTime", js: "OffsetDateTime", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "OffsetTime", js: "OffsetTime", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "oneway", js: "oneway", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "open", js: "open", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "operator", js: "operator", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "optional", js: "optional", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "or", js: "or", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "or_eq", js: "or_eq", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "out", js: "out", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "override", js: "override", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "package", js: "package", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "params", js: "params", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "pass", js: "pass", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "port", js: "port", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "postfix", js: "postfix", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "precedence", js: "precedence", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "prefix", js: "prefix", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "PrimitiveKind", js: "PrimitiveKind", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "print", js: "print", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "printf", js: "printf", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "printMembers", js: "printMembers", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "private", js: "private", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "protected", js: "protected", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Protocol", js: "Protocol", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "protocol", js: "protocol", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "public", js: "public", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "quicktype", js: "quicktype", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "raise", js: "raise", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "range", js: "range", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "readonly", js: "readonly", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "ref", js: "ref", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "RegExp", js: "RegExp", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "register", js: "register", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "reinterpret_cast", js: "reinterpret_cast", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "repeat", js: "repeat", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "require", js: "require", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "required", js: "required", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "requires", js: "requires", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "restrict", js: "restrict", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "retain", js: "retain", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "rethrows", js: "rethrows", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "return", js: "return", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "right", js: "right", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "runtimeType", js: "runtimeType", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "s", js: "s", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "sbyte", js: "sbyte", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "sealed", js: "sealed", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "SEL", js: "SEL", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "select", js: "select", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Self", js: "Self", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "self", js: "self", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Sendable", js: "Sendable", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "SerialDescriptor", js: "SerialDescriptor", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Serializable", js: "Serializable", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "SerializationFeature", js: "SerializationFeature", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "serialize", js: "serialize", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "SerializerProvider", js: "SerializerProvider", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "SerialName", js: "SerialName", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "set", js: "set", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "short", js: "short", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "signed", js: "signed", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "SimpleModule", js: "SimpleModule", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "sizeof", js: "sizeof", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "stackalloc", js: "stackalloc", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Standards", js: "Standards", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "static", js: "static", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "static_assert", js: "static_assert", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "static_cast", js: "static_cast", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "StdDeserializer", js: "StdDeserializer", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "StdSerializer", js: "StdSerializer", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "strictfp", js: "strictfp", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "string", js: "string", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "struct", js: "struct", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "subscript", js: "subscript", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "super", js: "super", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "switch", js: "switch", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "symbol", js: "symbol", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "synchronized", js: "synchronized", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "system", js: "system", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "template", js: "template", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "TextNode", js: "TextNode", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "then", js: "then", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "this", js: "this", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "thread_local", js: "thread_local", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "throw", js: "throw", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "throws", js: "throws", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "TimeOnly", js: "TimeOnly", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "TimeOnlyConverter", js: "TimeOnlyConverter", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "TimeZone", js: "TimeZone", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "to_dict", js: "to_dict", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "to_json", js: "to_json", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "top_level", js: "top_level", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "toString", js: "toString", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "transient", js: "transient", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "True", js: "True", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "true", js: "true", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "try", js: "try", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Type", js: "Type", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "type", js: "type", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "typealias", js: "typealias", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "typedef", js: "typedef", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "typeid", js: "typeid", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "typename", js: "typename", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "typeof", js: "typeof", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "uint", js: "uint", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "ulong", js: "ulong", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "unchecked", js: "unchecked", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "undefined", js: "undefined", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "union", js: "union", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "UnmarshalJSON", js: "UnmarshalJSON", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "unowned", js: "unowned", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "unsafe", js: "unsafe", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "unsigned", js: "unsigned", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "UseSerializers", js: "UseSerializers", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "ushort", js: "ushort", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "using", js: "using", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Utf8JsonReader", js: "Utf8JsonReader", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "Utf8JsonWriter", js: "Utf8JsonWriter", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "UUID", js: "UUID", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "var", js: "var", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "virtual", js: "virtual", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "void", js: "void", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "volatile", js: "volatile", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "wchar_t", js: "wchar_t", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "weak", js: "weak", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "where", js: "where", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "while", js: "while", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "willSet", js: "willSet", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "with", js: "with", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "xor", js: "xor", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "xor_eq", js: "xor_eq", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "YES", js: "YES", typ: u(undefined, u(m("any"), 3.14)) },
        { json: "yield", js: "yield", typ: u(undefined, u(m("any"), 3.14)) },
    ], "any"),
};
