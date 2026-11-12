//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <optional>
#include "json.hpp"

#include <optional>
#include <stdexcept>
#include <regex>
#include <unordered_map>

#ifndef NLOHMANN_OPT_HELPER
#define NLOHMANN_OPT_HELPER
namespace nlohmann {
    template <typename T>
    struct adl_serializer<std::shared_ptr<T>> {
        static void to_json(json & j, const std::shared_ptr<T> & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::shared_ptr<T> from_json(const json & j) {
            if (j.is_null()) return std::shared_ptr<T>(); else return std::make_shared<T>(j.get<T>());
        }
    };
    template <typename T>
    struct adl_serializer<std::optional<T>> {
        static void to_json(json & j, const std::optional<T> & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::optional<T> from_json(const json & j) {
            if (j.is_null()) return std::optional<T>(); else return std::make_optional<T>(j.get<T>());
        }
    };
}
#endif

namespace quicktype {
    using nlohmann::json;

    #ifndef NLOHMANN_UNTYPED_quicktype_HELPER
    #define NLOHMANN_UNTYPED_quicktype_HELPER
    inline json get_untyped(const json & j, const char * property) {
        if (j.find(property) != j.end()) {
            return j.at(property).get<json>();
        }
        return json();
    }

    inline json get_untyped(const json & j, std::string property) {
        return get_untyped(j, property.data());
    }
    #endif

    #ifndef NLOHMANN_OPTIONAL_quicktype_HELPER
    #define NLOHMANN_OPTIONAL_quicktype_HELPER
    template <typename T>
    inline std::shared_ptr<T> get_heap_optional(const json & j, const char * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<std::shared_ptr<T>>();
        }
        return std::shared_ptr<T>();
    }

    template <typename T>
    inline std::shared_ptr<T> get_heap_optional(const json & j, std::string property) {
        return get_heap_optional<T>(j, property.data());
    }
    template <typename T>
    inline std::optional<T> get_stack_optional(const json & j, const char * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<std::optional<T>>();
        }
        return std::optional<T>();
    }

    template <typename T>
    inline std::optional<T> get_stack_optional(const json & j, std::string property) {
        return get_stack_optional<T>(j, property.data());
    }
    #endif

    enum class Enum : int { EMPTY, BOOL, COMPLEX, IMAGINERY, ABSTRACT, ALIGNAS, ALIGNOF, AND, AND_EQ, ANY, ENUM_ANY, ARRAY_NODE, ARRAY, AS, ASM, ASSERT, ASSOCIATEDTYPE, ASSOCIATIVITY, ASYNC, ATOMIC, ATOMIC_CANCEL, ATOMIC_COMMIT, ATOMIC_NOEXCEPT, AUTO, AWAIT, BASE, BITAND, BITOR, ENUM_BOOL, PURPLE_BOOL, BOOLEAN, BOOLEAN_NODE, BREAK, BYCOPY, BYREF, BYTE, CALENDAR, CASE, CATCH, CHAN, CHAR, CHAR16_T, CHAR32_T, CHECKED, CLASS, ENUM_CLASS, CLONE, CO_AWAIT, CO_RETURN, CO_YIELD, CODABLE, CODING_KEY, CODING_KEYS, COMPL, CONCEPT, CONSOLE, CONST, CONST_CAST, CONSTEXPR, CONSTRUCTOR, CONTINUE, CONVENIENCE, CONVERT, CONVERTER, CULTURE_INFO, DATE, DATE_PARSE_HANDLING, DATE_FORMATTER, DATE_ONLY, DATE_ONLY_CONVERTER, DATE_TIME, DATE_TIME_STYLES, DEBUGGER, DECIMAL, DECLARE, DESERIALIZATION_FEATURE, DECLTYPE, DECODE_STRING, DECODER, DECODING_ERROR, DEF, DEFAULT, DEFER, DEINIT, DEL, DELEGATE, DELETE, DICT, DICTIONARY, DID_SET, DO, DOUBLE, DOUBLE_NODE, DYNAMIC, DYNAMIC_CAST, ELIF, ELSE, ENCODE_QUICK_TYPE, ENCODER, ENUM, ENUM_VALUES, EQUATABLE, EQUALITY_CONTRACT, EVENT, EXCEPT, EXCEPTION, EXPLICIT, EXPORT, EXPOSING, EXTENDS, EXTENSION, EXTERN, FALLTHROUGH, FALSE, ENUM_FALSE, FILEPRIVATE, FINAL, FINALLY, FIXED, FLOAT, FOR, FOREACH, FORMAT_EXCEPTION, FRIEND, FROM, FROM_DICT, FROM_JSON, FUNC, FUNCTION, GET, GLOBAL, GO, GOTO, GUARD, HASHABLE, HASH_CODE, HASHER, HAS_OWN_PROPERTY, ID, IF, IMP, IMPLEMENTS, IMPLICIT, IMPORT, IN, INDIRECT, INFIX, INIT, INLINE, INOUT, INSTANCEOF, INT, INT_NODE, INTERFACE, INTERNAL, ISO_DATE_TIME_OFFSET_CONVERTER, ITERABLE, IS, JDEC, JENC, JPIPE, JSON, JSON_CONVERTER, JSON_SERIALIZER, JSON_TOKEN, JSON_WRITER, JSON_ANY, JSON_CODING_KEY, JSON_DECODER, JSON_ENCODER, JSON_EXCEPTION, JSON_GENERATOR, JSON_NODE, JSON_NULL, JSON_PARSER, JSON_READER, JSON_TOKEN_TYPE, LAMBDA, LAZY, LEFT, LET, LIST, LOCAL_DATE, LONG_NODE, LOCALE, LOCK, LONG, MAP, MARSHAL_JSON, MAP_ENTRY, METADATA_PROPERTY_HANDLING, MODULE, MUTABLE, MUTATING, NAMESPACE, NATIVE, NEW, NEWTONSOFT, NIL, NULL_NODE, NO, NOEXCEPT, NONATOMIC, NONE, ENUM_NONE, NONLOCAL, NONMUTATING, NS_OBJECT, NO_SUCH_METHOD, NOT, NOT_EQ, NS_ERROR, NS_STRING, ENUM_NULL, PURPLE_NULL, NULLPTR, NUMBER, OBJECT, OFFSET_DATE_TIME, OFFSET_TIME, OBJECT_NODE, OBJECT_MAPPER, OBJECT_READER, OBJECT_WRITER, OF, ONEWAY, OPEN, OPERATOR, OPTIONAL, OR, OR_EQ, OUT, OVERRIDE, PACKAGE, PARAMS, PASS, PORT, POSTFIX, PRECEDENCE, PREFIX, PRINT, PRINTF, PRINT_MEMBERS, PRIVATE, PROTECTED, PROTOCOL, ENUM_PROTOCOL, PUBLIC, QUICKTYPE, RAISE, RANGE, READONLY, REF, REG_EXP, REGISTER, REINTERPRET_CAST, REPEAT, REQUIRE, REQUIRED, REQUIRES, RESTRICT, RETAIN, RETHROWS, RETURN, RIGHT, RUNTIME_TYPE, S, SBYTE, SEALED, SEL, SELECT, SELF, SERIALIZABLE, ENUM_SELF, SENDABLE, SERIALIZE, SERIAL_NAME, K_SERIALIZER, PRIMITIVE_KIND, SERIAL_DESCRIPTOR, SERIALIZATION_FEATURE, SERIALIZER_PROVIDER, SET, SHORT, SIGNED, SIMPLE_MODULE, SIZEOF, STACKALLOC, STANDARDS, STATIC, STATIC_ASSERT, STATIC_CAST, STD_DESERIALIZER, STD_SERIALIZER, STRICTFP, STRING, STRUCT, SUBSCRIPT, SUPER, SWITCH, SYMBOL, SYNCHRONIZED, SYSTEM, TEMPLATE, THEN, THIS, TEXT_NODE, THREAD_LOCAL, THROW, THROWS, TIME_ONLY, TIME_ONLY_CONVERTER, TIME_ZONE, TO_JSON, TOP_LEVEL, TO_STRING, TO_DICT, TRANSIENT, TRUE, ENUM_TRUE, TRY, TYPE, ENUM_TYPE, TYPEALIAS, TYPEDEF, TYPEID, TYPENAME, TYPEOF, UINT, ULONG, UNCHECKED, UNDEFINED, UNION, UNMARSHAL_JSON, USE_SERIALIZERS, UNOWNED, UNSAFE, UNSIGNED, USHORT, USING, UTF8_JSON_READER, UTF8_JSON_WRITER, UUID, VAR, VIRTUAL, VOID, VOLATILE, WCHAR_T, WEAK, WHERE, WHILE, WILL_SET, WITH, XOR, XOR_EQ, YES, YIELD, DUMMY };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<Enum> top_level_enum;

