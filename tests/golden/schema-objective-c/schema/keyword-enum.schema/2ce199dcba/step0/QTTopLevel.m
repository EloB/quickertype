#import "QTTopLevel.h"

#define λ(decl, expr) (^(decl) { return (expr); })

static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

@interface QTTopLevel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTEnum
+ (NSDictionary<NSString *, QTEnum *> *)values
{
    static NSDictionary<NSString *, QTEnum *> *values;
    return values = values ? values : @{
        @"_": [[QTEnum alloc] initWithValue:@"_"],
        @"_Bool": [[QTEnum alloc] initWithValue:@"_Bool"],
        @"_Complex": [[QTEnum alloc] initWithValue:@"_Complex"],
        @"_Imaginery": [[QTEnum alloc] initWithValue:@"_Imaginery"],
        @"abstract": [[QTEnum alloc] initWithValue:@"abstract"],
        @"alignas": [[QTEnum alloc] initWithValue:@"alignas"],
        @"alignof": [[QTEnum alloc] initWithValue:@"alignof"],
        @"and": [[QTEnum alloc] initWithValue:@"and"],
        @"and_eq": [[QTEnum alloc] initWithValue:@"and_eq"],
        @"any": [[QTEnum alloc] initWithValue:@"any"],
        @"Any": [[QTEnum alloc] initWithValue:@"Any"],
        @"ArrayNode": [[QTEnum alloc] initWithValue:@"ArrayNode"],
        @"array": [[QTEnum alloc] initWithValue:@"array"],
        @"as": [[QTEnum alloc] initWithValue:@"as"],
        @"asm": [[QTEnum alloc] initWithValue:@"asm"],
        @"assert": [[QTEnum alloc] initWithValue:@"assert"],
        @"associatedtype": [[QTEnum alloc] initWithValue:@"associatedtype"],
        @"associativity": [[QTEnum alloc] initWithValue:@"associativity"],
        @"async": [[QTEnum alloc] initWithValue:@"async"],
        @"atomic": [[QTEnum alloc] initWithValue:@"atomic"],
        @"atomic_cancel": [[QTEnum alloc] initWithValue:@"atomic_cancel"],
        @"atomic_commit": [[QTEnum alloc] initWithValue:@"atomic_commit"],
        @"atomic_noexcept": [[QTEnum alloc] initWithValue:@"atomic_noexcept"],
        @"auto": [[QTEnum alloc] initWithValue:@"auto"],
        @"await": [[QTEnum alloc] initWithValue:@"await"],
        @"base": [[QTEnum alloc] initWithValue:@"base"],
        @"bitand": [[QTEnum alloc] initWithValue:@"bitand"],
        @"bitor": [[QTEnum alloc] initWithValue:@"bitor"],
        @"BOOL": [[QTEnum alloc] initWithValue:@"BOOL"],
        @"bool": [[QTEnum alloc] initWithValue:@"bool"],
        @"boolean": [[QTEnum alloc] initWithValue:@"boolean"],
        @"BooleanNode": [[QTEnum alloc] initWithValue:@"BooleanNode"],
        @"break": [[QTEnum alloc] initWithValue:@"break"],
        @"bycopy": [[QTEnum alloc] initWithValue:@"bycopy"],
        @"byref": [[QTEnum alloc] initWithValue:@"byref"],
        @"byte": [[QTEnum alloc] initWithValue:@"byte"],
        @"Calendar": [[QTEnum alloc] initWithValue:@"Calendar"],
        @"case": [[QTEnum alloc] initWithValue:@"case"],
        @"catch": [[QTEnum alloc] initWithValue:@"catch"],
        @"chan": [[QTEnum alloc] initWithValue:@"chan"],
        @"char": [[QTEnum alloc] initWithValue:@"char"],
        @"char16_t": [[QTEnum alloc] initWithValue:@"char16_t"],
        @"char32_t": [[QTEnum alloc] initWithValue:@"char32_t"],
        @"checked": [[QTEnum alloc] initWithValue:@"checked"],
        @"class": [[QTEnum alloc] initWithValue:@"class"],
        @"Class": [[QTEnum alloc] initWithValue:@"Class"],
        @"clone": [[QTEnum alloc] initWithValue:@"clone"],
        @"co_await": [[QTEnum alloc] initWithValue:@"co_await"],
        @"co_return": [[QTEnum alloc] initWithValue:@"co_return"],
        @"co_yield": [[QTEnum alloc] initWithValue:@"co_yield"],
        @"Codable": [[QTEnum alloc] initWithValue:@"Codable"],
        @"CodingKey": [[QTEnum alloc] initWithValue:@"CodingKey"],
        @"CodingKeys": [[QTEnum alloc] initWithValue:@"CodingKeys"],
        @"compl": [[QTEnum alloc] initWithValue:@"compl"],
        @"concept": [[QTEnum alloc] initWithValue:@"concept"],
        @"console": [[QTEnum alloc] initWithValue:@"console"],
        @"const": [[QTEnum alloc] initWithValue:@"const"],
        @"const_cast": [[QTEnum alloc] initWithValue:@"const_cast"],
        @"constexpr": [[QTEnum alloc] initWithValue:@"constexpr"],
        @"constructor": [[QTEnum alloc] initWithValue:@"constructor"],
        @"continue": [[QTEnum alloc] initWithValue:@"continue"],
        @"convenience": [[QTEnum alloc] initWithValue:@"convenience"],
        @"convert": [[QTEnum alloc] initWithValue:@"convert"],
        @"converter": [[QTEnum alloc] initWithValue:@"converter"],
        @"CultureInfo": [[QTEnum alloc] initWithValue:@"CultureInfo"],
        @"date": [[QTEnum alloc] initWithValue:@"date"],
        @"date_parse_handling": [[QTEnum alloc] initWithValue:@"date_parse_handling"],
        @"DateFormatter": [[QTEnum alloc] initWithValue:@"DateFormatter"],
        @"DateOnly": [[QTEnum alloc] initWithValue:@"DateOnly"],
        @"DateOnlyConverter": [[QTEnum alloc] initWithValue:@"DateOnlyConverter"],
        @"DateTime": [[QTEnum alloc] initWithValue:@"DateTime"],
        @"DateTimeStyles": [[QTEnum alloc] initWithValue:@"DateTimeStyles"],
        @"debugger": [[QTEnum alloc] initWithValue:@"debugger"],
        @"decimal": [[QTEnum alloc] initWithValue:@"decimal"],
        @"declare": [[QTEnum alloc] initWithValue:@"declare"],
        @"DeserializationFeature": [[QTEnum alloc] initWithValue:@"DeserializationFeature"],
        @"decltype": [[QTEnum alloc] initWithValue:@"decltype"],
        @"decode_string": [[QTEnum alloc] initWithValue:@"decode_string"],
        @"Decoder": [[QTEnum alloc] initWithValue:@"Decoder"],
        @"DecodingError": [[QTEnum alloc] initWithValue:@"DecodingError"],
        @"def": [[QTEnum alloc] initWithValue:@"def"],
        @"default": [[QTEnum alloc] initWithValue:@"default"],
        @"defer": [[QTEnum alloc] initWithValue:@"defer"],
        @"deinit": [[QTEnum alloc] initWithValue:@"deinit"],
        @"del": [[QTEnum alloc] initWithValue:@"del"],
        @"delegate": [[QTEnum alloc] initWithValue:@"delegate"],
        @"delete": [[QTEnum alloc] initWithValue:@"delete"],
        @"dict": [[QTEnum alloc] initWithValue:@"dict"],
        @"dictionary": [[QTEnum alloc] initWithValue:@"dictionary"],
        @"didSet": [[QTEnum alloc] initWithValue:@"didSet"],
        @"do": [[QTEnum alloc] initWithValue:@"do"],
        @"double": [[QTEnum alloc] initWithValue:@"double"],
        @"DoubleNode": [[QTEnum alloc] initWithValue:@"DoubleNode"],
        @"dynamic": [[QTEnum alloc] initWithValue:@"dynamic"],
        @"dynamic_cast": [[QTEnum alloc] initWithValue:@"dynamic_cast"],
        @"elif": [[QTEnum alloc] initWithValue:@"elif"],
        @"else": [[QTEnum alloc] initWithValue:@"else"],
        @"encode_quick_type": [[QTEnum alloc] initWithValue:@"encode_quick_type"],
        @"Encoder": [[QTEnum alloc] initWithValue:@"Encoder"],
        @"enum": [[QTEnum alloc] initWithValue:@"enum"],
        @"EnumValues": [[QTEnum alloc] initWithValue:@"EnumValues"],
        @"Equatable": [[QTEnum alloc] initWithValue:@"Equatable"],
        @"equalityContract": [[QTEnum alloc] initWithValue:@"equalityContract"],
        @"event": [[QTEnum alloc] initWithValue:@"event"],
        @"except": [[QTEnum alloc] initWithValue:@"except"],
        @"exception": [[QTEnum alloc] initWithValue:@"exception"],
        @"explicit": [[QTEnum alloc] initWithValue:@"explicit"],
        @"export": [[QTEnum alloc] initWithValue:@"export"],
        @"exposing": [[QTEnum alloc] initWithValue:@"exposing"],
        @"extends": [[QTEnum alloc] initWithValue:@"extends"],
        @"extension": [[QTEnum alloc] initWithValue:@"extension"],
        @"extern": [[QTEnum alloc] initWithValue:@"extern"],
        @"fallthrough": [[QTEnum alloc] initWithValue:@"fallthrough"],
        @"false": [[QTEnum alloc] initWithValue:@"false"],
        @"False": [[QTEnum alloc] initWithValue:@"False"],
        @"fileprivate": [[QTEnum alloc] initWithValue:@"fileprivate"],
        @"final": [[QTEnum alloc] initWithValue:@"final"],
        @"finally": [[QTEnum alloc] initWithValue:@"finally"],
        @"fixed": [[QTEnum alloc] initWithValue:@"fixed"],
        @"float": [[QTEnum alloc] initWithValue:@"float"],
        @"for": [[QTEnum alloc] initWithValue:@"for"],
        @"foreach": [[QTEnum alloc] initWithValue:@"foreach"],
        @"FormatException": [[QTEnum alloc] initWithValue:@"FormatException"],
        @"friend": [[QTEnum alloc] initWithValue:@"friend"],
        @"from": [[QTEnum alloc] initWithValue:@"from"],
        @"from_dict": [[QTEnum alloc] initWithValue:@"from_dict"],
        @"from_json": [[QTEnum alloc] initWithValue:@"from_json"],
        @"func": [[QTEnum alloc] initWithValue:@"func"],
        @"function": [[QTEnum alloc] initWithValue:@"function"],
        @"get": [[QTEnum alloc] initWithValue:@"get"],
        @"global": [[QTEnum alloc] initWithValue:@"global"],
        @"go": [[QTEnum alloc] initWithValue:@"go"],
        @"goto": [[QTEnum alloc] initWithValue:@"goto"],
        @"guard": [[QTEnum alloc] initWithValue:@"guard"],
        @"Hashable": [[QTEnum alloc] initWithValue:@"Hashable"],
        @"hashCode": [[QTEnum alloc] initWithValue:@"hashCode"],
        @"Hasher": [[QTEnum alloc] initWithValue:@"Hasher"],
        @"hasOwnProperty": [[QTEnum alloc] initWithValue:@"hasOwnProperty"],
        @"id": [[QTEnum alloc] initWithValue:@"id"],
        @"if": [[QTEnum alloc] initWithValue:@"if"],
        @"IMP": [[QTEnum alloc] initWithValue:@"IMP"],
        @"implements": [[QTEnum alloc] initWithValue:@"implements"],
        @"implicit": [[QTEnum alloc] initWithValue:@"implicit"],
        @"import": [[QTEnum alloc] initWithValue:@"import"],
        @"in": [[QTEnum alloc] initWithValue:@"in"],
        @"indirect": [[QTEnum alloc] initWithValue:@"indirect"],
        @"infix": [[QTEnum alloc] initWithValue:@"infix"],
        @"init": [[QTEnum alloc] initWithValue:@"init"],
        @"inline": [[QTEnum alloc] initWithValue:@"inline"],
        @"inout": [[QTEnum alloc] initWithValue:@"inout"],
        @"instanceof": [[QTEnum alloc] initWithValue:@"instanceof"],
        @"int": [[QTEnum alloc] initWithValue:@"int"],
        @"IntNode": [[QTEnum alloc] initWithValue:@"IntNode"],
        @"interface": [[QTEnum alloc] initWithValue:@"interface"],
        @"internal": [[QTEnum alloc] initWithValue:@"internal"],
        @"IsoDateTimeOffsetConverter": [[QTEnum alloc] initWithValue:@"IsoDateTimeOffsetConverter"],
        @"iterable": [[QTEnum alloc] initWithValue:@"iterable"],
        @"is": [[QTEnum alloc] initWithValue:@"is"],
        @"jdec": [[QTEnum alloc] initWithValue:@"jdec"],
        @"jenc": [[QTEnum alloc] initWithValue:@"jenc"],
        @"jpipe": [[QTEnum alloc] initWithValue:@"jpipe"],
        @"json": [[QTEnum alloc] initWithValue:@"json"],
        @"json_converter": [[QTEnum alloc] initWithValue:@"json_converter"],
        @"json_serializer": [[QTEnum alloc] initWithValue:@"json_serializer"],
        @"json_token": [[QTEnum alloc] initWithValue:@"json_token"],
        @"json_writer": [[QTEnum alloc] initWithValue:@"json_writer"],
        @"JSONAny": [[QTEnum alloc] initWithValue:@"JSONAny"],
        @"JSONCodingKey": [[QTEnum alloc] initWithValue:@"JSONCodingKey"],
        @"JSONDecoder": [[QTEnum alloc] initWithValue:@"JSONDecoder"],
        @"JSONEncoder": [[QTEnum alloc] initWithValue:@"JSONEncoder"],
        @"JsonException": [[QTEnum alloc] initWithValue:@"JsonException"],
        @"JsonGenerator": [[QTEnum alloc] initWithValue:@"JsonGenerator"],
        @"JsonNode": [[QTEnum alloc] initWithValue:@"JsonNode"],
        @"JSONNull": [[QTEnum alloc] initWithValue:@"JSONNull"],
        @"JsonParser": [[QTEnum alloc] initWithValue:@"JsonParser"],
        @"JsonReader": [[QTEnum alloc] initWithValue:@"JsonReader"],
        @"JsonTokenType": [[QTEnum alloc] initWithValue:@"JsonTokenType"],
        @"lambda": [[QTEnum alloc] initWithValue:@"lambda"],
        @"lazy": [[QTEnum alloc] initWithValue:@"lazy"],
        @"left": [[QTEnum alloc] initWithValue:@"left"],
        @"let": [[QTEnum alloc] initWithValue:@"let"],
        @"list": [[QTEnum alloc] initWithValue:@"list"],
        @"LocalDate": [[QTEnum alloc] initWithValue:@"LocalDate"],
        @"LongNode": [[QTEnum alloc] initWithValue:@"LongNode"],
        @"Locale": [[QTEnum alloc] initWithValue:@"Locale"],
        @"lock": [[QTEnum alloc] initWithValue:@"lock"],
        @"long": [[QTEnum alloc] initWithValue:@"long"],
        @"map": [[QTEnum alloc] initWithValue:@"map"],
        @"MarshalJSON": [[QTEnum alloc] initWithValue:@"MarshalJSON"],
        @"MapEntry": [[QTEnum alloc] initWithValue:@"MapEntry"],
        @"metadata_property_handling": [[QTEnum alloc] initWithValue:@"metadata_property_handling"],
        @"module": [[QTEnum alloc] initWithValue:@"module"],
        @"mutable": [[QTEnum alloc] initWithValue:@"mutable"],
        @"mutating": [[QTEnum alloc] initWithValue:@"mutating"],
        @"namespace": [[QTEnum alloc] initWithValue:@"namespace"],
        @"native": [[QTEnum alloc] initWithValue:@"native"],
        @"new": [[QTEnum alloc] initWithValue:@"new"],
        @"newtonsoft": [[QTEnum alloc] initWithValue:@"newtonsoft"],
        @"nil": [[QTEnum alloc] initWithValue:@"nil"],
        @"NullNode": [[QTEnum alloc] initWithValue:@"NullNode"],
        @"NO": [[QTEnum alloc] initWithValue:@"NO"],
        @"noexcept": [[QTEnum alloc] initWithValue:@"noexcept"],
        @"nonatomic": [[QTEnum alloc] initWithValue:@"nonatomic"],
        @"none": [[QTEnum alloc] initWithValue:@"none"],
        @"None": [[QTEnum alloc] initWithValue:@"None"],
        @"nonlocal": [[QTEnum alloc] initWithValue:@"nonlocal"],
        @"nonmutating": [[QTEnum alloc] initWithValue:@"nonmutating"],
        @"NSObject": [[QTEnum alloc] initWithValue:@"NSObject"],
        @"noSuchMethod": [[QTEnum alloc] initWithValue:@"noSuchMethod"],
        @"not": [[QTEnum alloc] initWithValue:@"not"],
        @"not_eq": [[QTEnum alloc] initWithValue:@"not_eq"],
        @"NSError": [[QTEnum alloc] initWithValue:@"NSError"],
        @"NSString": [[QTEnum alloc] initWithValue:@"NSString"],
        @"NULL": [[QTEnum alloc] initWithValue:@"NULL"],
        @"null": [[QTEnum alloc] initWithValue:@"null"],
        @"nullptr": [[QTEnum alloc] initWithValue:@"nullptr"],
        @"number": [[QTEnum alloc] initWithValue:@"number"],
        @"object": [[QTEnum alloc] initWithValue:@"object"],
        @"OffsetDateTime": [[QTEnum alloc] initWithValue:@"OffsetDateTime"],
        @"OffsetTime": [[QTEnum alloc] initWithValue:@"OffsetTime"],
        @"ObjectNode": [[QTEnum alloc] initWithValue:@"ObjectNode"],
        @"ObjectMapper": [[QTEnum alloc] initWithValue:@"ObjectMapper"],
        @"ObjectReader": [[QTEnum alloc] initWithValue:@"ObjectReader"],
        @"ObjectWriter": [[QTEnum alloc] initWithValue:@"ObjectWriter"],
        @"of": [[QTEnum alloc] initWithValue:@"of"],
        @"oneway": [[QTEnum alloc] initWithValue:@"oneway"],
        @"open": [[QTEnum alloc] initWithValue:@"open"],
        @"operator": [[QTEnum alloc] initWithValue:@"operator"],
        @"optional": [[QTEnum alloc] initWithValue:@"optional"],
        @"or": [[QTEnum alloc] initWithValue:@"or"],
        @"or_eq": [[QTEnum alloc] initWithValue:@"or_eq"],
        @"out": [[QTEnum alloc] initWithValue:@"out"],
        @"override": [[QTEnum alloc] initWithValue:@"override"],
        @"package": [[QTEnum alloc] initWithValue:@"package"],
        @"params": [[QTEnum alloc] initWithValue:@"params"],
        @"pass": [[QTEnum alloc] initWithValue:@"pass"],
        @"port": [[QTEnum alloc] initWithValue:@"port"],
        @"postfix": [[QTEnum alloc] initWithValue:@"postfix"],
        @"precedence": [[QTEnum alloc] initWithValue:@"precedence"],
        @"prefix": [[QTEnum alloc] initWithValue:@"prefix"],
        @"print": [[QTEnum alloc] initWithValue:@"print"],
        @"printf": [[QTEnum alloc] initWithValue:@"printf"],
        @"printMembers": [[QTEnum alloc] initWithValue:@"printMembers"],
        @"private": [[QTEnum alloc] initWithValue:@"private"],
        @"protected": [[QTEnum alloc] initWithValue:@"protected"],
        @"Protocol": [[QTEnum alloc] initWithValue:@"Protocol"],
        @"protocol": [[QTEnum alloc] initWithValue:@"protocol"],
        @"public": [[QTEnum alloc] initWithValue:@"public"],
        @"quicktype": [[QTEnum alloc] initWithValue:@"quicktype"],
        @"raise": [[QTEnum alloc] initWithValue:@"raise"],
        @"range": [[QTEnum alloc] initWithValue:@"range"],
        @"readonly": [[QTEnum alloc] initWithValue:@"readonly"],
        @"ref": [[QTEnum alloc] initWithValue:@"ref"],
        @"RegExp": [[QTEnum alloc] initWithValue:@"RegExp"],
        @"register": [[QTEnum alloc] initWithValue:@"register"],
        @"reinterpret_cast": [[QTEnum alloc] initWithValue:@"reinterpret_cast"],
        @"repeat": [[QTEnum alloc] initWithValue:@"repeat"],
        @"require": [[QTEnum alloc] initWithValue:@"require"],
        @"required": [[QTEnum alloc] initWithValue:@"required"],
        @"requires": [[QTEnum alloc] initWithValue:@"requires"],
        @"restrict": [[QTEnum alloc] initWithValue:@"restrict"],
        @"retain": [[QTEnum alloc] initWithValue:@"retain"],
        @"rethrows": [[QTEnum alloc] initWithValue:@"rethrows"],
        @"return": [[QTEnum alloc] initWithValue:@"return"],
        @"right": [[QTEnum alloc] initWithValue:@"right"],
        @"runtimeType": [[QTEnum alloc] initWithValue:@"runtimeType"],
        @"s": [[QTEnum alloc] initWithValue:@"s"],
        @"sbyte": [[QTEnum alloc] initWithValue:@"sbyte"],
        @"sealed": [[QTEnum alloc] initWithValue:@"sealed"],
        @"SEL": [[QTEnum alloc] initWithValue:@"SEL"],
        @"select": [[QTEnum alloc] initWithValue:@"select"],
        @"Self": [[QTEnum alloc] initWithValue:@"Self"],
        @"Serializable": [[QTEnum alloc] initWithValue:@"Serializable"],
        @"self": [[QTEnum alloc] initWithValue:@"self"],
        @"Sendable": [[QTEnum alloc] initWithValue:@"Sendable"],
        @"serialize": [[QTEnum alloc] initWithValue:@"serialize"],
        @"SerialName": [[QTEnum alloc] initWithValue:@"SerialName"],
        @"KSerializer": [[QTEnum alloc] initWithValue:@"KSerializer"],
        @"PrimitiveKind": [[QTEnum alloc] initWithValue:@"PrimitiveKind"],
        @"SerialDescriptor": [[QTEnum alloc] initWithValue:@"SerialDescriptor"],
        @"SerializationFeature": [[QTEnum alloc] initWithValue:@"SerializationFeature"],
        @"SerializerProvider": [[QTEnum alloc] initWithValue:@"SerializerProvider"],
        @"set": [[QTEnum alloc] initWithValue:@"set"],
        @"short": [[QTEnum alloc] initWithValue:@"short"],
        @"signed": [[QTEnum alloc] initWithValue:@"signed"],
        @"SimpleModule": [[QTEnum alloc] initWithValue:@"SimpleModule"],
        @"sizeof": [[QTEnum alloc] initWithValue:@"sizeof"],
        @"stackalloc": [[QTEnum alloc] initWithValue:@"stackalloc"],
        @"Standards": [[QTEnum alloc] initWithValue:@"Standards"],
        @"static": [[QTEnum alloc] initWithValue:@"static"],
        @"static_assert": [[QTEnum alloc] initWithValue:@"static_assert"],
        @"static_cast": [[QTEnum alloc] initWithValue:@"static_cast"],
        @"StdDeserializer": [[QTEnum alloc] initWithValue:@"StdDeserializer"],
        @"StdSerializer": [[QTEnum alloc] initWithValue:@"StdSerializer"],
        @"strictfp": [[QTEnum alloc] initWithValue:@"strictfp"],
        @"string": [[QTEnum alloc] initWithValue:@"string"],
        @"struct": [[QTEnum alloc] initWithValue:@"struct"],
        @"subscript": [[QTEnum alloc] initWithValue:@"subscript"],
        @"super": [[QTEnum alloc] initWithValue:@"super"],
        @"switch": [[QTEnum alloc] initWithValue:@"switch"],
        @"symbol": [[QTEnum alloc] initWithValue:@"symbol"],
        @"synchronized": [[QTEnum alloc] initWithValue:@"synchronized"],
        @"system": [[QTEnum alloc] initWithValue:@"system"],
        @"template": [[QTEnum alloc] initWithValue:@"template"],
        @"then": [[QTEnum alloc] initWithValue:@"then"],
        @"this": [[QTEnum alloc] initWithValue:@"this"],
        @"TextNode": [[QTEnum alloc] initWithValue:@"TextNode"],
        @"thread_local": [[QTEnum alloc] initWithValue:@"thread_local"],
        @"throw": [[QTEnum alloc] initWithValue:@"throw"],
        @"throws": [[QTEnum alloc] initWithValue:@"throws"],
        @"TimeOnly": [[QTEnum alloc] initWithValue:@"TimeOnly"],
        @"TimeOnlyConverter": [[QTEnum alloc] initWithValue:@"TimeOnlyConverter"],
        @"TimeZone": [[QTEnum alloc] initWithValue:@"TimeZone"],
        @"to_json": [[QTEnum alloc] initWithValue:@"to_json"],
        @"top_level": [[QTEnum alloc] initWithValue:@"top_level"],
        @"toString": [[QTEnum alloc] initWithValue:@"toString"],
        @"to_dict": [[QTEnum alloc] initWithValue:@"to_dict"],
        @"transient": [[QTEnum alloc] initWithValue:@"transient"],
        @"True": [[QTEnum alloc] initWithValue:@"True"],
        @"true": [[QTEnum alloc] initWithValue:@"true"],
        @"try": [[QTEnum alloc] initWithValue:@"try"],
        @"Type": [[QTEnum alloc] initWithValue:@"Type"],
        @"type": [[QTEnum alloc] initWithValue:@"type"],
        @"typealias": [[QTEnum alloc] initWithValue:@"typealias"],
        @"typedef": [[QTEnum alloc] initWithValue:@"typedef"],
        @"typeid": [[QTEnum alloc] initWithValue:@"typeid"],
        @"typename": [[QTEnum alloc] initWithValue:@"typename"],
        @"typeof": [[QTEnum alloc] initWithValue:@"typeof"],
        @"uint": [[QTEnum alloc] initWithValue:@"uint"],
        @"ulong": [[QTEnum alloc] initWithValue:@"ulong"],
        @"unchecked": [[QTEnum alloc] initWithValue:@"unchecked"],
        @"undefined": [[QTEnum alloc] initWithValue:@"undefined"],
        @"union": [[QTEnum alloc] initWithValue:@"union"],
        @"UnmarshalJSON": [[QTEnum alloc] initWithValue:@"UnmarshalJSON"],
        @"UseSerializers": [[QTEnum alloc] initWithValue:@"UseSerializers"],
        @"unowned": [[QTEnum alloc] initWithValue:@"unowned"],
        @"unsafe": [[QTEnum alloc] initWithValue:@"unsafe"],
        @"unsigned": [[QTEnum alloc] initWithValue:@"unsigned"],
        @"ushort": [[QTEnum alloc] initWithValue:@"ushort"],
        @"using": [[QTEnum alloc] initWithValue:@"using"],
        @"Utf8JsonReader": [[QTEnum alloc] initWithValue:@"Utf8JsonReader"],
        @"Utf8JsonWriter": [[QTEnum alloc] initWithValue:@"Utf8JsonWriter"],
        @"UUID": [[QTEnum alloc] initWithValue:@"UUID"],
        @"var": [[QTEnum alloc] initWithValue:@"var"],
        @"virtual": [[QTEnum alloc] initWithValue:@"virtual"],
        @"void": [[QTEnum alloc] initWithValue:@"void"],
        @"volatile": [[QTEnum alloc] initWithValue:@"volatile"],
        @"wchar_t": [[QTEnum alloc] initWithValue:@"wchar_t"],
        @"weak": [[QTEnum alloc] initWithValue:@"weak"],
        @"where": [[QTEnum alloc] initWithValue:@"where"],
        @"while": [[QTEnum alloc] initWithValue:@"while"],
        @"willSet": [[QTEnum alloc] initWithValue:@"willSet"],
        @"with": [[QTEnum alloc] initWithValue:@"with"],
        @"xor": [[QTEnum alloc] initWithValue:@"xor"],
        @"xor_eq": [[QTEnum alloc] initWithValue:@"xor_eq"],
        @"YES": [[QTEnum alloc] initWithValue:@"YES"],
        @"yield": [[QTEnum alloc] initWithValue:@"yield"],
        @"dummy": [[QTEnum alloc] initWithValue:@"dummy"],
    };
}

