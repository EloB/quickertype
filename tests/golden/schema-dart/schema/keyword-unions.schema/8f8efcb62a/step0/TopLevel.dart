// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final dynamic empty;
    final dynamic purpleBool;
    final dynamic complex;
    final dynamic imaginery;
    final dynamic topLevelAbstract;
    final dynamic alignas;
    final dynamic alignof;
    final dynamic and;
    final dynamic andEq;
    final dynamic topLevelAny;
    final dynamic any;
    final dynamic array;
    final dynamic arrayNode;
    final dynamic topLevelAs;
    final dynamic asm;
    final dynamic topLevelAssert;
    final dynamic associatedtype;
    final dynamic associativity;
    final dynamic topLevelAsync;
    final dynamic atomic;
    final dynamic atomicCancel;
    final dynamic atomicCommit;
    final dynamic atomicNoexcept;
    final dynamic auto;
    final dynamic topLevelAwait;
    final dynamic base;
    final dynamic bitand;
    final dynamic bitor;
    final dynamic topLevelBool;
    final dynamic fluffyBool;
    final dynamic boolean;
    final dynamic booleanNode;
    final dynamic topLevelBreak;
    final dynamic bycopy;
    final dynamic byref;
    final dynamic byte;
    final dynamic calendar;
    final dynamic topLevelCase;
    final dynamic topLevelCatch;
    final dynamic chan;
    final dynamic char;
    final dynamic char16T;
    final dynamic char32T;
    final dynamic checked;
    final dynamic purpleClass;
    final dynamic topLevelClass;
    final dynamic clone;
    final dynamic coAwait;
    final dynamic coReturn;
    final dynamic coYield;
    final dynamic codable;
    final dynamic codingKey;
    final dynamic codingKeys;
    final dynamic compl;
    final dynamic concept;
    final dynamic console;
    final dynamic topLevelConst;
    final dynamic constCast;
    final dynamic constexpr;
    final dynamic constructor;
    final dynamic topLevelContinue;
    final dynamic convenience;
    final dynamic convert;
    final dynamic converter;
    final dynamic cultureInfo;
    final dynamic date;
    final dynamic dateParseHandling;
    final dynamic dateFormatter;
    final dynamic dateOnly;
    final dynamic dateOnlyConverter;
    final dynamic dateTime;
    final dynamic dateTimeStyles;
    final dynamic debugger;
    final dynamic decimal;
    final dynamic declare;
    final dynamic decltype;
    final dynamic decodeString;
    final dynamic decoder;
    final dynamic decodingError;
    final dynamic def;
    final dynamic topLevelDefault;
    final dynamic defer;
    final dynamic deinit;
    final dynamic del;
    final dynamic delegate;
    final dynamic delete;
    final dynamic deserializationFeature;
    final dynamic dict;
    final dynamic dictionary;
    final dynamic didSet;
    final dynamic topLevelDo;
    final dynamic topLevelDouble;
    final dynamic doubleNode;
    final double? dummy;
    final dynamic topLevelDynamic;
    final dynamic dynamicCast;
    final dynamic elif;
    final dynamic topLevelElse;
    final dynamic encodeQuickType;
    final dynamic encoder;
    final dynamic topLevelEnum;
    final dynamic enumValues;
    final dynamic equalityContract;
    final dynamic equatable;
    final dynamic event;
    final dynamic except;
    final dynamic exception;
    final dynamic explicit;
    final dynamic topLevelExport;
    final dynamic exposing;
    final dynamic topLevelExtends;
    final dynamic extension;
    final dynamic extern;
    final dynamic fallthrough;
    final dynamic purpleFalse;
    final dynamic topLevelFalse;
    final dynamic fileprivate;
    final dynamic topLevelFinal;
    final dynamic topLevelFinally;
    final dynamic fixed;
    final dynamic float;
    final dynamic topLevelFor;
    final dynamic foreach;
    final dynamic formatException;
    final dynamic friend;
    final dynamic from;
    final dynamic fromDict;
    final dynamic topLevelFromJson;
    final dynamic func;
    final dynamic function;
    final dynamic topLevelGet;
    final dynamic global;
    final dynamic go;
    final dynamic goto;
    final dynamic guard;
    final dynamic hashable;
    final dynamic topLevelHashCode;
    final dynamic hasher;
    final dynamic hasOwnProperty;
    final dynamic id;
    final dynamic topLevelIf;
    final dynamic imp;
    final dynamic topLevelImplements;
    final dynamic implicit;
    final dynamic topLevelImport;
    final dynamic topLevelIn;
    final dynamic indirect;
    final dynamic infix;
    final dynamic init;
    final dynamic inline;
    final dynamic inout;
    final dynamic instanceof;
    final dynamic topLevelInt;
    final dynamic topLevelInterface;
    final dynamic internal;
    final dynamic intNode;
    final dynamic topLevelIs;
    final dynamic isoDateTimeOffsetConverter;
    final dynamic iterable;
    final dynamic jdec;
    final dynamic jenc;
    final dynamic jpipe;
    final dynamic json;
    final dynamic jsonConverter;
    final dynamic jsonSerializer;
    final dynamic jsonToken;
    final dynamic jsonWriter;
    final dynamic jsonAny;
    final dynamic jsonCodingKey;
    final dynamic jsonDecoder;
    final dynamic jsonEncoder;
    final dynamic jsonException;
    final dynamic jsonGenerator;
    final dynamic jsonNode;
    final dynamic jsonNull;
    final dynamic jsonParser;
    final dynamic jsonReader;
    final dynamic jsonTokenType;
    final dynamic kSerializer;
    final dynamic lambda;
    final dynamic lazy;
    final dynamic left;
    final dynamic let;
    final dynamic list;
    final dynamic localDate;
    final dynamic locale;
    final dynamic lock;
    final dynamic long;
    final dynamic longNode;
    final dynamic map;
    final dynamic mapEntry;
    final dynamic marshalJson;
    final dynamic metadataPropertyHandling;
    final dynamic module;
    final dynamic mutable;
    final dynamic mutating;
    final dynamic namespace;
    final dynamic native;
    final dynamic topLevelNew;
    final dynamic newtonsoft;
    final dynamic nil;
    final dynamic no;
    final dynamic noexcept;
    final dynamic nonatomic;
    final dynamic topLevelNone;
    final dynamic none;
    final dynamic nonlocal;
    final dynamic nonmutating;
    final dynamic topLevelNoSuchMethod;
    final dynamic not;
    final dynamic notEq;
    final dynamic nsError;
    final dynamic nsObject;
    final dynamic nsString;
    final dynamic topLevelNull;
    final dynamic purpleNull;
    final dynamic nullNode;
    final dynamic nullptr;
    final dynamic number;
    final dynamic object;
    final dynamic objectMapper;
    final dynamic objectNode;
    final dynamic objectReader;
    final dynamic objectWriter;
    final dynamic of;
    final dynamic offsetDateTime;
    final dynamic offsetTime;
    final dynamic oneway;
    final dynamic open;
    final dynamic topLevelOperator;
    final dynamic optional;
    final dynamic or;
    final dynamic orEq;
    final dynamic out;
    final dynamic override;
    final dynamic package;
    final dynamic params;
    final dynamic pass;
    final dynamic port;
    final dynamic postfix;
    final dynamic precedence;
    final dynamic prefix;
    final dynamic primitiveKind;
    final dynamic print;
    final dynamic printf;
    final dynamic printMembers;
    final dynamic private;
    final dynamic protected;
    final dynamic protocol;
    final dynamic topLevelProtocol;
    final dynamic public;
    final dynamic quicktype;
    final dynamic raise;
    final dynamic range;
    final dynamic readonly;
    final dynamic ref;
    final dynamic regExp;
    final dynamic register;
    final dynamic reinterpretCast;
    final dynamic repeat;
    final dynamic require;
    final dynamic required;
    final dynamic requires;
    final dynamic restrict;
    final dynamic retain;
    final dynamic rethrows;
    final dynamic topLevelReturn;
    final dynamic right;
    final dynamic topLevelRuntimeType;
    final dynamic s;
    final dynamic sbyte;
    final dynamic sealed;
    final dynamic sel;
    final dynamic select;
    final dynamic self;
    final dynamic topLevelSelf;
    final dynamic sendable;
    final dynamic serialDescriptor;
    final dynamic serializable;
    final dynamic serializationFeature;
    final dynamic serialize;
    final dynamic serializerProvider;
    final dynamic serialName;
    final dynamic topLevelSet;
    final dynamic short;
    final dynamic signed;
    final dynamic simpleModule;
    final dynamic sizeof;
    final dynamic stackalloc;
    final dynamic standards;
    final dynamic topLevelStatic;
    final dynamic staticAssert;
    final dynamic staticCast;
    final dynamic stdDeserializer;
    final dynamic stdSerializer;
    final dynamic strictfp;
    final dynamic string;
    final dynamic struct;
    final dynamic subscript;
    final dynamic topLevelSuper;
    final dynamic topLevelSwitch;
    final dynamic symbol;
    final dynamic synchronized;
    final dynamic system;
    final dynamic template;
    final dynamic textNode;
    final dynamic then;
    final dynamic topLevelThis;
    final dynamic threadLocal;
    final dynamic topLevelThrow;
    final dynamic throws;
    final dynamic timeOnly;
    final dynamic timeOnlyConverter;
    final dynamic timeZone;
    final dynamic toDict;
    final dynamic topLevelToJson;
    final dynamic topLevel;
    final dynamic topLevelToString;
    final dynamic transient;
    final dynamic topLevelTrue;
    final dynamic purpleTrue;
    final dynamic topLevelTry;
    final dynamic type;
    final dynamic topLevelType;
    final dynamic typealias;
    final dynamic topLevelTypedef;
    final dynamic typeid;
    final dynamic typename;
    final dynamic typeof;
    final dynamic uint;
    final dynamic ulong;
    final dynamic unchecked;
    final dynamic undefined;
    final dynamic union;
    final dynamic unmarshalJson;
    final dynamic unowned;
    final dynamic unsafe;
    final dynamic unsigned;
    final dynamic useSerializers;
    final dynamic ushort;
    final dynamic using;
    final dynamic utf8JsonReader;
    final dynamic utf8JsonWriter;
    final dynamic uuid;
    final dynamic topLevelVar;
    final dynamic virtual;
    final dynamic topLevelVoid;
    final dynamic volatile;
    final dynamic wcharT;
    final dynamic weak;
    final dynamic where;
    final dynamic topLevelWhile;
    final dynamic willSet;
    final dynamic topLevelWith;
    final dynamic xor;
    final dynamic xorEq;
    final dynamic yes;
    final dynamic topLevelYield;

    TopLevel({
        this.empty,
        this.purpleBool,
        this.complex,
        this.imaginery,
        this.topLevelAbstract,
        this.alignas,
        this.alignof,
        this.and,
        this.andEq,
        this.topLevelAny,
        this.any,
        this.array,
        this.arrayNode,
        this.topLevelAs,
        this.asm,
        this.topLevelAssert,
        this.associatedtype,
        this.associativity,
        this.topLevelAsync,
        this.atomic,
        this.atomicCancel,
        this.atomicCommit,
        this.atomicNoexcept,
        this.auto,
        this.topLevelAwait,
        this.base,
        this.bitand,
        this.bitor,
        this.topLevelBool,
        this.fluffyBool,
        this.boolean,
        this.booleanNode,
        this.topLevelBreak,
        this.bycopy,
        this.byref,
        this.byte,
        this.calendar,
        this.topLevelCase,
        this.topLevelCatch,
        this.chan,
        this.char,
        this.char16T,
        this.char32T,
        this.checked,
        this.purpleClass,
        this.topLevelClass,
        this.clone,
        this.coAwait,
        this.coReturn,
        this.coYield,
        this.codable,
        this.codingKey,
        this.codingKeys,
        this.compl,
        this.concept,
        this.console,
        this.topLevelConst,
        this.constCast,
        this.constexpr,
        this.constructor,
        this.topLevelContinue,
        this.convenience,
        this.convert,
        this.converter,
        this.cultureInfo,
        this.date,
        this.dateParseHandling,
        this.dateFormatter,
        this.dateOnly,
        this.dateOnlyConverter,
        this.dateTime,
        this.dateTimeStyles,
        this.debugger,
        this.decimal,
        this.declare,
        this.decltype,
        this.decodeString,
        this.decoder,
        this.decodingError,
        this.def,
        this.topLevelDefault,
        this.defer,
        this.deinit,
        this.del,
        this.delegate,
        this.delete,
        this.deserializationFeature,
        this.dict,
        this.dictionary,
        this.didSet,
        this.topLevelDo,
        this.topLevelDouble,
        this.doubleNode,
        this.dummy,
        this.topLevelDynamic,
        this.dynamicCast,
        this.elif,
        this.topLevelElse,
        this.encodeQuickType,
        this.encoder,
        this.topLevelEnum,
        this.enumValues,
        this.equalityContract,
        this.equatable,
        this.event,
        this.except,
        this.exception,
        this.explicit,
        this.topLevelExport,
        this.exposing,
        this.topLevelExtends,
        this.extension,
        this.extern,
        this.fallthrough,
        this.purpleFalse,
        this.topLevelFalse,
        this.fileprivate,
        this.topLevelFinal,
        this.topLevelFinally,
        this.fixed,
        this.float,
        this.topLevelFor,
        this.foreach,
        this.formatException,
        this.friend,
        this.from,
        this.fromDict,
        this.topLevelFromJson,
        this.func,
        this.function,
        this.topLevelGet,
        this.global,
        this.go,
        this.goto,
        this.guard,
        this.hashable,
        this.topLevelHashCode,
        this.hasher,
        this.hasOwnProperty,
        this.id,
        this.topLevelIf,
        this.imp,
        this.topLevelImplements,
        this.implicit,
        this.topLevelImport,
        this.topLevelIn,
        this.indirect,
        this.infix,
        this.init,
        this.inline,
        this.inout,
        this.instanceof,
        this.topLevelInt,
        this.topLevelInterface,
        this.internal,
        this.intNode,
        this.topLevelIs,
        this.isoDateTimeOffsetConverter,
        this.iterable,
        this.jdec,
        this.jenc,
        this.jpipe,
        this.json,
        this.jsonConverter,
        this.jsonSerializer,
        this.jsonToken,
        this.jsonWriter,
        this.jsonAny,
        this.jsonCodingKey,
        this.jsonDecoder,
        this.jsonEncoder,
        this.jsonException,
        this.jsonGenerator,
        this.jsonNode,
        this.jsonNull,
        this.jsonParser,
        this.jsonReader,
        this.jsonTokenType,
        this.kSerializer,
        this.lambda,
        this.lazy,
        this.left,
        this.let,
        this.list,
        this.localDate,
        this.locale,
        this.lock,
        this.long,
        this.longNode,
        this.map,
        this.mapEntry,
        this.marshalJson,
        this.metadataPropertyHandling,
        this.module,
        this.mutable,
        this.mutating,
        this.namespace,
        this.native,
        this.topLevelNew,
        this.newtonsoft,
        this.nil,
        this.no,
        this.noexcept,
        this.nonatomic,
        this.topLevelNone,
        this.none,
        this.nonlocal,
        this.nonmutating,
        this.topLevelNoSuchMethod,
        this.not,
        this.notEq,
        this.nsError,
        this.nsObject,
        this.nsString,
        this.topLevelNull,
        this.purpleNull,
        this.nullNode,
        this.nullptr,
        this.number,
        this.object,
        this.objectMapper,
        this.objectNode,
        this.objectReader,
        this.objectWriter,
        this.of,
        this.offsetDateTime,
        this.offsetTime,
        this.oneway,
        this.open,
        this.topLevelOperator,
        this.optional,
        this.or,
        this.orEq,
        this.out,
        this.override,
        this.package,
        this.params,
        this.pass,
        this.port,
        this.postfix,
        this.precedence,
        this.prefix,
        this.primitiveKind,
        this.print,
        this.printf,
        this.printMembers,
        this.private,
        this.protected,
        this.protocol,
        this.topLevelProtocol,
        this.public,
        this.quicktype,
        this.raise,
        this.range,
        this.readonly,
        this.ref,
        this.regExp,
        this.register,
        this.reinterpretCast,
        this.repeat,
        this.require,
        this.required,
        this.requires,
        this.restrict,
        this.retain,
        this.rethrows,
        this.topLevelReturn,
        this.right,
        this.topLevelRuntimeType,
        this.s,
        this.sbyte,
        this.sealed,
        this.sel,
        this.select,
        this.self,
        this.topLevelSelf,
        this.sendable,
        this.serialDescriptor,
        this.serializable,
        this.serializationFeature,
        this.serialize,
        this.serializerProvider,
        this.serialName,
        this.topLevelSet,
        this.short,
        this.signed,
        this.simpleModule,
        this.sizeof,
        this.stackalloc,
        this.standards,
        this.topLevelStatic,
        this.staticAssert,
        this.staticCast,
        this.stdDeserializer,
        this.stdSerializer,
        this.strictfp,
        this.string,
        this.struct,
        this.subscript,
        this.topLevelSuper,
        this.topLevelSwitch,
        this.symbol,
        this.synchronized,
        this.system,
        this.template,
        this.textNode,
        this.then,
        this.topLevelThis,
        this.threadLocal,
        this.topLevelThrow,
        this.throws,
        this.timeOnly,
        this.timeOnlyConverter,
        this.timeZone,
        this.toDict,
        this.topLevelToJson,
        this.topLevel,
        this.topLevelToString,
        this.transient,
        this.topLevelTrue,
        this.purpleTrue,
        this.topLevelTry,
        this.type,
        this.topLevelType,
        this.typealias,
        this.topLevelTypedef,
        this.typeid,
        this.typename,
        this.typeof,
        this.uint,
        this.ulong,
        this.unchecked,
        this.undefined,
        this.union,
        this.unmarshalJson,
        this.unowned,
        this.unsafe,
        this.unsigned,
        this.useSerializers,
        this.ushort,
        this.using,
        this.utf8JsonReader,
        this.utf8JsonWriter,
        this.uuid,
        this.topLevelVar,
        this.virtual,
        this.topLevelVoid,
        this.volatile,
        this.wcharT,
        this.weak,
        this.where,
        this.topLevelWhile,
        this.willSet,
        this.topLevelWith,
        this.xor,
        this.xorEq,
        this.yes,
        this.topLevelYield,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        empty: json["_"],
        purpleBool: json["_Bool"],
        complex: json["_Complex"],
        imaginery: json["_Imaginery"],
        topLevelAbstract: json["abstract"],
        alignas: json["alignas"],
        alignof: json["alignof"],
        and: json["and"],
        andEq: json["and_eq"],
        topLevelAny: json["any"],
        any: json["Any"],
        array: json["array"],
        arrayNode: json["ArrayNode"],
        topLevelAs: json["as"],
        asm: json["asm"],
        topLevelAssert: json["assert"],
        associatedtype: json["associatedtype"],
        associativity: json["associativity"],
        topLevelAsync: json["async"],
        atomic: json["atomic"],
        atomicCancel: json["atomic_cancel"],
        atomicCommit: json["atomic_commit"],
        atomicNoexcept: json["atomic_noexcept"],
        auto: json["auto"],
        topLevelAwait: json["await"],
        base: json["base"],
        bitand: json["bitand"],
        bitor: json["bitor"],
        topLevelBool: json["BOOL"],
        fluffyBool: json["bool"],
        boolean: json["boolean"],
        booleanNode: json["BooleanNode"],
        topLevelBreak: json["break"],
        bycopy: json["bycopy"],
        byref: json["byref"],
        byte: json["byte"],
        calendar: json["Calendar"],
        topLevelCase: json["case"],
        topLevelCatch: json["catch"],
        chan: json["chan"],
        char: json["char"],
        char16T: json["char16_t"],
        char32T: json["char32_t"],
        checked: json["checked"],
        purpleClass: json["class"],
        topLevelClass: json["Class"],
        clone: json["clone"],
        coAwait: json["co_await"],
        coReturn: json["co_return"],
        coYield: json["co_yield"],
        codable: json["Codable"],
        codingKey: json["CodingKey"],
        codingKeys: json["CodingKeys"],
        compl: json["compl"],
        concept: json["concept"],
        console: json["console"],
        topLevelConst: json["const"],
        constCast: json["const_cast"],
        constexpr: json["constexpr"],
        constructor: json["constructor"],
        topLevelContinue: json["continue"],
        convenience: json["convenience"],
        convert: json["convert"],
        converter: json["converter"],
        cultureInfo: json["CultureInfo"],
        date: json["date"],
        dateParseHandling: json["date_parse_handling"],
        dateFormatter: json["DateFormatter"],
        dateOnly: json["DateOnly"],
        dateOnlyConverter: json["DateOnlyConverter"],
        dateTime: json["DateTime"],
        dateTimeStyles: json["DateTimeStyles"],
        debugger: json["debugger"],
        decimal: json["decimal"],
        declare: json["declare"],
        decltype: json["decltype"],
        decodeString: json["decode_string"],
        decoder: json["Decoder"],
        decodingError: json["DecodingError"],
        def: json["def"],
        topLevelDefault: json["default"],
        defer: json["defer"],
        deinit: json["deinit"],
        del: json["del"],
        delegate: json["delegate"],
        delete: json["delete"],
        deserializationFeature: json["DeserializationFeature"],
        dict: json["dict"],
        dictionary: json["dictionary"],
        didSet: json["didSet"],
        topLevelDo: json["do"],
        topLevelDouble: json["double"],
        doubleNode: json["DoubleNode"],
        dummy: json["dummy"]?.toDouble(),
        topLevelDynamic: json["dynamic"],
        dynamicCast: json["dynamic_cast"],
        elif: json["elif"],
        topLevelElse: json["else"],
        encodeQuickType: json["encode_quick_type"],
        encoder: json["Encoder"],
        topLevelEnum: json["enum"],
        enumValues: json["EnumValues"],
        equalityContract: json["equalityContract"],
        equatable: json["Equatable"],
        event: json["event"],
        except: json["except"],
        exception: json["exception"],
        explicit: json["explicit"],
        topLevelExport: json["export"],
        exposing: json["exposing"],
        topLevelExtends: json["extends"],
        extension: json["extension"],
        extern: json["extern"],
        fallthrough: json["fallthrough"],
        purpleFalse: json["false"],
        topLevelFalse: json["False"],
        fileprivate: json["fileprivate"],
        topLevelFinal: json["final"],
        topLevelFinally: json["finally"],
        fixed: json["fixed"],
        float: json["float"],
        topLevelFor: json["for"],
        foreach: json["foreach"],
        formatException: json["FormatException"],
        friend: json["friend"],
        from: json["from"],
        fromDict: json["from_dict"],
        topLevelFromJson: json["from_json"],
        func: json["func"],
        function: json["function"],
        topLevelGet: json["get"],
        global: json["global"],
        go: json["go"],
        goto: json["goto"],
        guard: json["guard"],
        hashable: json["Hashable"],
        topLevelHashCode: json["hashCode"],
        hasher: json["Hasher"],
        hasOwnProperty: json["hasOwnProperty"],
        id: json["id"],
        topLevelIf: json["if"],
        imp: json["IMP"],
        topLevelImplements: json["implements"],
        implicit: json["implicit"],
        topLevelImport: json["import"],
        topLevelIn: json["in"],
        indirect: json["indirect"],
        infix: json["infix"],
        init: json["init"],
        inline: json["inline"],
        inout: json["inout"],
        instanceof: json["instanceof"],
        topLevelInt: json["int"],
        topLevelInterface: json["interface"],
        internal: json["internal"],
        intNode: json["IntNode"],
        topLevelIs: json["is"],
        isoDateTimeOffsetConverter: json["IsoDateTimeOffsetConverter"],
        iterable: json["iterable"],
        jdec: json["jdec"],
        jenc: json["jenc"],
        jpipe: json["jpipe"],
        json: json["json"],
        jsonConverter: json["json_converter"],
        jsonSerializer: json["json_serializer"],
        jsonToken: json["json_token"],
        jsonWriter: json["json_writer"],
        jsonAny: json["JSONAny"],
        jsonCodingKey: json["JSONCodingKey"],
        jsonDecoder: json["JSONDecoder"],
        jsonEncoder: json["JSONEncoder"],
        jsonException: json["JsonException"],
        jsonGenerator: json["JsonGenerator"],
        jsonNode: json["JsonNode"],
        jsonNull: json["JSONNull"],
        jsonParser: json["JsonParser"],
        jsonReader: json["JsonReader"],
        jsonTokenType: json["JsonTokenType"],
        kSerializer: json["KSerializer"],
        lambda: json["lambda"],
        lazy: json["lazy"],
        left: json["left"],
        let: json["let"],
        list: json["list"],
        localDate: json["LocalDate"],
        locale: json["Locale"],
        lock: json["lock"],
        long: json["long"],
        longNode: json["LongNode"],
        map: json["map"],
        mapEntry: json["MapEntry"],
        marshalJson: json["MarshalJSON"],
        metadataPropertyHandling: json["metadata_property_handling"],
        module: json["module"],
        mutable: json["mutable"],
        mutating: json["mutating"],
        namespace: json["namespace"],
        native: json["native"],
        topLevelNew: json["new"],
        newtonsoft: json["newtonsoft"],
        nil: json["nil"],
        no: json["NO"],
        noexcept: json["noexcept"],
        nonatomic: json["nonatomic"],
        topLevelNone: json["none"],
        none: json["None"],
        nonlocal: json["nonlocal"],
        nonmutating: json["nonmutating"],
        topLevelNoSuchMethod: json["noSuchMethod"],
        not: json["not"],
        notEq: json["not_eq"],
        nsError: json["NSError"],
        nsObject: json["NSObject"],
        nsString: json["NSString"],
        topLevelNull: json["NULL"],
        purpleNull: json["null"],
        nullNode: json["NullNode"],
        nullptr: json["nullptr"],
        number: json["number"],
        object: json["object"],
        objectMapper: json["ObjectMapper"],
        objectNode: json["ObjectNode"],
        objectReader: json["ObjectReader"],
        objectWriter: json["ObjectWriter"],
        of: json["of"],
        offsetDateTime: json["OffsetDateTime"],
        offsetTime: json["OffsetTime"],
        oneway: json["oneway"],
        open: json["open"],
        topLevelOperator: json["operator"],
        optional: json["optional"],
        or: json["or"],
        orEq: json["or_eq"],
        out: json["out"],
        override: json["override"],
        package: json["package"],
        params: json["params"],
        pass: json["pass"],
        port: json["port"],
        postfix: json["postfix"],
        precedence: json["precedence"],
        prefix: json["prefix"],
        primitiveKind: json["PrimitiveKind"],
        print: json["print"],
        printf: json["printf"],
        printMembers: json["printMembers"],
        private: json["private"],
        protected: json["protected"],
        protocol: json["Protocol"],
        topLevelProtocol: json["protocol"],
        public: json["public"],
        quicktype: json["quicktype"],
        raise: json["raise"],
        range: json["range"],
        readonly: json["readonly"],
        ref: json["ref"],
        regExp: json["RegExp"],
        register: json["register"],
        reinterpretCast: json["reinterpret_cast"],
        repeat: json["repeat"],
        require: json["require"],
        required: json["required"],
        requires: json["requires"],
        restrict: json["restrict"],
        retain: json["retain"],
        rethrows: json["rethrows"],
        topLevelReturn: json["return"],
        right: json["right"],
        topLevelRuntimeType: json["runtimeType"],
        s: json["s"],
        sbyte: json["sbyte"],
        sealed: json["sealed"],
        sel: json["SEL"],
        select: json["select"],
        self: json["Self"],
        topLevelSelf: json["self"],
        sendable: json["Sendable"],
        serialDescriptor: json["SerialDescriptor"],
        serializable: json["Serializable"],
        serializationFeature: json["SerializationFeature"],
        serialize: json["serialize"],
        serializerProvider: json["SerializerProvider"],
        serialName: json["SerialName"],
        topLevelSet: json["set"],
        short: json["short"],
        signed: json["signed"],
        simpleModule: json["SimpleModule"],
        sizeof: json["sizeof"],
        stackalloc: json["stackalloc"],
        standards: json["Standards"],
        topLevelStatic: json["static"],
        staticAssert: json["static_assert"],
        staticCast: json["static_cast"],
        stdDeserializer: json["StdDeserializer"],
        stdSerializer: json["StdSerializer"],
        strictfp: json["strictfp"],
        string: json["string"],
        struct: json["struct"],
        subscript: json["subscript"],
        topLevelSuper: json["super"],
        topLevelSwitch: json["switch"],
        symbol: json["symbol"],
        synchronized: json["synchronized"],
        system: json["system"],
        template: json["template"],
        textNode: json["TextNode"],
        then: json["then"],
        topLevelThis: json["this"],
        threadLocal: json["thread_local"],
        topLevelThrow: json["throw"],
        throws: json["throws"],
        timeOnly: json["TimeOnly"],
        timeOnlyConverter: json["TimeOnlyConverter"],
        timeZone: json["TimeZone"],
        toDict: json["to_dict"],
        topLevelToJson: json["to_json"],
        topLevel: json["top_level"],
        topLevelToString: json["toString"],
        transient: json["transient"],
        topLevelTrue: json["True"],
        purpleTrue: json["true"],
        topLevelTry: json["try"],
        type: json["Type"],
        topLevelType: json["type"],
        typealias: json["typealias"],
        topLevelTypedef: json["typedef"],
        typeid: json["typeid"],
        typename: json["typename"],
        typeof: json["typeof"],
        uint: json["uint"],
        ulong: json["ulong"],
        unchecked: json["unchecked"],
        undefined: json["undefined"],
        union: json["union"],
        unmarshalJson: json["UnmarshalJSON"],
        unowned: json["unowned"],
        unsafe: json["unsafe"],
        unsigned: json["unsigned"],
        useSerializers: json["UseSerializers"],
        ushort: json["ushort"],
        using: json["using"],
        utf8JsonReader: json["Utf8JsonReader"],
        utf8JsonWriter: json["Utf8JsonWriter"],
        uuid: json["UUID"],
        topLevelVar: json["var"],
        virtual: json["virtual"],
        topLevelVoid: json["void"],
        volatile: json["volatile"],
        wcharT: json["wchar_t"],
        weak: json["weak"],
        where: json["where"],
        topLevelWhile: json["while"],
        willSet: json["willSet"],
        topLevelWith: json["with"],
        xor: json["xor"],
        xorEq: json["xor_eq"],
        yes: json["YES"],
        topLevelYield: json["yield"],
    );

    Map<String, dynamic> toJson() => {
        "_": empty,
        "_Bool": purpleBool,
        "_Complex": complex,
        "_Imaginery": imaginery,
        "abstract": topLevelAbstract,
        "alignas": alignas,
        "alignof": alignof,
        "and": and,
        "and_eq": andEq,
        "any": topLevelAny,
        "Any": any,
        "array": array,
        "ArrayNode": arrayNode,
        "as": topLevelAs,
        "asm": asm,
        "assert": topLevelAssert,
        "associatedtype": associatedtype,
        "associativity": associativity,
        "async": topLevelAsync,
        "atomic": atomic,
        "atomic_cancel": atomicCancel,
        "atomic_commit": atomicCommit,
        "atomic_noexcept": atomicNoexcept,
        "auto": auto,
        "await": topLevelAwait,
        "base": base,
        "bitand": bitand,
        "bitor": bitor,
        "BOOL": topLevelBool,
        "bool": fluffyBool,
        "boolean": boolean,
        "BooleanNode": booleanNode,
        "break": topLevelBreak,
        "bycopy": bycopy,
        "byref": byref,
        "byte": byte,
        "Calendar": calendar,
        "case": topLevelCase,
        "catch": topLevelCatch,
        "chan": chan,
        "char": char,
        "char16_t": char16T,
        "char32_t": char32T,
        "checked": checked,
        "class": purpleClass,
        "Class": topLevelClass,
        "clone": clone,
        "co_await": coAwait,
        "co_return": coReturn,
        "co_yield": coYield,
        "Codable": codable,
        "CodingKey": codingKey,
        "CodingKeys": codingKeys,
        "compl": compl,
        "concept": concept,
        "console": console,
        "const": topLevelConst,
        "const_cast": constCast,
        "constexpr": constexpr,
        "constructor": constructor,
        "continue": topLevelContinue,
        "convenience": convenience,
        "convert": convert,
        "converter": converter,
        "CultureInfo": cultureInfo,
        "date": date,
        "date_parse_handling": dateParseHandling,
        "DateFormatter": dateFormatter,
        "DateOnly": dateOnly,
        "DateOnlyConverter": dateOnlyConverter,
        "DateTime": dateTime,
        "DateTimeStyles": dateTimeStyles,
        "debugger": debugger,
        "decimal": decimal,
        "declare": declare,
        "decltype": decltype,
        "decode_string": decodeString,
        "Decoder": decoder,
        "DecodingError": decodingError,
        "def": def,
        "default": topLevelDefault,
        "defer": defer,
        "deinit": deinit,
        "del": del,
        "delegate": delegate,
        "delete": delete,
        "DeserializationFeature": deserializationFeature,
        "dict": dict,
        "dictionary": dictionary,
        "didSet": didSet,
        "do": topLevelDo,
        "double": topLevelDouble,
        "DoubleNode": doubleNode,
        "dummy": dummy,
        "dynamic": topLevelDynamic,
        "dynamic_cast": dynamicCast,
        "elif": elif,
        "else": topLevelElse,
        "encode_quick_type": encodeQuickType,
        "Encoder": encoder,
        "enum": topLevelEnum,
        "EnumValues": enumValues,
        "equalityContract": equalityContract,
        "Equatable": equatable,
        "event": event,
        "except": except,
        "exception": exception,
        "explicit": explicit,
        "export": topLevelExport,
        "exposing": exposing,
        "extends": topLevelExtends,
        "extension": extension,
        "extern": extern,
        "fallthrough": fallthrough,
        "false": purpleFalse,
        "False": topLevelFalse,
        "fileprivate": fileprivate,
        "final": topLevelFinal,
        "finally": topLevelFinally,
        "fixed": fixed,
        "float": float,
        "for": topLevelFor,
        "foreach": foreach,
        "FormatException": formatException,
        "friend": friend,
        "from": from,
        "from_dict": fromDict,
        "from_json": topLevelFromJson,
        "func": func,
        "function": function,
        "get": topLevelGet,
        "global": global,
        "go": go,
        "goto": goto,
        "guard": guard,
        "Hashable": hashable,
        "hashCode": topLevelHashCode,
        "Hasher": hasher,
        "hasOwnProperty": hasOwnProperty,
        "id": id,
        "if": topLevelIf,
        "IMP": imp,
        "implements": topLevelImplements,
        "implicit": implicit,
        "import": topLevelImport,
        "in": topLevelIn,
        "indirect": indirect,
        "infix": infix,
        "init": init,
        "inline": inline,
        "inout": inout,
        "instanceof": instanceof,
        "int": topLevelInt,
        "interface": topLevelInterface,
        "internal": internal,
        "IntNode": intNode,
        "is": topLevelIs,
        "IsoDateTimeOffsetConverter": isoDateTimeOffsetConverter,
        "iterable": iterable,
        "jdec": jdec,
        "jenc": jenc,
        "jpipe": jpipe,
        "json": json,
        "json_converter": jsonConverter,
        "json_serializer": jsonSerializer,
        "json_token": jsonToken,
        "json_writer": jsonWriter,
        "JSONAny": jsonAny,
        "JSONCodingKey": jsonCodingKey,
        "JSONDecoder": jsonDecoder,
        "JSONEncoder": jsonEncoder,
        "JsonException": jsonException,
        "JsonGenerator": jsonGenerator,
        "JsonNode": jsonNode,
        "JSONNull": jsonNull,
        "JsonParser": jsonParser,
        "JsonReader": jsonReader,
        "JsonTokenType": jsonTokenType,
        "KSerializer": kSerializer,
        "lambda": lambda,
        "lazy": lazy,
        "left": left,
        "let": let,
        "list": list,
        "LocalDate": localDate,
        "Locale": locale,
        "lock": lock,
        "long": long,
        "LongNode": longNode,
        "map": map,
        "MapEntry": mapEntry,
        "MarshalJSON": marshalJson,
        "metadata_property_handling": metadataPropertyHandling,
        "module": module,
        "mutable": mutable,
        "mutating": mutating,
        "namespace": namespace,
        "native": native,
        "new": topLevelNew,
        "newtonsoft": newtonsoft,
        "nil": nil,
        "NO": no,
        "noexcept": noexcept,
        "nonatomic": nonatomic,
        "none": topLevelNone,
        "None": none,
        "nonlocal": nonlocal,
        "nonmutating": nonmutating,
        "noSuchMethod": topLevelNoSuchMethod,
        "not": not,
        "not_eq": notEq,
        "NSError": nsError,
        "NSObject": nsObject,
        "NSString": nsString,
        "NULL": topLevelNull,
        "null": purpleNull,
        "NullNode": nullNode,
        "nullptr": nullptr,
        "number": number,
        "object": object,
        "ObjectMapper": objectMapper,
        "ObjectNode": objectNode,
        "ObjectReader": objectReader,
        "ObjectWriter": objectWriter,
        "of": of,
        "OffsetDateTime": offsetDateTime,
        "OffsetTime": offsetTime,
        "oneway": oneway,
        "open": open,
        "operator": topLevelOperator,
        "optional": optional,
        "or": or,
        "or_eq": orEq,
        "out": out,
        "override": override,
        "package": package,
        "params": params,
        "pass": pass,
        "port": port,
        "postfix": postfix,
        "precedence": precedence,
        "prefix": prefix,
        "PrimitiveKind": primitiveKind,
        "print": print,
        "printf": printf,
        "printMembers": printMembers,
        "private": private,
        "protected": protected,
        "Protocol": protocol,
        "protocol": topLevelProtocol,
        "public": public,
        "quicktype": quicktype,
        "raise": raise,
        "range": range,
        "readonly": readonly,
        "ref": ref,
        "RegExp": regExp,
        "register": register,
        "reinterpret_cast": reinterpretCast,
        "repeat": repeat,
        "require": require,
        "required": required,
        "requires": requires,
        "restrict": restrict,
        "retain": retain,
        "rethrows": rethrows,
        "return": topLevelReturn,
        "right": right,
        "runtimeType": topLevelRuntimeType,
        "s": s,
        "sbyte": sbyte,
        "sealed": sealed,
        "SEL": sel,
        "select": select,
        "Self": self,
        "self": topLevelSelf,
        "Sendable": sendable,
        "SerialDescriptor": serialDescriptor,
        "Serializable": serializable,
        "SerializationFeature": serializationFeature,
        "serialize": serialize,
        "SerializerProvider": serializerProvider,
        "SerialName": serialName,
        "set": topLevelSet,
        "short": short,
        "signed": signed,
        "SimpleModule": simpleModule,
        "sizeof": sizeof,
        "stackalloc": stackalloc,
        "Standards": standards,
        "static": topLevelStatic,
        "static_assert": staticAssert,
        "static_cast": staticCast,
        "StdDeserializer": stdDeserializer,
        "StdSerializer": stdSerializer,
        "strictfp": strictfp,
        "string": string,
        "struct": struct,
        "subscript": subscript,
        "super": topLevelSuper,
        "switch": topLevelSwitch,
        "symbol": symbol,
        "synchronized": synchronized,
        "system": system,
        "template": template,
        "TextNode": textNode,
        "then": then,
        "this": topLevelThis,
        "thread_local": threadLocal,
        "throw": topLevelThrow,
        "throws": throws,
        "TimeOnly": timeOnly,
        "TimeOnlyConverter": timeOnlyConverter,
        "TimeZone": timeZone,
        "to_dict": toDict,
        "to_json": topLevelToJson,
        "top_level": topLevel,
        "toString": topLevelToString,
        "transient": transient,
        "True": topLevelTrue,
        "true": purpleTrue,
        "try": topLevelTry,
        "Type": type,
        "type": topLevelType,
        "typealias": typealias,
        "typedef": topLevelTypedef,
        "typeid": typeid,
        "typename": typename,
        "typeof": typeof,
        "uint": uint,
        "ulong": ulong,
        "unchecked": unchecked,
        "undefined": undefined,
        "union": union,
        "UnmarshalJSON": unmarshalJson,
        "unowned": unowned,
        "unsafe": unsafe,
        "unsigned": unsigned,
        "UseSerializers": useSerializers,
        "ushort": ushort,
        "using": using,
        "Utf8JsonReader": utf8JsonReader,
        "Utf8JsonWriter": utf8JsonWriter,
        "UUID": uuid,
        "var": topLevelVar,
        "virtual": virtual,
        "void": topLevelVoid,
        "volatile": volatile,
        "wchar_t": wcharT,
        "weak": weak,
        "where": where,
        "while": topLevelWhile,
        "willSet": willSet,
        "with": topLevelWith,
        "xor": xor,
        "xor_eq": xorEq,
        "YES": yes,
        "yield": topLevelYield,
    };
}