        public:
        const std::optional<Enum> & get_top_level_enum() const { return top_level_enum; }
        std::optional<Enum> & get_mutable_top_level_enum() { return top_level_enum; }
        void set_top_level_enum(const std::optional<Enum> & value) { this->top_level_enum = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Enum & x);
    void to_json(json & j, const Enum & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("enum") != j.end() && j.at("enum").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_enum(get_stack_optional<Enum>(j, "enum"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["enum"] = x.get_top_level_enum();
    }

    inline void from_json(const json & j, Enum & x) {
        static std::unordered_map<std::string, Enum> enumValues {
            {"_", Enum::EMPTY},
            {"_Bool", Enum::BOOL},
            {"_Complex", Enum::COMPLEX},
            {"_Imaginery", Enum::IMAGINERY},
            {"abstract", Enum::ABSTRACT},
            {"alignas", Enum::ALIGNAS},
            {"alignof", Enum::ALIGNOF},
            {"and", Enum::AND},
            {"and_eq", Enum::AND_EQ},
            {"any", Enum::ANY},
            {"Any", Enum::ENUM_ANY},
            {"ArrayNode", Enum::ARRAY_NODE},
            {"array", Enum::ARRAY},
            {"as", Enum::AS},
            {"asm", Enum::ASM},
            {"assert", Enum::ASSERT},
            {"associatedtype", Enum::ASSOCIATEDTYPE},
            {"associativity", Enum::ASSOCIATIVITY},
            {"async", Enum::ASYNC},
            {"atomic", Enum::ATOMIC},
            {"atomic_cancel", Enum::ATOMIC_CANCEL},
            {"atomic_commit", Enum::ATOMIC_COMMIT},
            {"atomic_noexcept", Enum::ATOMIC_NOEXCEPT},
            {"auto", Enum::AUTO},
            {"await", Enum::AWAIT},
            {"base", Enum::BASE},
            {"bitand", Enum::BITAND},
            {"bitor", Enum::BITOR},
            {"BOOL", Enum::ENUM_BOOL},
            {"bool", Enum::PURPLE_BOOL},
            {"boolean", Enum::BOOLEAN},
            {"BooleanNode", Enum::BOOLEAN_NODE},
            {"break", Enum::BREAK},
            {"bycopy", Enum::BYCOPY},
            {"byref", Enum::BYREF},
            {"byte", Enum::BYTE},
            {"Calendar", Enum::CALENDAR},
            {"case", Enum::CASE},
            {"catch", Enum::CATCH},
            {"chan", Enum::CHAN},
            {"char", Enum::CHAR},
            {"char16_t", Enum::CHAR16_T},
            {"char32_t", Enum::CHAR32_T},
            {"checked", Enum::CHECKED},
            {"class", Enum::CLASS},
            {"Class", Enum::ENUM_CLASS},
            {"clone", Enum::CLONE},
            {"co_await", Enum::CO_AWAIT},
            {"co_return", Enum::CO_RETURN},
            {"co_yield", Enum::CO_YIELD},
            {"Codable", Enum::CODABLE},
            {"CodingKey", Enum::CODING_KEY},
            {"CodingKeys", Enum::CODING_KEYS},
            {"compl", Enum::COMPL},
            {"concept", Enum::CONCEPT},
            {"console", Enum::CONSOLE},
            {"const", Enum::CONST},
            {"const_cast", Enum::CONST_CAST},
            {"constexpr", Enum::CONSTEXPR},
            {"constructor", Enum::CONSTRUCTOR},
            {"continue", Enum::CONTINUE},
            {"convenience", Enum::CONVENIENCE},
            {"convert", Enum::CONVERT},
            {"converter", Enum::CONVERTER},
            {"CultureInfo", Enum::CULTURE_INFO},
            {"date", Enum::DATE},
            {"date_parse_handling", Enum::DATE_PARSE_HANDLING},
            {"DateFormatter", Enum::DATE_FORMATTER},
            {"DateOnly", Enum::DATE_ONLY},
            {"DateOnlyConverter", Enum::DATE_ONLY_CONVERTER},
            {"DateTime", Enum::DATE_TIME},
            {"DateTimeStyles", Enum::DATE_TIME_STYLES},
            {"debugger", Enum::DEBUGGER},
            {"decimal", Enum::DECIMAL},
            {"declare", Enum::DECLARE},
            {"DeserializationFeature", Enum::DESERIALIZATION_FEATURE},
            {"decltype", Enum::DECLTYPE},
            {"decode_string", Enum::DECODE_STRING},
            {"Decoder", Enum::DECODER},
            {"DecodingError", Enum::DECODING_ERROR},
            {"def", Enum::DEF},
            {"default", Enum::DEFAULT},
            {"defer", Enum::DEFER},
            {"deinit", Enum::DEINIT},
            {"del", Enum::DEL},
            {"delegate", Enum::DELEGATE},
            {"delete", Enum::DELETE},
            {"dict", Enum::DICT},
            {"dictionary", Enum::DICTIONARY},
            {"didSet", Enum::DID_SET},
            {"do", Enum::DO},
            {"double", Enum::DOUBLE},
            {"DoubleNode", Enum::DOUBLE_NODE},
            {"dynamic", Enum::DYNAMIC},
            {"dynamic_cast", Enum::DYNAMIC_CAST},
            {"elif", Enum::ELIF},
            {"else", Enum::ELSE},
            {"encode_quick_type", Enum::ENCODE_QUICK_TYPE},
            {"Encoder", Enum::ENCODER},
            {"enum", Enum::ENUM},
            {"EnumValues", Enum::ENUM_VALUES},
            {"Equatable", Enum::EQUATABLE},
            {"equalityContract", Enum::EQUALITY_CONTRACT},
            {"event", Enum::EVENT},
            {"except", Enum::EXCEPT},
            {"exception", Enum::EXCEPTION},
            {"explicit", Enum::EXPLICIT},
            {"export", Enum::EXPORT},
            {"exposing", Enum::EXPOSING},
            {"extends", Enum::EXTENDS},
            {"extension", Enum::EXTENSION},
            {"extern", Enum::EXTERN},
            {"fallthrough", Enum::FALLTHROUGH},
            {"false", Enum::FALSE},
            {"False", Enum::ENUM_FALSE},
            {"fileprivate", Enum::FILEPRIVATE},
            {"final", Enum::FINAL},
            {"finally", Enum::FINALLY},
            {"fixed", Enum::FIXED},
            {"float", Enum::FLOAT},
            {"for", Enum::FOR},
            {"foreach", Enum::FOREACH},
            {"FormatException", Enum::FORMAT_EXCEPTION},
            {"friend", Enum::FRIEND},
            {"from", Enum::FROM},
            {"from_dict", Enum::FROM_DICT},
            {"from_json", Enum::FROM_JSON},
            {"func", Enum::FUNC},
            {"function", Enum::FUNCTION},
            {"get", Enum::GET},
            {"global", Enum::GLOBAL},
            {"go", Enum::GO},
            {"goto", Enum::GOTO},
            {"guard", Enum::GUARD},
            {"Hashable", Enum::HASHABLE},
            {"hashCode", Enum::HASH_CODE},
            {"Hasher", Enum::HASHER},
            {"hasOwnProperty", Enum::HAS_OWN_PROPERTY},
            {"id", Enum::ID},
            {"if", Enum::IF},
            {"IMP", Enum::IMP},
            {"implements", Enum::IMPLEMENTS},
            {"implicit", Enum::IMPLICIT},
            {"import", Enum::IMPORT},
            {"in", Enum::IN},
            {"indirect", Enum::INDIRECT},
            {"infix", Enum::INFIX},
            {"init", Enum::INIT},
            {"inline", Enum::INLINE},
            {"inout", Enum::INOUT},
            {"instanceof", Enum::INSTANCEOF},
            {"int", Enum::INT},
            {"IntNode", Enum::INT_NODE},
            {"interface", Enum::INTERFACE},
            {"internal", Enum::INTERNAL},
            {"IsoDateTimeOffsetConverter", Enum::ISO_DATE_TIME_OFFSET_CONVERTER},
            {"iterable", Enum::ITERABLE},
            {"is", Enum::IS},
            {"jdec", Enum::JDEC},
            {"jenc", Enum::JENC},
            {"jpipe", Enum::JPIPE},
            {"json", Enum::JSON},
            {"json_converter", Enum::JSON_CONVERTER},
            {"json_serializer", Enum::JSON_SERIALIZER},
            {"json_token", Enum::JSON_TOKEN},
            {"json_writer", Enum::JSON_WRITER},
            {"JSONAny", Enum::JSON_ANY},
            {"JSONCodingKey", Enum::JSON_CODING_KEY},
            {"JSONDecoder", Enum::JSON_DECODER},
            {"JSONEncoder", Enum::JSON_ENCODER},
            {"JsonException", Enum::JSON_EXCEPTION},
            {"JsonGenerator", Enum::JSON_GENERATOR},
            {"JsonNode", Enum::JSON_NODE},
            {"JSONNull", Enum::JSON_NULL},
            {"JsonParser", Enum::JSON_PARSER},
            {"JsonReader", Enum::JSON_READER},
            {"JsonTokenType", Enum::JSON_TOKEN_TYPE},
            {"lambda", Enum::LAMBDA},
            {"lazy", Enum::LAZY},
            {"left", Enum::LEFT},
            {"let", Enum::LET},
            {"list", Enum::LIST},
            {"LocalDate", Enum::LOCAL_DATE},
            {"LongNode", Enum::LONG_NODE},
            {"Locale", Enum::LOCALE},
            {"lock", Enum::LOCK},
            {"long", Enum::LONG},
            {"map", Enum::MAP},
            {"MarshalJSON", Enum::MARSHAL_JSON},
            {"MapEntry", Enum::MAP_ENTRY},
            {"metadata_property_handling", Enum::METADATA_PROPERTY_HANDLING},
            {"module", Enum::MODULE},
            {"mutable", Enum::MUTABLE},
            {"mutating", Enum::MUTATING},
            {"namespace", Enum::NAMESPACE},
            {"native", Enum::NATIVE},
            {"new", Enum::NEW},
            {"newtonsoft", Enum::NEWTONSOFT},
            {"nil", Enum::NIL},
            {"NullNode", Enum::NULL_NODE},
            {"NO", Enum::NO},
            {"noexcept", Enum::NOEXCEPT},
            {"nonatomic", Enum::NONATOMIC},
            {"none", Enum::NONE},
            {"None", Enum::ENUM_NONE},
            {"nonlocal", Enum::NONLOCAL},
            {"nonmutating", Enum::NONMUTATING},
            {"NSObject", Enum::NS_OBJECT},
            {"noSuchMethod", Enum::NO_SUCH_METHOD},
            {"not", Enum::NOT},
            {"not_eq", Enum::NOT_EQ},
            {"NSError", Enum::NS_ERROR},
            {"NSString", Enum::NS_STRING},
            {"NULL", Enum::ENUM_NULL},
            {"null", Enum::PURPLE_NULL},
            {"nullptr", Enum::NULLPTR},
            {"number", Enum::NUMBER},
            {"object", Enum::OBJECT},
            {"OffsetDateTime", Enum::OFFSET_DATE_TIME},
            {"OffsetTime", Enum::OFFSET_TIME},
            {"ObjectNode", Enum::OBJECT_NODE},
            {"ObjectMapper", Enum::OBJECT_MAPPER},
            {"ObjectReader", Enum::OBJECT_READER},
            {"ObjectWriter", Enum::OBJECT_WRITER},
            {"of", Enum::OF},
            {"oneway", Enum::ONEWAY},
            {"open", Enum::OPEN},
            {"operator", Enum::OPERATOR},
            {"optional", Enum::OPTIONAL},
            {"or", Enum::OR},
            {"or_eq", Enum::OR_EQ},
            {"out", Enum::OUT},
            {"override", Enum::OVERRIDE},
            {"package", Enum::PACKAGE},
            {"params", Enum::PARAMS},
            {"pass", Enum::PASS},
            {"port", Enum::PORT},
            {"postfix", Enum::POSTFIX},
            {"precedence", Enum::PRECEDENCE},
            {"prefix", Enum::PREFIX},
            {"print", Enum::PRINT},
            {"printf", Enum::PRINTF},
            {"printMembers", Enum::PRINT_MEMBERS},
            {"private", Enum::PRIVATE},
            {"protected", Enum::PROTECTED},
            {"Protocol", Enum::PROTOCOL},
            {"protocol", Enum::ENUM_PROTOCOL},
            {"public", Enum::PUBLIC},
            {"quicktype", Enum::QUICKTYPE},
            {"raise", Enum::RAISE},
            {"range", Enum::RANGE},
            {"readonly", Enum::READONLY},
            {"ref", Enum::REF},
            {"RegExp", Enum::REG_EXP},
            {"register", Enum::REGISTER},
            {"reinterpret_cast", Enum::REINTERPRET_CAST},
            {"repeat", Enum::REPEAT},
            {"require", Enum::REQUIRE},
            {"required", Enum::REQUIRED},
            {"requires", Enum::REQUIRES},
            {"restrict", Enum::RESTRICT},
            {"retain", Enum::RETAIN},
            {"rethrows", Enum::RETHROWS},
            {"return", Enum::RETURN},
            {"right", Enum::RIGHT},
            {"runtimeType", Enum::RUNTIME_TYPE},
            {"s", Enum::S},
            {"sbyte", Enum::SBYTE},
            {"sealed", Enum::SEALED},
            {"SEL", Enum::SEL},
            {"select", Enum::SELECT},
            {"Self", Enum::SELF},
            {"Serializable", Enum::SERIALIZABLE},
            {"self", Enum::ENUM_SELF},
            {"Sendable", Enum::SENDABLE},
            {"serialize", Enum::SERIALIZE},
            {"SerialName", Enum::SERIAL_NAME},
            {"KSerializer", Enum::K_SERIALIZER},
            {"PrimitiveKind", Enum::PRIMITIVE_KIND},
            {"SerialDescriptor", Enum::SERIAL_DESCRIPTOR},
            {"SerializationFeature", Enum::SERIALIZATION_FEATURE},
            {"SerializerProvider", Enum::SERIALIZER_PROVIDER},
            {"set", Enum::SET},
            {"short", Enum::SHORT},
            {"signed", Enum::SIGNED},
            {"SimpleModule", Enum::SIMPLE_MODULE},
            {"sizeof", Enum::SIZEOF},
            {"stackalloc", Enum::STACKALLOC},
            {"Standards", Enum::STANDARDS},
            {"static", Enum::STATIC},
            {"static_assert", Enum::STATIC_ASSERT},
            {"static_cast", Enum::STATIC_CAST},
            {"StdDeserializer", Enum::STD_DESERIALIZER},
            {"StdSerializer", Enum::STD_SERIALIZER},
            {"strictfp", Enum::STRICTFP},
            {"string", Enum::STRING},
            {"struct", Enum::STRUCT},
            {"subscript", Enum::SUBSCRIPT},
            {"super", Enum::SUPER},
            {"switch", Enum::SWITCH},
            {"symbol", Enum::SYMBOL},
            {"synchronized", Enum::SYNCHRONIZED},
            {"system", Enum::SYSTEM},
            {"template", Enum::TEMPLATE},
            {"then", Enum::THEN},
            {"this", Enum::THIS},
            {"TextNode", Enum::TEXT_NODE},
            {"thread_local", Enum::THREAD_LOCAL},
            {"throw", Enum::THROW},
            {"throws", Enum::THROWS},
            {"TimeOnly", Enum::TIME_ONLY},
            {"TimeOnlyConverter", Enum::TIME_ONLY_CONVERTER},
            {"TimeZone", Enum::TIME_ZONE},
            {"to_json", Enum::TO_JSON},
            {"top_level", Enum::TOP_LEVEL},
            {"toString", Enum::TO_STRING},
            {"to_dict", Enum::TO_DICT},
            {"transient", Enum::TRANSIENT},
            {"True", Enum::TRUE},
            {"true", Enum::ENUM_TRUE},
            {"try", Enum::TRY},
            {"Type", Enum::TYPE},
            {"type", Enum::ENUM_TYPE},
            {"typealias", Enum::TYPEALIAS},
            {"typedef", Enum::TYPEDEF},
            {"typeid", Enum::TYPEID},
            {"typename", Enum::TYPENAME},
            {"typeof", Enum::TYPEOF},
            {"uint", Enum::UINT},
            {"ulong", Enum::ULONG},
            {"unchecked", Enum::UNCHECKED},
            {"undefined", Enum::UNDEFINED},
            {"union", Enum::UNION},
            {"UnmarshalJSON", Enum::UNMARSHAL_JSON},
            {"UseSerializers", Enum::USE_SERIALIZERS},
            {"unowned", Enum::UNOWNED},
            {"unsafe", Enum::UNSAFE},
            {"unsigned", Enum::UNSIGNED},
            {"ushort", Enum::USHORT},
            {"using", Enum::USING},
            {"Utf8JsonReader", Enum::UTF8_JSON_READER},
            {"Utf8JsonWriter", Enum::UTF8_JSON_WRITER},
            {"UUID", Enum::UUID},
            {"var", Enum::VAR},
            {"virtual", Enum::VIRTUAL},
            {"void", Enum::VOID},
            {"volatile", Enum::VOLATILE},
            {"wchar_t", Enum::WCHAR_T},
            {"weak", Enum::WEAK},
            {"where", Enum::WHERE},
            {"while", Enum::WHILE},
            {"willSet", Enum::WILL_SET},
            {"with", Enum::WITH},
            {"xor", Enum::XOR},
            {"xor_eq", Enum::XOR_EQ},
            {"YES", Enum::YES},
            {"yield", Enum::YIELD},
            {"dummy", Enum::DUMMY},
        };
        auto iter = enumValues.find(j.get<std::string>());
        if (iter != enumValues.end()) {
            x = iter->second;
        }
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Enum\""); }
    }