+ (QTEnum *)empty { return QTEnum.values[@"_"]; }
+ (QTEnum *)enumBool { return QTEnum.values[@"_Bool"]; }
+ (QTEnum *)complex { return QTEnum.values[@"_Complex"]; }
+ (QTEnum *)imaginery { return QTEnum.values[@"_Imaginery"]; }
+ (QTEnum *)abstract { return QTEnum.values[@"abstract"]; }
+ (QTEnum *)alignas { return QTEnum.values[@"alignas"]; }
+ (QTEnum *)alignof { return QTEnum.values[@"alignof"]; }
+ (QTEnum *)and { return QTEnum.values[@"and"]; }
+ (QTEnum *)andEq { return QTEnum.values[@"and_eq"]; }
+ (QTEnum *)any { return QTEnum.values[@"any"]; }
+ (QTEnum *)enumAny { return QTEnum.values[@"Any"]; }
+ (QTEnum *)arrayNode { return QTEnum.values[@"ArrayNode"]; }
+ (QTEnum *)array { return QTEnum.values[@"array"]; }
+ (QTEnum *)as { return QTEnum.values[@"as"]; }
+ (QTEnum *)enumASM { return QTEnum.values[@"asm"]; }
+ (QTEnum *)assert { return QTEnum.values[@"assert"]; }
+ (QTEnum *)associatedtype { return QTEnum.values[@"associatedtype"]; }
+ (QTEnum *)associativity { return QTEnum.values[@"associativity"]; }
+ (QTEnum *)async { return QTEnum.values[@"async"]; }
+ (QTEnum *)enumAtomic { return QTEnum.values[@"atomic"]; }
+ (QTEnum *)atomicCancel { return QTEnum.values[@"atomic_cancel"]; }
+ (QTEnum *)atomicCommit { return QTEnum.values[@"atomic_commit"]; }
+ (QTEnum *)atomicNoexcept { return QTEnum.values[@"atomic_noexcept"]; }
+ (QTEnum *)enumAuto { return QTEnum.values[@"auto"]; }
+ (QTEnum *)await { return QTEnum.values[@"await"]; }
+ (QTEnum *)base { return QTEnum.values[@"base"]; }
+ (QTEnum *)bitand { return QTEnum.values[@"bitand"]; }
+ (QTEnum *)bitor { return QTEnum.values[@"bitor"]; }
+ (QTEnum *)enumBOOL { return QTEnum.values[@"BOOL"]; }
+ (QTEnum *)bool1 { return QTEnum.values[@"bool"]; }
+ (QTEnum *)boolean { return QTEnum.values[@"boolean"]; }
+ (QTEnum *)booleanNode { return QTEnum.values[@"BooleanNode"]; }
+ (QTEnum *)enumBreak { return QTEnum.values[@"break"]; }
+ (QTEnum *)bycopy { return QTEnum.values[@"bycopy"]; }
+ (QTEnum *)byref { return QTEnum.values[@"byref"]; }
+ (QTEnum *)byte { return QTEnum.values[@"byte"]; }
+ (QTEnum *)calendar { return QTEnum.values[@"Calendar"]; }
+ (QTEnum *)enumCase { return QTEnum.values[@"case"]; }
+ (QTEnum *)catch { return QTEnum.values[@"catch"]; }
+ (QTEnum *)chan { return QTEnum.values[@"chan"]; }
+ (QTEnum *)enumChar { return QTEnum.values[@"char"]; }
+ (QTEnum *)char16T { return QTEnum.values[@"char16_t"]; }
+ (QTEnum *)char32T { return QTEnum.values[@"char32_t"]; }
+ (QTEnum *)checked { return QTEnum.values[@"checked"]; }
+ (QTEnum *)class { return QTEnum.values[@"class"]; }
+ (QTEnum *)enumClass { return QTEnum.values[@"Class"]; }
+ (QTEnum *)clone { return QTEnum.values[@"clone"]; }
+ (QTEnum *)coAwait { return QTEnum.values[@"co_await"]; }
+ (QTEnum *)coReturn { return QTEnum.values[@"co_return"]; }
+ (QTEnum *)coYield { return QTEnum.values[@"co_yield"]; }
+ (QTEnum *)codable { return QTEnum.values[@"Codable"]; }
+ (QTEnum *)codingKey { return QTEnum.values[@"CodingKey"]; }
+ (QTEnum *)codingKeys { return QTEnum.values[@"CodingKeys"]; }
+ (QTEnum *)compl { return QTEnum.values[@"compl"]; }
+ (QTEnum *)concept { return QTEnum.values[@"concept"]; }
+ (QTEnum *)console { return QTEnum.values[@"console"]; }
+ (QTEnum *)enumConst { return QTEnum.values[@"const"]; }
+ (QTEnum *)constCast { return QTEnum.values[@"const_cast"]; }
+ (QTEnum *)constexpr { return QTEnum.values[@"constexpr"]; }
+ (QTEnum *)constructor { return QTEnum.values[@"constructor"]; }
+ (QTEnum *)enumContinue { return QTEnum.values[@"continue"]; }
+ (QTEnum *)convenience { return QTEnum.values[@"convenience"]; }
+ (QTEnum *)convert { return QTEnum.values[@"convert"]; }
+ (QTEnum *)converter { return QTEnum.values[@"converter"]; }
+ (QTEnum *)cultureInfo { return QTEnum.values[@"CultureInfo"]; }
+ (QTEnum *)date { return QTEnum.values[@"date"]; }
+ (QTEnum *)dateParseHandling { return QTEnum.values[@"date_parse_handling"]; }
+ (QTEnum *)dateFormatter { return QTEnum.values[@"DateFormatter"]; }
+ (QTEnum *)dateOnly { return QTEnum.values[@"DateOnly"]; }
+ (QTEnum *)dateOnlyConverter { return QTEnum.values[@"DateOnlyConverter"]; }
+ (QTEnum *)dateTime { return QTEnum.values[@"DateTime"]; }
+ (QTEnum *)dateTimeStyles { return QTEnum.values[@"DateTimeStyles"]; }
+ (QTEnum *)debugger { return QTEnum.values[@"debugger"]; }
+ (QTEnum *)decimal { return QTEnum.values[@"decimal"]; }
+ (QTEnum *)declare { return QTEnum.values[@"declare"]; }
+ (QTEnum *)deserializationFeature { return QTEnum.values[@"DeserializationFeature"]; }
+ (QTEnum *)decltype { return QTEnum.values[@"decltype"]; }
+ (QTEnum *)decodeString { return QTEnum.values[@"decode_string"]; }
+ (QTEnum *)decoder { return QTEnum.values[@"Decoder"]; }
+ (QTEnum *)decodingError { return QTEnum.values[@"DecodingError"]; }
+ (QTEnum *)def { return QTEnum.values[@"def"]; }
+ (QTEnum *)enumDefault { return QTEnum.values[@"default"]; }
+ (QTEnum *)defer { return QTEnum.values[@"defer"]; }
+ (QTEnum *)deinit { return QTEnum.values[@"deinit"]; }
+ (QTEnum *)del { return QTEnum.values[@"del"]; }
+ (QTEnum *)delegate { return QTEnum.values[@"delegate"]; }
+ (QTEnum *)delete { return QTEnum.values[@"delete"]; }
+ (QTEnum *)dict { return QTEnum.values[@"dict"]; }
+ (QTEnum *)dictionary { return QTEnum.values[@"dictionary"]; }
+ (QTEnum *)didSet { return QTEnum.values[@"didSet"]; }
+ (QTEnum *)enumDo { return QTEnum.values[@"do"]; }
+ (QTEnum *)enumDouble { return QTEnum.values[@"double"]; }
+ (QTEnum *)doubleNode { return QTEnum.values[@"DoubleNode"]; }
+ (QTEnum *)dynamic { return QTEnum.values[@"dynamic"]; }
+ (QTEnum *)dynamicCast { return QTEnum.values[@"dynamic_cast"]; }
+ (QTEnum *)elif { return QTEnum.values[@"elif"]; }
+ (QTEnum *)enumElse { return QTEnum.values[@"else"]; }
+ (QTEnum *)encodeQuickType { return QTEnum.values[@"encode_quick_type"]; }
+ (QTEnum *)encoder { return QTEnum.values[@"Encoder"]; }
+ (QTEnum *)enumEnum { return QTEnum.values[@"enum"]; }
+ (QTEnum *)enumValues { return QTEnum.values[@"EnumValues"]; }
+ (QTEnum *)equatable { return QTEnum.values[@"Equatable"]; }
+ (QTEnum *)equalityContract { return QTEnum.values[@"equalityContract"]; }
+ (QTEnum *)event { return QTEnum.values[@"event"]; }
+ (QTEnum *)except { return QTEnum.values[@"except"]; }
+ (QTEnum *)exception { return QTEnum.values[@"exception"]; }
+ (QTEnum *)explicit { return QTEnum.values[@"explicit"]; }
+ (QTEnum *)export { return QTEnum.values[@"export"]; }
+ (QTEnum *)exposing { return QTEnum.values[@"exposing"]; }
+ (QTEnum *)extends { return QTEnum.values[@"extends"]; }
+ (QTEnum *)extension { return QTEnum.values[@"extension"]; }
+ (QTEnum *)enumExtern { return QTEnum.values[@"extern"]; }
+ (QTEnum *)fallthrough { return QTEnum.values[@"fallthrough"]; }
+ (QTEnum *)enumFalse { return QTEnum.values[@"false"]; }
+ (QTEnum *)false1 { return QTEnum.values[@"False"]; }
+ (QTEnum *)fileprivate { return QTEnum.values[@"fileprivate"]; }
+ (QTEnum *)final { return QTEnum.values[@"final"]; }
+ (QTEnum *)finally { return QTEnum.values[@"finally"]; }
+ (QTEnum *)fixed { return QTEnum.values[@"fixed"]; }
+ (QTEnum *)enumFloat { return QTEnum.values[@"float"]; }
+ (QTEnum *)enumFor { return QTEnum.values[@"for"]; }
+ (QTEnum *)foreach { return QTEnum.values[@"foreach"]; }
+ (QTEnum *)formatException { return QTEnum.values[@"FormatException"]; }
+ (QTEnum *)friend { return QTEnum.values[@"friend"]; }
+ (QTEnum *)from { return QTEnum.values[@"from"]; }
+ (QTEnum *)fromDict { return QTEnum.values[@"from_dict"]; }
+ (QTEnum *)fromJSON { return QTEnum.values[@"from_json"]; }
+ (QTEnum *)func { return QTEnum.values[@"func"]; }
+ (QTEnum *)function { return QTEnum.values[@"function"]; }
+ (QTEnum *)get { return QTEnum.values[@"get"]; }
+ (QTEnum *)global { return QTEnum.values[@"global"]; }
+ (QTEnum *)go { return QTEnum.values[@"go"]; }
+ (QTEnum *)enumGoto { return QTEnum.values[@"goto"]; }
+ (QTEnum *)guard { return QTEnum.values[@"guard"]; }
+ (QTEnum *)hashable { return QTEnum.values[@"Hashable"]; }
+ (QTEnum *)theHashCode { return QTEnum.values[@"hashCode"]; }
+ (QTEnum *)hasher { return QTEnum.values[@"Hasher"]; }
+ (QTEnum *)hasOwnProperty { return QTEnum.values[@"hasOwnProperty"]; }
+ (QTEnum *)identifier { return QTEnum.values[@"id"]; }
+ (QTEnum *)enumIf { return QTEnum.values[@"if"]; }
+ (QTEnum *)imp { return QTEnum.values[@"IMP"]; }
+ (QTEnum *)implements { return QTEnum.values[@"implements"]; }
+ (QTEnum *)implicit { return QTEnum.values[@"implicit"]; }
+ (QTEnum *)import { return QTEnum.values[@"import"]; }
+ (QTEnum *)in { return QTEnum.values[@"in"]; }
+ (QTEnum *)indirect { return QTEnum.values[@"indirect"]; }
+ (QTEnum *)infix { return QTEnum.values[@"infix"]; }
+ (QTEnum *)theInit { return QTEnum.values[@"init"]; }
+ (QTEnum *)enumInline { return QTEnum.values[@"inline"]; }
+ (QTEnum *)inout { return QTEnum.values[@"inout"]; }
+ (QTEnum *)instanceof { return QTEnum.values[@"instanceof"]; }
+ (QTEnum *)enumInt { return QTEnum.values[@"int"]; }
+ (QTEnum *)intNode { return QTEnum.values[@"IntNode"]; }
+ (QTEnum *)interface { return QTEnum.values[@"interface"]; }
+ (QTEnum *)internal { return QTEnum.values[@"internal"]; }
+ (QTEnum *)isoDateTimeOffsetConverter { return QTEnum.values[@"IsoDateTimeOffsetConverter"]; }
+ (QTEnum *)iterable { return QTEnum.values[@"iterable"]; }
+ (QTEnum *)is { return QTEnum.values[@"is"]; }
+ (QTEnum *)jdec { return QTEnum.values[@"jdec"]; }
+ (QTEnum *)jenc { return QTEnum.values[@"jenc"]; }
+ (QTEnum *)jpipe { return QTEnum.values[@"jpipe"]; }
+ (QTEnum *)json { return QTEnum.values[@"json"]; }
+ (QTEnum *)jsonConverter { return QTEnum.values[@"json_converter"]; }
+ (QTEnum *)jsonSerializer { return QTEnum.values[@"json_serializer"]; }
+ (QTEnum *)jsonToken { return QTEnum.values[@"json_token"]; }
+ (QTEnum *)jsonWriter { return QTEnum.values[@"json_writer"]; }
+ (QTEnum *)jsonAny { return QTEnum.values[@"JSONAny"]; }
+ (QTEnum *)jsonCodingKey { return QTEnum.values[@"JSONCodingKey"]; }
+ (QTEnum *)jsonDecoder { return QTEnum.values[@"JSONDecoder"]; }
+ (QTEnum *)jsonEncoder { return QTEnum.values[@"JSONEncoder"]; }
+ (QTEnum *)jsonException { return QTEnum.values[@"JsonException"]; }
+ (QTEnum *)jsonGenerator { return QTEnum.values[@"JsonGenerator"]; }
+ (QTEnum *)jsonNode { return QTEnum.values[@"JsonNode"]; }
+ (QTEnum *)jsonNull { return QTEnum.values[@"JSONNull"]; }
+ (QTEnum *)jsonParser { return QTEnum.values[@"JsonParser"]; }
+ (QTEnum *)jsonReader { return QTEnum.values[@"JsonReader"]; }
+ (QTEnum *)jsonTokenType { return QTEnum.values[@"JsonTokenType"]; }
+ (QTEnum *)lambda { return QTEnum.values[@"lambda"]; }
+ (QTEnum *)lazy { return QTEnum.values[@"lazy"]; }
+ (QTEnum *)left { return QTEnum.values[@"left"]; }
+ (QTEnum *)let { return QTEnum.values[@"let"]; }
+ (QTEnum *)list { return QTEnum.values[@"list"]; }
+ (QTEnum *)localDate { return QTEnum.values[@"LocalDate"]; }
+ (QTEnum *)longNode { return QTEnum.values[@"LongNode"]; }
+ (QTEnum *)locale { return QTEnum.values[@"Locale"]; }
+ (QTEnum *)lock { return QTEnum.values[@"lock"]; }
+ (QTEnum *)enumLong { return QTEnum.values[@"long"]; }
+ (QTEnum *)map { return QTEnum.values[@"map"]; }
+ (QTEnum *)marshalJSON { return QTEnum.values[@"MarshalJSON"]; }
+ (QTEnum *)mapEntry { return QTEnum.values[@"MapEntry"]; }
+ (QTEnum *)metadataPropertyHandling { return QTEnum.values[@"metadata_property_handling"]; }
+ (QTEnum *)module { return QTEnum.values[@"module"]; }
+ (QTEnum *)mutable { return QTEnum.values[@"mutable"]; }
+ (QTEnum *)mutating { return QTEnum.values[@"mutating"]; }
+ (QTEnum *)namespace { return QTEnum.values[@"namespace"]; }
+ (QTEnum *)native { return QTEnum.values[@"native"]; }
+ (QTEnum *)theNew { return QTEnum.values[@"new"]; }
+ (QTEnum *)newtonsoft { return QTEnum.values[@"newtonsoft"]; }
+ (QTEnum *)enumNil { return QTEnum.values[@"nil"]; }
+ (QTEnum *)nullNode { return QTEnum.values[@"NullNode"]; }
+ (QTEnum *)no { return QTEnum.values[@"NO"]; }
+ (QTEnum *)noexcept { return QTEnum.values[@"noexcept"]; }
+ (QTEnum *)enumNonatomic { return QTEnum.values[@"nonatomic"]; }
+ (QTEnum *)none { return QTEnum.values[@"none"]; }
+ (QTEnum *)enumNone { return QTEnum.values[@"None"]; }
+ (QTEnum *)nonlocal { return QTEnum.values[@"nonlocal"]; }
+ (QTEnum *)nonmutating { return QTEnum.values[@"nonmutating"]; }
+ (QTEnum *)nsObject { return QTEnum.values[@"NSObject"]; }
+ (QTEnum *)noSuchMethod { return QTEnum.values[@"noSuchMethod"]; }
+ (QTEnum *)not { return QTEnum.values[@"not"]; }
+ (QTEnum *)notEq { return QTEnum.values[@"not_eq"]; }
+ (QTEnum *)nsError { return QTEnum.values[@"NSError"]; }
+ (QTEnum *)nsString { return QTEnum.values[@"NSString"]; }
+ (QTEnum *)null { return QTEnum.values[@"NULL"]; }
+ (QTEnum *)enumNull { return QTEnum.values[@"null"]; }
+ (QTEnum *)nullptr { return QTEnum.values[@"nullptr"]; }
+ (QTEnum *)number { return QTEnum.values[@"number"]; }
+ (QTEnum *)object { return QTEnum.values[@"object"]; }
+ (QTEnum *)offsetDateTime { return QTEnum.values[@"OffsetDateTime"]; }
+ (QTEnum *)offsetTime { return QTEnum.values[@"OffsetTime"]; }
+ (QTEnum *)objectNode { return QTEnum.values[@"ObjectNode"]; }
+ (QTEnum *)objectMapper { return QTEnum.values[@"ObjectMapper"]; }
+ (QTEnum *)objectReader { return QTEnum.values[@"ObjectReader"]; }
+ (QTEnum *)objectWriter { return QTEnum.values[@"ObjectWriter"]; }
+ (QTEnum *)of { return QTEnum.values[@"of"]; }
+ (QTEnum *)oneway { return QTEnum.values[@"oneway"]; }
+ (QTEnum *)open { return QTEnum.values[@"open"]; }
+ (QTEnum *)operator { return QTEnum.values[@"operator"]; }
+ (QTEnum *)optional { return QTEnum.values[@"optional"]; }
+ (QTEnum *)or { return QTEnum.values[@"or"]; }
+ (QTEnum *)orEq { return QTEnum.values[@"or_eq"]; }
+ (QTEnum *)out { return QTEnum.values[@"out"]; }
+ (QTEnum *)override { return QTEnum.values[@"override"]; }
+ (QTEnum *)package { return QTEnum.values[@"package"]; }
+ (QTEnum *)params { return QTEnum.values[@"params"]; }
+ (QTEnum *)pass { return QTEnum.values[@"pass"]; }
+ (QTEnum *)port { return QTEnum.values[@"port"]; }
+ (QTEnum *)postfix { return QTEnum.values[@"postfix"]; }
+ (QTEnum *)precedence { return QTEnum.values[@"precedence"]; }
+ (QTEnum *)prefix { return QTEnum.values[@"prefix"]; }
+ (QTEnum *)print { return QTEnum.values[@"print"]; }
+ (QTEnum *)printf { return QTEnum.values[@"printf"]; }
+ (QTEnum *)printMembers { return QTEnum.values[@"printMembers"]; }
+ (QTEnum *)private { return QTEnum.values[@"private"]; }
+ (QTEnum *)protected { return QTEnum.values[@"protected"]; }
+ (QTEnum *)protocol { return QTEnum.values[@"Protocol"]; }
+ (QTEnum *)enumProtocol { return QTEnum.values[@"protocol"]; }
+ (QTEnum *)public { return QTEnum.values[@"public"]; }
+ (QTEnum *)quicktype { return QTEnum.values[@"quicktype"]; }
+ (QTEnum *)raise { return QTEnum.values[@"raise"]; }
+ (QTEnum *)range { return QTEnum.values[@"range"]; }
+ (QTEnum *)readonly { return QTEnum.values[@"readonly"]; }
+ (QTEnum *)ref { return QTEnum.values[@"ref"]; }
+ (QTEnum *)regExp { return QTEnum.values[@"RegExp"]; }
+ (QTEnum *)enumRegister { return QTEnum.values[@"register"]; }
+ (QTEnum *)reinterpretCast { return QTEnum.values[@"reinterpret_cast"]; }
+ (QTEnum *)repeat { return QTEnum.values[@"repeat"]; }
+ (QTEnum *)require { return QTEnum.values[@"require"]; }
+ (QTEnum *)required { return QTEnum.values[@"required"]; }
+ (QTEnum *)requires { return QTEnum.values[@"requires"]; }
+ (QTEnum *)enumRestrict { return QTEnum.values[@"restrict"]; }
+ (QTEnum *)enumRetain { return QTEnum.values[@"retain"]; }
+ (QTEnum *)rethrows { return QTEnum.values[@"rethrows"]; }
+ (QTEnum *)enumReturn { return QTEnum.values[@"return"]; }
+ (QTEnum *)right { return QTEnum.values[@"right"]; }
+ (QTEnum *)runtimeType { return QTEnum.values[@"runtimeType"]; }
+ (QTEnum *)s { return QTEnum.values[@"s"]; }
+ (QTEnum *)sbyte { return QTEnum.values[@"sbyte"]; }
+ (QTEnum *)sealed { return QTEnum.values[@"sealed"]; }
+ (QTEnum *)sel { return QTEnum.values[@"SEL"]; }
+ (QTEnum *)select { return QTEnum.values[@"select"]; }
+ (QTEnum *)self { return QTEnum.values[@"Self"]; }
+ (QTEnum *)serializable { return QTEnum.values[@"Serializable"]; }
+ (QTEnum *)enumSelf { return QTEnum.values[@"self"]; }
+ (QTEnum *)sendable { return QTEnum.values[@"Sendable"]; }
+ (QTEnum *)serialize { return QTEnum.values[@"serialize"]; }
+ (QTEnum *)serialName { return QTEnum.values[@"SerialName"]; }
+ (QTEnum *)kSerializer { return QTEnum.values[@"KSerializer"]; }
+ (QTEnum *)primitiveKind { return QTEnum.values[@"PrimitiveKind"]; }
+ (QTEnum *)serialDescriptor { return QTEnum.values[@"SerialDescriptor"]; }
+ (QTEnum *)serializationFeature { return QTEnum.values[@"SerializationFeature"]; }
+ (QTEnum *)serializerProvider { return QTEnum.values[@"SerializerProvider"]; }
+ (QTEnum *)set { return QTEnum.values[@"set"]; }
+ (QTEnum *)enumShort { return QTEnum.values[@"short"]; }
+ (QTEnum *)enumSigned { return QTEnum.values[@"signed"]; }
+ (QTEnum *)simpleModule { return QTEnum.values[@"SimpleModule"]; }
+ (QTEnum *)enumSizeof { return QTEnum.values[@"sizeof"]; }
+ (QTEnum *)stackalloc { return QTEnum.values[@"stackalloc"]; }
+ (QTEnum *)standards { return QTEnum.values[@"Standards"]; }
+ (QTEnum *)enumStatic { return QTEnum.values[@"static"]; }
+ (QTEnum *)staticAssert { return QTEnum.values[@"static_assert"]; }
+ (QTEnum *)staticCast { return QTEnum.values[@"static_cast"]; }
+ (QTEnum *)stdDeserializer { return QTEnum.values[@"StdDeserializer"]; }
+ (QTEnum *)stdSerializer { return QTEnum.values[@"StdSerializer"]; }
+ (QTEnum *)strictfp { return QTEnum.values[@"strictfp"]; }
+ (QTEnum *)string { return QTEnum.values[@"string"]; }
+ (QTEnum *)enumStruct { return QTEnum.values[@"struct"]; }
+ (QTEnum *)subscript { return QTEnum.values[@"subscript"]; }
+ (QTEnum *)super { return QTEnum.values[@"super"]; }
+ (QTEnum *)enumSwitch { return QTEnum.values[@"switch"]; }
+ (QTEnum *)symbol { return QTEnum.values[@"symbol"]; }
+ (QTEnum *)synchronized { return QTEnum.values[@"synchronized"]; }
+ (QTEnum *)system { return QTEnum.values[@"system"]; }
+ (QTEnum *)template { return QTEnum.values[@"template"]; }
+ (QTEnum *)then { return QTEnum.values[@"then"]; }
+ (QTEnum *)this { return QTEnum.values[@"this"]; }
+ (QTEnum *)textNode { return QTEnum.values[@"TextNode"]; }
+ (QTEnum *)threadLocal { return QTEnum.values[@"thread_local"]; }
+ (QTEnum *)throw { return QTEnum.values[@"throw"]; }
+ (QTEnum *)throws { return QTEnum.values[@"throws"]; }
+ (QTEnum *)timeOnly { return QTEnum.values[@"TimeOnly"]; }
+ (QTEnum *)timeOnlyConverter { return QTEnum.values[@"TimeOnlyConverter"]; }
+ (QTEnum *)timeZone { return QTEnum.values[@"TimeZone"]; }
+ (QTEnum *)toJSON { return QTEnum.values[@"to_json"]; }
+ (QTEnum *)topLevel { return QTEnum.values[@"top_level"]; }
+ (QTEnum *)toString { return QTEnum.values[@"toString"]; }
+ (QTEnum *)toDict { return QTEnum.values[@"to_dict"]; }
+ (QTEnum *)transient { return QTEnum.values[@"transient"]; }
+ (QTEnum *)enumTrue { return QTEnum.values[@"True"]; }
+ (QTEnum *)true1 { return QTEnum.values[@"true"]; }
+ (QTEnum *)try { return QTEnum.values[@"try"]; }
+ (QTEnum *)type { return QTEnum.values[@"Type"]; }
+ (QTEnum *)enumType { return QTEnum.values[@"type"]; }
+ (QTEnum *)typealias { return QTEnum.values[@"typealias"]; }
+ (QTEnum *)enumTypedef { return QTEnum.values[@"typedef"]; }
+ (QTEnum *)typeid { return QTEnum.values[@"typeid"]; }
+ (QTEnum *)typename { return QTEnum.values[@"typename"]; }
+ (QTEnum *)enumTypeof { return QTEnum.values[@"typeof"]; }
+ (QTEnum *)uint { return QTEnum.values[@"uint"]; }
+ (QTEnum *)ulong { return QTEnum.values[@"ulong"]; }
+ (QTEnum *)unchecked { return QTEnum.values[@"unchecked"]; }
+ (QTEnum *)undefined { return QTEnum.values[@"undefined"]; }
+ (QTEnum *)enumUnion { return QTEnum.values[@"union"]; }
+ (QTEnum *)unmarshalJSON { return QTEnum.values[@"UnmarshalJSON"]; }
+ (QTEnum *)useSerializers { return QTEnum.values[@"UseSerializers"]; }
+ (QTEnum *)unowned { return QTEnum.values[@"unowned"]; }
+ (QTEnum *)unsafe { return QTEnum.values[@"unsafe"]; }
+ (QTEnum *)enumUnsigned { return QTEnum.values[@"unsigned"]; }
+ (QTEnum *)ushort { return QTEnum.values[@"ushort"]; }
+ (QTEnum *)using { return QTEnum.values[@"using"]; }
+ (QTEnum *)utf8JSONReader { return QTEnum.values[@"Utf8JsonReader"]; }
+ (QTEnum *)utf8JSONWriter { return QTEnum.values[@"Utf8JsonWriter"]; }
+ (QTEnum *)uuid { return QTEnum.values[@"UUID"]; }
+ (QTEnum *)var { return QTEnum.values[@"var"]; }
+ (QTEnum *)virtual { return QTEnum.values[@"virtual"]; }
+ (QTEnum *)enumVoid { return QTEnum.values[@"void"]; }
+ (QTEnum *)enumVolatile { return QTEnum.values[@"volatile"]; }
+ (QTEnum *)wcharT { return QTEnum.values[@"wchar_t"]; }
+ (QTEnum *)weak { return QTEnum.values[@"weak"]; }
+ (QTEnum *)where { return QTEnum.values[@"where"]; }
+ (QTEnum *)enumWhile { return QTEnum.values[@"while"]; }
+ (QTEnum *)willSet { return QTEnum.values[@"willSet"]; }
+ (QTEnum *)with { return QTEnum.values[@"with"]; }
+ (QTEnum *)xor { return QTEnum.values[@"xor"]; }
+ (QTEnum *)xorEq { return QTEnum.values[@"xor_eq"]; }
+ (QTEnum *)yes { return QTEnum.values[@"YES"]; }
+ (QTEnum *)yield { return QTEnum.values[@"yield"]; }
+ (QTEnum *)dummy { return QTEnum.values[@"dummy"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTEnum.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

#pragma mark - JSON serialization

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [QTTopLevel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return QTTopLevelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error)
{
    @try {
        id json = [topLevel JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingFragmentsAllowed error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = QTTopLevelToData(topLevel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation QTTopLevel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"enum": @"qtTopLevelEnum",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return QTTopLevelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTTopLevelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _qtTopLevelEnum = [QTEnum withValue:(id)_qtTopLevelEnum];
        if (_qtTopLevelEnum == nil && dict[@"enum"] && ![dict[@"enum"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTopLevel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTopLevel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTopLevel.properties.allValues] mutableCopy];

    for (id jsonName in QTTopLevel.properties) {
        id propertyName = QTTopLevel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"enum": NSNullify([_qtTopLevelEnum value]),
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return QTTopLevelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTTopLevelToJSON(self, encoding, error);
}
@end

NS_ASSUME_NONNULL_END