class Alignas {
    Alignas();

    factory Alignas.fromJson(Map<String, dynamic> json) => Alignas(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Alignof {
    Alignof();

    factory Alignof.fromJson(Map<String, dynamic> json) => Alignof(
    );

    Map<String, dynamic> toJson() => {
    };
}

class And {
    And();

    factory And.fromJson(Map<String, dynamic> json) => And(
    );

    Map<String, dynamic> toJson() => {
    };
}

class AndEq {
    AndEq();

    factory AndEq.fromJson(Map<String, dynamic> json) => AndEq(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Any {
    Any();

    factory Any.fromJson(Map<String, dynamic> json) => Any(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Array {
    Array();

    factory Array.fromJson(Map<String, dynamic> json) => Array(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ArrayNode {
    ArrayNode();

    factory ArrayNode.fromJson(Map<String, dynamic> json) => ArrayNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Asm {
    Asm();

    factory Asm.fromJson(Map<String, dynamic> json) => Asm(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Associatedtype {
    Associatedtype();

    factory Associatedtype.fromJson(Map<String, dynamic> json) => Associatedtype(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Associativity {
    Associativity();

    factory Associativity.fromJson(Map<String, dynamic> json) => Associativity(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Atomic {
    Atomic();

    factory Atomic.fromJson(Map<String, dynamic> json) => Atomic(
    );

    Map<String, dynamic> toJson() => {
    };
}

class AtomicCancel {
    AtomicCancel();

    factory AtomicCancel.fromJson(Map<String, dynamic> json) => AtomicCancel(
    );

    Map<String, dynamic> toJson() => {
    };
}

class AtomicCommit {
    AtomicCommit();

    factory AtomicCommit.fromJson(Map<String, dynamic> json) => AtomicCommit(
    );

    Map<String, dynamic> toJson() => {
    };
}

class AtomicNoexcept {
    AtomicNoexcept();

    factory AtomicNoexcept.fromJson(Map<String, dynamic> json) => AtomicNoexcept(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Auto {
    Auto();

    factory Auto.fromJson(Map<String, dynamic> json) => Auto(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Base {
    Base();

    factory Base.fromJson(Map<String, dynamic> json) => Base(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Bitand {
    Bitand();

    factory Bitand.fromJson(Map<String, dynamic> json) => Bitand(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Bitor {
    Bitor();

    factory Bitor.fromJson(Map<String, dynamic> json) => Bitor(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Boolean {
    Boolean();

    factory Boolean.fromJson(Map<String, dynamic> json) => Boolean(
    );

    Map<String, dynamic> toJson() => {
    };
}

class BooleanNode {
    BooleanNode();

    factory BooleanNode.fromJson(Map<String, dynamic> json) => BooleanNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Bycopy {
    Bycopy();

    factory Bycopy.fromJson(Map<String, dynamic> json) => Bycopy(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Byref {
    Byref();

    factory Byref.fromJson(Map<String, dynamic> json) => Byref(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Byte {
    Byte();

    factory Byte.fromJson(Map<String, dynamic> json) => Byte(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Calendar {
    Calendar();

    factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Chan {
    Chan();

    factory Chan.fromJson(Map<String, dynamic> json) => Chan(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Char {
    Char();

    factory Char.fromJson(Map<String, dynamic> json) => Char(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Char16T {
    Char16T();

    factory Char16T.fromJson(Map<String, dynamic> json) => Char16T(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Char32T {
    Char32T();

    factory Char32T.fromJson(Map<String, dynamic> json) => Char32T(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Checked {
    Checked();

    factory Checked.fromJson(Map<String, dynamic> json) => Checked(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Clone {
    Clone();

    factory Clone.fromJson(Map<String, dynamic> json) => Clone(
    );

    Map<String, dynamic> toJson() => {
    };
}

class CoAwait {
    CoAwait();

    factory CoAwait.fromJson(Map<String, dynamic> json) => CoAwait(
    );

    Map<String, dynamic> toJson() => {
    };
}

class CoReturn {
    CoReturn();

    factory CoReturn.fromJson(Map<String, dynamic> json) => CoReturn(
    );

    Map<String, dynamic> toJson() => {
    };
}

class CoYield {
    CoYield();

    factory CoYield.fromJson(Map<String, dynamic> json) => CoYield(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Codable {
    Codable();

    factory Codable.fromJson(Map<String, dynamic> json) => Codable(
    );

    Map<String, dynamic> toJson() => {
    };
}

class CodingKey {
    CodingKey();

    factory CodingKey.fromJson(Map<String, dynamic> json) => CodingKey(
    );

    Map<String, dynamic> toJson() => {
    };
}

class CodingKeys {
    CodingKeys();

    factory CodingKeys.fromJson(Map<String, dynamic> json) => CodingKeys(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Compl {
    Compl();

    factory Compl.fromJson(Map<String, dynamic> json) => Compl(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Complex {
    Complex();

    factory Complex.fromJson(Map<String, dynamic> json) => Complex(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Concept {
    Concept();

    factory Concept.fromJson(Map<String, dynamic> json) => Concept(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Console {
    Console();

    factory Console.fromJson(Map<String, dynamic> json) => Console(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ConstCast {
    ConstCast();

    factory ConstCast.fromJson(Map<String, dynamic> json) => ConstCast(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Constexpr {
    Constexpr();

    factory Constexpr.fromJson(Map<String, dynamic> json) => Constexpr(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Constructor {
    Constructor();

    factory Constructor.fromJson(Map<String, dynamic> json) => Constructor(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Convenience {
    Convenience();

    factory Convenience.fromJson(Map<String, dynamic> json) => Convenience(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Convert {
    Convert();

    factory Convert.fromJson(Map<String, dynamic> json) => Convert(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Converter {
    Converter();

    factory Converter.fromJson(Map<String, dynamic> json) => Converter(
    );

    Map<String, dynamic> toJson() => {
    };
}

class CultureInfo {
    CultureInfo();

    factory CultureInfo.fromJson(Map<String, dynamic> json) => CultureInfo(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Date {
    Date();

    factory Date.fromJson(Map<String, dynamic> json) => Date(
    );

    Map<String, dynamic> toJson() => {
    };
}

class DateFormatter {
    DateFormatter();

    factory DateFormatter.fromJson(Map<String, dynamic> json) => DateFormatter(
    );

    Map<String, dynamic> toJson() => {
    };
}

class DateOnly {
    DateOnly();

    factory DateOnly.fromJson(Map<String, dynamic> json) => DateOnly(
    );

    Map<String, dynamic> toJson() => {
    };
}

class DateOnlyConverter {
    DateOnlyConverter();

    factory DateOnlyConverter.fromJson(Map<String, dynamic> json) => DateOnlyConverter(
    );

    Map<String, dynamic> toJson() => {
    };
}

class DateParseHandling {
    DateParseHandling();

    factory DateParseHandling.fromJson(Map<String, dynamic> json) => DateParseHandling(
    );

    Map<String, dynamic> toJson() => {
    };
}

class DateTimeClass {
    DateTimeClass();

    factory DateTimeClass.fromJson(Map<String, dynamic> json) => DateTimeClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class DateTimeStyles {
    DateTimeStyles();

    factory DateTimeStyles.fromJson(Map<String, dynamic> json) => DateTimeStyles(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Debugger {
    Debugger();

    factory Debugger.fromJson(Map<String, dynamic> json) => Debugger(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Decimal {
    Decimal();

    factory Decimal.fromJson(Map<String, dynamic> json) => Decimal(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Declare {
    Declare();

    factory Declare.fromJson(Map<String, dynamic> json) => Declare(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Decltype {
    Decltype();

    factory Decltype.fromJson(Map<String, dynamic> json) => Decltype(
    );

    Map<String, dynamic> toJson() => {
    };
}

class DecodeString {
    DecodeString();

    factory DecodeString.fromJson(Map<String, dynamic> json) => DecodeString(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Decoder {
    Decoder();

    factory Decoder.fromJson(Map<String, dynamic> json) => Decoder(
    );

    Map<String, dynamic> toJson() => {
    };
}

class DecodingError {
    DecodingError();

    factory DecodingError.fromJson(Map<String, dynamic> json) => DecodingError(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Def {
    Def();

    factory Def.fromJson(Map<String, dynamic> json) => Def(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Defer {
    Defer();

    factory Defer.fromJson(Map<String, dynamic> json) => Defer(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Deinit {
    Deinit();

    factory Deinit.fromJson(Map<String, dynamic> json) => Deinit(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Del {
    Del();

    factory Del.fromJson(Map<String, dynamic> json) => Del(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Delegate {
    Delegate();

    factory Delegate.fromJson(Map<String, dynamic> json) => Delegate(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Delete {
    Delete();

    factory Delete.fromJson(Map<String, dynamic> json) => Delete(
    );

    Map<String, dynamic> toJson() => {
    };
}

class DeserializationFeature {
    DeserializationFeature();

    factory DeserializationFeature.fromJson(Map<String, dynamic> json) => DeserializationFeature(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Dict {
    Dict();

    factory Dict.fromJson(Map<String, dynamic> json) => Dict(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Dictionary {
    Dictionary();

    factory Dictionary.fromJson(Map<String, dynamic> json) => Dictionary(
    );

    Map<String, dynamic> toJson() => {
    };
}

class DidSet {
    DidSet();

    factory DidSet.fromJson(Map<String, dynamic> json) => DidSet(
    );

    Map<String, dynamic> toJson() => {
    };
}

class DoubleNode {
    DoubleNode();

    factory DoubleNode.fromJson(Map<String, dynamic> json) => DoubleNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class DynamicCast {
    DynamicCast();

    factory DynamicCast.fromJson(Map<String, dynamic> json) => DynamicCast(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Elif {
    Elif();

    factory Elif.fromJson(Map<String, dynamic> json) => Elif(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Empty {
    Empty();

    factory Empty.fromJson(Map<String, dynamic> json) => Empty(
    );

    Map<String, dynamic> toJson() => {
    };
}

class EncodeQuickType {
    EncodeQuickType();

    factory EncodeQuickType.fromJson(Map<String, dynamic> json) => EncodeQuickType(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Encoder {
    Encoder();

    factory Encoder.fromJson(Map<String, dynamic> json) => Encoder(
    );

    Map<String, dynamic> toJson() => {
    };
}

class EnumValuesClass {
    EnumValuesClass();

    factory EnumValuesClass.fromJson(Map<String, dynamic> json) => EnumValuesClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class EqualityContract {
    EqualityContract();

    factory EqualityContract.fromJson(Map<String, dynamic> json) => EqualityContract(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Equatable {
    Equatable();

    factory Equatable.fromJson(Map<String, dynamic> json) => Equatable(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Event {
    Event();

    factory Event.fromJson(Map<String, dynamic> json) => Event(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Except {
    Except();

    factory Except.fromJson(Map<String, dynamic> json) => Except(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Exception {
    Exception();

    factory Exception.fromJson(Map<String, dynamic> json) => Exception(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Explicit {
    Explicit();

    factory Explicit.fromJson(Map<String, dynamic> json) => Explicit(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Exposing {
    Exposing();

    factory Exposing.fromJson(Map<String, dynamic> json) => Exposing(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Extension {
    Extension();

    factory Extension.fromJson(Map<String, dynamic> json) => Extension(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Extern {
    Extern();

    factory Extern.fromJson(Map<String, dynamic> json) => Extern(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Fallthrough {
    Fallthrough();

    factory Fallthrough.fromJson(Map<String, dynamic> json) => Fallthrough(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Fileprivate {
    Fileprivate();

    factory Fileprivate.fromJson(Map<String, dynamic> json) => Fileprivate(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Fixed {
    Fixed();

    factory Fixed.fromJson(Map<String, dynamic> json) => Fixed(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Float {
    Float();

    factory Float.fromJson(Map<String, dynamic> json) => Float(
    );

    Map<String, dynamic> toJson() => {
    };
}

class UnionBoolBool {
    UnionBoolBool();

    factory UnionBoolBool.fromJson(Map<String, dynamic> json) => UnionBoolBool(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Foreach {
    Foreach();

    factory Foreach.fromJson(Map<String, dynamic> json) => Foreach(
    );

    Map<String, dynamic> toJson() => {
    };
}

class FormatExceptionClass {
    FormatExceptionClass();

    factory FormatExceptionClass.fromJson(Map<String, dynamic> json) => FormatExceptionClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Friend {
    Friend();

    factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    );

    Map<String, dynamic> toJson() => {
    };
}

class From {
    From();

    factory From.fromJson(Map<String, dynamic> json) => From(
    );

    Map<String, dynamic> toJson() => {
    };
}

class FromDict {
    FromDict();

    factory FromDict.fromJson(Map<String, dynamic> json) => FromDict(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Func {
    Func();

    factory Func.fromJson(Map<String, dynamic> json) => Func(
    );

    Map<String, dynamic> toJson() => {
    };
}

class FunctionClass {
    FunctionClass();

    factory FunctionClass.fromJson(Map<String, dynamic> json) => FunctionClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Global {
    Global();

    factory Global.fromJson(Map<String, dynamic> json) => Global(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Go {
    Go();

    factory Go.fromJson(Map<String, dynamic> json) => Go(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Goto {
    Goto();

    factory Goto.fromJson(Map<String, dynamic> json) => Goto(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Guard {
    Guard();

    factory Guard.fromJson(Map<String, dynamic> json) => Guard(
    );

    Map<String, dynamic> toJson() => {
    };
}

class HasOwnProperty {
    HasOwnProperty();

    factory HasOwnProperty.fromJson(Map<String, dynamic> json) => HasOwnProperty(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Hashable {
    Hashable();

    factory Hashable.fromJson(Map<String, dynamic> json) => Hashable(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Hasher {
    Hasher();

    factory Hasher.fromJson(Map<String, dynamic> json) => Hasher(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Id {
    Id();

    factory Id.fromJson(Map<String, dynamic> json) => Id(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Imaginery {
    Imaginery();

    factory Imaginery.fromJson(Map<String, dynamic> json) => Imaginery(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Imp {
    Imp();

    factory Imp.fromJson(Map<String, dynamic> json) => Imp(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Implicit {
    Implicit();

    factory Implicit.fromJson(Map<String, dynamic> json) => Implicit(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Indirect {
    Indirect();

    factory Indirect.fromJson(Map<String, dynamic> json) => Indirect(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Infix {
    Infix();

    factory Infix.fromJson(Map<String, dynamic> json) => Infix(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Init {
    Init();

    factory Init.fromJson(Map<String, dynamic> json) => Init(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Inline {
    Inline();

    factory Inline.fromJson(Map<String, dynamic> json) => Inline(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Inout {
    Inout();

    factory Inout.fromJson(Map<String, dynamic> json) => Inout(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Instanceof {
    Instanceof();

    factory Instanceof.fromJson(Map<String, dynamic> json) => Instanceof(
    );

    Map<String, dynamic> toJson() => {
    };
}

class IntNode {
    IntNode();

    factory IntNode.fromJson(Map<String, dynamic> json) => IntNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Internal {
    Internal();

    factory Internal.fromJson(Map<String, dynamic> json) => Internal(
    );

    Map<String, dynamic> toJson() => {
    };
}

class IsoDateTimeOffsetConverter {
    IsoDateTimeOffsetConverter();

    factory IsoDateTimeOffsetConverter.fromJson(Map<String, dynamic> json) => IsoDateTimeOffsetConverter(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Iterable {
    Iterable();

    factory Iterable.fromJson(Map<String, dynamic> json) => Iterable(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Jdec {
    Jdec();

    factory Jdec.fromJson(Map<String, dynamic> json) => Jdec(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Jenc {
    Jenc();

    factory Jenc.fromJson(Map<String, dynamic> json) => Jenc(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Jpipe {
    Jpipe();

    factory Jpipe.fromJson(Map<String, dynamic> json) => Jpipe(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Json {
    Json();

    factory Json.fromJson(Map<String, dynamic> json) => Json(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonAny {
    JsonAny();

    factory JsonAny.fromJson(Map<String, dynamic> json) => JsonAny(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonCodingKey {
    JsonCodingKey();

    factory JsonCodingKey.fromJson(Map<String, dynamic> json) => JsonCodingKey(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonConverter {
    JsonConverter();

    factory JsonConverter.fromJson(Map<String, dynamic> json) => JsonConverter(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonDecoder {
    JsonDecoder();

    factory JsonDecoder.fromJson(Map<String, dynamic> json) => JsonDecoder(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonEncoder {
    JsonEncoder();

    factory JsonEncoder.fromJson(Map<String, dynamic> json) => JsonEncoder(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonException {
    JsonException();

    factory JsonException.fromJson(Map<String, dynamic> json) => JsonException(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonGenerator {
    JsonGenerator();

    factory JsonGenerator.fromJson(Map<String, dynamic> json) => JsonGenerator(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonNode {
    JsonNode();

    factory JsonNode.fromJson(Map<String, dynamic> json) => JsonNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonNull {
    JsonNull();

    factory JsonNull.fromJson(Map<String, dynamic> json) => JsonNull(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonParser {
    JsonParser();

    factory JsonParser.fromJson(Map<String, dynamic> json) => JsonParser(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonReader {
    JsonReader();

    factory JsonReader.fromJson(Map<String, dynamic> json) => JsonReader(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonSerializer {
    JsonSerializer();

    factory JsonSerializer.fromJson(Map<String, dynamic> json) => JsonSerializer(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonToken {
    JsonToken();

    factory JsonToken.fromJson(Map<String, dynamic> json) => JsonToken(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonTokenType {
    JsonTokenType();

    factory JsonTokenType.fromJson(Map<String, dynamic> json) => JsonTokenType(
    );

    Map<String, dynamic> toJson() => {
    };
}

class JsonWriter {
    JsonWriter();

    factory JsonWriter.fromJson(Map<String, dynamic> json) => JsonWriter(
    );

    Map<String, dynamic> toJson() => {
    };
}

class KSerializer {
    KSerializer();

    factory KSerializer.fromJson(Map<String, dynamic> json) => KSerializer(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Lambda {
    Lambda();

    factory Lambda.fromJson(Map<String, dynamic> json) => Lambda(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Lazy {
    Lazy();

    factory Lazy.fromJson(Map<String, dynamic> json) => Lazy(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Left {
    Left();

    factory Left.fromJson(Map<String, dynamic> json) => Left(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Let {
    Let();

    factory Let.fromJson(Map<String, dynamic> json) => Let(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ListClass {
    ListClass();

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class LocalDate {
    LocalDate();

    factory LocalDate.fromJson(Map<String, dynamic> json) => LocalDate(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Locale {
    Locale();

    factory Locale.fromJson(Map<String, dynamic> json) => Locale(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Lock {
    Lock();

    factory Lock.fromJson(Map<String, dynamic> json) => Lock(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Long {
    Long();

    factory Long.fromJson(Map<String, dynamic> json) => Long(
    );

    Map<String, dynamic> toJson() => {
    };
}

class LongNode {
    LongNode();

    factory LongNode.fromJson(Map<String, dynamic> json) => LongNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class MapClass {
    MapClass();

    factory MapClass.fromJson(Map<String, dynamic> json) => MapClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class MapEntryClass {
    MapEntryClass();

    factory MapEntryClass.fromJson(Map<String, dynamic> json) => MapEntryClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class MarshalJson {
    MarshalJson();

    factory MarshalJson.fromJson(Map<String, dynamic> json) => MarshalJson(
    );

    Map<String, dynamic> toJson() => {
    };
}

class MetadataPropertyHandling {
    MetadataPropertyHandling();

    factory MetadataPropertyHandling.fromJson(Map<String, dynamic> json) => MetadataPropertyHandling(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Module {
    Module();

    factory Module.fromJson(Map<String, dynamic> json) => Module(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Mutable {
    Mutable();

    factory Mutable.fromJson(Map<String, dynamic> json) => Mutable(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Mutating {
    Mutating();

    factory Mutating.fromJson(Map<String, dynamic> json) => Mutating(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Namespace {
    Namespace();

    factory Namespace.fromJson(Map<String, dynamic> json) => Namespace(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Native {
    Native();

    factory Native.fromJson(Map<String, dynamic> json) => Native(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Newtonsoft {
    Newtonsoft();

    factory Newtonsoft.fromJson(Map<String, dynamic> json) => Newtonsoft(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Nil {
    Nil();

    factory Nil.fromJson(Map<String, dynamic> json) => Nil(
    );

    Map<String, dynamic> toJson() => {
    };
}

class No {
    No();

    factory No.fromJson(Map<String, dynamic> json) => No(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Noexcept {
    Noexcept();

    factory Noexcept.fromJson(Map<String, dynamic> json) => Noexcept(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Nonatomic {
    Nonatomic();

    factory Nonatomic.fromJson(Map<String, dynamic> json) => Nonatomic(
    );

    Map<String, dynamic> toJson() => {
    };
}

class None {
    None();

    factory None.fromJson(Map<String, dynamic> json) => None(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Nonlocal {
    Nonlocal();

    factory Nonlocal.fromJson(Map<String, dynamic> json) => Nonlocal(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Nonmutating {
    Nonmutating();

    factory Nonmutating.fromJson(Map<String, dynamic> json) => Nonmutating(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Not {
    Not();

    factory Not.fromJson(Map<String, dynamic> json) => Not(
    );

    Map<String, dynamic> toJson() => {
    };
}

class NotEq {
    NotEq();

    factory NotEq.fromJson(Map<String, dynamic> json) => NotEq(
    );

    Map<String, dynamic> toJson() => {
    };
}

class NsError {
    NsError();

    factory NsError.fromJson(Map<String, dynamic> json) => NsError(
    );

    Map<String, dynamic> toJson() => {
    };
}

class NsObject {
    NsObject();

    factory NsObject.fromJson(Map<String, dynamic> json) => NsObject(
    );

    Map<String, dynamic> toJson() => {
    };
}

class NsString {
    NsString();

    factory NsString.fromJson(Map<String, dynamic> json) => NsString(
    );

    Map<String, dynamic> toJson() => {
    };
}

class NullNode {
    NullNode();

    factory NullNode.fromJson(Map<String, dynamic> json) => NullNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Nullptr {
    Nullptr();

    factory Nullptr.fromJson(Map<String, dynamic> json) => Nullptr(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Number {
    Number();

    factory Number.fromJson(Map<String, dynamic> json) => Number(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Object {
    Object();

    factory Object.fromJson(Map<String, dynamic> json) => Object(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ObjectMapper {
    ObjectMapper();

    factory ObjectMapper.fromJson(Map<String, dynamic> json) => ObjectMapper(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ObjectNode {
    ObjectNode();

    factory ObjectNode.fromJson(Map<String, dynamic> json) => ObjectNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ObjectReader {
    ObjectReader();

    factory ObjectReader.fromJson(Map<String, dynamic> json) => ObjectReader(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ObjectWriter {
    ObjectWriter();

    factory ObjectWriter.fromJson(Map<String, dynamic> json) => ObjectWriter(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Of {
    Of();

    factory Of.fromJson(Map<String, dynamic> json) => Of(
    );

    Map<String, dynamic> toJson() => {
    };
}

class OffsetDateTime {
    OffsetDateTime();

    factory OffsetDateTime.fromJson(Map<String, dynamic> json) => OffsetDateTime(
    );

    Map<String, dynamic> toJson() => {
    };
}

class OffsetTime {
    OffsetTime();

    factory OffsetTime.fromJson(Map<String, dynamic> json) => OffsetTime(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Oneway {
    Oneway();

    factory Oneway.fromJson(Map<String, dynamic> json) => Oneway(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Open {
    Open();

    factory Open.fromJson(Map<String, dynamic> json) => Open(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Optional {
    Optional();

    factory Optional.fromJson(Map<String, dynamic> json) => Optional(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Or {
    Or();

    factory Or.fromJson(Map<String, dynamic> json) => Or(
    );

    Map<String, dynamic> toJson() => {
    };
}

class OrEq {
    OrEq();

    factory OrEq.fromJson(Map<String, dynamic> json) => OrEq(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Out {
    Out();

    factory Out.fromJson(Map<String, dynamic> json) => Out(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Override {
    Override();

    factory Override.fromJson(Map<String, dynamic> json) => Override(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Package {
    Package();

    factory Package.fromJson(Map<String, dynamic> json) => Package(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Params {
    Params();

    factory Params.fromJson(Map<String, dynamic> json) => Params(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Pass {
    Pass();

    factory Pass.fromJson(Map<String, dynamic> json) => Pass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Port {
    Port();

    factory Port.fromJson(Map<String, dynamic> json) => Port(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Postfix {
    Postfix();

    factory Postfix.fromJson(Map<String, dynamic> json) => Postfix(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Precedence {
    Precedence();

    factory Precedence.fromJson(Map<String, dynamic> json) => Precedence(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Prefix {
    Prefix();

    factory Prefix.fromJson(Map<String, dynamic> json) => Prefix(
    );

    Map<String, dynamic> toJson() => {
    };
}

class PrimitiveKind {
    PrimitiveKind();

    factory PrimitiveKind.fromJson(Map<String, dynamic> json) => PrimitiveKind(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Print {
    Print();

    factory Print.fromJson(Map<String, dynamic> json) => Print(
    );

    Map<String, dynamic> toJson() => {
    };
}

class PrintMembers {
    PrintMembers();

    factory PrintMembers.fromJson(Map<String, dynamic> json) => PrintMembers(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Printf {
    Printf();

    factory Printf.fromJson(Map<String, dynamic> json) => Printf(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Private {
    Private();

    factory Private.fromJson(Map<String, dynamic> json) => Private(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Protected {
    Protected();

    factory Protected.fromJson(Map<String, dynamic> json) => Protected(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Protocol {
    Protocol();

    factory Protocol.fromJson(Map<String, dynamic> json) => Protocol(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Public {
    Public();

    factory Public.fromJson(Map<String, dynamic> json) => Public(
    );

    Map<String, dynamic> toJson() => {
    };
}

class BoolClass {
    BoolClass();

    factory BoolClass.fromJson(Map<String, dynamic> json) => BoolClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ClassClass {
    ClassClass();

    factory ClassClass.fromJson(Map<String, dynamic> json) => ClassClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class FalseClass {
    FalseClass();

    factory FalseClass.fromJson(Map<String, dynamic> json) => FalseClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class NullClass {
    NullClass();

    factory NullClass.fromJson(Map<String, dynamic> json) => NullClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class TrueClass {
    TrueClass();

    factory TrueClass.fromJson(Map<String, dynamic> json) => TrueClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Quicktype {
    Quicktype();

    factory Quicktype.fromJson(Map<String, dynamic> json) => Quicktype(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Raise {
    Raise();

    factory Raise.fromJson(Map<String, dynamic> json) => Raise(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Range {
    Range();

    factory Range.fromJson(Map<String, dynamic> json) => Range(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Readonly {
    Readonly();

    factory Readonly.fromJson(Map<String, dynamic> json) => Readonly(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Ref {
    Ref();

    factory Ref.fromJson(Map<String, dynamic> json) => Ref(
    );

    Map<String, dynamic> toJson() => {
    };
}

class RegExpClass {
    RegExpClass();

    factory RegExpClass.fromJson(Map<String, dynamic> json) => RegExpClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Register {
    Register();

    factory Register.fromJson(Map<String, dynamic> json) => Register(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ReinterpretCast {
    ReinterpretCast();

    factory ReinterpretCast.fromJson(Map<String, dynamic> json) => ReinterpretCast(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Repeat {
    Repeat();

    factory Repeat.fromJson(Map<String, dynamic> json) => Repeat(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Require {
    Require();

    factory Require.fromJson(Map<String, dynamic> json) => Require(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Required {
    Required();

    factory Required.fromJson(Map<String, dynamic> json) => Required(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Requires {
    Requires();

    factory Requires.fromJson(Map<String, dynamic> json) => Requires(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Restrict {
    Restrict();

    factory Restrict.fromJson(Map<String, dynamic> json) => Restrict(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Retain {
    Retain();

    factory Retain.fromJson(Map<String, dynamic> json) => Retain(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Rethrows {
    Rethrows();

    factory Rethrows.fromJson(Map<String, dynamic> json) => Rethrows(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Right {
    Right();

    factory Right.fromJson(Map<String, dynamic> json) => Right(
    );

    Map<String, dynamic> toJson() => {
    };
}

class S {
    S();

    factory S.fromJson(Map<String, dynamic> json) => S(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Sbyte {
    Sbyte();

    factory Sbyte.fromJson(Map<String, dynamic> json) => Sbyte(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Sealed {
    Sealed();

    factory Sealed.fromJson(Map<String, dynamic> json) => Sealed(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Sel {
    Sel();

    factory Sel.fromJson(Map<String, dynamic> json) => Sel(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Select {
    Select();

    factory Select.fromJson(Map<String, dynamic> json) => Select(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Self {
    Self();

    factory Self.fromJson(Map<String, dynamic> json) => Self(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Sendable {
    Sendable();

    factory Sendable.fromJson(Map<String, dynamic> json) => Sendable(
    );

    Map<String, dynamic> toJson() => {
    };
}

class SerialDescriptor {
    SerialDescriptor();

    factory SerialDescriptor.fromJson(Map<String, dynamic> json) => SerialDescriptor(
    );

    Map<String, dynamic> toJson() => {
    };
}

class SerialName {
    SerialName();

    factory SerialName.fromJson(Map<String, dynamic> json) => SerialName(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Serializable {
    Serializable();

    factory Serializable.fromJson(Map<String, dynamic> json) => Serializable(
    );

    Map<String, dynamic> toJson() => {
    };
}

class SerializationFeature {
    SerializationFeature();

    factory SerializationFeature.fromJson(Map<String, dynamic> json) => SerializationFeature(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Serialize {
    Serialize();

    factory Serialize.fromJson(Map<String, dynamic> json) => Serialize(
    );

    Map<String, dynamic> toJson() => {
    };
}

class SerializerProvider {
    SerializerProvider();

    factory SerializerProvider.fromJson(Map<String, dynamic> json) => SerializerProvider(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Short {
    Short();

    factory Short.fromJson(Map<String, dynamic> json) => Short(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Signed {
    Signed();

    factory Signed.fromJson(Map<String, dynamic> json) => Signed(
    );

    Map<String, dynamic> toJson() => {
    };
}

class SimpleModule {
    SimpleModule();

    factory SimpleModule.fromJson(Map<String, dynamic> json) => SimpleModule(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Sizeof {
    Sizeof();

    factory Sizeof.fromJson(Map<String, dynamic> json) => Sizeof(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Stackalloc {
    Stackalloc();

    factory Stackalloc.fromJson(Map<String, dynamic> json) => Stackalloc(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Standards {
    Standards();

    factory Standards.fromJson(Map<String, dynamic> json) => Standards(
    );

    Map<String, dynamic> toJson() => {
    };
}

class StaticAssert {
    StaticAssert();

    factory StaticAssert.fromJson(Map<String, dynamic> json) => StaticAssert(
    );

    Map<String, dynamic> toJson() => {
    };
}

class StaticCast {
    StaticCast();

    factory StaticCast.fromJson(Map<String, dynamic> json) => StaticCast(
    );

    Map<String, dynamic> toJson() => {
    };
}

class StdDeserializer {
    StdDeserializer();

    factory StdDeserializer.fromJson(Map<String, dynamic> json) => StdDeserializer(
    );

    Map<String, dynamic> toJson() => {
    };
}

class StdSerializer {
    StdSerializer();

    factory StdSerializer.fromJson(Map<String, dynamic> json) => StdSerializer(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Strictfp {
    Strictfp();

    factory Strictfp.fromJson(Map<String, dynamic> json) => Strictfp(
    );

    Map<String, dynamic> toJson() => {
    };
}

class StringClass {
    StringClass();

    factory StringClass.fromJson(Map<String, dynamic> json) => StringClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Struct {
    Struct();

    factory Struct.fromJson(Map<String, dynamic> json) => Struct(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Subscript {
    Subscript();

    factory Subscript.fromJson(Map<String, dynamic> json) => Subscript(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Symbol {
    Symbol();

    factory Symbol.fromJson(Map<String, dynamic> json) => Symbol(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Synchronized {
    Synchronized();

    factory Synchronized.fromJson(Map<String, dynamic> json) => Synchronized(
    );

    Map<String, dynamic> toJson() => {
    };
}

class System {
    System();

    factory System.fromJson(Map<String, dynamic> json) => System(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Template {
    Template();

    factory Template.fromJson(Map<String, dynamic> json) => Template(
    );

    Map<String, dynamic> toJson() => {
    };
}

class TextNode {
    TextNode();

    factory TextNode.fromJson(Map<String, dynamic> json) => TextNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Then {
    Then();

    factory Then.fromJson(Map<String, dynamic> json) => Then(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ThreadLocal {
    ThreadLocal();

    factory ThreadLocal.fromJson(Map<String, dynamic> json) => ThreadLocal(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Throws {
    Throws();

    factory Throws.fromJson(Map<String, dynamic> json) => Throws(
    );

    Map<String, dynamic> toJson() => {
    };
}

class TimeOnly {
    TimeOnly();

    factory TimeOnly.fromJson(Map<String, dynamic> json) => TimeOnly(
    );

    Map<String, dynamic> toJson() => {
    };
}

class TimeOnlyConverter {
    TimeOnlyConverter();

    factory TimeOnlyConverter.fromJson(Map<String, dynamic> json) => TimeOnlyConverter(
    );

    Map<String, dynamic> toJson() => {
    };
}

class TimeZone {
    TimeZone();

    factory TimeZone.fromJson(Map<String, dynamic> json) => TimeZone(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ToDict {
    ToDict();

    factory ToDict.fromJson(Map<String, dynamic> json) => ToDict(
    );

    Map<String, dynamic> toJson() => {
    };
}

class TopLevelClass {
    TopLevelClass();

    factory TopLevelClass.fromJson(Map<String, dynamic> json) => TopLevelClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Abstract {
    Abstract();

    factory Abstract.fromJson(Map<String, dynamic> json) => Abstract(
    );

    Map<String, dynamic> toJson() => {
    };
}

class AnyClass {
    AnyClass();

    factory AnyClass.fromJson(Map<String, dynamic> json) => AnyClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class As {
    As();

    factory As.fromJson(Map<String, dynamic> json) => As(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Assert {
    Assert();

    factory Assert.fromJson(Map<String, dynamic> json) => Assert(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Async {
    Async();

    factory Async.fromJson(Map<String, dynamic> json) => Async(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Await {
    Await();

    factory Await.fromJson(Map<String, dynamic> json) => Await(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Bool {
    Bool();

    factory Bool.fromJson(Map<String, dynamic> json) => Bool(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Break {
    Break();

    factory Break.fromJson(Map<String, dynamic> json) => Break(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Case {
    Case();

    factory Case.fromJson(Map<String, dynamic> json) => Case(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Catch {
    Catch();

    factory Catch.fromJson(Map<String, dynamic> json) => Catch(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Class {
    Class();

    factory Class.fromJson(Map<String, dynamic> json) => Class(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Const {
    Const();

    factory Const.fromJson(Map<String, dynamic> json) => Const(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Continue {
    Continue();

    factory Continue.fromJson(Map<String, dynamic> json) => Continue(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Default {
    Default();

    factory Default.fromJson(Map<String, dynamic> json) => Default(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Do {
    Do();

    factory Do.fromJson(Map<String, dynamic> json) => Do(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Double {
    Double();

    factory Double.fromJson(Map<String, dynamic> json) => Double(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Dynamic {
    Dynamic();

    factory Dynamic.fromJson(Map<String, dynamic> json) => Dynamic(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Else {
    Else();

    factory Else.fromJson(Map<String, dynamic> json) => Else(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Enum {
    Enum();

    factory Enum.fromJson(Map<String, dynamic> json) => Enum(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Export {
    Export();

    factory Export.fromJson(Map<String, dynamic> json) => Export(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Extends {
    Extends();

    factory Extends.fromJson(Map<String, dynamic> json) => Extends(
    );

    Map<String, dynamic> toJson() => {
    };
}

class False {
    False();

    factory False.fromJson(Map<String, dynamic> json) => False(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Final {
    Final();

    factory Final.fromJson(Map<String, dynamic> json) => Final(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Finally {
    Finally();

    factory Finally.fromJson(Map<String, dynamic> json) => Finally(
    );

    Map<String, dynamic> toJson() => {
    };
}

class For {
    For();

    factory For.fromJson(Map<String, dynamic> json) => For(
    );

    Map<String, dynamic> toJson() => {
    };
}

class FromJson {
    FromJson();

    factory FromJson.fromJson(Map<String, dynamic> json) => FromJson(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Get {
    Get();

    factory Get.fromJson(Map<String, dynamic> json) => Get(
    );

    Map<String, dynamic> toJson() => {
    };
}

class HashCode {
    HashCode();

    factory HashCode.fromJson(Map<String, dynamic> json) => HashCode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class If {
    If();

    factory If.fromJson(Map<String, dynamic> json) => If(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Implements {
    Implements();

    factory Implements.fromJson(Map<String, dynamic> json) => Implements(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Import {
    Import();

    factory Import.fromJson(Map<String, dynamic> json) => Import(
    );

    Map<String, dynamic> toJson() => {
    };
}

class In {
    In();

    factory In.fromJson(Map<String, dynamic> json) => In(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Int {
    Int();

    factory Int.fromJson(Map<String, dynamic> json) => Int(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Interface {
    Interface();

    factory Interface.fromJson(Map<String, dynamic> json) => Interface(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Is {
    Is();

    factory Is.fromJson(Map<String, dynamic> json) => Is(
    );

    Map<String, dynamic> toJson() => {
    };
}

class New {
    New();

    factory New.fromJson(Map<String, dynamic> json) => New(
    );

    Map<String, dynamic> toJson() => {
    };
}

class NoSuchMethod {
    NoSuchMethod();

    factory NoSuchMethod.fromJson(Map<String, dynamic> json) => NoSuchMethod(
    );

    Map<String, dynamic> toJson() => {
    };
}

class NoneClass {
    NoneClass();

    factory NoneClass.fromJson(Map<String, dynamic> json) => NoneClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Null {
    Null();

    factory Null.fromJson(Map<String, dynamic> json) => Null(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Operator {
    Operator();

    factory Operator.fromJson(Map<String, dynamic> json) => Operator(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ProtocolClass {
    ProtocolClass();

    factory ProtocolClass.fromJson(Map<String, dynamic> json) => ProtocolClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Return {
    Return();

    factory Return.fromJson(Map<String, dynamic> json) => Return(
    );

    Map<String, dynamic> toJson() => {
    };
}

class RuntimeType {
    RuntimeType();

    factory RuntimeType.fromJson(Map<String, dynamic> json) => RuntimeType(
    );

    Map<String, dynamic> toJson() => {
    };
}

class SelfClass {
    SelfClass();

    factory SelfClass.fromJson(Map<String, dynamic> json) => SelfClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Set {
    Set();

    factory Set.fromJson(Map<String, dynamic> json) => Set(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Static {
    Static();

    factory Static.fromJson(Map<String, dynamic> json) => Static(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Super {
    Super();

    factory Super.fromJson(Map<String, dynamic> json) => Super(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Switch {
    Switch();

    factory Switch.fromJson(Map<String, dynamic> json) => Switch(
    );

    Map<String, dynamic> toJson() => {
    };
}

class This {
    This();

    factory This.fromJson(Map<String, dynamic> json) => This(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Throw {
    Throw();

    factory Throw.fromJson(Map<String, dynamic> json) => Throw(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ToJson {
    ToJson();

    factory ToJson.fromJson(Map<String, dynamic> json) => ToJson(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ToString {
    ToString();

    factory ToString.fromJson(Map<String, dynamic> json) => ToString(
    );

    Map<String, dynamic> toJson() => {
    };
}

class True {
    True();

    factory True.fromJson(Map<String, dynamic> json) => True(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Try {
    Try();

    factory Try.fromJson(Map<String, dynamic> json) => Try(
    );

    Map<String, dynamic> toJson() => {
    };
}

class TypeClass {
    TypeClass();

    factory TypeClass.fromJson(Map<String, dynamic> json) => TypeClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Typedef {
    Typedef();

    factory Typedef.fromJson(Map<String, dynamic> json) => Typedef(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Var {
    Var();

    factory Var.fromJson(Map<String, dynamic> json) => Var(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Void {
    Void();

    factory Void.fromJson(Map<String, dynamic> json) => Void(
    );

    Map<String, dynamic> toJson() => {
    };
}

class While {
    While();

    factory While.fromJson(Map<String, dynamic> json) => While(
    );

    Map<String, dynamic> toJson() => {
    };
}

class With {
    With();

    factory With.fromJson(Map<String, dynamic> json) => With(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Yield {
    Yield();

    factory Yield.fromJson(Map<String, dynamic> json) => Yield(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Transient {
    Transient();

    factory Transient.fromJson(Map<String, dynamic> json) => Transient(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Type {
    Type();

    factory Type.fromJson(Map<String, dynamic> json) => Type(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Typealias {
    Typealias();

    factory Typealias.fromJson(Map<String, dynamic> json) => Typealias(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Typeid {
    Typeid();

    factory Typeid.fromJson(Map<String, dynamic> json) => Typeid(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Typename {
    Typename();

    factory Typename.fromJson(Map<String, dynamic> json) => Typename(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Typeof {
    Typeof();

    factory Typeof.fromJson(Map<String, dynamic> json) => Typeof(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Uint {
    Uint();

    factory Uint.fromJson(Map<String, dynamic> json) => Uint(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Ulong {
    Ulong();

    factory Ulong.fromJson(Map<String, dynamic> json) => Ulong(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Unchecked {
    Unchecked();

    factory Unchecked.fromJson(Map<String, dynamic> json) => Unchecked(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Undefined {
    Undefined();

    factory Undefined.fromJson(Map<String, dynamic> json) => Undefined(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Union {
    Union();

    factory Union.fromJson(Map<String, dynamic> json) => Union(
    );

    Map<String, dynamic> toJson() => {
    };
}

class UnmarshalJson {
    UnmarshalJson();

    factory UnmarshalJson.fromJson(Map<String, dynamic> json) => UnmarshalJson(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Unowned {
    Unowned();

    factory Unowned.fromJson(Map<String, dynamic> json) => Unowned(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Unsafe {
    Unsafe();

    factory Unsafe.fromJson(Map<String, dynamic> json) => Unsafe(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Unsigned {
    Unsigned();

    factory Unsigned.fromJson(Map<String, dynamic> json) => Unsigned(
    );

    Map<String, dynamic> toJson() => {
    };
}

class UseSerializers {
    UseSerializers();

    factory UseSerializers.fromJson(Map<String, dynamic> json) => UseSerializers(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Ushort {
    Ushort();

    factory Ushort.fromJson(Map<String, dynamic> json) => Ushort(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Using {
    Using();

    factory Using.fromJson(Map<String, dynamic> json) => Using(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Utf8JsonReader {
    Utf8JsonReader();

    factory Utf8JsonReader.fromJson(Map<String, dynamic> json) => Utf8JsonReader(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Utf8JsonWriter {
    Utf8JsonWriter();

    factory Utf8JsonWriter.fromJson(Map<String, dynamic> json) => Utf8JsonWriter(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Uuid {
    Uuid();

    factory Uuid.fromJson(Map<String, dynamic> json) => Uuid(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Virtual {
    Virtual();

    factory Virtual.fromJson(Map<String, dynamic> json) => Virtual(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Volatile {
    Volatile();

    factory Volatile.fromJson(Map<String, dynamic> json) => Volatile(
    );

    Map<String, dynamic> toJson() => {
    };
}

class WcharT {
    WcharT();

    factory WcharT.fromJson(Map<String, dynamic> json) => WcharT(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Weak {
    Weak();

    factory Weak.fromJson(Map<String, dynamic> json) => Weak(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Where {
    Where();

    factory Where.fromJson(Map<String, dynamic> json) => Where(
    );

    Map<String, dynamic> toJson() => {
    };
}

class WillSet {
    WillSet();

    factory WillSet.fromJson(Map<String, dynamic> json) => WillSet(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Xor {
    Xor();

    factory Xor.fromJson(Map<String, dynamic> json) => Xor(
    );

    Map<String, dynamic> toJson() => {
    };
}

class XorEq {
    XorEq();

    factory XorEq.fromJson(Map<String, dynamic> json) => XorEq(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Yes {
    Yes();

    factory Yes.fromJson(Map<String, dynamic> json) => Yes(
    );

    Map<String, dynamic> toJson() => {
    };
}