    inline void to_json(json & j, const Enum & x) {
        switch (x) {
            case Enum::EMPTY: j = "_"; break;
            case Enum::BOOL: j = "_Bool"; break;
            case Enum::COMPLEX: j = "_Complex"; break;
            case Enum::IMAGINERY: j = "_Imaginery"; break;
            case Enum::ABSTRACT: j = "abstract"; break;
            case Enum::ALIGNAS: j = "alignas"; break;
            case Enum::ALIGNOF: j = "alignof"; break;
            case Enum::AND: j = "and"; break;
            case Enum::AND_EQ: j = "and_eq"; break;
            case Enum::ANY: j = "any"; break;
            case Enum::ENUM_ANY: j = "Any"; break;
            case Enum::ARRAY_NODE: j = "ArrayNode"; break;
            case Enum::ARRAY: j = "array"; break;
            case Enum::AS: j = "as"; break;
            case Enum::ASM: j = "asm"; break;
            case Enum::ASSERT: j = "assert"; break;
            case Enum::ASSOCIATEDTYPE: j = "associatedtype"; break;
            case Enum::ASSOCIATIVITY: j = "associativity"; break;
            case Enum::ASYNC: j = "async"; break;
            case Enum::ATOMIC: j = "atomic"; break;
            case Enum::ATOMIC_CANCEL: j = "atomic_cancel"; break;
            case Enum::ATOMIC_COMMIT: j = "atomic_commit"; break;
            case Enum::ATOMIC_NOEXCEPT: j = "atomic_noexcept"; break;
            case Enum::AUTO: j = "auto"; break;
            case Enum::AWAIT: j = "await"; break;
            case Enum::BASE: j = "base"; break;
            case Enum::BITAND: j = "bitand"; break;
            case Enum::BITOR: j = "bitor"; break;
            case Enum::ENUM_BOOL: j = "BOOL"; break;
            case Enum::PURPLE_BOOL: j = "bool"; break;
            case Enum::BOOLEAN: j = "boolean"; break;
            case Enum::BOOLEAN_NODE: j = "BooleanNode"; break;
            case Enum::BREAK: j = "break"; break;
            case Enum::BYCOPY: j = "bycopy"; break;
            case Enum::BYREF: j = "byref"; break;
            case Enum::BYTE: j = "byte"; break;
            case Enum::CALENDAR: j = "Calendar"; break;
            case Enum::CASE: j = "case"; break;
            case Enum::CATCH: j = "catch"; break;
            case Enum::CHAN: j = "chan"; break;
            case Enum::CHAR: j = "char"; break;
            case Enum::CHAR16_T: j = "char16_t"; break;
            case Enum::CHAR32_T: j = "char32_t"; break;
            case Enum::CHECKED: j = "checked"; break;
            case Enum::CLASS: j = "class"; break;
            case Enum::ENUM_CLASS: j = "Class"; break;
            case Enum::CLONE: j = "clone"; break;
            case Enum::CO_AWAIT: j = "co_await"; break;
            case Enum::CO_RETURN: j = "co_return"; break;
            case Enum::CO_YIELD: j = "co_yield"; break;
            case Enum::CODABLE: j = "Codable"; break;
            case Enum::CODING_KEY: j = "CodingKey"; break;
            case Enum::CODING_KEYS: j = "CodingKeys"; break;
            case Enum::COMPL: j = "compl"; break;
            case Enum::CONCEPT: j = "concept"; break;
            case Enum::CONSOLE: j = "console"; break;
            case Enum::CONST: j = "const"; break;
            case Enum::CONST_CAST: j = "const_cast"; break;
            case Enum::CONSTEXPR: j = "constexpr"; break;
            case Enum::CONSTRUCTOR: j = "constructor"; break;
            case Enum::CONTINUE: j = "continue"; break;
            case Enum::CONVENIENCE: j = "convenience"; break;
            case Enum::CONVERT: j = "convert"; break;
            case Enum::CONVERTER: j = "converter"; break;
            case Enum::CULTURE_INFO: j = "CultureInfo"; break;
            case Enum::DATE: j = "date"; break;
            case Enum::DATE_PARSE_HANDLING: j = "date_parse_handling"; break;
            case Enum::DATE_FORMATTER: j = "DateFormatter"; break;
            case Enum::DATE_ONLY: j = "DateOnly"; break;
            case Enum::DATE_ONLY_CONVERTER: j = "DateOnlyConverter"; break;
            case Enum::DATE_TIME: j = "DateTime"; break;
            case Enum::DATE_TIME_STYLES: j = "DateTimeStyles"; break;
            case Enum::DEBUGGER: j = "debugger"; break;
            case Enum::DECIMAL: j = "decimal"; break;
            case Enum::DECLARE: j = "declare"; break;
            case Enum::DESERIALIZATION_FEATURE: j = "DeserializationFeature"; break;
            case Enum::DECLTYPE: j = "decltype"; break;
            case Enum::DECODE_STRING: j = "decode_string"; break;
            case Enum::DECODER: j = "Decoder"; break;
            case Enum::DECODING_ERROR: j = "DecodingError"; break;
            case Enum::DEF: j = "def"; break;
            case Enum::DEFAULT: j = "default"; break;
            case Enum::DEFER: j = "defer"; break;
            case Enum::DEINIT: j = "deinit"; break;
            case Enum::DEL: j = "del"; break;
            case Enum::DELEGATE: j = "delegate"; break;
            case Enum::DELETE: j = "delete"; break;
            case Enum::DICT: j = "dict"; break;
            case Enum::DICTIONARY: j = "dictionary"; break;
            case Enum::DID_SET: j = "didSet"; break;
            case Enum::DO: j = "do"; break;
            case Enum::DOUBLE: j = "double"; break;
            case Enum::DOUBLE_NODE: j = "DoubleNode"; break;
            case Enum::DYNAMIC: j = "dynamic"; break;
            case Enum::DYNAMIC_CAST: j = "dynamic_cast"; break;
            case Enum::ELIF: j = "elif"; break;
            case Enum::ELSE: j = "else"; break;
            case Enum::ENCODE_QUICK_TYPE: j = "encode_quick_type"; break;
            case Enum::ENCODER: j = "Encoder"; break;
            case Enum::ENUM: j = "enum"; break;
            case Enum::ENUM_VALUES: j = "EnumValues"; break;
            case Enum::EQUATABLE: j = "Equatable"; break;
            case Enum::EQUALITY_CONTRACT: j = "equalityContract"; break;
            case Enum::EVENT: j = "event"; break;
            case Enum::EXCEPT: j = "except"; break;
            case Enum::EXCEPTION: j = "exception"; break;
            case Enum::EXPLICIT: j = "explicit"; break;
            case Enum::EXPORT: j = "export"; break;
            case Enum::EXPOSING: j = "exposing"; break;
            case Enum::EXTENDS: j = "extends"; break;
            case Enum::EXTENSION: j = "extension"; break;
            case Enum::EXTERN: j = "extern"; break;
            case Enum::FALLTHROUGH: j = "fallthrough"; break;
            case Enum::FALSE: j = "false"; break;
            case Enum::ENUM_FALSE: j = "False"; break;
            case Enum::FILEPRIVATE: j = "fileprivate"; break;
            case Enum::FINAL: j = "final"; break;
            case Enum::FINALLY: j = "finally"; break;
            case Enum::FIXED: j = "fixed"; break;
            case Enum::FLOAT: j = "float"; break;
            case Enum::FOR: j = "for"; break;
            case Enum::FOREACH: j = "foreach"; break;
            case Enum::FORMAT_EXCEPTION: j = "FormatException"; break;
            case Enum::FRIEND: j = "friend"; break;
            case Enum::FROM: j = "from"; break;
            case Enum::FROM_DICT: j = "from_dict"; break;
            case Enum::FROM_JSON: j = "from_json"; break;
            case Enum::FUNC: j = "func"; break;
            case Enum::FUNCTION: j = "function"; break;
            case Enum::GET: j = "get"; break;
            case Enum::GLOBAL: j = "global"; break;
            case Enum::GO: j = "go"; break;
            case Enum::GOTO: j = "goto"; break;
            case Enum::GUARD: j = "guard"; break;
            case Enum::HASHABLE: j = "Hashable"; break;
            case Enum::HASH_CODE: j = "hashCode"; break;
            case Enum::HASHER: j = "Hasher"; break;
            case Enum::HAS_OWN_PROPERTY: j = "hasOwnProperty"; break;
            case Enum::ID: j = "id"; break;
            case Enum::IF: j = "if"; break;
            case Enum::IMP: j = "IMP"; break;
            case Enum::IMPLEMENTS: j = "implements"; break;
            case Enum::IMPLICIT: j = "implicit"; break;
            case Enum::IMPORT: j = "import"; break;
            case Enum::IN: j = "in"; break;
            case Enum::INDIRECT: j = "indirect"; break;
            case Enum::INFIX: j = "infix"; break;
            case Enum::INIT: j = "init"; break;
            case Enum::INLINE: j = "inline"; break;
            case Enum::INOUT: j = "inout"; break;
            case Enum::INSTANCEOF: j = "instanceof"; break;
            case Enum::INT: j = "int"; break;
            case Enum::INT_NODE: j = "IntNode"; break;
            case Enum::INTERFACE: j = "interface"; break;
            case Enum::INTERNAL: j = "internal"; break;
            case Enum::ISO_DATE_TIME_OFFSET_CONVERTER: j = "IsoDateTimeOffsetConverter"; break;
            case Enum::ITERABLE: j = "iterable"; break;
            case Enum::IS: j = "is"; break;
            case Enum::JDEC: j = "jdec"; break;
            case Enum::JENC: j = "jenc"; break;
            case Enum::JPIPE: j = "jpipe"; break;
            case Enum::JSON: j = "json"; break;
            case Enum::JSON_CONVERTER: j = "json_converter"; break;
            case Enum::JSON_SERIALIZER: j = "json_serializer"; break;
            case Enum::JSON_TOKEN: j = "json_token"; break;
            case Enum::JSON_WRITER: j = "json_writer"; break;
            case Enum::JSON_ANY: j = "JSONAny"; break;
            case Enum::JSON_CODING_KEY: j = "JSONCodingKey"; break;
            case Enum::JSON_DECODER: j = "JSONDecoder"; break;
            case Enum::JSON_ENCODER: j = "JSONEncoder"; break;
            case Enum::JSON_EXCEPTION: j = "JsonException"; break;
            case Enum::JSON_GENERATOR: j = "JsonGenerator"; break;
            case Enum::JSON_NODE: j = "JsonNode"; break;
            case Enum::JSON_NULL: j = "JSONNull"; break;
            case Enum::JSON_PARSER: j = "JsonParser"; break;
            case Enum::JSON_READER: j = "JsonReader"; break;
            case Enum::JSON_TOKEN_TYPE: j = "JsonTokenType"; break;
            case Enum::LAMBDA: j = "lambda"; break;
            case Enum::LAZY: j = "lazy"; break;
            case Enum::LEFT: j = "left"; break;
            case Enum::LET: j = "let"; break;
            case Enum::LIST: j = "list"; break;
            case Enum::LOCAL_DATE: j = "LocalDate"; break;
            case Enum::LONG_NODE: j = "LongNode"; break;
            case Enum::LOCALE: j = "Locale"; break;
            case Enum::LOCK: j = "lock"; break;
            case Enum::LONG: j = "long"; break;
            case Enum::MAP: j = "map"; break;
            case Enum::MARSHAL_JSON: j = "MarshalJSON"; break;
            case Enum::MAP_ENTRY: j = "MapEntry"; break;
            case Enum::METADATA_PROPERTY_HANDLING: j = "metadata_property_handling"; break;
            case Enum::MODULE: j = "module"; break;
            case Enum::MUTABLE: j = "mutable"; break;
            case Enum::MUTATING: j = "mutating"; break;
            case Enum::NAMESPACE: j = "namespace"; break;
            case Enum::NATIVE: j = "native"; break;
            case Enum::NEW: j = "new"; break;
            case Enum::NEWTONSOFT: j = "newtonsoft"; break;
            case Enum::NIL: j = "nil"; break;
            case Enum::NULL_NODE: j = "NullNode"; break;
            case Enum::NO: j = "NO"; break;
            case Enum::NOEXCEPT: j = "noexcept"; break;
            case Enum::NONATOMIC: j = "nonatomic"; break;
            case Enum::NONE: j = "none"; break;
            case Enum::ENUM_NONE: j = "None"; break;
            case Enum::NONLOCAL: j = "nonlocal"; break;
            case Enum::NONMUTATING: j = "nonmutating"; break;
            case Enum::NS_OBJECT: j = "NSObject"; break;
            case Enum::NO_SUCH_METHOD: j = "noSuchMethod"; break;
            case Enum::NOT: j = "not"; break;
            case Enum::NOT_EQ: j = "not_eq"; break;
            case Enum::NS_ERROR: j = "NSError"; break;
            case Enum::NS_STRING: j = "NSString"; break;
            case Enum::ENUM_NULL: j = "NULL"; break;
            case Enum::PURPLE_NULL: j = "null"; break;
            case Enum::NULLPTR: j = "nullptr"; break;
            case Enum::NUMBER: j = "number"; break;
            case Enum::OBJECT: j = "object"; break;
            case Enum::OFFSET_DATE_TIME: j = "OffsetDateTime"; break;
            case Enum::OFFSET_TIME: j = "OffsetTime"; break;
            case Enum::OBJECT_NODE: j = "ObjectNode"; break;
            case Enum::OBJECT_MAPPER: j = "ObjectMapper"; break;
            case Enum::OBJECT_READER: j = "ObjectReader"; break;
            case Enum::OBJECT_WRITER: j = "ObjectWriter"; break;
            case Enum::OF: j = "of"; break;
            case Enum::ONEWAY: j = "oneway"; break;
            case Enum::OPEN: j = "open"; break;
            case Enum::OPERATOR: j = "operator"; break;
            case Enum::OPTIONAL: j = "optional"; break;
            case Enum::OR: j = "or"; break;
            case Enum::OR_EQ: j = "or_eq"; break;
            case Enum::OUT: j = "out"; break;
            case Enum::OVERRIDE: j = "override"; break;
            case Enum::PACKAGE: j = "package"; break;
            case Enum::PARAMS: j = "params"; break;
            case Enum::PASS: j = "pass"; break;
            case Enum::PORT: j = "port"; break;
            case Enum::POSTFIX: j = "postfix"; break;
            case Enum::PRECEDENCE: j = "precedence"; break;
            case Enum::PREFIX: j = "prefix"; break;
            case Enum::PRINT: j = "print"; break;
            case Enum::PRINTF: j = "printf"; break;
            case Enum::PRINT_MEMBERS: j = "printMembers"; break;
            case Enum::PRIVATE: j = "private"; break;
            case Enum::PROTECTED: j = "protected"; break;
            case Enum::PROTOCOL: j = "Protocol"; break;
            case Enum::ENUM_PROTOCOL: j = "protocol"; break;
            case Enum::PUBLIC: j = "public"; break;
            case Enum::QUICKTYPE: j = "quicktype"; break;
            case Enum::RAISE: j = "raise"; break;
            case Enum::RANGE: j = "range"; break;
            case Enum::READONLY: j = "readonly"; break;
            case Enum::REF: j = "ref"; break;
            case Enum::REG_EXP: j = "RegExp"; break;
            case Enum::REGISTER: j = "register"; break;
            case Enum::REINTERPRET_CAST: j = "reinterpret_cast"; break;
            case Enum::REPEAT: j = "repeat"; break;
            case Enum::REQUIRE: j = "require"; break;
            case Enum::REQUIRED: j = "required"; break;
            case Enum::REQUIRES: j = "requires"; break;
            case Enum::RESTRICT: j = "restrict"; break;
            case Enum::RETAIN: j = "retain"; break;
            case Enum::RETHROWS: j = "rethrows"; break;
            case Enum::RETURN: j = "return"; break;
            case Enum::RIGHT: j = "right"; break;
            case Enum::RUNTIME_TYPE: j = "runtimeType"; break;
            case Enum::S: j = "s"; break;
            case Enum::SBYTE: j = "sbyte"; break;
            case Enum::SEALED: j = "sealed"; break;
            case Enum::SEL: j = "SEL"; break;
            case Enum::SELECT: j = "select"; break;
            case Enum::SELF: j = "Self"; break;
            case Enum::SERIALIZABLE: j = "Serializable"; break;
            case Enum::ENUM_SELF: j = "self"; break;
            case Enum::SENDABLE: j = "Sendable"; break;
            case Enum::SERIALIZE: j = "serialize"; break;
            case Enum::SERIAL_NAME: j = "SerialName"; break;
            case Enum::K_SERIALIZER: j = "KSerializer"; break;
            case Enum::PRIMITIVE_KIND: j = "PrimitiveKind"; break;
            case Enum::SERIAL_DESCRIPTOR: j = "SerialDescriptor"; break;
            case Enum::SERIALIZATION_FEATURE: j = "SerializationFeature"; break;
            case Enum::SERIALIZER_PROVIDER: j = "SerializerProvider"; break;
            case Enum::SET: j = "set"; break;
            case Enum::SHORT: j = "short"; break;
            case Enum::SIGNED: j = "signed"; break;
            case Enum::SIMPLE_MODULE: j = "SimpleModule"; break;
            case Enum::SIZEOF: j = "sizeof"; break;
            case Enum::STACKALLOC: j = "stackalloc"; break;
            case Enum::STANDARDS: j = "Standards"; break;
            case Enum::STATIC: j = "static"; break;
            case Enum::STATIC_ASSERT: j = "static_assert"; break;
            case Enum::STATIC_CAST: j = "static_cast"; break;
            case Enum::STD_DESERIALIZER: j = "StdDeserializer"; break;
            case Enum::STD_SERIALIZER: j = "StdSerializer"; break;
            case Enum::STRICTFP: j = "strictfp"; break;
            case Enum::STRING: j = "string"; break;
            case Enum::STRUCT: j = "struct"; break;
            case Enum::SUBSCRIPT: j = "subscript"; break;
            case Enum::SUPER: j = "super"; break;
            case Enum::SWITCH: j = "switch"; break;
            case Enum::SYMBOL: j = "symbol"; break;
            case Enum::SYNCHRONIZED: j = "synchronized"; break;
            case Enum::SYSTEM: j = "system"; break;
            case Enum::TEMPLATE: j = "template"; break;
            case Enum::THEN: j = "then"; break;
            case Enum::THIS: j = "this"; break;
            case Enum::TEXT_NODE: j = "TextNode"; break;
            case Enum::THREAD_LOCAL: j = "thread_local"; break;
            case Enum::THROW: j = "throw"; break;
            case Enum::THROWS: j = "throws"; break;
            case Enum::TIME_ONLY: j = "TimeOnly"; break;
            case Enum::TIME_ONLY_CONVERTER: j = "TimeOnlyConverter"; break;
            case Enum::TIME_ZONE: j = "TimeZone"; break;
            case Enum::TO_JSON: j = "to_json"; break;
            case Enum::TOP_LEVEL: j = "top_level"; break;
            case Enum::TO_STRING: j = "toString"; break;
            case Enum::TO_DICT: j = "to_dict"; break;
            case Enum::TRANSIENT: j = "transient"; break;
            case Enum::TRUE: j = "True"; break;
            case Enum::ENUM_TRUE: j = "true"; break;
            case Enum::TRY: j = "try"; break;
            case Enum::TYPE: j = "Type"; break;
            case Enum::ENUM_TYPE: j = "type"; break;
            case Enum::TYPEALIAS: j = "typealias"; break;
            case Enum::TYPEDEF: j = "typedef"; break;
            case Enum::TYPEID: j = "typeid"; break;
            case Enum::TYPENAME: j = "typename"; break;
            case Enum::TYPEOF: j = "typeof"; break;
            case Enum::UINT: j = "uint"; break;
            case Enum::ULONG: j = "ulong"; break;
            case Enum::UNCHECKED: j = "unchecked"; break;
            case Enum::UNDEFINED: j = "undefined"; break;
            case Enum::UNION: j = "union"; break;
            case Enum::UNMARSHAL_JSON: j = "UnmarshalJSON"; break;
            case Enum::USE_SERIALIZERS: j = "UseSerializers"; break;
            case Enum::UNOWNED: j = "unowned"; break;
            case Enum::UNSAFE: j = "unsafe"; break;
            case Enum::UNSIGNED: j = "unsigned"; break;
            case Enum::USHORT: j = "ushort"; break;
            case Enum::USING: j = "using"; break;
            case Enum::UTF8_JSON_READER: j = "Utf8JsonReader"; break;
            case Enum::UTF8_JSON_WRITER: j = "Utf8JsonWriter"; break;
            case Enum::UUID: j = "UUID"; break;
            case Enum::VAR: j = "var"; break;
            case Enum::VIRTUAL: j = "virtual"; break;
            case Enum::VOID: j = "void"; break;
            case Enum::VOLATILE: j = "volatile"; break;
            case Enum::WCHAR_T: j = "wchar_t"; break;
            case Enum::WEAK: j = "weak"; break;
            case Enum::WHERE: j = "where"; break;
            case Enum::WHILE: j = "while"; break;
            case Enum::WILL_SET: j = "willSet"; break;
            case Enum::WITH: j = "with"; break;
            case Enum::XOR: j = "xor"; break;
            case Enum::XOR_EQ: j = "xor_eq"; break;
            case Enum::YES: j = "YES"; break;
            case Enum::YIELD: j = "yield"; break;
            case Enum::DUMMY: j = "dummy"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Enum\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
