//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <optional>
#include <variant>
#include "json.hpp"

#include <optional>
#include <stdexcept>
#include <regex>

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

    class Abstract {
        public:
        Abstract() = default;
        virtual ~Abstract() = default;

        private:

        public:
    };

    using UnionAbstract = std::variant<Abstract, double>;

    class Any {
        public:
        Any() = default;
        virtual ~Any() = default;

        private:

        public:
    };

    using UnionAny = std::variant<Any, double>;

    class Array {
        public:
        Array() = default;
        virtual ~Array() = default;

        private:

        public:
    };

    using UnionArray = std::variant<Array, double>;

    class ArrayNode {
        public:
        ArrayNode() = default;
        virtual ~ArrayNode() = default;

        private:

        public:
    };

    using UnionArrayNode = std::variant<ArrayNode, double>;

    class As {
        public:
        As() = default;
        virtual ~As() = default;

        private:

        public:
    };

    using UnionAs = std::variant<As, double>;

    class Assert {
        public:
        Assert() = default;
        virtual ~Assert() = default;

        private:

        public:
    };

    using UnionAssert = std::variant<Assert, double>;

    class Associatedtype {
        public:
        Associatedtype() = default;
        virtual ~Associatedtype() = default;

        private:

        public:
    };

    using UnionAssociatedtype = std::variant<Associatedtype, double>;

    class Associativity {
        public:
        Associativity() = default;
        virtual ~Associativity() = default;

        private:

        public:
    };

    using UnionAssociativity = std::variant<Associativity, double>;

    class Async {
        public:
        Async() = default;
        virtual ~Async() = default;

        private:

        public:
    };

    using UnionAsync = std::variant<Async, double>;

    class Atomic {
        public:
        Atomic() = default;
        virtual ~Atomic() = default;

        private:

        public:
    };

    using UnionAtomic = std::variant<Atomic, double>;

    class Await {
        public:
        Await() = default;
        virtual ~Await() = default;

        private:

        public:
    };

    using UnionAwait = std::variant<Await, double>;

    class Base {
        public:
        Base() = default;
        virtual ~Base() = default;

        private:

        public:
    };

    using UnionBase = std::variant<Base, double>;

    class Boolean {
        public:
        Boolean() = default;
        virtual ~Boolean() = default;

        private:

        public:
    };

    using UnionBoolean = std::variant<Boolean, double>;

    class BooleanNode {
        public:
        BooleanNode() = default;
        virtual ~BooleanNode() = default;

        private:

        public:
    };

    using UnionBooleanNode = std::variant<BooleanNode, double>;

    class Bycopy {
        public:
        Bycopy() = default;
        virtual ~Bycopy() = default;

        private:

        public:
    };

    using UnionBycopy = std::variant<Bycopy, double>;

    class Byref {
        public:
        Byref() = default;
        virtual ~Byref() = default;

        private:

        public:
    };

    using UnionByref = std::variant<Byref, double>;

    class Byte {
        public:
        Byte() = default;
        virtual ~Byte() = default;

        private:

        public:
    };

    using UnionByte = std::variant<Byte, double>;

    class Calendar {
        public:
        Calendar() = default;
        virtual ~Calendar() = default;

        private:

        public:
    };

    using UnionCalendar = std::variant<Calendar, double>;

    class Chan {
        public:
        Chan() = default;
        virtual ~Chan() = default;

        private:

        public:
    };

    using UnionChan = std::variant<Chan, double>;

    class Checked {
        public:
        Checked() = default;
        virtual ~Checked() = default;

        private:

        public:
    };

    using UnionChecked = std::variant<Checked, double>;

    class Clone {
        public:
        Clone() = default;
        virtual ~Clone() = default;

        private:

        public:
    };

    using UnionClone = std::variant<Clone, double>;

    class Codable {
        public:
        Codable() = default;
        virtual ~Codable() = default;

        private:

        public:
    };

    using UnionCodable = std::variant<Codable, double>;

    class CodingKey {
        public:
        CodingKey() = default;
        virtual ~CodingKey() = default;

        private:

        public:
    };

    using UnionCodingKey = std::variant<CodingKey, double>;

    class CodingKeys {
        public:
        CodingKeys() = default;
        virtual ~CodingKeys() = default;

        private:

        public:
    };

    using UnionCodingKeys = std::variant<CodingKeys, double>;

    class Complex {
        public:
        Complex() = default;
        virtual ~Complex() = default;

        private:

        public:
    };

    using UnionComplex = std::variant<Complex, double>;

    class Console {
        public:
        Console() = default;
        virtual ~Console() = default;

        private:

        public:
    };

    using UnionConsole = std::variant<Console, double>;

    class Constructor {
        public:
        Constructor() = default;
        virtual ~Constructor() = default;

        private:

        public:
    };

    using UnionConstructor = std::variant<Constructor, double>;

    class Convenience {
        public:
        Convenience() = default;
        virtual ~Convenience() = default;

        private:

        public:
    };

    using UnionConvenience = std::variant<Convenience, double>;

    class Convert {
        public:
        Convert() = default;
        virtual ~Convert() = default;

        private:

        public:
    };

    using UnionConvert = std::variant<Convert, double>;

    class Converter {
        public:
        Converter() = default;
        virtual ~Converter() = default;

        private:

        public:
    };

    using UnionConverter = std::variant<Converter, double>;

    class CultureInfo {
        public:
        CultureInfo() = default;
        virtual ~CultureInfo() = default;

        private:

        public:
    };

    using UnionCultureInfo = std::variant<CultureInfo, double>;

    class Date {
        public:
        Date() = default;
        virtual ~Date() = default;

        private:

        public:
    };

    using UnionDate = std::variant<Date, double>;

    class DateFormatter {
        public:
        DateFormatter() = default;
        virtual ~DateFormatter() = default;

        private:

        public:
    };

    using UnionDateFormatter = std::variant<DateFormatter, double>;

    class DateOnly {
        public:
        DateOnly() = default;
        virtual ~DateOnly() = default;

        private:

        public:
    };

    using UnionDateOnly = std::variant<DateOnly, double>;

    class DateOnlyConverter {
        public:
        DateOnlyConverter() = default;
        virtual ~DateOnlyConverter() = default;

        private:

        public:
    };

    using UnionDateOnlyConverter = std::variant<DateOnlyConverter, double>;

    class DateParseHandling {
        public:
        DateParseHandling() = default;
        virtual ~DateParseHandling() = default;

        private:

        public:
    };

    using UnionDateParseHandling = std::variant<DateParseHandling, double>;

    class DateTime {
        public:
        DateTime() = default;
        virtual ~DateTime() = default;

        private:

        public:
    };

    using UnionDateTime = std::variant<DateTime, double>;

    class DateTimeStyles {
        public:
        DateTimeStyles() = default;
        virtual ~DateTimeStyles() = default;

        private:

        public:
    };

    using UnionDateTimeStyles = std::variant<DateTimeStyles, double>;

    class Debugger {
        public:
        Debugger() = default;
        virtual ~Debugger() = default;

        private:

        public:
    };

    using UnionDebugger = std::variant<Debugger, double>;

    class Decimal {
        public:
        Decimal() = default;
        virtual ~Decimal() = default;

        private:

        public:
    };

    using UnionDecimal = std::variant<Decimal, double>;

    class Declare {
        public:
        Declare() = default;
        virtual ~Declare() = default;

        private:

        public:
    };

    using UnionDeclare = std::variant<Declare, double>;

    class DecodeString {
        public:
        DecodeString() = default;
        virtual ~DecodeString() = default;

        private:

        public:
    };

    using UnionDecodeString = std::variant<DecodeString, double>;

    class Decoder {
        public:
        Decoder() = default;
        virtual ~Decoder() = default;

        private:

        public:
    };

    using UnionDecoder = std::variant<Decoder, double>;

    class DecodingError {
        public:
        DecodingError() = default;
        virtual ~DecodingError() = default;

        private:

        public:
    };

    using UnionDecodingError = std::variant<DecodingError, double>;

    class Def {
        public:
        Def() = default;
        virtual ~Def() = default;

        private:

        public:
    };

    using UnionDef = std::variant<Def, double>;

    class Defer {
        public:
        Defer() = default;
        virtual ~Defer() = default;

        private:

        public:
    };

    using UnionDefer = std::variant<Defer, double>;

    class Deinit {
        public:
        Deinit() = default;
        virtual ~Deinit() = default;

        private:

        public:
    };

    using UnionDeinit = std::variant<Deinit, double>;

    class Del {
        public:
        Del() = default;
        virtual ~Del() = default;

        private:

        public:
    };

    using UnionDel = std::variant<Del, double>;

    class Delegate {
        public:
        Delegate() = default;
        virtual ~Delegate() = default;

        private:

        public:
    };

    using UnionDelegate = std::variant<Delegate, double>;

    class DeserializationFeature {
        public:
        DeserializationFeature() = default;
        virtual ~DeserializationFeature() = default;

        private:

        public:
    };

    using UnionDeserializationFeature = std::variant<DeserializationFeature, double>;

    class Dict {
        public:
        Dict() = default;
        virtual ~Dict() = default;

        private:

        public:
    };

    using UnionDict = std::variant<Dict, double>;

    class Dictionary {
        public:
        Dictionary() = default;
        virtual ~Dictionary() = default;

        private:

        public:
    };

    using UnionDictionary = std::variant<Dictionary, double>;

    class DidSet {
        public:
        DidSet() = default;
        virtual ~DidSet() = default;

        private:

        public:
    };

    using UnionDidSet = std::variant<DidSet, double>;

    class DoubleNode {
        public:
        DoubleNode() = default;
        virtual ~DoubleNode() = default;

        private:

        public:
    };

    using UnionDoubleNode = std::variant<DoubleNode, double>;

    class Dynamic {
        public:
        Dynamic() = default;
        virtual ~Dynamic() = default;

        private:

        public:
    };

    using UnionDynamic = std::variant<Dynamic, double>;

    class Elif {
        public:
        Elif() = default;
        virtual ~Elif() = default;

        private:

        public:
    };

    using UnionElif = std::variant<Elif, double>;

    class Empty {
        public:
        Empty() = default;
        virtual ~Empty() = default;

        private:

        public:
    };

    using UnionUnion = std::variant<Empty, double>;

    class EncodeQuickType {
        public:
        EncodeQuickType() = default;
        virtual ~EncodeQuickType() = default;

        private:

        public:
    };

    using UnionEncodeQuickType = std::variant<EncodeQuickType, double>;

    class Encoder {
        public:
        Encoder() = default;
        virtual ~Encoder() = default;

        private:

        public:
    };

    using UnionEncoder = std::variant<Encoder, double>;

    class EnumValues {
        public:
        EnumValues() = default;
        virtual ~EnumValues() = default;

        private:

        public:
    };

    using UnionEnumValues = std::variant<EnumValues, double>;

    class EqualityContract {
        public:
        EqualityContract() = default;
        virtual ~EqualityContract() = default;

        private:

        public:
    };

    using UnionEqualityContract = std::variant<EqualityContract, double>;

    class Equatable {
        public:
        Equatable() = default;
        virtual ~Equatable() = default;

        private:

        public:
    };

    using UnionEquatable = std::variant<Equatable, double>;

    class Event {
        public:
        Event() = default;
        virtual ~Event() = default;

        private:

        public:
    };

    using UnionEvent = std::variant<Event, double>;

    class Except {
        public:
        Except() = default;
        virtual ~Except() = default;

        private:

        public:
    };

    using UnionExcept = std::variant<Except, double>;

    class Exception {
        public:
        Exception() = default;
        virtual ~Exception() = default;

        private:

        public:
    };

    using UnionException = std::variant<Exception, double>;

    class Exposing {
        public:
        Exposing() = default;
        virtual ~Exposing() = default;

        private:

        public:
    };

    using UnionExposing = std::variant<Exposing, double>;

    class Extends {
        public:
        Extends() = default;
        virtual ~Extends() = default;

        private:

        public:
    };

    using UnionExtends = std::variant<Extends, double>;

    class Extension {
        public:
        Extension() = default;
        virtual ~Extension() = default;

        private:

        public:
    };

    using UnionExtension = std::variant<Extension, double>;

    class Fallthrough {
        public:
        Fallthrough() = default;
        virtual ~Fallthrough() = default;

        private:

        public:
    };

    using UnionFallthrough = std::variant<Fallthrough, double>;

    class Fileprivate {
        public:
        Fileprivate() = default;
        virtual ~Fileprivate() = default;

        private:

        public:
    };

    using UnionFileprivate = std::variant<Fileprivate, double>;

    class Finally {
        public:
        Finally() = default;
        virtual ~Finally() = default;

        private:

        public:
    };

    using UnionFinally = std::variant<Finally, double>;

    class Fixed {
        public:
        Fixed() = default;
        virtual ~Fixed() = default;

        private:

        public:
    };

    using UnionFixed = std::variant<Fixed, double>;

    class UnionBoolBool {
        public:
        UnionBoolBool() = default;
        virtual ~UnionBoolBool() = default;

        private:

        public:
    };

    using TopLevelUnionBool = std::variant<UnionBoolBool, double>;

    class Foreach {
        public:
        Foreach() = default;
        virtual ~Foreach() = default;

        private:

        public:
    };

    using UnionForeach = std::variant<Foreach, double>;

    class FormatException {
        public:
        FormatException() = default;
        virtual ~FormatException() = default;

        private:

        public:
    };

    using UnionFormatException = std::variant<FormatException, double>;

    class From {
        public:
        From() = default;
        virtual ~From() = default;

        private:

        public:
    };

    using UnionFrom = std::variant<From, double>;

    class FromDict {
        public:
        FromDict() = default;
        virtual ~FromDict() = default;

        private:

        public:
    };

    using UnionFromDict = std::variant<FromDict, double>;

    class FromJson {
        public:
        FromJson() = default;
        virtual ~FromJson() = default;

        private:

        public:
    };

    using UnionFromJson = std::variant<FromJson, double>;

    class Func {
        public:
        Func() = default;
        virtual ~Func() = default;

        private:

        public:
    };

    using UnionFunc = std::variant<Func, double>;

    class Function {
        public:
        Function() = default;
        virtual ~Function() = default;

        private:

        public:
    };

    using UnionFunction = std::variant<Function, double>;

    class Get {
        public:
        Get() = default;
        virtual ~Get() = default;

        private:

        public:
    };

    using UnionGet = std::variant<Get, double>;

    class Global {
        public:
        Global() = default;
        virtual ~Global() = default;

        private:

        public:
    };

    using UnionGlobal = std::variant<Global, double>;

    class Go {
        public:
        Go() = default;
        virtual ~Go() = default;

        private:

        public:
    };

    using UnionGo = std::variant<Go, double>;

    class Guard {
        public:
        Guard() = default;
        virtual ~Guard() = default;

        private:

        public:
    };

    using UnionGuard = std::variant<Guard, double>;

    class HasOwnProperty {
        public:
        HasOwnProperty() = default;
        virtual ~HasOwnProperty() = default;

        private:

        public:
    };

    using UnionHasOwnProperty = std::variant<HasOwnProperty, double>;

    class HashCode {
        public:
        HashCode() = default;
        virtual ~HashCode() = default;

        private:

        public:
    };

    using UnionHashCode = std::variant<HashCode, double>;

    class Hashable {
        public:
        Hashable() = default;
        virtual ~Hashable() = default;

        private:

        public:
    };

    using UnionHashable = std::variant<Hashable, double>;

    class Hasher {
        public:
        Hasher() = default;
        virtual ~Hasher() = default;

        private:

        public:
    };

    using UnionHasher = std::variant<Hasher, double>;

    class Id {
        public:
        Id() = default;
        virtual ~Id() = default;

        private:

        public:
    };

    using UnionId = std::variant<Id, double>;

    class Imaginery {
        public:
        Imaginery() = default;
        virtual ~Imaginery() = default;

        private:

        public:
    };

    using UnionImaginery = std::variant<Imaginery, double>;

    class Imp {
        public:
        Imp() = default;
        virtual ~Imp() = default;

        private:

        public:
    };

    using UnionImp = std::variant<Imp, double>;

    class Implements {
        public:
        Implements() = default;
        virtual ~Implements() = default;

        private:

        public:
    };

    using UnionImplements = std::variant<Implements, double>;

    class Implicit {
        public:
        Implicit() = default;
        virtual ~Implicit() = default;

        private:

        public:
    };

    using UnionImplicit = std::variant<Implicit, double>;

    class In {
        public:
        In() = default;
        virtual ~In() = default;

        private:

        public:
    };

    using UnionIn = std::variant<In, double>;

    class Indirect {
        public:
        Indirect() = default;
        virtual ~Indirect() = default;

        private:

        public:
    };

    using UnionIndirect = std::variant<Indirect, double>;

    class Infix {
        public:
        Infix() = default;
        virtual ~Infix() = default;

        private:

        public:
    };

    using UnionInfix = std::variant<Infix, double>;

    class Init {
        public:
        Init() = default;
        virtual ~Init() = default;

        private:

        public:
    };

    using UnionInit = std::variant<Init, double>;

    class Inout {
        public:
        Inout() = default;
        virtual ~Inout() = default;

        private:

        public:
    };

    using UnionInout = std::variant<Inout, double>;

    class Instanceof {
        public:
        Instanceof() = default;
        virtual ~Instanceof() = default;

        private:

        public:
    };

    using UnionInstanceof = std::variant<Instanceof, double>;

    class IntNode {
        public:
        IntNode() = default;
        virtual ~IntNode() = default;

        private:

        public:
    };

    using UnionIntNode = std::variant<IntNode, double>;

    class Interface {
        public:
        Interface() = default;
        virtual ~Interface() = default;

        private:

        public:
    };

    using UnionInterface = std::variant<Interface, double>;

    class Internal {
        public:
        Internal() = default;
        virtual ~Internal() = default;

        private:

        public:
    };

    using UnionInternal = std::variant<Internal, double>;

    class Is {
        public:
        Is() = default;
        virtual ~Is() = default;

        private:

        public:
    };

    using UnionIs = std::variant<Is, double>;

    class IsoDateTimeOffsetConverter {
        public:
        IsoDateTimeOffsetConverter() = default;
        virtual ~IsoDateTimeOffsetConverter() = default;

        private:

        public:
    };

    using UnionIsoDateTimeOffsetConverter = std::variant<IsoDateTimeOffsetConverter, double>;

    class Iterable {
        public:
        Iterable() = default;
        virtual ~Iterable() = default;

        private:

        public:
    };

    using UnionIterable = std::variant<Iterable, double>;

    class Jdec {
        public:
        Jdec() = default;
        virtual ~Jdec() = default;

        private:

        public:
    };

    using UnionJdec = std::variant<Jdec, double>;

    class Jenc {
        public:
        Jenc() = default;
        virtual ~Jenc() = default;

        private:

        public:
    };

    using UnionJenc = std::variant<Jenc, double>;

    class Jpipe {
        public:
        Jpipe() = default;
        virtual ~Jpipe() = default;

        private:

        public:
    };

    using UnionJpipe = std::variant<Jpipe, double>;

    class Json {
        public:
        Json() = default;
        virtual ~Json() = default;

        private:

        public:
    };

    using UnionJson = std::variant<Json, double>;

    class JsonAny {
        public:
        JsonAny() = default;
        virtual ~JsonAny() = default;

        private:

        public:
    };

    using UnionJsonAny = std::variant<JsonAny, double>;

    class JsonCodingKey {
        public:
        JsonCodingKey() = default;
        virtual ~JsonCodingKey() = default;

        private:

        public:
    };

    using UnionJsonCodingKey = std::variant<JsonCodingKey, double>;

    class JsonConverter {
        public:
        JsonConverter() = default;
        virtual ~JsonConverter() = default;

        private:

        public:
    };

    using UnionJsonConverter = std::variant<JsonConverter, double>;

    class JsonDecoder {
        public:
        JsonDecoder() = default;
        virtual ~JsonDecoder() = default;

        private:

        public:
    };

    using UnionJsonDecoder = std::variant<JsonDecoder, double>;

    class JsonEncoder {
        public:
        JsonEncoder() = default;
        virtual ~JsonEncoder() = default;

        private:

        public:
    };

    using UnionJsonEncoder = std::variant<JsonEncoder, double>;

    class JsonException {
        public:
        JsonException() = default;
        virtual ~JsonException() = default;

        private:

        public:
    };

    using UnionJsonException = std::variant<JsonException, double>;

    class JsonGenerator {
        public:
        JsonGenerator() = default;
        virtual ~JsonGenerator() = default;

        private:

        public:
    };

    using UnionJsonGenerator = std::variant<JsonGenerator, double>;

    class JsonNode {
        public:
        JsonNode() = default;
        virtual ~JsonNode() = default;

        private:

        public:
    };

    using UnionJsonNode = std::variant<JsonNode, double>;

    class JsonNull {
        public:
        JsonNull() = default;
        virtual ~JsonNull() = default;

        private:

        public:
    };

    using UnionJsonNull = std::variant<JsonNull, double>;

    class JsonParser {
        public:
        JsonParser() = default;
        virtual ~JsonParser() = default;

        private:

        public:
    };

    using UnionJsonParser = std::variant<JsonParser, double>;

    class JsonReader {
        public:
        JsonReader() = default;
        virtual ~JsonReader() = default;

        private:

        public:
    };

    using UnionJsonReader = std::variant<JsonReader, double>;

    class JsonSerializer {
        public:
        JsonSerializer() = default;
        virtual ~JsonSerializer() = default;

        private:

        public:
    };

    using UnionJsonSerializer = std::variant<JsonSerializer, double>;

    class JsonToken {
        public:
        JsonToken() = default;
        virtual ~JsonToken() = default;

        private:

        public:
    };

    using UnionJsonToken = std::variant<JsonToken, double>;

    class JsonTokenType {
        public:
        JsonTokenType() = default;
        virtual ~JsonTokenType() = default;

        private:

        public:
    };

    using UnionJsonTokenType = std::variant<JsonTokenType, double>;

    class JsonWriter {
        public:
        JsonWriter() = default;
        virtual ~JsonWriter() = default;

        private:

        public:
    };

    using UnionJsonWriter = std::variant<JsonWriter, double>;

    class KSerializer {
        public:
        KSerializer() = default;
        virtual ~KSerializer() = default;

        private:

        public:
    };

    using UnionKSerializer = std::variant<KSerializer, double>;

    class Lambda {
        public:
        Lambda() = default;
        virtual ~Lambda() = default;

        private:

        public:
    };

    using UnionLambda = std::variant<Lambda, double>;

    class Lazy {
        public:
        Lazy() = default;
        virtual ~Lazy() = default;

        private:

        public:
    };

    using UnionLazy = std::variant<Lazy, double>;

    class Left {
        public:
        Left() = default;
        virtual ~Left() = default;

        private:

        public:
    };

    using UnionLeft = std::variant<Left, double>;

    class Let {
        public:
        Let() = default;
        virtual ~Let() = default;

        private:

        public:
    };

    using UnionLet = std::variant<Let, double>;

    class List {
        public:
        List() = default;
        virtual ~List() = default;

        private:

        public:
    };

    using UnionList = std::variant<List, double>;

    class LocalDate {
        public:
        LocalDate() = default;
        virtual ~LocalDate() = default;

        private:

        public:
    };

    using UnionLocalDate = std::variant<LocalDate, double>;

    class Locale {
        public:
        Locale() = default;
        virtual ~Locale() = default;

        private:

        public:
    };

    using UnionLocale = std::variant<Locale, double>;

    class Lock {
        public:
        Lock() = default;
        virtual ~Lock() = default;

        private:

        public:
    };

    using UnionLock = std::variant<Lock, double>;

    class LongNode {
        public:
        LongNode() = default;
        virtual ~LongNode() = default;

        private:

        public:
    };

    using UnionLongNode = std::variant<LongNode, double>;

    class Map {
        public:
        Map() = default;
        virtual ~Map() = default;

        private:

        public:
    };

    using UnionMap = std::variant<Map, double>;

    class MapEntry {
        public:
        MapEntry() = default;
        virtual ~MapEntry() = default;

        private:

        public:
    };

    using UnionMapEntry = std::variant<MapEntry, double>;

    class MarshalJson {
        public:
        MarshalJson() = default;
        virtual ~MarshalJson() = default;

        private:

        public:
    };

    using UnionMarshalJson = std::variant<MarshalJson, double>;

    class MetadataPropertyHandling {
        public:
        MetadataPropertyHandling() = default;
        virtual ~MetadataPropertyHandling() = default;

        private:

        public:
    };

    using UnionMetadataPropertyHandling = std::variant<MetadataPropertyHandling, double>;

    class Mutating {
        public:
        Mutating() = default;
        virtual ~Mutating() = default;

        private:

        public:
    };

    using UnionMutating = std::variant<Mutating, double>;

    class Native {
        public:
        Native() = default;
        virtual ~Native() = default;

        private:

        public:
    };

    using UnionNative = std::variant<Native, double>;

    class Newtonsoft {
        public:
        Newtonsoft() = default;
        virtual ~Newtonsoft() = default;

        private:

        public:
    };

    using UnionNewtonsoft = std::variant<Newtonsoft, double>;

    class Nil {
        public:
        Nil() = default;
        virtual ~Nil() = default;

        private:

        public:
    };

    using UnionNil = std::variant<Nil, double>;

    class No {
        public:
        No() = default;
        virtual ~No() = default;

        private:

        public:
    };

    using UnionNo = std::variant<No, double>;

    class NoSuchMethod {
        public:
        NoSuchMethod() = default;
        virtual ~NoSuchMethod() = default;

        private:

        public:
    };

    using UnionNoSuchMethod = std::variant<NoSuchMethod, double>;

    class Nonatomic {
        public:
        Nonatomic() = default;
        virtual ~Nonatomic() = default;

        private:

        public:
    };

    using UnionNonatomic = std::variant<Nonatomic, double>;

    class None {
        public:
        None() = default;
        virtual ~None() = default;

        private:

        public:
    };

    using UnionNone = std::variant<None, double>;

    class Nonlocal {
        public:
        Nonlocal() = default;
        virtual ~Nonlocal() = default;

        private:

        public:
    };

    using UnionNonlocal = std::variant<Nonlocal, double>;

    class Nonmutating {
        public:
        Nonmutating() = default;
        virtual ~Nonmutating() = default;

        private:

        public:
    };

    using UnionNonmutating = std::variant<Nonmutating, double>;

    class NsError {
        public:
        NsError() = default;
        virtual ~NsError() = default;

        private:

        public:
    };

    using UnionNsError = std::variant<NsError, double>;

    class NsObject {
        public:
        NsObject() = default;
        virtual ~NsObject() = default;

        private:

        public:
    };

    using UnionNsObject = std::variant<NsObject, double>;

    class NsString {
        public:
        NsString() = default;
        virtual ~NsString() = default;

        private:

        public:
    };

    using UnionNsString = std::variant<NsString, double>;

    class Null {
        public:
        Null() = default;
        virtual ~Null() = default;

        private:

        public:
    };

    using UnionNull = std::variant<Null, double>;

    class NullNode {
        public:
        NullNode() = default;
        virtual ~NullNode() = default;

        private:

        public:
    };

    using UnionNullNode = std::variant<NullNode, double>;

    class Number {
        public:
        Number() = default;
        virtual ~Number() = default;

        private:

        public:
    };

    using UnionNumber = std::variant<Number, double>;

    class Object {
        public:
        Object() = default;
        virtual ~Object() = default;

        private:

        public:
    };

    using UnionObject = std::variant<Object, double>;

    class ObjectMapper {
        public:
        ObjectMapper() = default;
        virtual ~ObjectMapper() = default;

        private:

        public:
    };

    using UnionObjectMapper = std::variant<ObjectMapper, double>;

    class ObjectNode {
        public:
        ObjectNode() = default;
        virtual ~ObjectNode() = default;

        private:

        public:
    };

    using UnionObjectNode = std::variant<ObjectNode, double>;

    class ObjectReader {
        public:
        ObjectReader() = default;
        virtual ~ObjectReader() = default;

        private:

        public:
    };

    using UnionObjectReader = std::variant<ObjectReader, double>;

    class ObjectWriter {
        public:
        ObjectWriter() = default;
        virtual ~ObjectWriter() = default;

        private:

        public:
    };

    using UnionObjectWriter = std::variant<ObjectWriter, double>;

    class Of {
        public:
        Of() = default;
        virtual ~Of() = default;

        private:

        public:
    };

    using UnionOf = std::variant<Of, double>;

    class OffsetDateTime {
        public:
        OffsetDateTime() = default;
        virtual ~OffsetDateTime() = default;

        private:

        public:
    };

    using UnionOffsetDateTime = std::variant<OffsetDateTime, double>;

    class OffsetTime {
        public:
        OffsetTime() = default;
        virtual ~OffsetTime() = default;

        private:

        public:
    };

    using UnionOffsetTime = std::variant<OffsetTime, double>;

    class Oneway {
        public:
        Oneway() = default;
        virtual ~Oneway() = default;

        private:

        public:
    };

    using UnionOneway = std::variant<Oneway, double>;

    class Open {
        public:
        Open() = default;
        virtual ~Open() = default;

        private:

        public:
    };

    using UnionOpen = std::variant<Open, double>;

    class Optional {
        public:
        Optional() = default;
        virtual ~Optional() = default;

        private:

        public:
    };

    using UnionOptional = std::variant<Optional, double>;

    class Out {
        public:
        Out() = default;
        virtual ~Out() = default;

        private:

        public:
    };

    using UnionOut = std::variant<Out, double>;

    class Package {
        public:
        Package() = default;
        virtual ~Package() = default;

        private:

        public:
    };

    using UnionPackage = std::variant<Package, double>;

    class Params {
        public:
        Params() = default;
        virtual ~Params() = default;

        private:

        public:
    };

    using UnionParams = std::variant<Params, double>;

    class Pass {
        public:
        Pass() = default;
        virtual ~Pass() = default;

        private:

        public:
    };

    using UnionPass = std::variant<Pass, double>;

    class Port {
        public:
        Port() = default;
        virtual ~Port() = default;

        private:

        public:
    };

    using UnionPort = std::variant<Port, double>;

    class Postfix {
        public:
        Postfix() = default;
        virtual ~Postfix() = default;

        private:

        public:
    };

    using UnionPostfix = std::variant<Postfix, double>;

    class Precedence {
        public:
        Precedence() = default;
        virtual ~Precedence() = default;

        private:

        public:
    };

    using UnionPrecedence = std::variant<Precedence, double>;

    class Prefix {
        public:
        Prefix() = default;
        virtual ~Prefix() = default;

        private:

        public:
    };

    using UnionPrefix = std::variant<Prefix, double>;

    class PrimitiveKind {
        public:
        PrimitiveKind() = default;
        virtual ~PrimitiveKind() = default;

        private:

        public:
    };

    using UnionPrimitiveKind = std::variant<PrimitiveKind, double>;

    class Print {
        public:
        Print() = default;
        virtual ~Print() = default;

        private:

        public:
    };

    using UnionPrint = std::variant<Print, double>;

    class PrintMembers {
        public:
        PrintMembers() = default;
        virtual ~PrintMembers() = default;

        private:

        public:
    };

    using UnionPrintMembers = std::variant<PrintMembers, double>;

    class Printf {
        public:
        Printf() = default;
        virtual ~Printf() = default;

        private:

        public:
    };

    using UnionPrintf = std::variant<Printf, double>;

    class Protocol {
        public:
        Protocol() = default;
        virtual ~Protocol() = default;

        private:

        public:
    };

    using UnionProtocol = std::variant<Protocol, double>;

    class BoolClass {
        public:
        BoolClass() = default;
        virtual ~BoolClass() = default;

        private:

        public:
    };

    using UnionBoolUnion = std::variant<BoolClass, double>;

    class ClassClass {
        public:
        ClassClass() = default;
        virtual ~ClassClass() = default;

        private:

        public:
    };

    using UnionClassUnion = std::variant<ClassClass, double>;

    class FalseClass {
        public:
        FalseClass() = default;
        virtual ~FalseClass() = default;

        private:

        public:
    };

    using UnionFalseUnion = std::variant<FalseClass, double>;

    class TrueClass {
        public:
        TrueClass() = default;
        virtual ~TrueClass() = default;

        private:

        public:
    };

    using UnionTrueUnion = std::variant<TrueClass, double>;

    class Quicktype {
        public:
        Quicktype() = default;
        virtual ~Quicktype() = default;

        private:

        public:
    };

    using UnionQuicktype = std::variant<Quicktype, double>;

    class Raise {
        public:
        Raise() = default;
        virtual ~Raise() = default;

        private:

        public:
    };

    using UnionRaise = std::variant<Raise, double>;

    class Range {
        public:
        Range() = default;
        virtual ~Range() = default;

        private:

        public:
    };

    using UnionRange = std::variant<Range, double>;

    class Readonly {
        public:
        Readonly() = default;
        virtual ~Readonly() = default;

        private:

        public:
    };

    using UnionReadonly = std::variant<Readonly, double>;

    class Ref {
        public:
        Ref() = default;
        virtual ~Ref() = default;

        private:

        public:
    };

    using UnionRef = std::variant<Ref, double>;

    class RegExp {
        public:
        RegExp() = default;
        virtual ~RegExp() = default;

        private:

        public:
    };

    using UnionRegExp = std::variant<RegExp, double>;

    class Repeat {
        public:
        Repeat() = default;
        virtual ~Repeat() = default;

        private:

        public:
    };

    using UnionRepeat = std::variant<Repeat, double>;

    class Require {
        public:
        Require() = default;
        virtual ~Require() = default;

        private:

        public:
    };

    using UnionRequire = std::variant<Require, double>;

    class Required {
        public:
        Required() = default;
        virtual ~Required() = default;

        private:

        public:
    };

    using UnionRequired = std::variant<Required, double>;

    class Restrict {
        public:
        Restrict() = default;
        virtual ~Restrict() = default;

        private:

        public:
    };

    using UnionRestrict = std::variant<Restrict, double>;

    class Retain {
        public:
        Retain() = default;
        virtual ~Retain() = default;

        private:

        public:
    };

    using UnionRetain = std::variant<Retain, double>;

    class Rethrows {
        public:
        Rethrows() = default;
        virtual ~Rethrows() = default;

        private:

        public:
    };

    using UnionRethrows = std::variant<Rethrows, double>;

    class Right {
        public:
        Right() = default;
        virtual ~Right() = default;

        private:

        public:
    };

    using UnionRight = std::variant<Right, double>;

    class RuntimeType {
        public:
        RuntimeType() = default;
        virtual ~RuntimeType() = default;

        private:

        public:
    };

    using UnionRuntimeType = std::variant<RuntimeType, double>;

    class S {
        public:
        S() = default;
        virtual ~S() = default;

        private:

        public:
    };

    using UnionS = std::variant<S, double>;

    class Sbyte {
        public:
        Sbyte() = default;
        virtual ~Sbyte() = default;

        private:

        public:
    };

    using UnionSbyte = std::variant<Sbyte, double>;

    class Sealed {
        public:
        Sealed() = default;
        virtual ~Sealed() = default;

        private:

        public:
    };

    using UnionSealed = std::variant<Sealed, double>;

    class Sel {
        public:
        Sel() = default;
        virtual ~Sel() = default;

        private:

        public:
    };

    using UnionSel = std::variant<Sel, double>;

    class Select {
        public:
        Select() = default;
        virtual ~Select() = default;

        private:

        public:
    };

    using UnionSelect = std::variant<Select, double>;

    class Self {
        public:
        Self() = default;
        virtual ~Self() = default;

        private:

        public:
    };

    using UnionSelf = std::variant<Self, double>;

    class Sendable {
        public:
        Sendable() = default;
        virtual ~Sendable() = default;

        private:

        public:
    };

    using UnionSendable = std::variant<Sendable, double>;

    class SerialDescriptor {
        public:
        SerialDescriptor() = default;
        virtual ~SerialDescriptor() = default;

        private:

        public:
    };

    using UnionSerialDescriptor = std::variant<SerialDescriptor, double>;

    class SerialName {
        public:
        SerialName() = default;
        virtual ~SerialName() = default;

        private:

        public:
    };

    using UnionSerialName = std::variant<SerialName, double>;

    class Serializable {
        public:
        Serializable() = default;
        virtual ~Serializable() = default;

        private:

        public:
    };

    using UnionSerializable = std::variant<Serializable, double>;

    class SerializationFeature {
        public:
        SerializationFeature() = default;
        virtual ~SerializationFeature() = default;

        private:

        public:
    };

    using UnionSerializationFeature = std::variant<SerializationFeature, double>;

    class Serialize {
        public:
        Serialize() = default;
        virtual ~Serialize() = default;

        private:

        public:
    };

    using UnionSerialize = std::variant<Serialize, double>;

    class SerializerProvider {
        public:
        SerializerProvider() = default;
        virtual ~SerializerProvider() = default;

        private:

        public:
    };

    using UnionSerializerProvider = std::variant<SerializerProvider, double>;

    class Set {
        public:
        Set() = default;
        virtual ~Set() = default;

        private:

        public:
    };

    using UnionSet = std::variant<Set, double>;

    class SimpleModule {
        public:
        SimpleModule() = default;
        virtual ~SimpleModule() = default;

        private:

        public:
    };

    using UnionSimpleModule = std::variant<SimpleModule, double>;

    class Stackalloc {
        public:
        Stackalloc() = default;
        virtual ~Stackalloc() = default;

        private:

        public:
    };

    using UnionStackalloc = std::variant<Stackalloc, double>;

    class Standards {
        public:
        Standards() = default;
        virtual ~Standards() = default;

        private:

        public:
    };

    using UnionStandards = std::variant<Standards, double>;

    class StdDeserializer {
        public:
        StdDeserializer() = default;
        virtual ~StdDeserializer() = default;

        private:

        public:
    };

    using UnionStdDeserializer = std::variant<StdDeserializer, double>;

    class StdSerializer {
        public:
        StdSerializer() = default;
        virtual ~StdSerializer() = default;

        private:

        public:
    };

    using UnionStdSerializer = std::variant<StdSerializer, double>;

    class Strictfp {
        public:
        Strictfp() = default;
        virtual ~Strictfp() = default;

        private:

        public:
    };

    using UnionStrictfp = std::variant<Strictfp, double>;

    class String {
        public:
        String() = default;
        virtual ~String() = default;

        private:

        public:
    };

    using UnionString = std::variant<String, double>;

    class Subscript {
        public:
        Subscript() = default;
        virtual ~Subscript() = default;

        private:

        public:
    };

    using UnionSubscript = std::variant<Subscript, double>;

    class Super {
        public:
        Super() = default;
        virtual ~Super() = default;

        private:

        public:
    };

    using UnionSuper = std::variant<Super, double>;

    class Symbol {
        public:
        Symbol() = default;
        virtual ~Symbol() = default;

        private:

        public:
    };

    using UnionSymbol = std::variant<Symbol, double>;

    class System {
        public:
        System() = default;
        virtual ~System() = default;

        private:

        public:
    };

    using UnionSystem = std::variant<System, double>;

    class TextNode {
        public:
        TextNode() = default;
        virtual ~TextNode() = default;

        private:

        public:
    };

    using UnionTextNode = std::variant<TextNode, double>;

    class Then {
        public:
        Then() = default;
        virtual ~Then() = default;

        private:

        public:
    };

    using UnionThen = std::variant<Then, double>;

    class Throws {
        public:
        Throws() = default;
        virtual ~Throws() = default;

        private:

        public:
    };

    using UnionThrows = std::variant<Throws, double>;

    class TimeOnly {
        public:
        TimeOnly() = default;
        virtual ~TimeOnly() = default;

        private:

        public:
    };

    using UnionTimeOnly = std::variant<TimeOnly, double>;

    class TimeOnlyConverter {
        public:
        TimeOnlyConverter() = default;
        virtual ~TimeOnlyConverter() = default;

        private:

        public:
    };

    using UnionTimeOnlyConverter = std::variant<TimeOnlyConverter, double>;

    class TimeZone {
        public:
        TimeZone() = default;
        virtual ~TimeZone() = default;

        private:

        public:
    };

    using UnionTimeZone = std::variant<TimeZone, double>;

    class ToDict {
        public:
        ToDict() = default;
        virtual ~ToDict() = default;

        private:

        public:
    };

    using UnionToDict = std::variant<ToDict, double>;

    class ToJson {
        public:
        ToJson() = default;
        virtual ~ToJson() = default;

        private:

        public:
    };

    using UnionToJson = std::variant<ToJson, double>;

    class ToString {
        public:
        ToString() = default;
        virtual ~ToString() = default;

        private:

        public:
    };

    using UnionToString = std::variant<ToString, double>;

    class TopLevelClass {
        public:
        TopLevelClass() = default;
        virtual ~TopLevelClass() = default;

        private:

        public:
    };

    using UnionTopLevel = std::variant<TopLevelClass, double>;

    class Alignas {
        public:
        Alignas() = default;
        virtual ~Alignas() = default;

        private:

        public:
    };

    using UnionAlignas = std::variant<Alignas, double>;

    class Alignof {
        public:
        Alignof() = default;
        virtual ~Alignof() = default;

        private:

        public:
    };

    using UnionAlignof = std::variant<Alignof, double>;

    class And {
        public:
        And() = default;
        virtual ~And() = default;

        private:

        public:
    };

    using UnionAnd = std::variant<And, double>;

    class AndEq {
        public:
        AndEq() = default;
        virtual ~AndEq() = default;

        private:

        public:
    };

    using UnionAndEq = std::variant<AndEq, double>;

    class AnyClass {
        public:
        AnyClass() = default;
        virtual ~AnyClass() = default;

        private:

        public:
    };

    using UnionAnyUnion = std::variant<AnyClass, double>;

    class Asm {
        public:
        Asm() = default;
        virtual ~Asm() = default;

        private:

        public:
    };

    using UnionAsm = std::variant<Asm, double>;

    class AtomicCancel {
        public:
        AtomicCancel() = default;
        virtual ~AtomicCancel() = default;

        private:

        public:
    };

    using UnionAtomicCancel = std::variant<AtomicCancel, double>;

    class AtomicCommit {
        public:
        AtomicCommit() = default;
        virtual ~AtomicCommit() = default;

        private:

        public:
    };

    using UnionAtomicCommit = std::variant<AtomicCommit, double>;

    class AtomicNoexcept {
        public:
        AtomicNoexcept() = default;
        virtual ~AtomicNoexcept() = default;

        private:

        public:
    };

    using UnionAtomicNoexcept = std::variant<AtomicNoexcept, double>;

    class Auto {
        public:
        Auto() = default;
        virtual ~Auto() = default;

        private:

        public:
    };

    using UnionAuto = std::variant<Auto, double>;

    class Bitand {
        public:
        Bitand() = default;
        virtual ~Bitand() = default;

        private:

        public:
    };

    using UnionBitand = std::variant<Bitand, double>;

    class Bitor {
        public:
        Bitor() = default;
        virtual ~Bitor() = default;

        private:

        public:
    };

    using UnionBitor = std::variant<Bitor, double>;

    class Bool {
        public:
        Bool() = default;
        virtual ~Bool() = default;

        private:

        public:
    };

    using UnionBool = std::variant<Bool, double>;

    class Break {
        public:
        Break() = default;
        virtual ~Break() = default;

        private:

        public:
    };

    using UnionBreak = std::variant<Break, double>;

    class Case {
        public:
        Case() = default;
        virtual ~Case() = default;

        private:

        public:
    };

    using UnionCase = std::variant<Case, double>;

    class Catch {
        public:
        Catch() = default;
        virtual ~Catch() = default;

        private:

        public:
    };

    using UnionCatch = std::variant<Catch, double>;

    class Char {
        public:
        Char() = default;
        virtual ~Char() = default;

        private:

        public:
    };

    using UnionChar = std::variant<Char, double>;

    class Char16T {
        public:
        Char16T() = default;
        virtual ~Char16T() = default;

        private:

        public:
    };

    using UnionChar16T = std::variant<Char16T, double>;

    class Char32T {
        public:
        Char32T() = default;
        virtual ~Char32T() = default;

        private:

        public:
    };

    using UnionChar32T = std::variant<Char32T, double>;

    class Class {
        public:
        Class() = default;
        virtual ~Class() = default;

        private:

        public:
    };

    using UnionClass = std::variant<Class, double>;

    class CoAwait {
        public:
        CoAwait() = default;
        virtual ~CoAwait() = default;

        private:

        public:
    };

    using UnionCoAwait = std::variant<CoAwait, double>;

    class CoReturn {
        public:
        CoReturn() = default;
        virtual ~CoReturn() = default;

        private:

        public:
    };

    using UnionCoReturn = std::variant<CoReturn, double>;

    class CoYield {
        public:
        CoYield() = default;
        virtual ~CoYield() = default;

        private:

        public:
    };

    using UnionCoYield = std::variant<CoYield, double>;

    class Compl {
        public:
        Compl() = default;
        virtual ~Compl() = default;

        private:

        public:
    };

    using UnionCompl = std::variant<Compl, double>;

    class Concept {
        public:
        Concept() = default;
        virtual ~Concept() = default;

        private:

        public:
    };

    using UnionConcept = std::variant<Concept, double>;

    class Const {
        public:
        Const() = default;
        virtual ~Const() = default;

        private:

        public:
    };

    using UnionConst = std::variant<Const, double>;

    class ConstCast {
        public:
        ConstCast() = default;
        virtual ~ConstCast() = default;

        private:

        public:
    };

    using UnionConstCast = std::variant<ConstCast, double>;

    class Constexpr {
        public:
        Constexpr() = default;
        virtual ~Constexpr() = default;

        private:

        public:
    };

    using UnionConstexpr = std::variant<Constexpr, double>;

    class Continue {
        public:
        Continue() = default;
        virtual ~Continue() = default;

        private:

        public:
    };

    using UnionContinue = std::variant<Continue, double>;

    class Decltype {
        public:
        Decltype() = default;
        virtual ~Decltype() = default;

        private:

        public:
    };

    using UnionDecltype = std::variant<Decltype, double>;

    class Default {
        public:
        Default() = default;
        virtual ~Default() = default;

        private:

        public:
    };

    using UnionDefault = std::variant<Default, double>;

    class Delete {
        public:
        Delete() = default;
        virtual ~Delete() = default;

        private:

        public:
    };

    using UnionDelete = std::variant<Delete, double>;

    class Do {
        public:
        Do() = default;
        virtual ~Do() = default;

        private:

        public:
    };

    using UnionDo = std::variant<Do, double>;

    class Double {
        public:
        Double() = default;
        virtual ~Double() = default;

        private:

        public:
    };

    using UnionDouble = std::variant<Double, double>;

    class DynamicCast {
        public:
        DynamicCast() = default;
        virtual ~DynamicCast() = default;

        private:

        public:
    };

    using UnionDynamicCast = std::variant<DynamicCast, double>;

    class Else {
        public:
        Else() = default;
        virtual ~Else() = default;

        private:

        public:
    };

    using UnionElse = std::variant<Else, double>;

    class Enum {
        public:
        Enum() = default;
        virtual ~Enum() = default;

        private:

        public:
    };

    using UnionEnum = std::variant<Enum, double>;

    class Explicit {
        public:
        Explicit() = default;
        virtual ~Explicit() = default;

        private:

        public:
    };

    using UnionExplicit = std::variant<Explicit, double>;

    class Export {
        public:
        Export() = default;
        virtual ~Export() = default;

        private:

        public:
    };

    using UnionExport = std::variant<Export, double>;

    class Extern {
        public:
        Extern() = default;
        virtual ~Extern() = default;

        private:

        public:
    };

    using UnionExtern = std::variant<Extern, double>;

    class False {
        public:
        False() = default;
        virtual ~False() = default;

        private:

        public:
    };

    using UnionFalse = std::variant<False, double>;

    class Final {
        public:
        Final() = default;
        virtual ~Final() = default;

        private:

        public:
    };

    using UnionFinal = std::variant<Final, double>;

    class Float {
        public:
        Float() = default;
        virtual ~Float() = default;

        private:

        public:
    };

    using UnionFloat = std::variant<Float, double>;

    class For {
        public:
        For() = default;
        virtual ~For() = default;

        private:

        public:
    };

    using UnionFor = std::variant<For, double>;

    class Friend {
        public:
        Friend() = default;
        virtual ~Friend() = default;

        private:

        public:
    };

    using UnionFriend = std::variant<Friend, double>;

    class Goto {
        public:
        Goto() = default;
        virtual ~Goto() = default;

        private:

        public:
    };

    using UnionGoto = std::variant<Goto, double>;

    class If {
        public:
        If() = default;
        virtual ~If() = default;

        private:

        public:
    };

    using UnionIf = std::variant<If, double>;

    class Import {
        public:
        Import() = default;
        virtual ~Import() = default;

        private:

        public:
    };

    using UnionImport = std::variant<Import, double>;

    class Inline {
        public:
        Inline() = default;
        virtual ~Inline() = default;

        private:

        public:
    };

    using UnionInline = std::variant<Inline, double>;

    class Int {
        public:
        Int() = default;
        virtual ~Int() = default;

        private:

        public:
    };

    using UnionInt = std::variant<Int, double>;

    class Long {
        public:
        Long() = default;
        virtual ~Long() = default;

        private:

        public:
    };

    using UnionLong = std::variant<Long, double>;

    class Module {
        public:
        Module() = default;
        virtual ~Module() = default;

        private:

        public:
    };

    using UnionModule = std::variant<Module, double>;

    class Mutable {
        public:
        Mutable() = default;
        virtual ~Mutable() = default;

        private:

        public:
    };

    using UnionMutable = std::variant<Mutable, double>;

    class Namespace {
        public:
        Namespace() = default;
        virtual ~Namespace() = default;

        private:

        public:
    };

    using UnionNamespace = std::variant<Namespace, double>;

    class New {
        public:
        New() = default;
        virtual ~New() = default;

        private:

        public:
    };

    using UnionNew = std::variant<New, double>;

    class Noexcept {
        public:
        Noexcept() = default;
        virtual ~Noexcept() = default;

        private:

        public:
    };

    using UnionNoexcept = std::variant<Noexcept, double>;

    class NoneClass {
        public:
        NoneClass() = default;
        virtual ~NoneClass() = default;

        private:

        public:
    };

    using UnionNoneUnion = std::variant<NoneClass, double>;

    class Not {
        public:
        Not() = default;
        virtual ~Not() = default;

        private:

        public:
    };

    using UnionNot = std::variant<Not, double>;

    class NotEq {
        public:
        NotEq() = default;
        virtual ~NotEq() = default;

        private:

        public:
    };

    using UnionNotEq = std::variant<NotEq, double>;

    class NullClass {
        public:
        NullClass() = default;
        virtual ~NullClass() = default;

        private:

        public:
    };

    using UnionNullUnion = std::variant<NullClass, double>;

    class Nullptr {
        public:
        Nullptr() = default;
        virtual ~Nullptr() = default;

        private:

        public:
    };

    using UnionNullptr = std::variant<Nullptr, double>;

    class Operator {
        public:
        Operator() = default;
        virtual ~Operator() = default;

        private:

        public:
    };

    using UnionOperator = std::variant<Operator, double>;

    class Or {
        public:
        Or() = default;
        virtual ~Or() = default;

        private:

        public:
    };

    using UnionOr = std::variant<Or, double>;

    class OrEq {
        public:
        OrEq() = default;
        virtual ~OrEq() = default;

        private:

        public:
    };

    using UnionOrEq = std::variant<OrEq, double>;

    class Override {
        public:
        Override() = default;
        virtual ~Override() = default;

        private:

        public:
    };

    using UnionOverride = std::variant<Override, double>;

    class Private {
        public:
        Private() = default;
        virtual ~Private() = default;

        private:

        public:
    };

    using UnionPrivate = std::variant<Private, double>;

    class Protected {
        public:
        Protected() = default;
        virtual ~Protected() = default;

        private:

        public:
    };

    using UnionProtected = std::variant<Protected, double>;

    class ProtocolClass {
        public:
        ProtocolClass() = default;
        virtual ~ProtocolClass() = default;

        private:

        public:
    };

    using UnionProtocolUnion = std::variant<ProtocolClass, double>;

    class Public {
        public:
        Public() = default;
        virtual ~Public() = default;

        private:

        public:
    };

    using UnionPublic = std::variant<Public, double>;

    class Register {
        public:
        Register() = default;
        virtual ~Register() = default;

        private:

        public:
    };

    using UnionRegister = std::variant<Register, double>;

    class ReinterpretCast {
        public:
        ReinterpretCast() = default;
        virtual ~ReinterpretCast() = default;

        private:

        public:
    };

    using UnionReinterpretCast = std::variant<ReinterpretCast, double>;

    class Requires {
        public:
        Requires() = default;
        virtual ~Requires() = default;

        private:

        public:
    };

    using UnionRequires = std::variant<Requires, double>;

    class Return {
        public:
        Return() = default;
        virtual ~Return() = default;

        private:

        public:
    };

    using UnionReturn = std::variant<Return, double>;

    class SelfClass {
        public:
        SelfClass() = default;
        virtual ~SelfClass() = default;

        private:

        public:
    };

    using UnionSelfUnion = std::variant<SelfClass, double>;

    class Short {
        public:
        Short() = default;
        virtual ~Short() = default;

        private:

        public:
    };

    using UnionShort = std::variant<Short, double>;

    class Signed {
        public:
        Signed() = default;
        virtual ~Signed() = default;

        private:

        public:
    };

    using UnionSigned = std::variant<Signed, double>;

    class Sizeof {
        public:
        Sizeof() = default;
        virtual ~Sizeof() = default;

        private:

        public:
    };

    using UnionSizeof = std::variant<Sizeof, double>;

    class Static {
        public:
        Static() = default;
        virtual ~Static() = default;

        private:

        public:
    };

    using UnionStatic = std::variant<Static, double>;

    class StaticAssert {
        public:
        StaticAssert() = default;
        virtual ~StaticAssert() = default;

        private:

        public:
    };

    using UnionStaticAssert = std::variant<StaticAssert, double>;

    class StaticCast {
        public:
        StaticCast() = default;
        virtual ~StaticCast() = default;

        private:

        public:
    };

    using UnionStaticCast = std::variant<StaticCast, double>;

    class Struct {
        public:
        Struct() = default;
        virtual ~Struct() = default;

        private:

        public:
    };

    using UnionStruct = std::variant<Struct, double>;

    class Switch {
        public:
        Switch() = default;
        virtual ~Switch() = default;

        private:

        public:
    };

    using UnionSwitch = std::variant<Switch, double>;

    class Synchronized {
        public:
        Synchronized() = default;
        virtual ~Synchronized() = default;

        private:

        public:
    };

    using UnionSynchronized = std::variant<Synchronized, double>;

    class Template {
        public:
        Template() = default;
        virtual ~Template() = default;

        private:

        public:
    };

    using UnionTemplate = std::variant<Template, double>;

    class This {
        public:
        This() = default;
        virtual ~This() = default;

        private:

        public:
    };

    using UnionThis = std::variant<This, double>;

    class ThreadLocal {
        public:
        ThreadLocal() = default;
        virtual ~ThreadLocal() = default;

        private:

        public:
    };

    using UnionThreadLocal = std::variant<ThreadLocal, double>;

    class Throw {
        public:
        Throw() = default;
        virtual ~Throw() = default;

        private:

        public:
    };

    using UnionThrow = std::variant<Throw, double>;

    class True {
        public:
        True() = default;
        virtual ~True() = default;

        private:

        public:
    };

    using UnionTrue = std::variant<True, double>;

    class Try {
        public:
        Try() = default;
        virtual ~Try() = default;

        private:

        public:
    };

    using UnionTry = std::variant<Try, double>;

    class TypeClass {
        public:
        TypeClass() = default;
        virtual ~TypeClass() = default;

        private:

        public:
    };

    using UnionTypeUnion = std::variant<TypeClass, double>;

    class Typedef {
        public:
        Typedef() = default;
        virtual ~Typedef() = default;

        private:

        public:
    };

    using UnionTypedef = std::variant<Typedef, double>;

    class Typeid {
        public:
        Typeid() = default;
        virtual ~Typeid() = default;

        private:

        public:
    };

    using UnionTypeid = std::variant<Typeid, double>;

    class Typename {
        public:
        Typename() = default;
        virtual ~Typename() = default;

        private:

        public:
    };

    using UnionTypename = std::variant<Typename, double>;

    class Union {
        public:
        Union() = default;
        virtual ~Union() = default;

        private:

        public:
    };

    using UnionUnionUnion = std::variant<Union, double>;

    class Unsigned {
        public:
        Unsigned() = default;
        virtual ~Unsigned() = default;

        private:

        public:
    };

    using UnionUnsigned = std::variant<Unsigned, double>;

    class Using {
        public:
        Using() = default;
        virtual ~Using() = default;

        private:

        public:
    };

    using UnionUsing = std::variant<Using, double>;

    class Virtual {
        public:
        Virtual() = default;
        virtual ~Virtual() = default;

        private:

        public:
    };

    using UnionVirtual = std::variant<Virtual, double>;

    class Void {
        public:
        Void() = default;
        virtual ~Void() = default;

        private:

        public:
    };

    using UnionVoid = std::variant<Void, double>;

    class Volatile {
        public:
        Volatile() = default;
        virtual ~Volatile() = default;

        private:

        public:
    };

    using UnionVolatile = std::variant<Volatile, double>;

    class WcharT {
        public:
        WcharT() = default;
        virtual ~WcharT() = default;

        private:

        public:
    };

    using UnionWcharT = std::variant<WcharT, double>;

    class While {
        public:
        While() = default;
        virtual ~While() = default;

        private:

        public:
    };

    using UnionWhile = std::variant<While, double>;

    class Xor {
        public:
        Xor() = default;
        virtual ~Xor() = default;

        private:

        public:
    };

    using UnionXor = std::variant<Xor, double>;

    class XorEq {
        public:
        XorEq() = default;
        virtual ~XorEq() = default;

        private:

        public:
    };

    using UnionXorEq = std::variant<XorEq, double>;

    class Transient {
        public:
        Transient() = default;
        virtual ~Transient() = default;

        private:

        public:
    };

    using UnionTransient = std::variant<Transient, double>;

    class Type {
        public:
        Type() = default;
        virtual ~Type() = default;

        private:

        public:
    };

    using UnionType = std::variant<Type, double>;

    class Typealias {
        public:
        Typealias() = default;
        virtual ~Typealias() = default;

        private:

        public:
    };

    using UnionTypealias = std::variant<Typealias, double>;

    class Typeof {
        public:
        Typeof() = default;
        virtual ~Typeof() = default;

        private:

        public:
    };

    using UnionTypeof = std::variant<Typeof, double>;

    class Uint {
        public:
        Uint() = default;
        virtual ~Uint() = default;

        private:

        public:
    };

    using UnionUint = std::variant<Uint, double>;

    class Ulong {
        public:
        Ulong() = default;
        virtual ~Ulong() = default;

        private:

        public:
    };

    using UnionUlong = std::variant<Ulong, double>;

    class Unchecked {
        public:
        Unchecked() = default;
        virtual ~Unchecked() = default;

        private:

        public:
    };

    using UnionUnchecked = std::variant<Unchecked, double>;

    class Undefined {
        public:
        Undefined() = default;
        virtual ~Undefined() = default;

        private:

        public:
    };

    using UnionUndefined = std::variant<Undefined, double>;

    class UnmarshalJson {
        public:
        UnmarshalJson() = default;
        virtual ~UnmarshalJson() = default;

        private:

        public:
    };

    using UnionUnmarshalJson = std::variant<UnmarshalJson, double>;

    class Unowned {
        public:
        Unowned() = default;
        virtual ~Unowned() = default;

        private:

        public:
    };

    using UnionUnowned = std::variant<Unowned, double>;

    class Unsafe {
        public:
        Unsafe() = default;
        virtual ~Unsafe() = default;

        private:

        public:
    };

    using UnionUnsafe = std::variant<Unsafe, double>;

    class UseSerializers {
        public:
        UseSerializers() = default;
        virtual ~UseSerializers() = default;

        private:

        public:
    };

    using UnionUseSerializers = std::variant<UseSerializers, double>;

    class Ushort {
        public:
        Ushort() = default;
        virtual ~Ushort() = default;

        private:

        public:
    };

    using UnionUshort = std::variant<Ushort, double>;

    class Utf8JsonReader {
        public:
        Utf8JsonReader() = default;
        virtual ~Utf8JsonReader() = default;

        private:

        public:
    };

    using UnionUtf8JsonReader = std::variant<Utf8JsonReader, double>;

    class Utf8JsonWriter {
        public:
        Utf8JsonWriter() = default;
        virtual ~Utf8JsonWriter() = default;

        private:

        public:
    };

    using UnionUtf8JsonWriter = std::variant<Utf8JsonWriter, double>;

    class Uuid {
        public:
        Uuid() = default;
        virtual ~Uuid() = default;

        private:

        public:
    };

    using UnionUuid = std::variant<Uuid, double>;

    class Var {
        public:
        Var() = default;
        virtual ~Var() = default;

        private:

        public:
    };

    using UnionVar = std::variant<Var, double>;

    class Weak {
        public:
        Weak() = default;
        virtual ~Weak() = default;

        private:

        public:
    };

    using UnionWeak = std::variant<Weak, double>;

    class Where {
        public:
        Where() = default;
        virtual ~Where() = default;

        private:

        public:
    };

    using UnionWhere = std::variant<Where, double>;

    class WillSet {
        public:
        WillSet() = default;
        virtual ~WillSet() = default;

        private:

        public:
    };

    using UnionWillSet = std::variant<WillSet, double>;

    class With {
        public:
        With() = default;
        virtual ~With() = default;

        private:

        public:
    };

    using UnionWith = std::variant<With, double>;

    class Yes {
        public:
        Yes() = default;
        virtual ~Yes() = default;

        private:

        public:
    };

    using UnionYes = std::variant<Yes, double>;

    class Yield {
        public:
        Yield() = default;
        virtual ~Yield() = default;

        private:

        public:
    };

    using UnionYield = std::variant<Yield, double>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<UnionUnion> empty;
        std::optional<UnionBoolUnion> purple_bool;
        std::optional<UnionComplex> complex;
        std::optional<UnionImaginery> imaginery;
        std::optional<UnionAbstract> abstract;
        std::optional<UnionAlignas> top_level_alignas;
        std::optional<UnionAlignof> top_level_alignof;
        std::optional<UnionAnd> top_level_and;
        std::optional<UnionAndEq> top_level_and_eq;
        std::optional<UnionAnyUnion> top_level_any;
        std::optional<UnionAny> any;
        std::optional<UnionArray> array;
        std::optional<UnionArrayNode> array_node;
        std::optional<UnionAs> as;
        std::optional<UnionAsm> top_level_asm;
        std::optional<UnionAssert> assert;
        std::optional<UnionAssociatedtype> associatedtype;
        std::optional<UnionAssociativity> associativity;
        std::optional<UnionAsync> async;
        std::optional<UnionAtomic> atomic;
        std::optional<UnionAtomicCancel> top_level_atomic_cancel;
        std::optional<UnionAtomicCommit> top_level_atomic_commit;
        std::optional<UnionAtomicNoexcept> top_level_atomic_noexcept;
        std::optional<UnionAuto> top_level_auto;
        std::optional<UnionAwait> await;
        std::optional<UnionBase> base;
        std::optional<UnionBitand> top_level_bitand;
        std::optional<UnionBitor> top_level_bitor;
        std::optional<UnionBool> top_level_bool;
        std::optional<TopLevelUnionBool> fluffy_bool;
        std::optional<UnionBoolean> boolean;
        std::optional<UnionBooleanNode> boolean_node;
        std::optional<UnionBreak> top_level_break;
        std::optional<UnionBycopy> bycopy;
        std::optional<UnionByref> byref;
        std::optional<UnionByte> byte;
        std::optional<UnionCalendar> calendar;
        std::optional<UnionCase> top_level_case;
        std::optional<UnionCatch> top_level_catch;
        std::optional<UnionChan> chan;
        std::optional<UnionChar> top_level_char;
        std::optional<UnionChar16T> top_level_char16_t;
        std::optional<UnionChar32T> top_level_char32_t;
        std::optional<UnionChecked> checked;
        std::optional<UnionClassUnion> purple_class;
        std::optional<UnionClass> top_level_class;
        std::optional<UnionClone> clone;
        std::optional<UnionCoAwait> top_level_co_await;
        std::optional<UnionCoReturn> top_level_co_return;
        std::optional<UnionCoYield> top_level_co_yield;
        std::optional<UnionCodable> codable;
        std::optional<UnionCodingKey> coding_key;
        std::optional<UnionCodingKeys> coding_keys;
        std::optional<UnionCompl> top_level_compl;
        std::optional<UnionConcept> top_level_concept;
        std::optional<UnionConsole> console;
        std::optional<UnionConst> top_level_const;
        std::optional<UnionConstCast> top_level_const_cast;
        std::optional<UnionConstexpr> top_level_constexpr;
        std::optional<UnionConstructor> constructor;
        std::optional<UnionContinue> top_level_continue;
        std::optional<UnionConvenience> convenience;
        std::optional<UnionConvert> convert;
        std::optional<UnionConverter> converter;
        std::optional<UnionCultureInfo> culture_info;
        std::optional<UnionDate> date;
        std::optional<UnionDateParseHandling> date_parse_handling;
        std::optional<UnionDateFormatter> date_formatter;
        std::optional<UnionDateOnly> date_only;
        std::optional<UnionDateOnlyConverter> date_only_converter;
        std::optional<UnionDateTime> date_time;
        std::optional<UnionDateTimeStyles> date_time_styles;
        std::optional<UnionDebugger> debugger;
        std::optional<UnionDecimal> decimal;
        std::optional<UnionDeclare> declare;
        std::optional<UnionDecltype> top_level_decltype;
        std::optional<UnionDecodeString> decode_string;
        std::optional<UnionDecoder> decoder;
        std::optional<UnionDecodingError> decoding_error;
        std::optional<UnionDef> def;
        std::optional<UnionDefault> top_level_default;
        std::optional<UnionDefer> defer;
        std::optional<UnionDeinit> deinit;
        std::optional<UnionDel> del;
        std::optional<UnionDelegate> delegate;
        std::optional<UnionDelete> top_level_delete;
        std::optional<UnionDeserializationFeature> deserialization_feature;
        std::optional<UnionDict> dict;
        std::optional<UnionDictionary> dictionary;
        std::optional<UnionDidSet> did_set;
        std::optional<UnionDo> top_level_do;
        std::optional<UnionDouble> top_level_double;
        std::optional<UnionDoubleNode> double_node;
        std::optional<double> dummy;
        std::optional<UnionDynamic> dynamic;
        std::optional<UnionDynamicCast> top_level_dynamic_cast;
        std::optional<UnionElif> elif;
        std::optional<UnionElse> top_level_else;
        std::optional<UnionEncodeQuickType> encode_quick_type;
        std::optional<UnionEncoder> encoder;
        std::optional<UnionEnum> top_level_enum;
        std::optional<UnionEnumValues> enum_values;
        std::optional<UnionEqualityContract> equality_contract;
        std::optional<UnionEquatable> equatable;
        std::optional<UnionEvent> event;
        std::optional<UnionExcept> except;
        std::optional<UnionException> exception;
        std::optional<UnionExplicit> top_level_explicit;
        std::optional<UnionExport> top_level_export;
        std::optional<UnionExposing> exposing;
        std::optional<UnionExtends> extends;
        std::optional<UnionExtension> extension;
        std::optional<UnionExtern> top_level_extern;
        std::optional<UnionFallthrough> fallthrough;
        std::optional<UnionFalseUnion> purple_false;
        std::optional<UnionFalse> top_level_false;
        std::optional<UnionFileprivate> fileprivate;
        std::optional<UnionFinal> top_level_final;
        std::optional<UnionFinally> finally;
        std::optional<UnionFixed> fixed;
        std::optional<UnionFloat> top_level_float;
        std::optional<UnionFor> top_level_for;
        std::optional<UnionForeach> foreach;
        std::optional<UnionFormatException> format_exception;
        std::optional<UnionFriend> top_level_friend;
        std::optional<UnionFrom> from;
        std::optional<UnionFromDict> from_dict;
        std::optional<UnionFromJson> from_json;
        std::optional<UnionFunc> func;
        std::optional<UnionFunction> function;
        std::optional<UnionGet> get;
        std::optional<UnionGlobal> global;
        std::optional<UnionGo> go;
        std::optional<UnionGoto> top_level_goto;
        std::optional<UnionGuard> guard;
        std::optional<UnionHashable> hashable;
        std::optional<UnionHashCode> hash_code;
        std::optional<UnionHasher> hasher;
        std::optional<UnionHasOwnProperty> has_own_property;
        std::optional<UnionId> id;
        std::optional<UnionIf> top_level_if;
        std::optional<UnionImp> imp;
        std::optional<UnionImplements> implements;
        std::optional<UnionImplicit> implicit;
        std::optional<UnionImport> top_level_import;
        std::optional<UnionIn> in;
        std::optional<UnionIndirect> indirect;
        std::optional<UnionInfix> infix;
        std::optional<UnionInit> init;
        std::optional<UnionInline> top_level_inline;
        std::optional<UnionInout> inout;
        std::optional<UnionInstanceof> instanceof;
        std::optional<UnionInt> top_level_int;
        std::optional<UnionInterface> interface;
        std::optional<UnionInternal> internal;
        std::optional<UnionIntNode> int_node;
        std::optional<UnionIs> is;
        std::optional<UnionIsoDateTimeOffsetConverter> iso_date_time_offset_converter;
        std::optional<UnionIterable> iterable;
        std::optional<UnionJdec> jdec;
        std::optional<UnionJenc> jenc;
        std::optional<UnionJpipe> jpipe;
        std::optional<UnionJson> json;
        std::optional<UnionJsonConverter> json_converter;
        std::optional<UnionJsonSerializer> json_serializer;
        std::optional<UnionJsonToken> json_token;
        std::optional<UnionJsonWriter> json_writer;
        std::optional<UnionJsonAny> json_any;
        std::optional<UnionJsonCodingKey> json_coding_key;
        std::optional<UnionJsonDecoder> json_decoder;
        std::optional<UnionJsonEncoder> json_encoder;
        std::optional<UnionJsonException> json_exception;
        std::optional<UnionJsonGenerator> json_generator;
        std::optional<UnionJsonNode> json_node;
        std::optional<UnionJsonNull> json_null;
        std::optional<UnionJsonParser> json_parser;
        std::optional<UnionJsonReader> json_reader;
        std::optional<UnionJsonTokenType> json_token_type;
        std::optional<UnionKSerializer> k_serializer;
        std::optional<UnionLambda> lambda;
        std::optional<UnionLazy> lazy;
        std::optional<UnionLeft> left;
        std::optional<UnionLet> let;
        std::optional<UnionList> list;
        std::optional<UnionLocalDate> local_date;
        std::optional<UnionLocale> locale;
        std::optional<UnionLock> lock;
        std::optional<UnionLong> top_level_long;
        std::optional<UnionLongNode> long_node;
        std::optional<UnionMap> map;
        std::optional<UnionMapEntry> map_entry;
        std::optional<UnionMarshalJson> marshal_json;
        std::optional<UnionMetadataPropertyHandling> metadata_property_handling;
        std::optional<UnionModule> top_level_module;
        std::optional<UnionMutable> top_level_mutable;
        std::optional<UnionMutating> mutating;
        std::optional<UnionNamespace> top_level_namespace;
        std::optional<UnionNative> native;
        std::optional<UnionNew> top_level_new;
        std::optional<UnionNewtonsoft> newtonsoft;
        std::optional<UnionNil> nil;
        std::optional<UnionNo> no;
        std::optional<UnionNoexcept> top_level_noexcept;
        std::optional<UnionNonatomic> nonatomic;
        std::optional<UnionNoneUnion> top_level_none;
        std::optional<UnionNone> none;
        std::optional<UnionNonlocal> nonlocal;
        std::optional<UnionNonmutating> nonmutating;
        std::optional<UnionNoSuchMethod> no_such_method;
        std::optional<UnionNot> top_level_not;
        std::optional<UnionNotEq> top_level_not_eq;
        std::optional<UnionNsError> ns_error;
        std::optional<UnionNsObject> ns_object;
        std::optional<UnionNsString> ns_string;
        std::optional<UnionNull> null;
        std::optional<UnionNullUnion> top_level_null;
        std::optional<UnionNullNode> null_node;
        std::optional<UnionNullptr> top_level_nullptr;
        std::optional<UnionNumber> number;
        std::optional<UnionObject> object;
        std::optional<UnionObjectMapper> object_mapper;
        std::optional<UnionObjectNode> object_node;
        std::optional<UnionObjectReader> object_reader;
        std::optional<UnionObjectWriter> object_writer;
        std::optional<UnionOf> of;
        std::optional<UnionOffsetDateTime> offset_date_time;
        std::optional<UnionOffsetTime> offset_time;
        std::optional<UnionOneway> oneway;
        std::optional<UnionOpen> open;
        std::optional<UnionOperator> top_level_operator;
        std::optional<UnionOptional> optional;
        std::optional<UnionOr> top_level_or;
        std::optional<UnionOrEq> top_level_or_eq;
        std::optional<UnionOut> out;
        std::optional<UnionOverride> top_level_override;
        std::optional<UnionPackage> package;
        std::optional<UnionParams> params;
        std::optional<UnionPass> pass;
        std::optional<UnionPort> port;
        std::optional<UnionPostfix> postfix;
        std::optional<UnionPrecedence> precedence;
        std::optional<UnionPrefix> prefix;
        std::optional<UnionPrimitiveKind> primitive_kind;
        std::optional<UnionPrint> print;
        std::optional<UnionPrintf> printf;
        std::optional<UnionPrintMembers> print_members;
        std::optional<UnionPrivate> top_level_private;
        std::optional<UnionProtected> top_level_protected;
        std::optional<UnionProtocol> protocol;
        std::optional<UnionProtocolUnion> top_level_protocol;
        std::optional<UnionPublic> top_level_public;
        std::optional<UnionQuicktype> quicktype;
        std::optional<UnionRaise> raise;
        std::optional<UnionRange> range;
        std::optional<UnionReadonly> readonly;
        std::optional<UnionRef> ref;
        std::optional<UnionRegExp> reg_exp;
        std::optional<UnionRegister> top_level_register;
        std::optional<UnionReinterpretCast> top_level_reinterpret_cast;
        std::optional<UnionRepeat> repeat;
        std::optional<UnionRequire> require;
        std::optional<UnionRequired> required;
        std::optional<UnionRequires> top_level_requires;
        std::optional<UnionRestrict> restrict;
        std::optional<UnionRetain> retain;
        std::optional<UnionRethrows> rethrows;
        std::optional<UnionReturn> top_level_return;
        std::optional<UnionRight> right;
        std::optional<UnionRuntimeType> runtime_type;
        std::optional<UnionS> s;
        std::optional<UnionSbyte> sbyte;
        std::optional<UnionSealed> sealed;
        std::optional<UnionSel> sel;
        std::optional<UnionSelect> select;
        std::optional<UnionSelf> self;
        std::optional<UnionSelfUnion> top_level_self;
        std::optional<UnionSendable> sendable;
        std::optional<UnionSerialDescriptor> serial_descriptor;
        std::optional<UnionSerializable> serializable;
        std::optional<UnionSerializationFeature> serialization_feature;
        std::optional<UnionSerialize> serialize;
        std::optional<UnionSerializerProvider> serializer_provider;
        std::optional<UnionSerialName> serial_name;
        std::optional<UnionSet> set;
        std::optional<UnionShort> top_level_short;
        std::optional<UnionSigned> top_level_signed;
        std::optional<UnionSimpleModule> simple_module;
        std::optional<UnionSizeof> top_level_sizeof;
        std::optional<UnionStackalloc> stackalloc;
        std::optional<UnionStandards> standards;
        std::optional<UnionStatic> top_level_static;
        std::optional<UnionStaticAssert> top_level_static_assert;
        std::optional<UnionStaticCast> top_level_static_cast;
        std::optional<UnionStdDeserializer> std_deserializer;
        std::optional<UnionStdSerializer> std_serializer;
        std::optional<UnionStrictfp> strictfp;
        std::optional<UnionString> string;
        std::optional<UnionStruct> top_level_struct;
        std::optional<UnionSubscript> subscript;
        std::optional<UnionSuper> super;
        std::optional<UnionSwitch> top_level_switch;
        std::optional<UnionSymbol> symbol;
        std::optional<UnionSynchronized> top_level_synchronized;
        std::optional<UnionSystem> system;
        std::optional<UnionTemplate> top_level_template;
        std::optional<UnionTextNode> text_node;
        std::optional<UnionThen> then;
        std::optional<UnionThis> top_level_this;
        std::optional<UnionThreadLocal> top_level_thread_local;
        std::optional<UnionThrow> top_level_throw;
        std::optional<UnionThrows> throws;
        std::optional<UnionTimeOnly> time_only;
        std::optional<UnionTimeOnlyConverter> time_only_converter;
        std::optional<UnionTimeZone> time_zone;
        std::optional<UnionToDict> to_dict;
        std::optional<UnionToJson> to_json;
        std::optional<UnionTopLevel> top_level;
        std::optional<UnionToString> to_string;
        std::optional<UnionTransient> transient;
        std::optional<UnionTrue> top_level_true;
        std::optional<UnionTrueUnion> purple_true;
        std::optional<UnionTry> top_level_try;
        std::optional<UnionType> type;
        std::optional<UnionTypeUnion> top_level_type;
        std::optional<UnionTypealias> typealias;
        std::optional<UnionTypedef> top_level_typedef;
        std::optional<UnionTypeid> top_level_typeid;
        std::optional<UnionTypename> top_level_typename;
        std::optional<UnionTypeof> typeof;
        std::optional<UnionUint> uint;
        std::optional<UnionUlong> ulong;
        std::optional<UnionUnchecked> unchecked;
        std::optional<UnionUndefined> undefined;
        std::optional<UnionUnionUnion> top_level_union;
        std::optional<UnionUnmarshalJson> unmarshal_json;
        std::optional<UnionUnowned> unowned;
        std::optional<UnionUnsafe> unsafe;
        std::optional<UnionUnsigned> top_level_unsigned;
        std::optional<UnionUseSerializers> use_serializers;
        std::optional<UnionUshort> ushort;
        std::optional<UnionUsing> top_level_using;
        std::optional<UnionUtf8JsonReader> utf8_json_reader;
        std::optional<UnionUtf8JsonWriter> utf8_json_writer;
        std::optional<UnionUuid> uuid;
        std::optional<UnionVar> var;
        std::optional<UnionVirtual> top_level_virtual;
        std::optional<UnionVoid> top_level_void;
        std::optional<UnionVolatile> top_level_volatile;
        std::optional<UnionWcharT> top_level_wchar_t;
        std::optional<UnionWeak> weak;
        std::optional<UnionWhere> where;
        std::optional<UnionWhile> top_level_while;
        std::optional<UnionWillSet> will_set;
        std::optional<UnionWith> with;
        std::optional<UnionXor> top_level_xor;
        std::optional<UnionXorEq> top_level_xor_eq;
        std::optional<UnionYes> yes;
        std::optional<UnionYield> yield;

        public:
        const std::optional<UnionUnion> & get_empty() const { return empty; }
        std::optional<UnionUnion> & get_mutable_empty() { return empty; }
        void set_empty(const std::optional<UnionUnion> & value) { this->empty = value; }

        const std::optional<UnionBoolUnion> & get_purple_bool() const { return purple_bool; }
        std::optional<UnionBoolUnion> & get_mutable_purple_bool() { return purple_bool; }
        void set_purple_bool(const std::optional<UnionBoolUnion> & value) { this->purple_bool = value; }

        const std::optional<UnionComplex> & get_complex() const { return complex; }
        std::optional<UnionComplex> & get_mutable_complex() { return complex; }
        void set_complex(const std::optional<UnionComplex> & value) { this->complex = value; }

        const std::optional<UnionImaginery> & get_imaginery() const { return imaginery; }
        std::optional<UnionImaginery> & get_mutable_imaginery() { return imaginery; }
        void set_imaginery(const std::optional<UnionImaginery> & value) { this->imaginery = value; }

        const std::optional<UnionAbstract> & get_abstract() const { return abstract; }
        std::optional<UnionAbstract> & get_mutable_abstract() { return abstract; }
        void set_abstract(const std::optional<UnionAbstract> & value) { this->abstract = value; }

        const std::optional<UnionAlignas> & get_top_level_alignas() const { return top_level_alignas; }
        std::optional<UnionAlignas> & get_mutable_top_level_alignas() { return top_level_alignas; }
        void set_top_level_alignas(const std::optional<UnionAlignas> & value) { this->top_level_alignas = value; }

        const std::optional<UnionAlignof> & get_top_level_alignof() const { return top_level_alignof; }
        std::optional<UnionAlignof> & get_mutable_top_level_alignof() { return top_level_alignof; }
        void set_top_level_alignof(const std::optional<UnionAlignof> & value) { this->top_level_alignof = value; }

        const std::optional<UnionAnd> & get_top_level_and() const { return top_level_and; }
        std::optional<UnionAnd> & get_mutable_top_level_and() { return top_level_and; }
        void set_top_level_and(const std::optional<UnionAnd> & value) { this->top_level_and = value; }

        const std::optional<UnionAndEq> & get_top_level_and_eq() const { return top_level_and_eq; }
        std::optional<UnionAndEq> & get_mutable_top_level_and_eq() { return top_level_and_eq; }
        void set_top_level_and_eq(const std::optional<UnionAndEq> & value) { this->top_level_and_eq = value; }

        const std::optional<UnionAnyUnion> & get_top_level_any() const { return top_level_any; }
        std::optional<UnionAnyUnion> & get_mutable_top_level_any() { return top_level_any; }
        void set_top_level_any(const std::optional<UnionAnyUnion> & value) { this->top_level_any = value; }

        const std::optional<UnionAny> & get_any() const { return any; }
        std::optional<UnionAny> & get_mutable_any() { return any; }
        void set_any(const std::optional<UnionAny> & value) { this->any = value; }

        const std::optional<UnionArray> & get_array() const { return array; }
        std::optional<UnionArray> & get_mutable_array() { return array; }
        void set_array(const std::optional<UnionArray> & value) { this->array = value; }

        const std::optional<UnionArrayNode> & get_array_node() const { return array_node; }
        std::optional<UnionArrayNode> & get_mutable_array_node() { return array_node; }
        void set_array_node(const std::optional<UnionArrayNode> & value) { this->array_node = value; }

        const std::optional<UnionAs> & get_as() const { return as; }
        std::optional<UnionAs> & get_mutable_as() { return as; }
        void set_as(const std::optional<UnionAs> & value) { this->as = value; }

        const std::optional<UnionAsm> & get_top_level_asm() const { return top_level_asm; }
        std::optional<UnionAsm> & get_mutable_top_level_asm() { return top_level_asm; }
        void set_top_level_asm(const std::optional<UnionAsm> & value) { this->top_level_asm = value; }

        const std::optional<UnionAssert> & get_assert() const { return assert; }
        std::optional<UnionAssert> & get_mutable_assert() { return assert; }
        void set_assert(const std::optional<UnionAssert> & value) { this->assert = value; }

        const std::optional<UnionAssociatedtype> & get_associatedtype() const { return associatedtype; }
        std::optional<UnionAssociatedtype> & get_mutable_associatedtype() { return associatedtype; }
        void set_associatedtype(const std::optional<UnionAssociatedtype> & value) { this->associatedtype = value; }

        const std::optional<UnionAssociativity> & get_associativity() const { return associativity; }
        std::optional<UnionAssociativity> & get_mutable_associativity() { return associativity; }
        void set_associativity(const std::optional<UnionAssociativity> & value) { this->associativity = value; }

        const std::optional<UnionAsync> & get_async() const { return async; }
        std::optional<UnionAsync> & get_mutable_async() { return async; }
        void set_async(const std::optional<UnionAsync> & value) { this->async = value; }

        const std::optional<UnionAtomic> & get_atomic() const { return atomic; }
        std::optional<UnionAtomic> & get_mutable_atomic() { return atomic; }
        void set_atomic(const std::optional<UnionAtomic> & value) { this->atomic = value; }

        const std::optional<UnionAtomicCancel> & get_top_level_atomic_cancel() const { return top_level_atomic_cancel; }
        std::optional<UnionAtomicCancel> & get_mutable_top_level_atomic_cancel() { return top_level_atomic_cancel; }
        void set_top_level_atomic_cancel(const std::optional<UnionAtomicCancel> & value) { this->top_level_atomic_cancel = value; }

        const std::optional<UnionAtomicCommit> & get_top_level_atomic_commit() const { return top_level_atomic_commit; }
        std::optional<UnionAtomicCommit> & get_mutable_top_level_atomic_commit() { return top_level_atomic_commit; }
        void set_top_level_atomic_commit(const std::optional<UnionAtomicCommit> & value) { this->top_level_atomic_commit = value; }

        const std::optional<UnionAtomicNoexcept> & get_top_level_atomic_noexcept() const { return top_level_atomic_noexcept; }
        std::optional<UnionAtomicNoexcept> & get_mutable_top_level_atomic_noexcept() { return top_level_atomic_noexcept; }
        void set_top_level_atomic_noexcept(const std::optional<UnionAtomicNoexcept> & value) { this->top_level_atomic_noexcept = value; }

        const std::optional<UnionAuto> & get_top_level_auto() const { return top_level_auto; }
        std::optional<UnionAuto> & get_mutable_top_level_auto() { return top_level_auto; }
        void set_top_level_auto(const std::optional<UnionAuto> & value) { this->top_level_auto = value; }

        const std::optional<UnionAwait> & get_await() const { return await; }
        std::optional<UnionAwait> & get_mutable_await() { return await; }
        void set_await(const std::optional<UnionAwait> & value) { this->await = value; }

        const std::optional<UnionBase> & get_base() const { return base; }
        std::optional<UnionBase> & get_mutable_base() { return base; }
        void set_base(const std::optional<UnionBase> & value) { this->base = value; }

        const std::optional<UnionBitand> & get_top_level_bitand() const { return top_level_bitand; }
        std::optional<UnionBitand> & get_mutable_top_level_bitand() { return top_level_bitand; }
        void set_top_level_bitand(const std::optional<UnionBitand> & value) { this->top_level_bitand = value; }

        const std::optional<UnionBitor> & get_top_level_bitor() const { return top_level_bitor; }
        std::optional<UnionBitor> & get_mutable_top_level_bitor() { return top_level_bitor; }
        void set_top_level_bitor(const std::optional<UnionBitor> & value) { this->top_level_bitor = value; }

        const std::optional<UnionBool> & get_top_level_bool() const { return top_level_bool; }
        std::optional<UnionBool> & get_mutable_top_level_bool() { return top_level_bool; }
        void set_top_level_bool(const std::optional<UnionBool> & value) { this->top_level_bool = value; }

        const std::optional<TopLevelUnionBool> & get_fluffy_bool() const { return fluffy_bool; }
        std::optional<TopLevelUnionBool> & get_mutable_fluffy_bool() { return fluffy_bool; }
        void set_fluffy_bool(const std::optional<TopLevelUnionBool> & value) { this->fluffy_bool = value; }

        const std::optional<UnionBoolean> & get_boolean() const { return boolean; }
        std::optional<UnionBoolean> & get_mutable_boolean() { return boolean; }
        void set_boolean(const std::optional<UnionBoolean> & value) { this->boolean = value; }

        const std::optional<UnionBooleanNode> & get_boolean_node() const { return boolean_node; }
        std::optional<UnionBooleanNode> & get_mutable_boolean_node() { return boolean_node; }
        void set_boolean_node(const std::optional<UnionBooleanNode> & value) { this->boolean_node = value; }

        const std::optional<UnionBreak> & get_top_level_break() const { return top_level_break; }
        std::optional<UnionBreak> & get_mutable_top_level_break() { return top_level_break; }
        void set_top_level_break(const std::optional<UnionBreak> & value) { this->top_level_break = value; }

        const std::optional<UnionBycopy> & get_bycopy() const { return bycopy; }
        std::optional<UnionBycopy> & get_mutable_bycopy() { return bycopy; }
        void set_bycopy(const std::optional<UnionBycopy> & value) { this->bycopy = value; }

        const std::optional<UnionByref> & get_byref() const { return byref; }
        std::optional<UnionByref> & get_mutable_byref() { return byref; }
        void set_byref(const std::optional<UnionByref> & value) { this->byref = value; }

        const std::optional<UnionByte> & get_byte() const { return byte; }
        std::optional<UnionByte> & get_mutable_byte() { return byte; }
        void set_byte(const std::optional<UnionByte> & value) { this->byte = value; }

        const std::optional<UnionCalendar> & get_calendar() const { return calendar; }
        std::optional<UnionCalendar> & get_mutable_calendar() { return calendar; }
        void set_calendar(const std::optional<UnionCalendar> & value) { this->calendar = value; }

        const std::optional<UnionCase> & get_top_level_case() const { return top_level_case; }
        std::optional<UnionCase> & get_mutable_top_level_case() { return top_level_case; }
        void set_top_level_case(const std::optional<UnionCase> & value) { this->top_level_case = value; }

        const std::optional<UnionCatch> & get_top_level_catch() const { return top_level_catch; }
        std::optional<UnionCatch> & get_mutable_top_level_catch() { return top_level_catch; }
        void set_top_level_catch(const std::optional<UnionCatch> & value) { this->top_level_catch = value; }

        const std::optional<UnionChan> & get_chan() const { return chan; }
        std::optional<UnionChan> & get_mutable_chan() { return chan; }
        void set_chan(const std::optional<UnionChan> & value) { this->chan = value; }

        const std::optional<UnionChar> & get_top_level_char() const { return top_level_char; }
        std::optional<UnionChar> & get_mutable_top_level_char() { return top_level_char; }
        void set_top_level_char(const std::optional<UnionChar> & value) { this->top_level_char = value; }

        const std::optional<UnionChar16T> & get_top_level_char16_t() const { return top_level_char16_t; }
        std::optional<UnionChar16T> & get_mutable_top_level_char16_t() { return top_level_char16_t; }
        void set_top_level_char16_t(const std::optional<UnionChar16T> & value) { this->top_level_char16_t = value; }

        const std::optional<UnionChar32T> & get_top_level_char32_t() const { return top_level_char32_t; }
        std::optional<UnionChar32T> & get_mutable_top_level_char32_t() { return top_level_char32_t; }
        void set_top_level_char32_t(const std::optional<UnionChar32T> & value) { this->top_level_char32_t = value; }

        const std::optional<UnionChecked> & get_checked() const { return checked; }
        std::optional<UnionChecked> & get_mutable_checked() { return checked; }
        void set_checked(const std::optional<UnionChecked> & value) { this->checked = value; }

        const std::optional<UnionClassUnion> & get_purple_class() const { return purple_class; }
        std::optional<UnionClassUnion> & get_mutable_purple_class() { return purple_class; }
        void set_purple_class(const std::optional<UnionClassUnion> & value) { this->purple_class = value; }

        const std::optional<UnionClass> & get_top_level_class() const { return top_level_class; }
        std::optional<UnionClass> & get_mutable_top_level_class() { return top_level_class; }
        void set_top_level_class(const std::optional<UnionClass> & value) { this->top_level_class = value; }

        const std::optional<UnionClone> & get_clone() const { return clone; }
        std::optional<UnionClone> & get_mutable_clone() { return clone; }
        void set_clone(const std::optional<UnionClone> & value) { this->clone = value; }

        const std::optional<UnionCoAwait> & get_top_level_co_await() const { return top_level_co_await; }
        std::optional<UnionCoAwait> & get_mutable_top_level_co_await() { return top_level_co_await; }
        void set_top_level_co_await(const std::optional<UnionCoAwait> & value) { this->top_level_co_await = value; }

        const std::optional<UnionCoReturn> & get_top_level_co_return() const { return top_level_co_return; }
        std::optional<UnionCoReturn> & get_mutable_top_level_co_return() { return top_level_co_return; }
        void set_top_level_co_return(const std::optional<UnionCoReturn> & value) { this->top_level_co_return = value; }

        const std::optional<UnionCoYield> & get_top_level_co_yield() const { return top_level_co_yield; }
        std::optional<UnionCoYield> & get_mutable_top_level_co_yield() { return top_level_co_yield; }
        void set_top_level_co_yield(const std::optional<UnionCoYield> & value) { this->top_level_co_yield = value; }

        const std::optional<UnionCodable> & get_codable() const { return codable; }
        std::optional<UnionCodable> & get_mutable_codable() { return codable; }
        void set_codable(const std::optional<UnionCodable> & value) { this->codable = value; }

        const std::optional<UnionCodingKey> & get_coding_key() const { return coding_key; }
        std::optional<UnionCodingKey> & get_mutable_coding_key() { return coding_key; }
        void set_coding_key(const std::optional<UnionCodingKey> & value) { this->coding_key = value; }

        const std::optional<UnionCodingKeys> & get_coding_keys() const { return coding_keys; }
        std::optional<UnionCodingKeys> & get_mutable_coding_keys() { return coding_keys; }
        void set_coding_keys(const std::optional<UnionCodingKeys> & value) { this->coding_keys = value; }

        const std::optional<UnionCompl> & get_top_level_compl() const { return top_level_compl; }
        std::optional<UnionCompl> & get_mutable_top_level_compl() { return top_level_compl; }
        void set_top_level_compl(const std::optional<UnionCompl> & value) { this->top_level_compl = value; }

        const std::optional<UnionConcept> & get_top_level_concept() const { return top_level_concept; }
        std::optional<UnionConcept> & get_mutable_top_level_concept() { return top_level_concept; }
        void set_top_level_concept(const std::optional<UnionConcept> & value) { this->top_level_concept = value; }

        const std::optional<UnionConsole> & get_console() const { return console; }
        std::optional<UnionConsole> & get_mutable_console() { return console; }
        void set_console(const std::optional<UnionConsole> & value) { this->console = value; }

        const std::optional<UnionConst> & get_top_level_const() const { return top_level_const; }
        std::optional<UnionConst> & get_mutable_top_level_const() { return top_level_const; }
        void set_top_level_const(const std::optional<UnionConst> & value) { this->top_level_const = value; }

        const std::optional<UnionConstCast> & get_top_level_const_cast() const { return top_level_const_cast; }
        std::optional<UnionConstCast> & get_mutable_top_level_const_cast() { return top_level_const_cast; }
        void set_top_level_const_cast(const std::optional<UnionConstCast> & value) { this->top_level_const_cast = value; }

        const std::optional<UnionConstexpr> & get_top_level_constexpr() const { return top_level_constexpr; }
        std::optional<UnionConstexpr> & get_mutable_top_level_constexpr() { return top_level_constexpr; }
        void set_top_level_constexpr(const std::optional<UnionConstexpr> & value) { this->top_level_constexpr = value; }

        const std::optional<UnionConstructor> & get_constructor() const { return constructor; }
        std::optional<UnionConstructor> & get_mutable_constructor() { return constructor; }
        void set_constructor(const std::optional<UnionConstructor> & value) { this->constructor = value; }

        const std::optional<UnionContinue> & get_top_level_continue() const { return top_level_continue; }
        std::optional<UnionContinue> & get_mutable_top_level_continue() { return top_level_continue; }
        void set_top_level_continue(const std::optional<UnionContinue> & value) { this->top_level_continue = value; }

        const std::optional<UnionConvenience> & get_convenience() const { return convenience; }
        std::optional<UnionConvenience> & get_mutable_convenience() { return convenience; }
        void set_convenience(const std::optional<UnionConvenience> & value) { this->convenience = value; }

        const std::optional<UnionConvert> & get_convert() const { return convert; }
        std::optional<UnionConvert> & get_mutable_convert() { return convert; }
        void set_convert(const std::optional<UnionConvert> & value) { this->convert = value; }

        const std::optional<UnionConverter> & get_converter() const { return converter; }
        std::optional<UnionConverter> & get_mutable_converter() { return converter; }
        void set_converter(const std::optional<UnionConverter> & value) { this->converter = value; }

        const std::optional<UnionCultureInfo> & get_culture_info() const { return culture_info; }
        std::optional<UnionCultureInfo> & get_mutable_culture_info() { return culture_info; }
        void set_culture_info(const std::optional<UnionCultureInfo> & value) { this->culture_info = value; }

        const std::optional<UnionDate> & get_date() const { return date; }
        std::optional<UnionDate> & get_mutable_date() { return date; }
        void set_date(const std::optional<UnionDate> & value) { this->date = value; }

        const std::optional<UnionDateParseHandling> & get_date_parse_handling() const { return date_parse_handling; }
        std::optional<UnionDateParseHandling> & get_mutable_date_parse_handling() { return date_parse_handling; }
        void set_date_parse_handling(const std::optional<UnionDateParseHandling> & value) { this->date_parse_handling = value; }

        const std::optional<UnionDateFormatter> & get_date_formatter() const { return date_formatter; }
        std::optional<UnionDateFormatter> & get_mutable_date_formatter() { return date_formatter; }
        void set_date_formatter(const std::optional<UnionDateFormatter> & value) { this->date_formatter = value; }

        const std::optional<UnionDateOnly> & get_date_only() const { return date_only; }
        std::optional<UnionDateOnly> & get_mutable_date_only() { return date_only; }
        void set_date_only(const std::optional<UnionDateOnly> & value) { this->date_only = value; }

        const std::optional<UnionDateOnlyConverter> & get_date_only_converter() const { return date_only_converter; }
        std::optional<UnionDateOnlyConverter> & get_mutable_date_only_converter() { return date_only_converter; }
        void set_date_only_converter(const std::optional<UnionDateOnlyConverter> & value) { this->date_only_converter = value; }

        const std::optional<UnionDateTime> & get_date_time() const { return date_time; }
        std::optional<UnionDateTime> & get_mutable_date_time() { return date_time; }
        void set_date_time(const std::optional<UnionDateTime> & value) { this->date_time = value; }

        const std::optional<UnionDateTimeStyles> & get_date_time_styles() const { return date_time_styles; }
        std::optional<UnionDateTimeStyles> & get_mutable_date_time_styles() { return date_time_styles; }
        void set_date_time_styles(const std::optional<UnionDateTimeStyles> & value) { this->date_time_styles = value; }

        const std::optional<UnionDebugger> & get_debugger() const { return debugger; }
        std::optional<UnionDebugger> & get_mutable_debugger() { return debugger; }
        void set_debugger(const std::optional<UnionDebugger> & value) { this->debugger = value; }

        const std::optional<UnionDecimal> & get_decimal() const { return decimal; }
        std::optional<UnionDecimal> & get_mutable_decimal() { return decimal; }
        void set_decimal(const std::optional<UnionDecimal> & value) { this->decimal = value; }

        const std::optional<UnionDeclare> & get_declare() const { return declare; }
        std::optional<UnionDeclare> & get_mutable_declare() { return declare; }
        void set_declare(const std::optional<UnionDeclare> & value) { this->declare = value; }

        const std::optional<UnionDecltype> & get_top_level_decltype() const { return top_level_decltype; }
        std::optional<UnionDecltype> & get_mutable_top_level_decltype() { return top_level_decltype; }
        void set_top_level_decltype(const std::optional<UnionDecltype> & value) { this->top_level_decltype = value; }

        const std::optional<UnionDecodeString> & get_decode_string() const { return decode_string; }
        std::optional<UnionDecodeString> & get_mutable_decode_string() { return decode_string; }
        void set_decode_string(const std::optional<UnionDecodeString> & value) { this->decode_string = value; }

        const std::optional<UnionDecoder> & get_decoder() const { return decoder; }
        std::optional<UnionDecoder> & get_mutable_decoder() { return decoder; }
        void set_decoder(const std::optional<UnionDecoder> & value) { this->decoder = value; }

        const std::optional<UnionDecodingError> & get_decoding_error() const { return decoding_error; }
        std::optional<UnionDecodingError> & get_mutable_decoding_error() { return decoding_error; }
        void set_decoding_error(const std::optional<UnionDecodingError> & value) { this->decoding_error = value; }

        const std::optional<UnionDef> & get_def() const { return def; }
        std::optional<UnionDef> & get_mutable_def() { return def; }
        void set_def(const std::optional<UnionDef> & value) { this->def = value; }

        const std::optional<UnionDefault> & get_top_level_default() const { return top_level_default; }
        std::optional<UnionDefault> & get_mutable_top_level_default() { return top_level_default; }
        void set_top_level_default(const std::optional<UnionDefault> & value) { this->top_level_default = value; }

        const std::optional<UnionDefer> & get_defer() const { return defer; }
        std::optional<UnionDefer> & get_mutable_defer() { return defer; }
        void set_defer(const std::optional<UnionDefer> & value) { this->defer = value; }

        const std::optional<UnionDeinit> & get_deinit() const { return deinit; }
        std::optional<UnionDeinit> & get_mutable_deinit() { return deinit; }
        void set_deinit(const std::optional<UnionDeinit> & value) { this->deinit = value; }

        const std::optional<UnionDel> & get_del() const { return del; }
        std::optional<UnionDel> & get_mutable_del() { return del; }
        void set_del(const std::optional<UnionDel> & value) { this->del = value; }

        const std::optional<UnionDelegate> & get_delegate() const { return delegate; }
        std::optional<UnionDelegate> & get_mutable_delegate() { return delegate; }
        void set_delegate(const std::optional<UnionDelegate> & value) { this->delegate = value; }

        const std::optional<UnionDelete> & get_top_level_delete() const { return top_level_delete; }
        std::optional<UnionDelete> & get_mutable_top_level_delete() { return top_level_delete; }
        void set_top_level_delete(const std::optional<UnionDelete> & value) { this->top_level_delete = value; }

        const std::optional<UnionDeserializationFeature> & get_deserialization_feature() const { return deserialization_feature; }
        std::optional<UnionDeserializationFeature> & get_mutable_deserialization_feature() { return deserialization_feature; }
        void set_deserialization_feature(const std::optional<UnionDeserializationFeature> & value) { this->deserialization_feature = value; }

        const std::optional<UnionDict> & get_dict() const { return dict; }
        std::optional<UnionDict> & get_mutable_dict() { return dict; }
        void set_dict(const std::optional<UnionDict> & value) { this->dict = value; }

        const std::optional<UnionDictionary> & get_dictionary() const { return dictionary; }
        std::optional<UnionDictionary> & get_mutable_dictionary() { return dictionary; }
        void set_dictionary(const std::optional<UnionDictionary> & value) { this->dictionary = value; }

        const std::optional<UnionDidSet> & get_did_set() const { return did_set; }
        std::optional<UnionDidSet> & get_mutable_did_set() { return did_set; }
        void set_did_set(const std::optional<UnionDidSet> & value) { this->did_set = value; }

        const std::optional<UnionDo> & get_top_level_do() const { return top_level_do; }
        std::optional<UnionDo> & get_mutable_top_level_do() { return top_level_do; }
        void set_top_level_do(const std::optional<UnionDo> & value) { this->top_level_do = value; }

        const std::optional<UnionDouble> & get_top_level_double() const { return top_level_double; }
        std::optional<UnionDouble> & get_mutable_top_level_double() { return top_level_double; }
        void set_top_level_double(const std::optional<UnionDouble> & value) { this->top_level_double = value; }

        const std::optional<UnionDoubleNode> & get_double_node() const { return double_node; }
        std::optional<UnionDoubleNode> & get_mutable_double_node() { return double_node; }
        void set_double_node(const std::optional<UnionDoubleNode> & value) { this->double_node = value; }

        const std::optional<double> & get_dummy() const { return dummy; }
        std::optional<double> & get_mutable_dummy() { return dummy; }
        void set_dummy(const std::optional<double> & value) { this->dummy = value; }

        const std::optional<UnionDynamic> & get_dynamic() const { return dynamic; }
        std::optional<UnionDynamic> & get_mutable_dynamic() { return dynamic; }
        void set_dynamic(const std::optional<UnionDynamic> & value) { this->dynamic = value; }

        const std::optional<UnionDynamicCast> & get_top_level_dynamic_cast() const { return top_level_dynamic_cast; }
        std::optional<UnionDynamicCast> & get_mutable_top_level_dynamic_cast() { return top_level_dynamic_cast; }
        void set_top_level_dynamic_cast(const std::optional<UnionDynamicCast> & value) { this->top_level_dynamic_cast = value; }

        const std::optional<UnionElif> & get_elif() const { return elif; }
        std::optional<UnionElif> & get_mutable_elif() { return elif; }
        void set_elif(const std::optional<UnionElif> & value) { this->elif = value; }

        const std::optional<UnionElse> & get_top_level_else() const { return top_level_else; }
        std::optional<UnionElse> & get_mutable_top_level_else() { return top_level_else; }
        void set_top_level_else(const std::optional<UnionElse> & value) { this->top_level_else = value; }

        const std::optional<UnionEncodeQuickType> & get_encode_quick_type() const { return encode_quick_type; }
        std::optional<UnionEncodeQuickType> & get_mutable_encode_quick_type() { return encode_quick_type; }
        void set_encode_quick_type(const std::optional<UnionEncodeQuickType> & value) { this->encode_quick_type = value; }

        const std::optional<UnionEncoder> & get_encoder() const { return encoder; }
        std::optional<UnionEncoder> & get_mutable_encoder() { return encoder; }
        void set_encoder(const std::optional<UnionEncoder> & value) { this->encoder = value; }

        const std::optional<UnionEnum> & get_top_level_enum() const { return top_level_enum; }
        std::optional<UnionEnum> & get_mutable_top_level_enum() { return top_level_enum; }
        void set_top_level_enum(const std::optional<UnionEnum> & value) { this->top_level_enum = value; }

        const std::optional<UnionEnumValues> & get_enum_values() const { return enum_values; }
        std::optional<UnionEnumValues> & get_mutable_enum_values() { return enum_values; }
        void set_enum_values(const std::optional<UnionEnumValues> & value) { this->enum_values = value; }

        const std::optional<UnionEqualityContract> & get_equality_contract() const { return equality_contract; }
        std::optional<UnionEqualityContract> & get_mutable_equality_contract() { return equality_contract; }
        void set_equality_contract(const std::optional<UnionEqualityContract> & value) { this->equality_contract = value; }

        const std::optional<UnionEquatable> & get_equatable() const { return equatable; }
        std::optional<UnionEquatable> & get_mutable_equatable() { return equatable; }
        void set_equatable(const std::optional<UnionEquatable> & value) { this->equatable = value; }

        const std::optional<UnionEvent> & get_event() const { return event; }
        std::optional<UnionEvent> & get_mutable_event() { return event; }
        void set_event(const std::optional<UnionEvent> & value) { this->event = value; }

        const std::optional<UnionExcept> & get_except() const { return except; }
        std::optional<UnionExcept> & get_mutable_except() { return except; }
        void set_except(const std::optional<UnionExcept> & value) { this->except = value; }

        const std::optional<UnionException> & get_exception() const { return exception; }
        std::optional<UnionException> & get_mutable_exception() { return exception; }
        void set_exception(const std::optional<UnionException> & value) { this->exception = value; }

        const std::optional<UnionExplicit> & get_top_level_explicit() const { return top_level_explicit; }
        std::optional<UnionExplicit> & get_mutable_top_level_explicit() { return top_level_explicit; }
        void set_top_level_explicit(const std::optional<UnionExplicit> & value) { this->top_level_explicit = value; }

        const std::optional<UnionExport> & get_top_level_export() const { return top_level_export; }
        std::optional<UnionExport> & get_mutable_top_level_export() { return top_level_export; }
        void set_top_level_export(const std::optional<UnionExport> & value) { this->top_level_export = value; }

        const std::optional<UnionExposing> & get_exposing() const { return exposing; }
        std::optional<UnionExposing> & get_mutable_exposing() { return exposing; }
        void set_exposing(const std::optional<UnionExposing> & value) { this->exposing = value; }

        const std::optional<UnionExtends> & get_extends() const { return extends; }
        std::optional<UnionExtends> & get_mutable_extends() { return extends; }
        void set_extends(const std::optional<UnionExtends> & value) { this->extends = value; }

        const std::optional<UnionExtension> & get_extension() const { return extension; }
        std::optional<UnionExtension> & get_mutable_extension() { return extension; }
        void set_extension(const std::optional<UnionExtension> & value) { this->extension = value; }

        const std::optional<UnionExtern> & get_top_level_extern() const { return top_level_extern; }
        std::optional<UnionExtern> & get_mutable_top_level_extern() { return top_level_extern; }
        void set_top_level_extern(const std::optional<UnionExtern> & value) { this->top_level_extern = value; }

        const std::optional<UnionFallthrough> & get_fallthrough() const { return fallthrough; }
        std::optional<UnionFallthrough> & get_mutable_fallthrough() { return fallthrough; }
        void set_fallthrough(const std::optional<UnionFallthrough> & value) { this->fallthrough = value; }

        const std::optional<UnionFalseUnion> & get_purple_false() const { return purple_false; }
        std::optional<UnionFalseUnion> & get_mutable_purple_false() { return purple_false; }
        void set_purple_false(const std::optional<UnionFalseUnion> & value) { this->purple_false = value; }

        const std::optional<UnionFalse> & get_top_level_false() const { return top_level_false; }
        std::optional<UnionFalse> & get_mutable_top_level_false() { return top_level_false; }
        void set_top_level_false(const std::optional<UnionFalse> & value) { this->top_level_false = value; }

        const std::optional<UnionFileprivate> & get_fileprivate() const { return fileprivate; }
        std::optional<UnionFileprivate> & get_mutable_fileprivate() { return fileprivate; }
        void set_fileprivate(const std::optional<UnionFileprivate> & value) { this->fileprivate = value; }

        const std::optional<UnionFinal> & get_top_level_final() const { return top_level_final; }
        std::optional<UnionFinal> & get_mutable_top_level_final() { return top_level_final; }
        void set_top_level_final(const std::optional<UnionFinal> & value) { this->top_level_final = value; }

        const std::optional<UnionFinally> & get_finally() const { return finally; }
        std::optional<UnionFinally> & get_mutable_finally() { return finally; }
        void set_finally(const std::optional<UnionFinally> & value) { this->finally = value; }

        const std::optional<UnionFixed> & get_fixed() const { return fixed; }
        std::optional<UnionFixed> & get_mutable_fixed() { return fixed; }
        void set_fixed(const std::optional<UnionFixed> & value) { this->fixed = value; }

        const std::optional<UnionFloat> & get_top_level_float() const { return top_level_float; }
        std::optional<UnionFloat> & get_mutable_top_level_float() { return top_level_float; }
        void set_top_level_float(const std::optional<UnionFloat> & value) { this->top_level_float = value; }

        const std::optional<UnionFor> & get_top_level_for() const { return top_level_for; }
        std::optional<UnionFor> & get_mutable_top_level_for() { return top_level_for; }
        void set_top_level_for(const std::optional<UnionFor> & value) { this->top_level_for = value; }

        const std::optional<UnionForeach> & get_foreach() const { return foreach; }
        std::optional<UnionForeach> & get_mutable_foreach() { return foreach; }
        void set_foreach(const std::optional<UnionForeach> & value) { this->foreach = value; }

        const std::optional<UnionFormatException> & get_format_exception() const { return format_exception; }
        std::optional<UnionFormatException> & get_mutable_format_exception() { return format_exception; }
        void set_format_exception(const std::optional<UnionFormatException> & value) { this->format_exception = value; }

        const std::optional<UnionFriend> & get_top_level_friend() const { return top_level_friend; }
        std::optional<UnionFriend> & get_mutable_top_level_friend() { return top_level_friend; }
        void set_top_level_friend(const std::optional<UnionFriend> & value) { this->top_level_friend = value; }

        const std::optional<UnionFrom> & get_from() const { return from; }
        std::optional<UnionFrom> & get_mutable_from() { return from; }
        void set_from(const std::optional<UnionFrom> & value) { this->from = value; }

        const std::optional<UnionFromDict> & get_from_dict() const { return from_dict; }
        std::optional<UnionFromDict> & get_mutable_from_dict() { return from_dict; }
        void set_from_dict(const std::optional<UnionFromDict> & value) { this->from_dict = value; }

        const std::optional<UnionFromJson> & get_from_json() const { return from_json; }
        std::optional<UnionFromJson> & get_mutable_from_json() { return from_json; }
        void set_from_json(const std::optional<UnionFromJson> & value) { this->from_json = value; }

        const std::optional<UnionFunc> & get_func() const { return func; }
        std::optional<UnionFunc> & get_mutable_func() { return func; }
        void set_func(const std::optional<UnionFunc> & value) { this->func = value; }

        const std::optional<UnionFunction> & get_function() const { return function; }
        std::optional<UnionFunction> & get_mutable_function() { return function; }
        void set_function(const std::optional<UnionFunction> & value) { this->function = value; }

        const std::optional<UnionGet> & get_get() const { return get; }
        std::optional<UnionGet> & get_mutable_get() { return get; }
        void set_get(const std::optional<UnionGet> & value) { this->get = value; }

        const std::optional<UnionGlobal> & get_global() const { return global; }
        std::optional<UnionGlobal> & get_mutable_global() { return global; }
        void set_global(const std::optional<UnionGlobal> & value) { this->global = value; }

        const std::optional<UnionGo> & get_go() const { return go; }
        std::optional<UnionGo> & get_mutable_go() { return go; }
        void set_go(const std::optional<UnionGo> & value) { this->go = value; }

        const std::optional<UnionGoto> & get_top_level_goto() const { return top_level_goto; }
        std::optional<UnionGoto> & get_mutable_top_level_goto() { return top_level_goto; }
        void set_top_level_goto(const std::optional<UnionGoto> & value) { this->top_level_goto = value; }

        const std::optional<UnionGuard> & get_guard() const { return guard; }
        std::optional<UnionGuard> & get_mutable_guard() { return guard; }
        void set_guard(const std::optional<UnionGuard> & value) { this->guard = value; }

        const std::optional<UnionHashable> & get_hashable() const { return hashable; }
        std::optional<UnionHashable> & get_mutable_hashable() { return hashable; }
        void set_hashable(const std::optional<UnionHashable> & value) { this->hashable = value; }

        const std::optional<UnionHashCode> & get_hash_code() const { return hash_code; }
        std::optional<UnionHashCode> & get_mutable_hash_code() { return hash_code; }
        void set_hash_code(const std::optional<UnionHashCode> & value) { this->hash_code = value; }

        const std::optional<UnionHasher> & get_hasher() const { return hasher; }
        std::optional<UnionHasher> & get_mutable_hasher() { return hasher; }
        void set_hasher(const std::optional<UnionHasher> & value) { this->hasher = value; }

        const std::optional<UnionHasOwnProperty> & get_has_own_property() const { return has_own_property; }
        std::optional<UnionHasOwnProperty> & get_mutable_has_own_property() { return has_own_property; }
        void set_has_own_property(const std::optional<UnionHasOwnProperty> & value) { this->has_own_property = value; }

        const std::optional<UnionId> & get_id() const { return id; }
        std::optional<UnionId> & get_mutable_id() { return id; }
        void set_id(const std::optional<UnionId> & value) { this->id = value; }

        const std::optional<UnionIf> & get_top_level_if() const { return top_level_if; }
        std::optional<UnionIf> & get_mutable_top_level_if() { return top_level_if; }
        void set_top_level_if(const std::optional<UnionIf> & value) { this->top_level_if = value; }

        const std::optional<UnionImp> & get_imp() const { return imp; }
        std::optional<UnionImp> & get_mutable_imp() { return imp; }
        void set_imp(const std::optional<UnionImp> & value) { this->imp = value; }

        const std::optional<UnionImplements> & get_implements() const { return implements; }
        std::optional<UnionImplements> & get_mutable_implements() { return implements; }
        void set_implements(const std::optional<UnionImplements> & value) { this->implements = value; }

        const std::optional<UnionImplicit> & get_implicit() const { return implicit; }
        std::optional<UnionImplicit> & get_mutable_implicit() { return implicit; }
        void set_implicit(const std::optional<UnionImplicit> & value) { this->implicit = value; }

        const std::optional<UnionImport> & get_top_level_import() const { return top_level_import; }
        std::optional<UnionImport> & get_mutable_top_level_import() { return top_level_import; }
        void set_top_level_import(const std::optional<UnionImport> & value) { this->top_level_import = value; }

        const std::optional<UnionIn> & get_in() const { return in; }
        std::optional<UnionIn> & get_mutable_in() { return in; }
        void set_in(const std::optional<UnionIn> & value) { this->in = value; }

        const std::optional<UnionIndirect> & get_indirect() const { return indirect; }
        std::optional<UnionIndirect> & get_mutable_indirect() { return indirect; }
        void set_indirect(const std::optional<UnionIndirect> & value) { this->indirect = value; }

        const std::optional<UnionInfix> & get_infix() const { return infix; }
        std::optional<UnionInfix> & get_mutable_infix() { return infix; }
        void set_infix(const std::optional<UnionInfix> & value) { this->infix = value; }

        const std::optional<UnionInit> & get_init() const { return init; }
        std::optional<UnionInit> & get_mutable_init() { return init; }
        void set_init(const std::optional<UnionInit> & value) { this->init = value; }

        const std::optional<UnionInline> & get_top_level_inline() const { return top_level_inline; }
        std::optional<UnionInline> & get_mutable_top_level_inline() { return top_level_inline; }
        void set_top_level_inline(const std::optional<UnionInline> & value) { this->top_level_inline = value; }

        const std::optional<UnionInout> & get_inout() const { return inout; }
        std::optional<UnionInout> & get_mutable_inout() { return inout; }
        void set_inout(const std::optional<UnionInout> & value) { this->inout = value; }

        const std::optional<UnionInstanceof> & get_instanceof() const { return instanceof; }
        std::optional<UnionInstanceof> & get_mutable_instanceof() { return instanceof; }
        void set_instanceof(const std::optional<UnionInstanceof> & value) { this->instanceof = value; }

        const std::optional<UnionInt> & get_top_level_int() const { return top_level_int; }
        std::optional<UnionInt> & get_mutable_top_level_int() { return top_level_int; }
        void set_top_level_int(const std::optional<UnionInt> & value) { this->top_level_int = value; }

        const std::optional<UnionInterface> & get_interface() const { return interface; }
        std::optional<UnionInterface> & get_mutable_interface() { return interface; }
        void set_interface(const std::optional<UnionInterface> & value) { this->interface = value; }

        const std::optional<UnionInternal> & get_internal() const { return internal; }
        std::optional<UnionInternal> & get_mutable_internal() { return internal; }
        void set_internal(const std::optional<UnionInternal> & value) { this->internal = value; }

        const std::optional<UnionIntNode> & get_int_node() const { return int_node; }
        std::optional<UnionIntNode> & get_mutable_int_node() { return int_node; }
        void set_int_node(const std::optional<UnionIntNode> & value) { this->int_node = value; }

        const std::optional<UnionIs> & get_is() const { return is; }
        std::optional<UnionIs> & get_mutable_is() { return is; }
        void set_is(const std::optional<UnionIs> & value) { this->is = value; }

        const std::optional<UnionIsoDateTimeOffsetConverter> & get_iso_date_time_offset_converter() const { return iso_date_time_offset_converter; }
        std::optional<UnionIsoDateTimeOffsetConverter> & get_mutable_iso_date_time_offset_converter() { return iso_date_time_offset_converter; }
        void set_iso_date_time_offset_converter(const std::optional<UnionIsoDateTimeOffsetConverter> & value) { this->iso_date_time_offset_converter = value; }

        const std::optional<UnionIterable> & get_iterable() const { return iterable; }
        std::optional<UnionIterable> & get_mutable_iterable() { return iterable; }
        void set_iterable(const std::optional<UnionIterable> & value) { this->iterable = value; }

        const std::optional<UnionJdec> & get_jdec() const { return jdec; }
        std::optional<UnionJdec> & get_mutable_jdec() { return jdec; }
        void set_jdec(const std::optional<UnionJdec> & value) { this->jdec = value; }

        const std::optional<UnionJenc> & get_jenc() const { return jenc; }
        std::optional<UnionJenc> & get_mutable_jenc() { return jenc; }
        void set_jenc(const std::optional<UnionJenc> & value) { this->jenc = value; }

        const std::optional<UnionJpipe> & get_jpipe() const { return jpipe; }
        std::optional<UnionJpipe> & get_mutable_jpipe() { return jpipe; }
        void set_jpipe(const std::optional<UnionJpipe> & value) { this->jpipe = value; }

        const std::optional<UnionJson> & get_json() const { return json; }
        std::optional<UnionJson> & get_mutable_json() { return json; }
        void set_json(const std::optional<UnionJson> & value) { this->json = value; }

        const std::optional<UnionJsonConverter> & get_json_converter() const { return json_converter; }
        std::optional<UnionJsonConverter> & get_mutable_json_converter() { return json_converter; }
        void set_json_converter(const std::optional<UnionJsonConverter> & value) { this->json_converter = value; }

        const std::optional<UnionJsonSerializer> & get_json_serializer() const { return json_serializer; }
        std::optional<UnionJsonSerializer> & get_mutable_json_serializer() { return json_serializer; }
        void set_json_serializer(const std::optional<UnionJsonSerializer> & value) { this->json_serializer = value; }

        const std::optional<UnionJsonToken> & get_json_token() const { return json_token; }
        std::optional<UnionJsonToken> & get_mutable_json_token() { return json_token; }
        void set_json_token(const std::optional<UnionJsonToken> & value) { this->json_token = value; }

        const std::optional<UnionJsonWriter> & get_json_writer() const { return json_writer; }
        std::optional<UnionJsonWriter> & get_mutable_json_writer() { return json_writer; }
        void set_json_writer(const std::optional<UnionJsonWriter> & value) { this->json_writer = value; }

        const std::optional<UnionJsonAny> & get_json_any() const { return json_any; }
        std::optional<UnionJsonAny> & get_mutable_json_any() { return json_any; }
        void set_json_any(const std::optional<UnionJsonAny> & value) { this->json_any = value; }

        const std::optional<UnionJsonCodingKey> & get_json_coding_key() const { return json_coding_key; }
        std::optional<UnionJsonCodingKey> & get_mutable_json_coding_key() { return json_coding_key; }
        void set_json_coding_key(const std::optional<UnionJsonCodingKey> & value) { this->json_coding_key = value; }

        const std::optional<UnionJsonDecoder> & get_json_decoder() const { return json_decoder; }
        std::optional<UnionJsonDecoder> & get_mutable_json_decoder() { return json_decoder; }
        void set_json_decoder(const std::optional<UnionJsonDecoder> & value) { this->json_decoder = value; }

        const std::optional<UnionJsonEncoder> & get_json_encoder() const { return json_encoder; }
        std::optional<UnionJsonEncoder> & get_mutable_json_encoder() { return json_encoder; }
        void set_json_encoder(const std::optional<UnionJsonEncoder> & value) { this->json_encoder = value; }

        const std::optional<UnionJsonException> & get_json_exception() const { return json_exception; }
        std::optional<UnionJsonException> & get_mutable_json_exception() { return json_exception; }
        void set_json_exception(const std::optional<UnionJsonException> & value) { this->json_exception = value; }

        const std::optional<UnionJsonGenerator> & get_json_generator() const { return json_generator; }
        std::optional<UnionJsonGenerator> & get_mutable_json_generator() { return json_generator; }
        void set_json_generator(const std::optional<UnionJsonGenerator> & value) { this->json_generator = value; }

        const std::optional<UnionJsonNode> & get_json_node() const { return json_node; }
        std::optional<UnionJsonNode> & get_mutable_json_node() { return json_node; }
        void set_json_node(const std::optional<UnionJsonNode> & value) { this->json_node = value; }

        const std::optional<UnionJsonNull> & get_json_null() const { return json_null; }
        std::optional<UnionJsonNull> & get_mutable_json_null() { return json_null; }
        void set_json_null(const std::optional<UnionJsonNull> & value) { this->json_null = value; }

        const std::optional<UnionJsonParser> & get_json_parser() const { return json_parser; }
        std::optional<UnionJsonParser> & get_mutable_json_parser() { return json_parser; }
        void set_json_parser(const std::optional<UnionJsonParser> & value) { this->json_parser = value; }

        const std::optional<UnionJsonReader> & get_json_reader() const { return json_reader; }
        std::optional<UnionJsonReader> & get_mutable_json_reader() { return json_reader; }
        void set_json_reader(const std::optional<UnionJsonReader> & value) { this->json_reader = value; }

        const std::optional<UnionJsonTokenType> & get_json_token_type() const { return json_token_type; }
        std::optional<UnionJsonTokenType> & get_mutable_json_token_type() { return json_token_type; }
        void set_json_token_type(const std::optional<UnionJsonTokenType> & value) { this->json_token_type = value; }

        const std::optional<UnionKSerializer> & get_k_serializer() const { return k_serializer; }
        std::optional<UnionKSerializer> & get_mutable_k_serializer() { return k_serializer; }
        void set_k_serializer(const std::optional<UnionKSerializer> & value) { this->k_serializer = value; }

        const std::optional<UnionLambda> & get_lambda() const { return lambda; }
        std::optional<UnionLambda> & get_mutable_lambda() { return lambda; }
        void set_lambda(const std::optional<UnionLambda> & value) { this->lambda = value; }

        const std::optional<UnionLazy> & get_lazy() const { return lazy; }
        std::optional<UnionLazy> & get_mutable_lazy() { return lazy; }
        void set_lazy(const std::optional<UnionLazy> & value) { this->lazy = value; }

        const std::optional<UnionLeft> & get_left() const { return left; }
        std::optional<UnionLeft> & get_mutable_left() { return left; }
        void set_left(const std::optional<UnionLeft> & value) { this->left = value; }

        const std::optional<UnionLet> & get_let() const { return let; }
        std::optional<UnionLet> & get_mutable_let() { return let; }
        void set_let(const std::optional<UnionLet> & value) { this->let = value; }

        const std::optional<UnionList> & get_list() const { return list; }
        std::optional<UnionList> & get_mutable_list() { return list; }
        void set_list(const std::optional<UnionList> & value) { this->list = value; }

        const std::optional<UnionLocalDate> & get_local_date() const { return local_date; }
        std::optional<UnionLocalDate> & get_mutable_local_date() { return local_date; }
        void set_local_date(const std::optional<UnionLocalDate> & value) { this->local_date = value; }

        const std::optional<UnionLocale> & get_locale() const { return locale; }
        std::optional<UnionLocale> & get_mutable_locale() { return locale; }
        void set_locale(const std::optional<UnionLocale> & value) { this->locale = value; }

        const std::optional<UnionLock> & get_lock() const { return lock; }
        std::optional<UnionLock> & get_mutable_lock() { return lock; }
        void set_lock(const std::optional<UnionLock> & value) { this->lock = value; }

        const std::optional<UnionLong> & get_top_level_long() const { return top_level_long; }
        std::optional<UnionLong> & get_mutable_top_level_long() { return top_level_long; }
        void set_top_level_long(const std::optional<UnionLong> & value) { this->top_level_long = value; }

        const std::optional<UnionLongNode> & get_long_node() const { return long_node; }
        std::optional<UnionLongNode> & get_mutable_long_node() { return long_node; }
        void set_long_node(const std::optional<UnionLongNode> & value) { this->long_node = value; }

        const std::optional<UnionMap> & get_map() const { return map; }
        std::optional<UnionMap> & get_mutable_map() { return map; }
        void set_map(const std::optional<UnionMap> & value) { this->map = value; }

        const std::optional<UnionMapEntry> & get_map_entry() const { return map_entry; }
        std::optional<UnionMapEntry> & get_mutable_map_entry() { return map_entry; }
        void set_map_entry(const std::optional<UnionMapEntry> & value) { this->map_entry = value; }

        const std::optional<UnionMarshalJson> & get_marshal_json() const { return marshal_json; }
        std::optional<UnionMarshalJson> & get_mutable_marshal_json() { return marshal_json; }
        void set_marshal_json(const std::optional<UnionMarshalJson> & value) { this->marshal_json = value; }

        const std::optional<UnionMetadataPropertyHandling> & get_metadata_property_handling() const { return metadata_property_handling; }
        std::optional<UnionMetadataPropertyHandling> & get_mutable_metadata_property_handling() { return metadata_property_handling; }
        void set_metadata_property_handling(const std::optional<UnionMetadataPropertyHandling> & value) { this->metadata_property_handling = value; }

        const std::optional<UnionModule> & get_top_level_module() const { return top_level_module; }
        std::optional<UnionModule> & get_mutable_top_level_module() { return top_level_module; }
        void set_top_level_module(const std::optional<UnionModule> & value) { this->top_level_module = value; }

        const std::optional<UnionMutable> & get_top_level_mutable() const { return top_level_mutable; }
        std::optional<UnionMutable> & get_mutable_top_level_mutable() { return top_level_mutable; }
        void set_top_level_mutable(const std::optional<UnionMutable> & value) { this->top_level_mutable = value; }

        const std::optional<UnionMutating> & get_mutating() const { return mutating; }
        std::optional<UnionMutating> & get_mutable_mutating() { return mutating; }
        void set_mutating(const std::optional<UnionMutating> & value) { this->mutating = value; }

        const std::optional<UnionNamespace> & get_top_level_namespace() const { return top_level_namespace; }
        std::optional<UnionNamespace> & get_mutable_top_level_namespace() { return top_level_namespace; }
        void set_top_level_namespace(const std::optional<UnionNamespace> & value) { this->top_level_namespace = value; }

        const std::optional<UnionNative> & get_native() const { return native; }
        std::optional<UnionNative> & get_mutable_native() { return native; }
        void set_native(const std::optional<UnionNative> & value) { this->native = value; }

        const std::optional<UnionNew> & get_top_level_new() const { return top_level_new; }
        std::optional<UnionNew> & get_mutable_top_level_new() { return top_level_new; }
        void set_top_level_new(const std::optional<UnionNew> & value) { this->top_level_new = value; }

        const std::optional<UnionNewtonsoft> & get_newtonsoft() const { return newtonsoft; }
        std::optional<UnionNewtonsoft> & get_mutable_newtonsoft() { return newtonsoft; }
        void set_newtonsoft(const std::optional<UnionNewtonsoft> & value) { this->newtonsoft = value; }

        const std::optional<UnionNil> & get_nil() const { return nil; }
        std::optional<UnionNil> & get_mutable_nil() { return nil; }
        void set_nil(const std::optional<UnionNil> & value) { this->nil = value; }

        const std::optional<UnionNo> & get_no() const { return no; }
        std::optional<UnionNo> & get_mutable_no() { return no; }
        void set_no(const std::optional<UnionNo> & value) { this->no = value; }

        const std::optional<UnionNoexcept> & get_top_level_noexcept() const { return top_level_noexcept; }
        std::optional<UnionNoexcept> & get_mutable_top_level_noexcept() { return top_level_noexcept; }
        void set_top_level_noexcept(const std::optional<UnionNoexcept> & value) { this->top_level_noexcept = value; }

        const std::optional<UnionNonatomic> & get_nonatomic() const { return nonatomic; }
        std::optional<UnionNonatomic> & get_mutable_nonatomic() { return nonatomic; }
        void set_nonatomic(const std::optional<UnionNonatomic> & value) { this->nonatomic = value; }

        const std::optional<UnionNoneUnion> & get_top_level_none() const { return top_level_none; }
        std::optional<UnionNoneUnion> & get_mutable_top_level_none() { return top_level_none; }
        void set_top_level_none(const std::optional<UnionNoneUnion> & value) { this->top_level_none = value; }

        const std::optional<UnionNone> & get_none() const { return none; }
        std::optional<UnionNone> & get_mutable_none() { return none; }
        void set_none(const std::optional<UnionNone> & value) { this->none = value; }

        const std::optional<UnionNonlocal> & get_nonlocal() const { return nonlocal; }
        std::optional<UnionNonlocal> & get_mutable_nonlocal() { return nonlocal; }
        void set_nonlocal(const std::optional<UnionNonlocal> & value) { this->nonlocal = value; }

        const std::optional<UnionNonmutating> & get_nonmutating() const { return nonmutating; }
        std::optional<UnionNonmutating> & get_mutable_nonmutating() { return nonmutating; }
        void set_nonmutating(const std::optional<UnionNonmutating> & value) { this->nonmutating = value; }

        const std::optional<UnionNoSuchMethod> & get_no_such_method() const { return no_such_method; }
        std::optional<UnionNoSuchMethod> & get_mutable_no_such_method() { return no_such_method; }
        void set_no_such_method(const std::optional<UnionNoSuchMethod> & value) { this->no_such_method = value; }

        const std::optional<UnionNot> & get_top_level_not() const { return top_level_not; }
        std::optional<UnionNot> & get_mutable_top_level_not() { return top_level_not; }
        void set_top_level_not(const std::optional<UnionNot> & value) { this->top_level_not = value; }

        const std::optional<UnionNotEq> & get_top_level_not_eq() const { return top_level_not_eq; }
        std::optional<UnionNotEq> & get_mutable_top_level_not_eq() { return top_level_not_eq; }
        void set_top_level_not_eq(const std::optional<UnionNotEq> & value) { this->top_level_not_eq = value; }

        const std::optional<UnionNsError> & get_ns_error() const { return ns_error; }
        std::optional<UnionNsError> & get_mutable_ns_error() { return ns_error; }
        void set_ns_error(const std::optional<UnionNsError> & value) { this->ns_error = value; }

        const std::optional<UnionNsObject> & get_ns_object() const { return ns_object; }
        std::optional<UnionNsObject> & get_mutable_ns_object() { return ns_object; }
        void set_ns_object(const std::optional<UnionNsObject> & value) { this->ns_object = value; }

        const std::optional<UnionNsString> & get_ns_string() const { return ns_string; }
        std::optional<UnionNsString> & get_mutable_ns_string() { return ns_string; }
        void set_ns_string(const std::optional<UnionNsString> & value) { this->ns_string = value; }

        const std::optional<UnionNull> & get_null() const { return null; }
        std::optional<UnionNull> & get_mutable_null() { return null; }
        void set_null(const std::optional<UnionNull> & value) { this->null = value; }

        const std::optional<UnionNullUnion> & get_top_level_null() const { return top_level_null; }
        std::optional<UnionNullUnion> & get_mutable_top_level_null() { return top_level_null; }
        void set_top_level_null(const std::optional<UnionNullUnion> & value) { this->top_level_null = value; }

        const std::optional<UnionNullNode> & get_null_node() const { return null_node; }
        std::optional<UnionNullNode> & get_mutable_null_node() { return null_node; }
        void set_null_node(const std::optional<UnionNullNode> & value) { this->null_node = value; }

        const std::optional<UnionNullptr> & get_top_level_nullptr() const { return top_level_nullptr; }
        std::optional<UnionNullptr> & get_mutable_top_level_nullptr() { return top_level_nullptr; }
        void set_top_level_nullptr(const std::optional<UnionNullptr> & value) { this->top_level_nullptr = value; }

        const std::optional<UnionNumber> & get_number() const { return number; }
        std::optional<UnionNumber> & get_mutable_number() { return number; }
        void set_number(const std::optional<UnionNumber> & value) { this->number = value; }

        const std::optional<UnionObject> & get_object() const { return object; }
        std::optional<UnionObject> & get_mutable_object() { return object; }
        void set_object(const std::optional<UnionObject> & value) { this->object = value; }

        const std::optional<UnionObjectMapper> & get_object_mapper() const { return object_mapper; }
        std::optional<UnionObjectMapper> & get_mutable_object_mapper() { return object_mapper; }
        void set_object_mapper(const std::optional<UnionObjectMapper> & value) { this->object_mapper = value; }

        const std::optional<UnionObjectNode> & get_object_node() const { return object_node; }
        std::optional<UnionObjectNode> & get_mutable_object_node() { return object_node; }
        void set_object_node(const std::optional<UnionObjectNode> & value) { this->object_node = value; }

        const std::optional<UnionObjectReader> & get_object_reader() const { return object_reader; }
        std::optional<UnionObjectReader> & get_mutable_object_reader() { return object_reader; }
        void set_object_reader(const std::optional<UnionObjectReader> & value) { this->object_reader = value; }

        const std::optional<UnionObjectWriter> & get_object_writer() const { return object_writer; }
        std::optional<UnionObjectWriter> & get_mutable_object_writer() { return object_writer; }
        void set_object_writer(const std::optional<UnionObjectWriter> & value) { this->object_writer = value; }

        const std::optional<UnionOf> & get_of() const { return of; }
        std::optional<UnionOf> & get_mutable_of() { return of; }
        void set_of(const std::optional<UnionOf> & value) { this->of = value; }

        const std::optional<UnionOffsetDateTime> & get_offset_date_time() const { return offset_date_time; }
        std::optional<UnionOffsetDateTime> & get_mutable_offset_date_time() { return offset_date_time; }
        void set_offset_date_time(const std::optional<UnionOffsetDateTime> & value) { this->offset_date_time = value; }

        const std::optional<UnionOffsetTime> & get_offset_time() const { return offset_time; }
        std::optional<UnionOffsetTime> & get_mutable_offset_time() { return offset_time; }
        void set_offset_time(const std::optional<UnionOffsetTime> & value) { this->offset_time = value; }

        const std::optional<UnionOneway> & get_oneway() const { return oneway; }
        std::optional<UnionOneway> & get_mutable_oneway() { return oneway; }
        void set_oneway(const std::optional<UnionOneway> & value) { this->oneway = value; }

        const std::optional<UnionOpen> & get_open() const { return open; }
        std::optional<UnionOpen> & get_mutable_open() { return open; }
        void set_open(const std::optional<UnionOpen> & value) { this->open = value; }

        const std::optional<UnionOperator> & get_top_level_operator() const { return top_level_operator; }
        std::optional<UnionOperator> & get_mutable_top_level_operator() { return top_level_operator; }
        void set_top_level_operator(const std::optional<UnionOperator> & value) { this->top_level_operator = value; }

        const std::optional<UnionOptional> & get_optional() const { return optional; }
        std::optional<UnionOptional> & get_mutable_optional() { return optional; }
        void set_optional(const std::optional<UnionOptional> & value) { this->optional = value; }

        const std::optional<UnionOr> & get_top_level_or() const { return top_level_or; }
        std::optional<UnionOr> & get_mutable_top_level_or() { return top_level_or; }
        void set_top_level_or(const std::optional<UnionOr> & value) { this->top_level_or = value; }

        const std::optional<UnionOrEq> & get_top_level_or_eq() const { return top_level_or_eq; }
        std::optional<UnionOrEq> & get_mutable_top_level_or_eq() { return top_level_or_eq; }
        void set_top_level_or_eq(const std::optional<UnionOrEq> & value) { this->top_level_or_eq = value; }

        const std::optional<UnionOut> & get_out() const { return out; }
        std::optional<UnionOut> & get_mutable_out() { return out; }
        void set_out(const std::optional<UnionOut> & value) { this->out = value; }

        const std::optional<UnionOverride> & get_top_level_override() const { return top_level_override; }
        std::optional<UnionOverride> & get_mutable_top_level_override() { return top_level_override; }
        void set_top_level_override(const std::optional<UnionOverride> & value) { this->top_level_override = value; }

        const std::optional<UnionPackage> & get_package() const { return package; }
        std::optional<UnionPackage> & get_mutable_package() { return package; }
        void set_package(const std::optional<UnionPackage> & value) { this->package = value; }

        const std::optional<UnionParams> & get_params() const { return params; }
        std::optional<UnionParams> & get_mutable_params() { return params; }
        void set_params(const std::optional<UnionParams> & value) { this->params = value; }

        const std::optional<UnionPass> & get_pass() const { return pass; }
        std::optional<UnionPass> & get_mutable_pass() { return pass; }
        void set_pass(const std::optional<UnionPass> & value) { this->pass = value; }

        const std::optional<UnionPort> & get_port() const { return port; }
        std::optional<UnionPort> & get_mutable_port() { return port; }
        void set_port(const std::optional<UnionPort> & value) { this->port = value; }

        const std::optional<UnionPostfix> & get_postfix() const { return postfix; }
        std::optional<UnionPostfix> & get_mutable_postfix() { return postfix; }
        void set_postfix(const std::optional<UnionPostfix> & value) { this->postfix = value; }

        const std::optional<UnionPrecedence> & get_precedence() const { return precedence; }
        std::optional<UnionPrecedence> & get_mutable_precedence() { return precedence; }
        void set_precedence(const std::optional<UnionPrecedence> & value) { this->precedence = value; }

        const std::optional<UnionPrefix> & get_prefix() const { return prefix; }
        std::optional<UnionPrefix> & get_mutable_prefix() { return prefix; }
        void set_prefix(const std::optional<UnionPrefix> & value) { this->prefix = value; }

        const std::optional<UnionPrimitiveKind> & get_primitive_kind() const { return primitive_kind; }
        std::optional<UnionPrimitiveKind> & get_mutable_primitive_kind() { return primitive_kind; }
        void set_primitive_kind(const std::optional<UnionPrimitiveKind> & value) { this->primitive_kind = value; }

        const std::optional<UnionPrint> & get_print() const { return print; }
        std::optional<UnionPrint> & get_mutable_print() { return print; }
        void set_print(const std::optional<UnionPrint> & value) { this->print = value; }

        const std::optional<UnionPrintf> & get_printf() const { return printf; }
        std::optional<UnionPrintf> & get_mutable_printf() { return printf; }
        void set_printf(const std::optional<UnionPrintf> & value) { this->printf = value; }

        const std::optional<UnionPrintMembers> & get_print_members() const { return print_members; }
        std::optional<UnionPrintMembers> & get_mutable_print_members() { return print_members; }
        void set_print_members(const std::optional<UnionPrintMembers> & value) { this->print_members = value; }

        const std::optional<UnionPrivate> & get_top_level_private() const { return top_level_private; }
        std::optional<UnionPrivate> & get_mutable_top_level_private() { return top_level_private; }
        void set_top_level_private(const std::optional<UnionPrivate> & value) { this->top_level_private = value; }

        const std::optional<UnionProtected> & get_top_level_protected() const { return top_level_protected; }
        std::optional<UnionProtected> & get_mutable_top_level_protected() { return top_level_protected; }
        void set_top_level_protected(const std::optional<UnionProtected> & value) { this->top_level_protected = value; }

        const std::optional<UnionProtocol> & get_protocol() const { return protocol; }
        std::optional<UnionProtocol> & get_mutable_protocol() { return protocol; }
        void set_protocol(const std::optional<UnionProtocol> & value) { this->protocol = value; }

        const std::optional<UnionProtocolUnion> & get_top_level_protocol() const { return top_level_protocol; }
        std::optional<UnionProtocolUnion> & get_mutable_top_level_protocol() { return top_level_protocol; }
        void set_top_level_protocol(const std::optional<UnionProtocolUnion> & value) { this->top_level_protocol = value; }

        const std::optional<UnionPublic> & get_top_level_public() const { return top_level_public; }
        std::optional<UnionPublic> & get_mutable_top_level_public() { return top_level_public; }
        void set_top_level_public(const std::optional<UnionPublic> & value) { this->top_level_public = value; }

        const std::optional<UnionQuicktype> & get_quicktype() const { return quicktype; }
        std::optional<UnionQuicktype> & get_mutable_quicktype() { return quicktype; }
        void set_quicktype(const std::optional<UnionQuicktype> & value) { this->quicktype = value; }

        const std::optional<UnionRaise> & get_raise() const { return raise; }
        std::optional<UnionRaise> & get_mutable_raise() { return raise; }
        void set_raise(const std::optional<UnionRaise> & value) { this->raise = value; }

        const std::optional<UnionRange> & get_range() const { return range; }
        std::optional<UnionRange> & get_mutable_range() { return range; }
        void set_range(const std::optional<UnionRange> & value) { this->range = value; }

        const std::optional<UnionReadonly> & get_readonly() const { return readonly; }
        std::optional<UnionReadonly> & get_mutable_readonly() { return readonly; }
        void set_readonly(const std::optional<UnionReadonly> & value) { this->readonly = value; }

        const std::optional<UnionRef> & get_ref() const { return ref; }
        std::optional<UnionRef> & get_mutable_ref() { return ref; }
        void set_ref(const std::optional<UnionRef> & value) { this->ref = value; }

        const std::optional<UnionRegExp> & get_reg_exp() const { return reg_exp; }
        std::optional<UnionRegExp> & get_mutable_reg_exp() { return reg_exp; }
        void set_reg_exp(const std::optional<UnionRegExp> & value) { this->reg_exp = value; }

        const std::optional<UnionRegister> & get_top_level_register() const { return top_level_register; }
        std::optional<UnionRegister> & get_mutable_top_level_register() { return top_level_register; }
        void set_top_level_register(const std::optional<UnionRegister> & value) { this->top_level_register = value; }

        const std::optional<UnionReinterpretCast> & get_top_level_reinterpret_cast() const { return top_level_reinterpret_cast; }
        std::optional<UnionReinterpretCast> & get_mutable_top_level_reinterpret_cast() { return top_level_reinterpret_cast; }
        void set_top_level_reinterpret_cast(const std::optional<UnionReinterpretCast> & value) { this->top_level_reinterpret_cast = value; }

        const std::optional<UnionRepeat> & get_repeat() const { return repeat; }
        std::optional<UnionRepeat> & get_mutable_repeat() { return repeat; }
        void set_repeat(const std::optional<UnionRepeat> & value) { this->repeat = value; }

        const std::optional<UnionRequire> & get_require() const { return require; }
        std::optional<UnionRequire> & get_mutable_require() { return require; }
        void set_require(const std::optional<UnionRequire> & value) { this->require = value; }

        const std::optional<UnionRequired> & get_required() const { return required; }
        std::optional<UnionRequired> & get_mutable_required() { return required; }
        void set_required(const std::optional<UnionRequired> & value) { this->required = value; }

        const std::optional<UnionRequires> & get_top_level_requires() const { return top_level_requires; }
        std::optional<UnionRequires> & get_mutable_top_level_requires() { return top_level_requires; }
        void set_top_level_requires(const std::optional<UnionRequires> & value) { this->top_level_requires = value; }

        const std::optional<UnionRestrict> & get_restrict() const { return restrict; }
        std::optional<UnionRestrict> & get_mutable_restrict() { return restrict; }
        void set_restrict(const std::optional<UnionRestrict> & value) { this->restrict = value; }

        const std::optional<UnionRetain> & get_retain() const { return retain; }
        std::optional<UnionRetain> & get_mutable_retain() { return retain; }
        void set_retain(const std::optional<UnionRetain> & value) { this->retain = value; }

        const std::optional<UnionRethrows> & get_rethrows() const { return rethrows; }
        std::optional<UnionRethrows> & get_mutable_rethrows() { return rethrows; }
        void set_rethrows(const std::optional<UnionRethrows> & value) { this->rethrows = value; }

        const std::optional<UnionReturn> & get_top_level_return() const { return top_level_return; }
        std::optional<UnionReturn> & get_mutable_top_level_return() { return top_level_return; }
        void set_top_level_return(const std::optional<UnionReturn> & value) { this->top_level_return = value; }

        const std::optional<UnionRight> & get_right() const { return right; }
        std::optional<UnionRight> & get_mutable_right() { return right; }
        void set_right(const std::optional<UnionRight> & value) { this->right = value; }

        const std::optional<UnionRuntimeType> & get_runtime_type() const { return runtime_type; }
        std::optional<UnionRuntimeType> & get_mutable_runtime_type() { return runtime_type; }
        void set_runtime_type(const std::optional<UnionRuntimeType> & value) { this->runtime_type = value; }

        const std::optional<UnionS> & get_s() const { return s; }
        std::optional<UnionS> & get_mutable_s() { return s; }
        void set_s(const std::optional<UnionS> & value) { this->s = value; }

        const std::optional<UnionSbyte> & get_sbyte() const { return sbyte; }
        std::optional<UnionSbyte> & get_mutable_sbyte() { return sbyte; }
        void set_sbyte(const std::optional<UnionSbyte> & value) { this->sbyte = value; }

        const std::optional<UnionSealed> & get_sealed() const { return sealed; }
        std::optional<UnionSealed> & get_mutable_sealed() { return sealed; }
        void set_sealed(const std::optional<UnionSealed> & value) { this->sealed = value; }

        const std::optional<UnionSel> & get_sel() const { return sel; }
        std::optional<UnionSel> & get_mutable_sel() { return sel; }
        void set_sel(const std::optional<UnionSel> & value) { this->sel = value; }

        const std::optional<UnionSelect> & get_select() const { return select; }
        std::optional<UnionSelect> & get_mutable_select() { return select; }
        void set_select(const std::optional<UnionSelect> & value) { this->select = value; }

        const std::optional<UnionSelf> & get_self() const { return self; }
        std::optional<UnionSelf> & get_mutable_self() { return self; }
        void set_self(const std::optional<UnionSelf> & value) { this->self = value; }

        const std::optional<UnionSelfUnion> & get_top_level_self() const { return top_level_self; }
        std::optional<UnionSelfUnion> & get_mutable_top_level_self() { return top_level_self; }
        void set_top_level_self(const std::optional<UnionSelfUnion> & value) { this->top_level_self = value; }

        const std::optional<UnionSendable> & get_sendable() const { return sendable; }
        std::optional<UnionSendable> & get_mutable_sendable() { return sendable; }
        void set_sendable(const std::optional<UnionSendable> & value) { this->sendable = value; }

        const std::optional<UnionSerialDescriptor> & get_serial_descriptor() const { return serial_descriptor; }
        std::optional<UnionSerialDescriptor> & get_mutable_serial_descriptor() { return serial_descriptor; }
        void set_serial_descriptor(const std::optional<UnionSerialDescriptor> & value) { this->serial_descriptor = value; }

        const std::optional<UnionSerializable> & get_serializable() const { return serializable; }
        std::optional<UnionSerializable> & get_mutable_serializable() { return serializable; }
        void set_serializable(const std::optional<UnionSerializable> & value) { this->serializable = value; }

        const std::optional<UnionSerializationFeature> & get_serialization_feature() const { return serialization_feature; }
        std::optional<UnionSerializationFeature> & get_mutable_serialization_feature() { return serialization_feature; }
        void set_serialization_feature(const std::optional<UnionSerializationFeature> & value) { this->serialization_feature = value; }

        const std::optional<UnionSerialize> & get_serialize() const { return serialize; }
        std::optional<UnionSerialize> & get_mutable_serialize() { return serialize; }
        void set_serialize(const std::optional<UnionSerialize> & value) { this->serialize = value; }

        const std::optional<UnionSerializerProvider> & get_serializer_provider() const { return serializer_provider; }
        std::optional<UnionSerializerProvider> & get_mutable_serializer_provider() { return serializer_provider; }
        void set_serializer_provider(const std::optional<UnionSerializerProvider> & value) { this->serializer_provider = value; }

        const std::optional<UnionSerialName> & get_serial_name() const { return serial_name; }
        std::optional<UnionSerialName> & get_mutable_serial_name() { return serial_name; }
        void set_serial_name(const std::optional<UnionSerialName> & value) { this->serial_name = value; }

        const std::optional<UnionSet> & get_set() const { return set; }
        std::optional<UnionSet> & get_mutable_set() { return set; }
        void set_set(const std::optional<UnionSet> & value) { this->set = value; }

        const std::optional<UnionShort> & get_top_level_short() const { return top_level_short; }
        std::optional<UnionShort> & get_mutable_top_level_short() { return top_level_short; }
        void set_top_level_short(const std::optional<UnionShort> & value) { this->top_level_short = value; }

        const std::optional<UnionSigned> & get_top_level_signed() const { return top_level_signed; }
        std::optional<UnionSigned> & get_mutable_top_level_signed() { return top_level_signed; }
        void set_top_level_signed(const std::optional<UnionSigned> & value) { this->top_level_signed = value; }

        const std::optional<UnionSimpleModule> & get_simple_module() const { return simple_module; }
        std::optional<UnionSimpleModule> & get_mutable_simple_module() { return simple_module; }
        void set_simple_module(const std::optional<UnionSimpleModule> & value) { this->simple_module = value; }

        const std::optional<UnionSizeof> & get_top_level_sizeof() const { return top_level_sizeof; }
        std::optional<UnionSizeof> & get_mutable_top_level_sizeof() { return top_level_sizeof; }
        void set_top_level_sizeof(const std::optional<UnionSizeof> & value) { this->top_level_sizeof = value; }

        const std::optional<UnionStackalloc> & get_stackalloc() const { return stackalloc; }
        std::optional<UnionStackalloc> & get_mutable_stackalloc() { return stackalloc; }
        void set_stackalloc(const std::optional<UnionStackalloc> & value) { this->stackalloc = value; }

        const std::optional<UnionStandards> & get_standards() const { return standards; }
        std::optional<UnionStandards> & get_mutable_standards() { return standards; }
        void set_standards(const std::optional<UnionStandards> & value) { this->standards = value; }

        const std::optional<UnionStatic> & get_top_level_static() const { return top_level_static; }
        std::optional<UnionStatic> & get_mutable_top_level_static() { return top_level_static; }
        void set_top_level_static(const std::optional<UnionStatic> & value) { this->top_level_static = value; }

        const std::optional<UnionStaticAssert> & get_top_level_static_assert() const { return top_level_static_assert; }
        std::optional<UnionStaticAssert> & get_mutable_top_level_static_assert() { return top_level_static_assert; }
        void set_top_level_static_assert(const std::optional<UnionStaticAssert> & value) { this->top_level_static_assert = value; }

        const std::optional<UnionStaticCast> & get_top_level_static_cast() const { return top_level_static_cast; }
        std::optional<UnionStaticCast> & get_mutable_top_level_static_cast() { return top_level_static_cast; }
        void set_top_level_static_cast(const std::optional<UnionStaticCast> & value) { this->top_level_static_cast = value; }

        const std::optional<UnionStdDeserializer> & get_std_deserializer() const { return std_deserializer; }
        std::optional<UnionStdDeserializer> & get_mutable_std_deserializer() { return std_deserializer; }
        void set_std_deserializer(const std::optional<UnionStdDeserializer> & value) { this->std_deserializer = value; }

        const std::optional<UnionStdSerializer> & get_std_serializer() const { return std_serializer; }
        std::optional<UnionStdSerializer> & get_mutable_std_serializer() { return std_serializer; }
        void set_std_serializer(const std::optional<UnionStdSerializer> & value) { this->std_serializer = value; }

        const std::optional<UnionStrictfp> & get_strictfp() const { return strictfp; }
        std::optional<UnionStrictfp> & get_mutable_strictfp() { return strictfp; }
        void set_strictfp(const std::optional<UnionStrictfp> & value) { this->strictfp = value; }

        const std::optional<UnionString> & get_string() const { return string; }
        std::optional<UnionString> & get_mutable_string() { return string; }
        void set_string(const std::optional<UnionString> & value) { this->string = value; }

        const std::optional<UnionStruct> & get_top_level_struct() const { return top_level_struct; }
        std::optional<UnionStruct> & get_mutable_top_level_struct() { return top_level_struct; }
        void set_top_level_struct(const std::optional<UnionStruct> & value) { this->top_level_struct = value; }

        const std::optional<UnionSubscript> & get_subscript() const { return subscript; }
        std::optional<UnionSubscript> & get_mutable_subscript() { return subscript; }
        void set_subscript(const std::optional<UnionSubscript> & value) { this->subscript = value; }

        const std::optional<UnionSuper> & get_super() const { return super; }
        std::optional<UnionSuper> & get_mutable_super() { return super; }
        void set_super(const std::optional<UnionSuper> & value) { this->super = value; }

        const std::optional<UnionSwitch> & get_top_level_switch() const { return top_level_switch; }
        std::optional<UnionSwitch> & get_mutable_top_level_switch() { return top_level_switch; }
        void set_top_level_switch(const std::optional<UnionSwitch> & value) { this->top_level_switch = value; }

        const std::optional<UnionSymbol> & get_symbol() const { return symbol; }
        std::optional<UnionSymbol> & get_mutable_symbol() { return symbol; }
        void set_symbol(const std::optional<UnionSymbol> & value) { this->symbol = value; }

        const std::optional<UnionSynchronized> & get_top_level_synchronized() const { return top_level_synchronized; }
        std::optional<UnionSynchronized> & get_mutable_top_level_synchronized() { return top_level_synchronized; }
        void set_top_level_synchronized(const std::optional<UnionSynchronized> & value) { this->top_level_synchronized = value; }

        const std::optional<UnionSystem> & get_system() const { return system; }
        std::optional<UnionSystem> & get_mutable_system() { return system; }
        void set_system(const std::optional<UnionSystem> & value) { this->system = value; }

        const std::optional<UnionTemplate> & get_top_level_template() const { return top_level_template; }
        std::optional<UnionTemplate> & get_mutable_top_level_template() { return top_level_template; }
        void set_top_level_template(const std::optional<UnionTemplate> & value) { this->top_level_template = value; }

        const std::optional<UnionTextNode> & get_text_node() const { return text_node; }
        std::optional<UnionTextNode> & get_mutable_text_node() { return text_node; }
        void set_text_node(const std::optional<UnionTextNode> & value) { this->text_node = value; }

        const std::optional<UnionThen> & get_then() const { return then; }
        std::optional<UnionThen> & get_mutable_then() { return then; }
        void set_then(const std::optional<UnionThen> & value) { this->then = value; }

        const std::optional<UnionThis> & get_top_level_this() const { return top_level_this; }
        std::optional<UnionThis> & get_mutable_top_level_this() { return top_level_this; }
        void set_top_level_this(const std::optional<UnionThis> & value) { this->top_level_this = value; }

        const std::optional<UnionThreadLocal> & get_top_level_thread_local() const { return top_level_thread_local; }
        std::optional<UnionThreadLocal> & get_mutable_top_level_thread_local() { return top_level_thread_local; }
        void set_top_level_thread_local(const std::optional<UnionThreadLocal> & value) { this->top_level_thread_local = value; }

        const std::optional<UnionThrow> & get_top_level_throw() const { return top_level_throw; }
        std::optional<UnionThrow> & get_mutable_top_level_throw() { return top_level_throw; }
        void set_top_level_throw(const std::optional<UnionThrow> & value) { this->top_level_throw = value; }

        const std::optional<UnionThrows> & get_throws() const { return throws; }
        std::optional<UnionThrows> & get_mutable_throws() { return throws; }
        void set_throws(const std::optional<UnionThrows> & value) { this->throws = value; }

        const std::optional<UnionTimeOnly> & get_time_only() const { return time_only; }
        std::optional<UnionTimeOnly> & get_mutable_time_only() { return time_only; }
        void set_time_only(const std::optional<UnionTimeOnly> & value) { this->time_only = value; }

        const std::optional<UnionTimeOnlyConverter> & get_time_only_converter() const { return time_only_converter; }
        std::optional<UnionTimeOnlyConverter> & get_mutable_time_only_converter() { return time_only_converter; }
        void set_time_only_converter(const std::optional<UnionTimeOnlyConverter> & value) { this->time_only_converter = value; }

        const std::optional<UnionTimeZone> & get_time_zone() const { return time_zone; }
        std::optional<UnionTimeZone> & get_mutable_time_zone() { return time_zone; }
        void set_time_zone(const std::optional<UnionTimeZone> & value) { this->time_zone = value; }

        const std::optional<UnionToDict> & get_to_dict() const { return to_dict; }
        std::optional<UnionToDict> & get_mutable_to_dict() { return to_dict; }
        void set_to_dict(const std::optional<UnionToDict> & value) { this->to_dict = value; }

        const std::optional<UnionToJson> & get_to_json() const { return to_json; }
        std::optional<UnionToJson> & get_mutable_to_json() { return to_json; }
        void set_to_json(const std::optional<UnionToJson> & value) { this->to_json = value; }

        const std::optional<UnionTopLevel> & get_top_level() const { return top_level; }
        std::optional<UnionTopLevel> & get_mutable_top_level() { return top_level; }
        void set_top_level(const std::optional<UnionTopLevel> & value) { this->top_level = value; }

        const std::optional<UnionToString> & get_to_string() const { return to_string; }
        std::optional<UnionToString> & get_mutable_to_string() { return to_string; }
        void set_to_string(const std::optional<UnionToString> & value) { this->to_string = value; }

        const std::optional<UnionTransient> & get_transient() const { return transient; }
        std::optional<UnionTransient> & get_mutable_transient() { return transient; }
        void set_transient(const std::optional<UnionTransient> & value) { this->transient = value; }

        const std::optional<UnionTrue> & get_top_level_true() const { return top_level_true; }
        std::optional<UnionTrue> & get_mutable_top_level_true() { return top_level_true; }
        void set_top_level_true(const std::optional<UnionTrue> & value) { this->top_level_true = value; }

        const std::optional<UnionTrueUnion> & get_purple_true() const { return purple_true; }
        std::optional<UnionTrueUnion> & get_mutable_purple_true() { return purple_true; }
        void set_purple_true(const std::optional<UnionTrueUnion> & value) { this->purple_true = value; }

        const std::optional<UnionTry> & get_top_level_try() const { return top_level_try; }
        std::optional<UnionTry> & get_mutable_top_level_try() { return top_level_try; }
        void set_top_level_try(const std::optional<UnionTry> & value) { this->top_level_try = value; }

        const std::optional<UnionType> & get_type() const { return type; }
        std::optional<UnionType> & get_mutable_type() { return type; }
        void set_type(const std::optional<UnionType> & value) { this->type = value; }

        const std::optional<UnionTypeUnion> & get_top_level_type() const { return top_level_type; }
        std::optional<UnionTypeUnion> & get_mutable_top_level_type() { return top_level_type; }
        void set_top_level_type(const std::optional<UnionTypeUnion> & value) { this->top_level_type = value; }

        const std::optional<UnionTypealias> & get_typealias() const { return typealias; }
        std::optional<UnionTypealias> & get_mutable_typealias() { return typealias; }
        void set_typealias(const std::optional<UnionTypealias> & value) { this->typealias = value; }

        const std::optional<UnionTypedef> & get_top_level_typedef() const { return top_level_typedef; }
        std::optional<UnionTypedef> & get_mutable_top_level_typedef() { return top_level_typedef; }
        void set_top_level_typedef(const std::optional<UnionTypedef> & value) { this->top_level_typedef = value; }

        const std::optional<UnionTypeid> & get_top_level_typeid() const { return top_level_typeid; }
        std::optional<UnionTypeid> & get_mutable_top_level_typeid() { return top_level_typeid; }
        void set_top_level_typeid(const std::optional<UnionTypeid> & value) { this->top_level_typeid = value; }

        const std::optional<UnionTypename> & get_top_level_typename() const { return top_level_typename; }
        std::optional<UnionTypename> & get_mutable_top_level_typename() { return top_level_typename; }
        void set_top_level_typename(const std::optional<UnionTypename> & value) { this->top_level_typename = value; }

        const std::optional<UnionTypeof> & get_typeof() const { return typeof; }
        std::optional<UnionTypeof> & get_mutable_typeof() { return typeof; }
        void set_typeof(const std::optional<UnionTypeof> & value) { this->typeof = value; }

        const std::optional<UnionUint> & get_uint() const { return uint; }
        std::optional<UnionUint> & get_mutable_uint() { return uint; }
        void set_uint(const std::optional<UnionUint> & value) { this->uint = value; }

        const std::optional<UnionUlong> & get_ulong() const { return ulong; }
        std::optional<UnionUlong> & get_mutable_ulong() { return ulong; }
        void set_ulong(const std::optional<UnionUlong> & value) { this->ulong = value; }

        const std::optional<UnionUnchecked> & get_unchecked() const { return unchecked; }
        std::optional<UnionUnchecked> & get_mutable_unchecked() { return unchecked; }
        void set_unchecked(const std::optional<UnionUnchecked> & value) { this->unchecked = value; }

        const std::optional<UnionUndefined> & get_undefined() const { return undefined; }
        std::optional<UnionUndefined> & get_mutable_undefined() { return undefined; }
        void set_undefined(const std::optional<UnionUndefined> & value) { this->undefined = value; }

        const std::optional<UnionUnionUnion> & get_top_level_union() const { return top_level_union; }
        std::optional<UnionUnionUnion> & get_mutable_top_level_union() { return top_level_union; }
        void set_top_level_union(const std::optional<UnionUnionUnion> & value) { this->top_level_union = value; }

        const std::optional<UnionUnmarshalJson> & get_unmarshal_json() const { return unmarshal_json; }
        std::optional<UnionUnmarshalJson> & get_mutable_unmarshal_json() { return unmarshal_json; }
        void set_unmarshal_json(const std::optional<UnionUnmarshalJson> & value) { this->unmarshal_json = value; }

        const std::optional<UnionUnowned> & get_unowned() const { return unowned; }
        std::optional<UnionUnowned> & get_mutable_unowned() { return unowned; }
        void set_unowned(const std::optional<UnionUnowned> & value) { this->unowned = value; }

        const std::optional<UnionUnsafe> & get_unsafe() const { return unsafe; }
        std::optional<UnionUnsafe> & get_mutable_unsafe() { return unsafe; }
        void set_unsafe(const std::optional<UnionUnsafe> & value) { this->unsafe = value; }

        const std::optional<UnionUnsigned> & get_top_level_unsigned() const { return top_level_unsigned; }
        std::optional<UnionUnsigned> & get_mutable_top_level_unsigned() { return top_level_unsigned; }
        void set_top_level_unsigned(const std::optional<UnionUnsigned> & value) { this->top_level_unsigned = value; }

        const std::optional<UnionUseSerializers> & get_use_serializers() const { return use_serializers; }
        std::optional<UnionUseSerializers> & get_mutable_use_serializers() { return use_serializers; }
        void set_use_serializers(const std::optional<UnionUseSerializers> & value) { this->use_serializers = value; }

        const std::optional<UnionUshort> & get_ushort() const { return ushort; }
        std::optional<UnionUshort> & get_mutable_ushort() { return ushort; }
        void set_ushort(const std::optional<UnionUshort> & value) { this->ushort = value; }

        const std::optional<UnionUsing> & get_top_level_using() const { return top_level_using; }
        std::optional<UnionUsing> & get_mutable_top_level_using() { return top_level_using; }
        void set_top_level_using(const std::optional<UnionUsing> & value) { this->top_level_using = value; }

        const std::optional<UnionUtf8JsonReader> & get_utf8_json_reader() const { return utf8_json_reader; }
        std::optional<UnionUtf8JsonReader> & get_mutable_utf8_json_reader() { return utf8_json_reader; }
        void set_utf8_json_reader(const std::optional<UnionUtf8JsonReader> & value) { this->utf8_json_reader = value; }

        const std::optional<UnionUtf8JsonWriter> & get_utf8_json_writer() const { return utf8_json_writer; }
        std::optional<UnionUtf8JsonWriter> & get_mutable_utf8_json_writer() { return utf8_json_writer; }
        void set_utf8_json_writer(const std::optional<UnionUtf8JsonWriter> & value) { this->utf8_json_writer = value; }

        const std::optional<UnionUuid> & get_uuid() const { return uuid; }
        std::optional<UnionUuid> & get_mutable_uuid() { return uuid; }
        void set_uuid(const std::optional<UnionUuid> & value) { this->uuid = value; }

        const std::optional<UnionVar> & get_var() const { return var; }
        std::optional<UnionVar> & get_mutable_var() { return var; }
        void set_var(const std::optional<UnionVar> & value) { this->var = value; }

        const std::optional<UnionVirtual> & get_top_level_virtual() const { return top_level_virtual; }
        std::optional<UnionVirtual> & get_mutable_top_level_virtual() { return top_level_virtual; }
        void set_top_level_virtual(const std::optional<UnionVirtual> & value) { this->top_level_virtual = value; }

        const std::optional<UnionVoid> & get_top_level_void() const { return top_level_void; }
        std::optional<UnionVoid> & get_mutable_top_level_void() { return top_level_void; }
        void set_top_level_void(const std::optional<UnionVoid> & value) { this->top_level_void = value; }

        const std::optional<UnionVolatile> & get_top_level_volatile() const { return top_level_volatile; }
        std::optional<UnionVolatile> & get_mutable_top_level_volatile() { return top_level_volatile; }
        void set_top_level_volatile(const std::optional<UnionVolatile> & value) { this->top_level_volatile = value; }

        const std::optional<UnionWcharT> & get_top_level_wchar_t() const { return top_level_wchar_t; }
        std::optional<UnionWcharT> & get_mutable_top_level_wchar_t() { return top_level_wchar_t; }
        void set_top_level_wchar_t(const std::optional<UnionWcharT> & value) { this->top_level_wchar_t = value; }

        const std::optional<UnionWeak> & get_weak() const { return weak; }
        std::optional<UnionWeak> & get_mutable_weak() { return weak; }
        void set_weak(const std::optional<UnionWeak> & value) { this->weak = value; }

        const std::optional<UnionWhere> & get_where() const { return where; }
        std::optional<UnionWhere> & get_mutable_where() { return where; }
        void set_where(const std::optional<UnionWhere> & value) { this->where = value; }

        const std::optional<UnionWhile> & get_top_level_while() const { return top_level_while; }
        std::optional<UnionWhile> & get_mutable_top_level_while() { return top_level_while; }
        void set_top_level_while(const std::optional<UnionWhile> & value) { this->top_level_while = value; }

        const std::optional<UnionWillSet> & get_will_set() const { return will_set; }
        std::optional<UnionWillSet> & get_mutable_will_set() { return will_set; }
        void set_will_set(const std::optional<UnionWillSet> & value) { this->will_set = value; }

        const std::optional<UnionWith> & get_with() const { return with; }
        std::optional<UnionWith> & get_mutable_with() { return with; }
        void set_with(const std::optional<UnionWith> & value) { this->with = value; }

        const std::optional<UnionXor> & get_top_level_xor() const { return top_level_xor; }
        std::optional<UnionXor> & get_mutable_top_level_xor() { return top_level_xor; }
        void set_top_level_xor(const std::optional<UnionXor> & value) { this->top_level_xor = value; }

        const std::optional<UnionXorEq> & get_top_level_xor_eq() const { return top_level_xor_eq; }
        std::optional<UnionXorEq> & get_mutable_top_level_xor_eq() { return top_level_xor_eq; }
        void set_top_level_xor_eq(const std::optional<UnionXorEq> & value) { this->top_level_xor_eq = value; }

        const std::optional<UnionYes> & get_yes() const { return yes; }
        std::optional<UnionYes> & get_mutable_yes() { return yes; }
        void set_yes(const std::optional<UnionYes> & value) { this->yes = value; }

        const std::optional<UnionYield> & get_yield() const { return yield; }
        std::optional<UnionYield> & get_mutable_yield() { return yield; }
        void set_yield(const std::optional<UnionYield> & value) { this->yield = value; }
    };
}

namespace quicktype {
void from_json(const json & j, Abstract & x);
void to_json(json & j, const Abstract & x);

void from_json(const json & j, Any & x);
void to_json(json & j, const Any & x);

void from_json(const json & j, Array & x);
void to_json(json & j, const Array & x);

void from_json(const json & j, ArrayNode & x);
void to_json(json & j, const ArrayNode & x);

void from_json(const json & j, As & x);
void to_json(json & j, const As & x);

void from_json(const json & j, Assert & x);
void to_json(json & j, const Assert & x);

void from_json(const json & j, Associatedtype & x);
void to_json(json & j, const Associatedtype & x);

void from_json(const json & j, Associativity & x);
void to_json(json & j, const Associativity & x);

void from_json(const json & j, Async & x);
void to_json(json & j, const Async & x);

void from_json(const json & j, Atomic & x);
void to_json(json & j, const Atomic & x);

void from_json(const json & j, Await & x);
void to_json(json & j, const Await & x);

void from_json(const json & j, Base & x);
void to_json(json & j, const Base & x);

void from_json(const json & j, Boolean & x);
void to_json(json & j, const Boolean & x);

void from_json(const json & j, BooleanNode & x);
void to_json(json & j, const BooleanNode & x);

void from_json(const json & j, Bycopy & x);
void to_json(json & j, const Bycopy & x);

void from_json(const json & j, Byref & x);
void to_json(json & j, const Byref & x);

void from_json(const json & j, Byte & x);
void to_json(json & j, const Byte & x);

void from_json(const json & j, Calendar & x);
void to_json(json & j, const Calendar & x);

void from_json(const json & j, Chan & x);
void to_json(json & j, const Chan & x);

void from_json(const json & j, Checked & x);
void to_json(json & j, const Checked & x);

void from_json(const json & j, Clone & x);
void to_json(json & j, const Clone & x);

void from_json(const json & j, Codable & x);
void to_json(json & j, const Codable & x);

void from_json(const json & j, CodingKey & x);
void to_json(json & j, const CodingKey & x);

void from_json(const json & j, CodingKeys & x);
void to_json(json & j, const CodingKeys & x);

void from_json(const json & j, Complex & x);
void to_json(json & j, const Complex & x);

void from_json(const json & j, Console & x);
void to_json(json & j, const Console & x);

void from_json(const json & j, Constructor & x);
void to_json(json & j, const Constructor & x);

void from_json(const json & j, Convenience & x);
void to_json(json & j, const Convenience & x);

void from_json(const json & j, Convert & x);
void to_json(json & j, const Convert & x);

void from_json(const json & j, Converter & x);
void to_json(json & j, const Converter & x);

void from_json(const json & j, CultureInfo & x);
void to_json(json & j, const CultureInfo & x);

void from_json(const json & j, Date & x);
void to_json(json & j, const Date & x);

void from_json(const json & j, DateFormatter & x);
void to_json(json & j, const DateFormatter & x);

void from_json(const json & j, DateOnly & x);
void to_json(json & j, const DateOnly & x);

void from_json(const json & j, DateOnlyConverter & x);
void to_json(json & j, const DateOnlyConverter & x);

void from_json(const json & j, DateParseHandling & x);
void to_json(json & j, const DateParseHandling & x);

void from_json(const json & j, DateTime & x);
void to_json(json & j, const DateTime & x);

void from_json(const json & j, DateTimeStyles & x);
void to_json(json & j, const DateTimeStyles & x);

void from_json(const json & j, Debugger & x);
void to_json(json & j, const Debugger & x);

void from_json(const json & j, Decimal & x);
void to_json(json & j, const Decimal & x);

void from_json(const json & j, Declare & x);
void to_json(json & j, const Declare & x);

void from_json(const json & j, DecodeString & x);
void to_json(json & j, const DecodeString & x);

void from_json(const json & j, Decoder & x);
void to_json(json & j, const Decoder & x);

void from_json(const json & j, DecodingError & x);
void to_json(json & j, const DecodingError & x);

void from_json(const json & j, Def & x);
void to_json(json & j, const Def & x);

void from_json(const json & j, Defer & x);
void to_json(json & j, const Defer & x);

void from_json(const json & j, Deinit & x);
void to_json(json & j, const Deinit & x);

void from_json(const json & j, Del & x);
void to_json(json & j, const Del & x);

void from_json(const json & j, Delegate & x);
void to_json(json & j, const Delegate & x);

void from_json(const json & j, DeserializationFeature & x);
void to_json(json & j, const DeserializationFeature & x);

void from_json(const json & j, Dict & x);
void to_json(json & j, const Dict & x);

void from_json(const json & j, Dictionary & x);
void to_json(json & j, const Dictionary & x);

void from_json(const json & j, DidSet & x);
void to_json(json & j, const DidSet & x);

void from_json(const json & j, DoubleNode & x);
void to_json(json & j, const DoubleNode & x);

void from_json(const json & j, Dynamic & x);
void to_json(json & j, const Dynamic & x);

void from_json(const json & j, Elif & x);
void to_json(json & j, const Elif & x);

void from_json(const json & j, Empty & x);
void to_json(json & j, const Empty & x);

void from_json(const json & j, EncodeQuickType & x);
void to_json(json & j, const EncodeQuickType & x);

void from_json(const json & j, Encoder & x);
void to_json(json & j, const Encoder & x);

void from_json(const json & j, EnumValues & x);
void to_json(json & j, const EnumValues & x);

void from_json(const json & j, EqualityContract & x);
void to_json(json & j, const EqualityContract & x);

void from_json(const json & j, Equatable & x);
void to_json(json & j, const Equatable & x);

void from_json(const json & j, Event & x);
void to_json(json & j, const Event & x);

void from_json(const json & j, Except & x);
void to_json(json & j, const Except & x);

void from_json(const json & j, Exception & x);
void to_json(json & j, const Exception & x);

void from_json(const json & j, Exposing & x);
void to_json(json & j, const Exposing & x);

void from_json(const json & j, Extends & x);
void to_json(json & j, const Extends & x);

void from_json(const json & j, Extension & x);
void to_json(json & j, const Extension & x);

void from_json(const json & j, Fallthrough & x);
void to_json(json & j, const Fallthrough & x);

void from_json(const json & j, Fileprivate & x);
void to_json(json & j, const Fileprivate & x);

void from_json(const json & j, Finally & x);
void to_json(json & j, const Finally & x);

void from_json(const json & j, Fixed & x);
void to_json(json & j, const Fixed & x);

void from_json(const json & j, UnionBoolBool & x);
void to_json(json & j, const UnionBoolBool & x);

void from_json(const json & j, Foreach & x);
void to_json(json & j, const Foreach & x);

void from_json(const json & j, FormatException & x);
void to_json(json & j, const FormatException & x);

void from_json(const json & j, From & x);
void to_json(json & j, const From & x);

void from_json(const json & j, FromDict & x);
void to_json(json & j, const FromDict & x);

void from_json(const json & j, FromJson & x);
void to_json(json & j, const FromJson & x);

void from_json(const json & j, Func & x);
void to_json(json & j, const Func & x);

void from_json(const json & j, Function & x);
void to_json(json & j, const Function & x);

void from_json(const json & j, Get & x);
void to_json(json & j, const Get & x);

void from_json(const json & j, Global & x);
void to_json(json & j, const Global & x);

void from_json(const json & j, Go & x);
void to_json(json & j, const Go & x);

void from_json(const json & j, Guard & x);
void to_json(json & j, const Guard & x);

void from_json(const json & j, HasOwnProperty & x);
void to_json(json & j, const HasOwnProperty & x);

void from_json(const json & j, HashCode & x);
void to_json(json & j, const HashCode & x);

void from_json(const json & j, Hashable & x);
void to_json(json & j, const Hashable & x);

void from_json(const json & j, Hasher & x);
void to_json(json & j, const Hasher & x);

void from_json(const json & j, Id & x);
void to_json(json & j, const Id & x);

void from_json(const json & j, Imaginery & x);
void to_json(json & j, const Imaginery & x);

void from_json(const json & j, Imp & x);
void to_json(json & j, const Imp & x);

void from_json(const json & j, Implements & x);
void to_json(json & j, const Implements & x);

void from_json(const json & j, Implicit & x);
void to_json(json & j, const Implicit & x);

void from_json(const json & j, In & x);
void to_json(json & j, const In & x);

void from_json(const json & j, Indirect & x);
void to_json(json & j, const Indirect & x);

void from_json(const json & j, Infix & x);
void to_json(json & j, const Infix & x);

void from_json(const json & j, Init & x);
void to_json(json & j, const Init & x);

void from_json(const json & j, Inout & x);
void to_json(json & j, const Inout & x);

void from_json(const json & j, Instanceof & x);
void to_json(json & j, const Instanceof & x);

void from_json(const json & j, IntNode & x);
void to_json(json & j, const IntNode & x);

void from_json(const json & j, Interface & x);
void to_json(json & j, const Interface & x);

void from_json(const json & j, Internal & x);
void to_json(json & j, const Internal & x);

void from_json(const json & j, Is & x);
void to_json(json & j, const Is & x);

void from_json(const json & j, IsoDateTimeOffsetConverter & x);
void to_json(json & j, const IsoDateTimeOffsetConverter & x);

void from_json(const json & j, Iterable & x);
void to_json(json & j, const Iterable & x);

void from_json(const json & j, Jdec & x);
void to_json(json & j, const Jdec & x);

void from_json(const json & j, Jenc & x);
void to_json(json & j, const Jenc & x);

void from_json(const json & j, Jpipe & x);
void to_json(json & j, const Jpipe & x);

void from_json(const json & j, Json & x);
void to_json(json & j, const Json & x);

void from_json(const json & j, JsonAny & x);
void to_json(json & j, const JsonAny & x);

void from_json(const json & j, JsonCodingKey & x);
void to_json(json & j, const JsonCodingKey & x);

void from_json(const json & j, JsonConverter & x);
void to_json(json & j, const JsonConverter & x);

void from_json(const json & j, JsonDecoder & x);
void to_json(json & j, const JsonDecoder & x);

void from_json(const json & j, JsonEncoder & x);
void to_json(json & j, const JsonEncoder & x);

void from_json(const json & j, JsonException & x);
void to_json(json & j, const JsonException & x);

void from_json(const json & j, JsonGenerator & x);
void to_json(json & j, const JsonGenerator & x);

void from_json(const json & j, JsonNode & x);
void to_json(json & j, const JsonNode & x);

void from_json(const json & j, JsonNull & x);
void to_json(json & j, const JsonNull & x);

void from_json(const json & j, JsonParser & x);
void to_json(json & j, const JsonParser & x);

void from_json(const json & j, JsonReader & x);
void to_json(json & j, const JsonReader & x);

void from_json(const json & j, JsonSerializer & x);
void to_json(json & j, const JsonSerializer & x);

void from_json(const json & j, JsonToken & x);
void to_json(json & j, const JsonToken & x);

void from_json(const json & j, JsonTokenType & x);
void to_json(json & j, const JsonTokenType & x);

void from_json(const json & j, JsonWriter & x);
void to_json(json & j, const JsonWriter & x);

void from_json(const json & j, KSerializer & x);
void to_json(json & j, const KSerializer & x);

void from_json(const json & j, Lambda & x);
void to_json(json & j, const Lambda & x);

void from_json(const json & j, Lazy & x);
void to_json(json & j, const Lazy & x);

void from_json(const json & j, Left & x);
void to_json(json & j, const Left & x);

void from_json(const json & j, Let & x);
void to_json(json & j, const Let & x);

void from_json(const json & j, List & x);
void to_json(json & j, const List & x);

void from_json(const json & j, LocalDate & x);
void to_json(json & j, const LocalDate & x);

void from_json(const json & j, Locale & x);
void to_json(json & j, const Locale & x);

void from_json(const json & j, Lock & x);
void to_json(json & j, const Lock & x);

void from_json(const json & j, LongNode & x);
void to_json(json & j, const LongNode & x);

void from_json(const json & j, Map & x);
void to_json(json & j, const Map & x);

void from_json(const json & j, MapEntry & x);
void to_json(json & j, const MapEntry & x);

void from_json(const json & j, MarshalJson & x);
void to_json(json & j, const MarshalJson & x);

void from_json(const json & j, MetadataPropertyHandling & x);
void to_json(json & j, const MetadataPropertyHandling & x);

void from_json(const json & j, Mutating & x);
void to_json(json & j, const Mutating & x);

void from_json(const json & j, Native & x);
void to_json(json & j, const Native & x);

void from_json(const json & j, Newtonsoft & x);
void to_json(json & j, const Newtonsoft & x);

void from_json(const json & j, Nil & x);
void to_json(json & j, const Nil & x);

void from_json(const json & j, No & x);
void to_json(json & j, const No & x);

void from_json(const json & j, NoSuchMethod & x);
void to_json(json & j, const NoSuchMethod & x);

void from_json(const json & j, Nonatomic & x);
void to_json(json & j, const Nonatomic & x);

void from_json(const json & j, None & x);
void to_json(json & j, const None & x);

void from_json(const json & j, Nonlocal & x);
void to_json(json & j, const Nonlocal & x);

void from_json(const json & j, Nonmutating & x);
void to_json(json & j, const Nonmutating & x);

void from_json(const json & j, NsError & x);
void to_json(json & j, const NsError & x);

void from_json(const json & j, NsObject & x);
void to_json(json & j, const NsObject & x);

void from_json(const json & j, NsString & x);
void to_json(json & j, const NsString & x);

void from_json(const json & j, Null & x);
void to_json(json & j, const Null & x);

void from_json(const json & j, NullNode & x);
void to_json(json & j, const NullNode & x);

void from_json(const json & j, Number & x);
void to_json(json & j, const Number & x);

void from_json(const json & j, Object & x);
void to_json(json & j, const Object & x);

void from_json(const json & j, ObjectMapper & x);
void to_json(json & j, const ObjectMapper & x);

void from_json(const json & j, ObjectNode & x);
void to_json(json & j, const ObjectNode & x);

void from_json(const json & j, ObjectReader & x);
void to_json(json & j, const ObjectReader & x);

void from_json(const json & j, ObjectWriter & x);
void to_json(json & j, const ObjectWriter & x);

void from_json(const json & j, Of & x);
void to_json(json & j, const Of & x);

void from_json(const json & j, OffsetDateTime & x);
void to_json(json & j, const OffsetDateTime & x);

void from_json(const json & j, OffsetTime & x);
void to_json(json & j, const OffsetTime & x);

void from_json(const json & j, Oneway & x);
void to_json(json & j, const Oneway & x);

void from_json(const json & j, Open & x);
void to_json(json & j, const Open & x);

void from_json(const json & j, Optional & x);
void to_json(json & j, const Optional & x);

void from_json(const json & j, Out & x);
void to_json(json & j, const Out & x);

void from_json(const json & j, Package & x);
void to_json(json & j, const Package & x);

void from_json(const json & j, Params & x);
void to_json(json & j, const Params & x);

void from_json(const json & j, Pass & x);
void to_json(json & j, const Pass & x);

void from_json(const json & j, Port & x);
void to_json(json & j, const Port & x);

void from_json(const json & j, Postfix & x);
void to_json(json & j, const Postfix & x);

void from_json(const json & j, Precedence & x);
void to_json(json & j, const Precedence & x);

void from_json(const json & j, Prefix & x);
void to_json(json & j, const Prefix & x);

void from_json(const json & j, PrimitiveKind & x);
void to_json(json & j, const PrimitiveKind & x);

void from_json(const json & j, Print & x);
void to_json(json & j, const Print & x);

void from_json(const json & j, PrintMembers & x);
void to_json(json & j, const PrintMembers & x);

void from_json(const json & j, Printf & x);
void to_json(json & j, const Printf & x);

void from_json(const json & j, Protocol & x);
void to_json(json & j, const Protocol & x);

void from_json(const json & j, BoolClass & x);
void to_json(json & j, const BoolClass & x);

void from_json(const json & j, ClassClass & x);
void to_json(json & j, const ClassClass & x);

void from_json(const json & j, FalseClass & x);
void to_json(json & j, const FalseClass & x);

void from_json(const json & j, TrueClass & x);
void to_json(json & j, const TrueClass & x);

void from_json(const json & j, Quicktype & x);
void to_json(json & j, const Quicktype & x);

void from_json(const json & j, Raise & x);
void to_json(json & j, const Raise & x);

void from_json(const json & j, Range & x);
void to_json(json & j, const Range & x);

void from_json(const json & j, Readonly & x);
void to_json(json & j, const Readonly & x);

void from_json(const json & j, Ref & x);
void to_json(json & j, const Ref & x);

void from_json(const json & j, RegExp & x);
void to_json(json & j, const RegExp & x);

void from_json(const json & j, Repeat & x);
void to_json(json & j, const Repeat & x);

void from_json(const json & j, Require & x);
void to_json(json & j, const Require & x);

void from_json(const json & j, Required & x);
void to_json(json & j, const Required & x);

void from_json(const json & j, Restrict & x);
void to_json(json & j, const Restrict & x);

void from_json(const json & j, Retain & x);
void to_json(json & j, const Retain & x);

void from_json(const json & j, Rethrows & x);
void to_json(json & j, const Rethrows & x);

void from_json(const json & j, Right & x);
void to_json(json & j, const Right & x);

void from_json(const json & j, RuntimeType & x);
void to_json(json & j, const RuntimeType & x);

void from_json(const json & j, S & x);
void to_json(json & j, const S & x);

void from_json(const json & j, Sbyte & x);
void to_json(json & j, const Sbyte & x);

void from_json(const json & j, Sealed & x);
void to_json(json & j, const Sealed & x);

void from_json(const json & j, Sel & x);
void to_json(json & j, const Sel & x);

void from_json(const json & j, Select & x);
void to_json(json & j, const Select & x);

void from_json(const json & j, Self & x);
void to_json(json & j, const Self & x);

void from_json(const json & j, Sendable & x);
void to_json(json & j, const Sendable & x);

void from_json(const json & j, SerialDescriptor & x);
void to_json(json & j, const SerialDescriptor & x);

void from_json(const json & j, SerialName & x);
void to_json(json & j, const SerialName & x);

void from_json(const json & j, Serializable & x);
void to_json(json & j, const Serializable & x);

void from_json(const json & j, SerializationFeature & x);
void to_json(json & j, const SerializationFeature & x);

void from_json(const json & j, Serialize & x);
void to_json(json & j, const Serialize & x);

void from_json(const json & j, SerializerProvider & x);
void to_json(json & j, const SerializerProvider & x);

void from_json(const json & j, Set & x);
void to_json(json & j, const Set & x);

void from_json(const json & j, SimpleModule & x);
void to_json(json & j, const SimpleModule & x);

void from_json(const json & j, Stackalloc & x);
void to_json(json & j, const Stackalloc & x);

void from_json(const json & j, Standards & x);
void to_json(json & j, const Standards & x);

void from_json(const json & j, StdDeserializer & x);
void to_json(json & j, const StdDeserializer & x);

void from_json(const json & j, StdSerializer & x);
void to_json(json & j, const StdSerializer & x);

void from_json(const json & j, Strictfp & x);
void to_json(json & j, const Strictfp & x);

void from_json(const json & j, String & x);
void to_json(json & j, const String & x);

void from_json(const json & j, Subscript & x);
void to_json(json & j, const Subscript & x);

void from_json(const json & j, Super & x);
void to_json(json & j, const Super & x);

void from_json(const json & j, Symbol & x);
void to_json(json & j, const Symbol & x);

void from_json(const json & j, System & x);
void to_json(json & j, const System & x);

void from_json(const json & j, TextNode & x);
void to_json(json & j, const TextNode & x);

void from_json(const json & j, Then & x);
void to_json(json & j, const Then & x);

void from_json(const json & j, Throws & x);
void to_json(json & j, const Throws & x);

void from_json(const json & j, TimeOnly & x);
void to_json(json & j, const TimeOnly & x);

void from_json(const json & j, TimeOnlyConverter & x);
void to_json(json & j, const TimeOnlyConverter & x);

void from_json(const json & j, TimeZone & x);
void to_json(json & j, const TimeZone & x);

void from_json(const json & j, ToDict & x);
void to_json(json & j, const ToDict & x);

void from_json(const json & j, ToJson & x);
void to_json(json & j, const ToJson & x);

void from_json(const json & j, ToString & x);
void to_json(json & j, const ToString & x);

void from_json(const json & j, TopLevelClass & x);
void to_json(json & j, const TopLevelClass & x);

void from_json(const json & j, Alignas & x);
void to_json(json & j, const Alignas & x);

void from_json(const json & j, Alignof & x);
void to_json(json & j, const Alignof & x);

void from_json(const json & j, And & x);
void to_json(json & j, const And & x);

void from_json(const json & j, AndEq & x);
void to_json(json & j, const AndEq & x);

void from_json(const json & j, AnyClass & x);
void to_json(json & j, const AnyClass & x);

void from_json(const json & j, Asm & x);
void to_json(json & j, const Asm & x);

void from_json(const json & j, AtomicCancel & x);
void to_json(json & j, const AtomicCancel & x);

void from_json(const json & j, AtomicCommit & x);
void to_json(json & j, const AtomicCommit & x);

void from_json(const json & j, AtomicNoexcept & x);
void to_json(json & j, const AtomicNoexcept & x);

void from_json(const json & j, Auto & x);
void to_json(json & j, const Auto & x);

void from_json(const json & j, Bitand & x);
void to_json(json & j, const Bitand & x);

void from_json(const json & j, Bitor & x);
void to_json(json & j, const Bitor & x);

void from_json(const json & j, Bool & x);
void to_json(json & j, const Bool & x);

void from_json(const json & j, Break & x);
void to_json(json & j, const Break & x);

void from_json(const json & j, Case & x);
void to_json(json & j, const Case & x);

void from_json(const json & j, Catch & x);
void to_json(json & j, const Catch & x);

void from_json(const json & j, Char & x);
void to_json(json & j, const Char & x);

void from_json(const json & j, Char16T & x);
void to_json(json & j, const Char16T & x);

void from_json(const json & j, Char32T & x);
void to_json(json & j, const Char32T & x);

void from_json(const json & j, Class & x);
void to_json(json & j, const Class & x);

void from_json(const json & j, CoAwait & x);
void to_json(json & j, const CoAwait & x);

void from_json(const json & j, CoReturn & x);
void to_json(json & j, const CoReturn & x);

void from_json(const json & j, CoYield & x);
void to_json(json & j, const CoYield & x);

void from_json(const json & j, Compl & x);
void to_json(json & j, const Compl & x);

void from_json(const json & j, Concept & x);
void to_json(json & j, const Concept & x);

void from_json(const json & j, Const & x);
void to_json(json & j, const Const & x);

void from_json(const json & j, ConstCast & x);
void to_json(json & j, const ConstCast & x);

void from_json(const json & j, Constexpr & x);
void to_json(json & j, const Constexpr & x);

void from_json(const json & j, Continue & x);
void to_json(json & j, const Continue & x);

void from_json(const json & j, Decltype & x);
void to_json(json & j, const Decltype & x);

void from_json(const json & j, Default & x);
void to_json(json & j, const Default & x);

void from_json(const json & j, Delete & x);
void to_json(json & j, const Delete & x);

void from_json(const json & j, Do & x);
void to_json(json & j, const Do & x);

void from_json(const json & j, Double & x);
void to_json(json & j, const Double & x);

void from_json(const json & j, DynamicCast & x);
void to_json(json & j, const DynamicCast & x);

void from_json(const json & j, Else & x);
void to_json(json & j, const Else & x);

void from_json(const json & j, Enum & x);
void to_json(json & j, const Enum & x);

void from_json(const json & j, Explicit & x);
void to_json(json & j, const Explicit & x);

void from_json(const json & j, Export & x);
void to_json(json & j, const Export & x);

void from_json(const json & j, Extern & x);
void to_json(json & j, const Extern & x);

void from_json(const json & j, False & x);
void to_json(json & j, const False & x);

void from_json(const json & j, Final & x);
void to_json(json & j, const Final & x);

void from_json(const json & j, Float & x);
void to_json(json & j, const Float & x);

void from_json(const json & j, For & x);
void to_json(json & j, const For & x);

void from_json(const json & j, Friend & x);
void to_json(json & j, const Friend & x);

void from_json(const json & j, Goto & x);
void to_json(json & j, const Goto & x);

void from_json(const json & j, If & x);
void to_json(json & j, const If & x);

void from_json(const json & j, Import & x);
void to_json(json & j, const Import & x);

void from_json(const json & j, Inline & x);
void to_json(json & j, const Inline & x);

void from_json(const json & j, Int & x);
void to_json(json & j, const Int & x);

void from_json(const json & j, Long & x);
void to_json(json & j, const Long & x);

void from_json(const json & j, Module & x);
void to_json(json & j, const Module & x);

void from_json(const json & j, Mutable & x);
void to_json(json & j, const Mutable & x);

void from_json(const json & j, Namespace & x);
void to_json(json & j, const Namespace & x);

void from_json(const json & j, New & x);
void to_json(json & j, const New & x);

void from_json(const json & j, Noexcept & x);
void to_json(json & j, const Noexcept & x);

void from_json(const json & j, NoneClass & x);
void to_json(json & j, const NoneClass & x);

void from_json(const json & j, Not & x);
void to_json(json & j, const Not & x);

void from_json(const json & j, NotEq & x);
void to_json(json & j, const NotEq & x);

void from_json(const json & j, NullClass & x);
void to_json(json & j, const NullClass & x);

void from_json(const json & j, Nullptr & x);
void to_json(json & j, const Nullptr & x);

void from_json(const json & j, Operator & x);
void to_json(json & j, const Operator & x);

void from_json(const json & j, Or & x);
void to_json(json & j, const Or & x);

void from_json(const json & j, OrEq & x);
void to_json(json & j, const OrEq & x);

void from_json(const json & j, Override & x);
void to_json(json & j, const Override & x);

void from_json(const json & j, Private & x);
void to_json(json & j, const Private & x);

void from_json(const json & j, Protected & x);
void to_json(json & j, const Protected & x);

void from_json(const json & j, ProtocolClass & x);
void to_json(json & j, const ProtocolClass & x);

void from_json(const json & j, Public & x);
void to_json(json & j, const Public & x);

void from_json(const json & j, Register & x);
void to_json(json & j, const Register & x);

void from_json(const json & j, ReinterpretCast & x);
void to_json(json & j, const ReinterpretCast & x);

void from_json(const json & j, Requires & x);
void to_json(json & j, const Requires & x);

void from_json(const json & j, Return & x);
void to_json(json & j, const Return & x);

void from_json(const json & j, SelfClass & x);
void to_json(json & j, const SelfClass & x);

void from_json(const json & j, Short & x);
void to_json(json & j, const Short & x);

void from_json(const json & j, Signed & x);
void to_json(json & j, const Signed & x);

void from_json(const json & j, Sizeof & x);
void to_json(json & j, const Sizeof & x);

void from_json(const json & j, Static & x);
void to_json(json & j, const Static & x);

void from_json(const json & j, StaticAssert & x);
void to_json(json & j, const StaticAssert & x);

void from_json(const json & j, StaticCast & x);
void to_json(json & j, const StaticCast & x);

void from_json(const json & j, Struct & x);
void to_json(json & j, const Struct & x);

void from_json(const json & j, Switch & x);
void to_json(json & j, const Switch & x);

void from_json(const json & j, Synchronized & x);
void to_json(json & j, const Synchronized & x);

void from_json(const json & j, Template & x);
void to_json(json & j, const Template & x);

void from_json(const json & j, This & x);
void to_json(json & j, const This & x);

void from_json(const json & j, ThreadLocal & x);
void to_json(json & j, const ThreadLocal & x);

void from_json(const json & j, Throw & x);
void to_json(json & j, const Throw & x);

void from_json(const json & j, True & x);
void to_json(json & j, const True & x);

void from_json(const json & j, Try & x);
void to_json(json & j, const Try & x);

void from_json(const json & j, TypeClass & x);
void to_json(json & j, const TypeClass & x);

void from_json(const json & j, Typedef & x);
void to_json(json & j, const Typedef & x);

void from_json(const json & j, Typeid & x);
void to_json(json & j, const Typeid & x);

void from_json(const json & j, Typename & x);
void to_json(json & j, const Typename & x);

void from_json(const json & j, Union & x);
void to_json(json & j, const Union & x);

void from_json(const json & j, Unsigned & x);
void to_json(json & j, const Unsigned & x);

void from_json(const json & j, Using & x);
void to_json(json & j, const Using & x);

void from_json(const json & j, Virtual & x);
void to_json(json & j, const Virtual & x);

void from_json(const json & j, Void & x);
void to_json(json & j, const Void & x);

void from_json(const json & j, Volatile & x);
void to_json(json & j, const Volatile & x);

void from_json(const json & j, WcharT & x);
void to_json(json & j, const WcharT & x);

void from_json(const json & j, While & x);
void to_json(json & j, const While & x);

void from_json(const json & j, Xor & x);
void to_json(json & j, const Xor & x);

void from_json(const json & j, XorEq & x);
void to_json(json & j, const XorEq & x);

void from_json(const json & j, Transient & x);
void to_json(json & j, const Transient & x);

void from_json(const json & j, Type & x);
void to_json(json & j, const Type & x);

void from_json(const json & j, Typealias & x);
void to_json(json & j, const Typealias & x);

void from_json(const json & j, Typeof & x);
void to_json(json & j, const Typeof & x);

void from_json(const json & j, Uint & x);
void to_json(json & j, const Uint & x);

void from_json(const json & j, Ulong & x);
void to_json(json & j, const Ulong & x);

void from_json(const json & j, Unchecked & x);
void to_json(json & j, const Unchecked & x);

void from_json(const json & j, Undefined & x);
void to_json(json & j, const Undefined & x);

void from_json(const json & j, UnmarshalJson & x);
void to_json(json & j, const UnmarshalJson & x);

void from_json(const json & j, Unowned & x);
void to_json(json & j, const Unowned & x);

void from_json(const json & j, Unsafe & x);
void to_json(json & j, const Unsafe & x);

void from_json(const json & j, UseSerializers & x);
void to_json(json & j, const UseSerializers & x);

void from_json(const json & j, Ushort & x);
void to_json(json & j, const Ushort & x);

void from_json(const json & j, Utf8JsonReader & x);
void to_json(json & j, const Utf8JsonReader & x);

void from_json(const json & j, Utf8JsonWriter & x);
void to_json(json & j, const Utf8JsonWriter & x);

void from_json(const json & j, Uuid & x);
void to_json(json & j, const Uuid & x);

void from_json(const json & j, Var & x);
void to_json(json & j, const Var & x);

void from_json(const json & j, Weak & x);
void to_json(json & j, const Weak & x);

void from_json(const json & j, Where & x);
void to_json(json & j, const Where & x);

void from_json(const json & j, WillSet & x);
void to_json(json & j, const WillSet & x);

void from_json(const json & j, With & x);
void to_json(json & j, const With & x);

void from_json(const json & j, Yes & x);
void to_json(json & j, const Yes & x);

void from_json(const json & j, Yield & x);
void to_json(json & j, const Yield & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<quicktype::Abstract, double>> {
    static void from_json(const json & j, std::variant<quicktype::Abstract, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Abstract, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Any, double>> {
    static void from_json(const json & j, std::variant<quicktype::Any, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Any, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Array, double>> {
    static void from_json(const json & j, std::variant<quicktype::Array, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Array, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ArrayNode, double>> {
    static void from_json(const json & j, std::variant<quicktype::ArrayNode, double> & x);
    static void to_json(json & j, const std::variant<quicktype::ArrayNode, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::As, double>> {
    static void from_json(const json & j, std::variant<quicktype::As, double> & x);
    static void to_json(json & j, const std::variant<quicktype::As, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Assert, double>> {
    static void from_json(const json & j, std::variant<quicktype::Assert, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Assert, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Associatedtype, double>> {
    static void from_json(const json & j, std::variant<quicktype::Associatedtype, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Associatedtype, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Associativity, double>> {
    static void from_json(const json & j, std::variant<quicktype::Associativity, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Associativity, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Async, double>> {
    static void from_json(const json & j, std::variant<quicktype::Async, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Async, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Atomic, double>> {
    static void from_json(const json & j, std::variant<quicktype::Atomic, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Atomic, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Await, double>> {
    static void from_json(const json & j, std::variant<quicktype::Await, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Await, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Base, double>> {
    static void from_json(const json & j, std::variant<quicktype::Base, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Base, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Boolean, double>> {
    static void from_json(const json & j, std::variant<quicktype::Boolean, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Boolean, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::BooleanNode, double>> {
    static void from_json(const json & j, std::variant<quicktype::BooleanNode, double> & x);
    static void to_json(json & j, const std::variant<quicktype::BooleanNode, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Bycopy, double>> {
    static void from_json(const json & j, std::variant<quicktype::Bycopy, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Bycopy, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Byref, double>> {
    static void from_json(const json & j, std::variant<quicktype::Byref, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Byref, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Byte, double>> {
    static void from_json(const json & j, std::variant<quicktype::Byte, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Byte, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Calendar, double>> {
    static void from_json(const json & j, std::variant<quicktype::Calendar, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Calendar, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Chan, double>> {
    static void from_json(const json & j, std::variant<quicktype::Chan, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Chan, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Checked, double>> {
    static void from_json(const json & j, std::variant<quicktype::Checked, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Checked, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Clone, double>> {
    static void from_json(const json & j, std::variant<quicktype::Clone, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Clone, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Codable, double>> {
    static void from_json(const json & j, std::variant<quicktype::Codable, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Codable, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CodingKey, double>> {
    static void from_json(const json & j, std::variant<quicktype::CodingKey, double> & x);
    static void to_json(json & j, const std::variant<quicktype::CodingKey, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CodingKeys, double>> {
    static void from_json(const json & j, std::variant<quicktype::CodingKeys, double> & x);
    static void to_json(json & j, const std::variant<quicktype::CodingKeys, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Complex, double>> {
    static void from_json(const json & j, std::variant<quicktype::Complex, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Complex, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Console, double>> {
    static void from_json(const json & j, std::variant<quicktype::Console, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Console, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Constructor, double>> {
    static void from_json(const json & j, std::variant<quicktype::Constructor, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Constructor, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Convenience, double>> {
    static void from_json(const json & j, std::variant<quicktype::Convenience, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Convenience, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Convert, double>> {
    static void from_json(const json & j, std::variant<quicktype::Convert, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Convert, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Converter, double>> {
    static void from_json(const json & j, std::variant<quicktype::Converter, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Converter, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CultureInfo, double>> {
    static void from_json(const json & j, std::variant<quicktype::CultureInfo, double> & x);
    static void to_json(json & j, const std::variant<quicktype::CultureInfo, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Date, double>> {
    static void from_json(const json & j, std::variant<quicktype::Date, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Date, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DateFormatter, double>> {
    static void from_json(const json & j, std::variant<quicktype::DateFormatter, double> & x);
    static void to_json(json & j, const std::variant<quicktype::DateFormatter, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DateOnly, double>> {
    static void from_json(const json & j, std::variant<quicktype::DateOnly, double> & x);
    static void to_json(json & j, const std::variant<quicktype::DateOnly, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DateOnlyConverter, double>> {
    static void from_json(const json & j, std::variant<quicktype::DateOnlyConverter, double> & x);
    static void to_json(json & j, const std::variant<quicktype::DateOnlyConverter, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DateParseHandling, double>> {
    static void from_json(const json & j, std::variant<quicktype::DateParseHandling, double> & x);
    static void to_json(json & j, const std::variant<quicktype::DateParseHandling, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DateTime, double>> {
    static void from_json(const json & j, std::variant<quicktype::DateTime, double> & x);
    static void to_json(json & j, const std::variant<quicktype::DateTime, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DateTimeStyles, double>> {
    static void from_json(const json & j, std::variant<quicktype::DateTimeStyles, double> & x);
    static void to_json(json & j, const std::variant<quicktype::DateTimeStyles, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Debugger, double>> {
    static void from_json(const json & j, std::variant<quicktype::Debugger, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Debugger, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Decimal, double>> {
    static void from_json(const json & j, std::variant<quicktype::Decimal, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Decimal, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Declare, double>> {
    static void from_json(const json & j, std::variant<quicktype::Declare, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Declare, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DecodeString, double>> {
    static void from_json(const json & j, std::variant<quicktype::DecodeString, double> & x);
    static void to_json(json & j, const std::variant<quicktype::DecodeString, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Decoder, double>> {
    static void from_json(const json & j, std::variant<quicktype::Decoder, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Decoder, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DecodingError, double>> {
    static void from_json(const json & j, std::variant<quicktype::DecodingError, double> & x);
    static void to_json(json & j, const std::variant<quicktype::DecodingError, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Def, double>> {
    static void from_json(const json & j, std::variant<quicktype::Def, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Def, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Defer, double>> {
    static void from_json(const json & j, std::variant<quicktype::Defer, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Defer, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Deinit, double>> {
    static void from_json(const json & j, std::variant<quicktype::Deinit, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Deinit, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Del, double>> {
    static void from_json(const json & j, std::variant<quicktype::Del, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Del, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Delegate, double>> {
    static void from_json(const json & j, std::variant<quicktype::Delegate, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Delegate, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DeserializationFeature, double>> {
    static void from_json(const json & j, std::variant<quicktype::DeserializationFeature, double> & x);
    static void to_json(json & j, const std::variant<quicktype::DeserializationFeature, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Dict, double>> {
    static void from_json(const json & j, std::variant<quicktype::Dict, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Dict, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Dictionary, double>> {
    static void from_json(const json & j, std::variant<quicktype::Dictionary, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Dictionary, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DidSet, double>> {
    static void from_json(const json & j, std::variant<quicktype::DidSet, double> & x);
    static void to_json(json & j, const std::variant<quicktype::DidSet, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DoubleNode, double>> {
    static void from_json(const json & j, std::variant<quicktype::DoubleNode, double> & x);
    static void to_json(json & j, const std::variant<quicktype::DoubleNode, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Dynamic, double>> {
    static void from_json(const json & j, std::variant<quicktype::Dynamic, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Dynamic, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Elif, double>> {
    static void from_json(const json & j, std::variant<quicktype::Elif, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Elif, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Empty, double>> {
    static void from_json(const json & j, std::variant<quicktype::Empty, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Empty, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::EncodeQuickType, double>> {
    static void from_json(const json & j, std::variant<quicktype::EncodeQuickType, double> & x);
    static void to_json(json & j, const std::variant<quicktype::EncodeQuickType, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Encoder, double>> {
    static void from_json(const json & j, std::variant<quicktype::Encoder, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Encoder, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::EnumValues, double>> {
    static void from_json(const json & j, std::variant<quicktype::EnumValues, double> & x);
    static void to_json(json & j, const std::variant<quicktype::EnumValues, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::EqualityContract, double>> {
    static void from_json(const json & j, std::variant<quicktype::EqualityContract, double> & x);
    static void to_json(json & j, const std::variant<quicktype::EqualityContract, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Equatable, double>> {
    static void from_json(const json & j, std::variant<quicktype::Equatable, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Equatable, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Event, double>> {
    static void from_json(const json & j, std::variant<quicktype::Event, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Event, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Except, double>> {
    static void from_json(const json & j, std::variant<quicktype::Except, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Except, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Exception, double>> {
    static void from_json(const json & j, std::variant<quicktype::Exception, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Exception, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Exposing, double>> {
    static void from_json(const json & j, std::variant<quicktype::Exposing, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Exposing, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Extends, double>> {
    static void from_json(const json & j, std::variant<quicktype::Extends, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Extends, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Extension, double>> {
    static void from_json(const json & j, std::variant<quicktype::Extension, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Extension, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Fallthrough, double>> {
    static void from_json(const json & j, std::variant<quicktype::Fallthrough, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Fallthrough, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Fileprivate, double>> {
    static void from_json(const json & j, std::variant<quicktype::Fileprivate, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Fileprivate, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Finally, double>> {
    static void from_json(const json & j, std::variant<quicktype::Finally, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Finally, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Fixed, double>> {
    static void from_json(const json & j, std::variant<quicktype::Fixed, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Fixed, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::UnionBoolBool, double>> {
    static void from_json(const json & j, std::variant<quicktype::UnionBoolBool, double> & x);
    static void to_json(json & j, const std::variant<quicktype::UnionBoolBool, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Foreach, double>> {
    static void from_json(const json & j, std::variant<quicktype::Foreach, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Foreach, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::FormatException, double>> {
    static void from_json(const json & j, std::variant<quicktype::FormatException, double> & x);
    static void to_json(json & j, const std::variant<quicktype::FormatException, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::From, double>> {
    static void from_json(const json & j, std::variant<quicktype::From, double> & x);
    static void to_json(json & j, const std::variant<quicktype::From, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::FromDict, double>> {
    static void from_json(const json & j, std::variant<quicktype::FromDict, double> & x);
    static void to_json(json & j, const std::variant<quicktype::FromDict, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::FromJson, double>> {
    static void from_json(const json & j, std::variant<quicktype::FromJson, double> & x);
    static void to_json(json & j, const std::variant<quicktype::FromJson, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Func, double>> {
    static void from_json(const json & j, std::variant<quicktype::Func, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Func, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Function, double>> {
    static void from_json(const json & j, std::variant<quicktype::Function, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Function, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Get, double>> {
    static void from_json(const json & j, std::variant<quicktype::Get, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Get, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Global, double>> {
    static void from_json(const json & j, std::variant<quicktype::Global, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Global, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Go, double>> {
    static void from_json(const json & j, std::variant<quicktype::Go, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Go, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Guard, double>> {
    static void from_json(const json & j, std::variant<quicktype::Guard, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Guard, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::HasOwnProperty, double>> {
    static void from_json(const json & j, std::variant<quicktype::HasOwnProperty, double> & x);
    static void to_json(json & j, const std::variant<quicktype::HasOwnProperty, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::HashCode, double>> {
    static void from_json(const json & j, std::variant<quicktype::HashCode, double> & x);
    static void to_json(json & j, const std::variant<quicktype::HashCode, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Hashable, double>> {
    static void from_json(const json & j, std::variant<quicktype::Hashable, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Hashable, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Hasher, double>> {
    static void from_json(const json & j, std::variant<quicktype::Hasher, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Hasher, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Id, double>> {
    static void from_json(const json & j, std::variant<quicktype::Id, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Id, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Imaginery, double>> {
    static void from_json(const json & j, std::variant<quicktype::Imaginery, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Imaginery, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Imp, double>> {
    static void from_json(const json & j, std::variant<quicktype::Imp, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Imp, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Implements, double>> {
    static void from_json(const json & j, std::variant<quicktype::Implements, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Implements, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Implicit, double>> {
    static void from_json(const json & j, std::variant<quicktype::Implicit, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Implicit, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::In, double>> {
    static void from_json(const json & j, std::variant<quicktype::In, double> & x);
    static void to_json(json & j, const std::variant<quicktype::In, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Indirect, double>> {
    static void from_json(const json & j, std::variant<quicktype::Indirect, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Indirect, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Infix, double>> {
    static void from_json(const json & j, std::variant<quicktype::Infix, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Infix, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Init, double>> {
    static void from_json(const json & j, std::variant<quicktype::Init, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Init, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Inout, double>> {
    static void from_json(const json & j, std::variant<quicktype::Inout, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Inout, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Instanceof, double>> {
    static void from_json(const json & j, std::variant<quicktype::Instanceof, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Instanceof, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::IntNode, double>> {
    static void from_json(const json & j, std::variant<quicktype::IntNode, double> & x);
    static void to_json(json & j, const std::variant<quicktype::IntNode, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Interface, double>> {
    static void from_json(const json & j, std::variant<quicktype::Interface, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Interface, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Internal, double>> {
    static void from_json(const json & j, std::variant<quicktype::Internal, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Internal, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Is, double>> {
    static void from_json(const json & j, std::variant<quicktype::Is, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Is, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::IsoDateTimeOffsetConverter, double>> {
    static void from_json(const json & j, std::variant<quicktype::IsoDateTimeOffsetConverter, double> & x);
    static void to_json(json & j, const std::variant<quicktype::IsoDateTimeOffsetConverter, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Iterable, double>> {
    static void from_json(const json & j, std::variant<quicktype::Iterable, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Iterable, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Jdec, double>> {
    static void from_json(const json & j, std::variant<quicktype::Jdec, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Jdec, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Jenc, double>> {
    static void from_json(const json & j, std::variant<quicktype::Jenc, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Jenc, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Jpipe, double>> {
    static void from_json(const json & j, std::variant<quicktype::Jpipe, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Jpipe, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Json, double>> {
    static void from_json(const json & j, std::variant<quicktype::Json, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Json, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonAny, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonAny, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonAny, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonCodingKey, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonCodingKey, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonCodingKey, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonConverter, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonConverter, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonConverter, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonDecoder, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonDecoder, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonDecoder, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonEncoder, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonEncoder, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonEncoder, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonException, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonException, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonException, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonGenerator, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonGenerator, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonGenerator, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonNode, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonNode, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonNode, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonNull, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonNull, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonNull, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonParser, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonParser, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonParser, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonReader, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonReader, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonReader, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonSerializer, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonSerializer, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonSerializer, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonToken, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonToken, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonToken, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonTokenType, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonTokenType, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonTokenType, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::JsonWriter, double>> {
    static void from_json(const json & j, std::variant<quicktype::JsonWriter, double> & x);
    static void to_json(json & j, const std::variant<quicktype::JsonWriter, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::KSerializer, double>> {
    static void from_json(const json & j, std::variant<quicktype::KSerializer, double> & x);
    static void to_json(json & j, const std::variant<quicktype::KSerializer, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Lambda, double>> {
    static void from_json(const json & j, std::variant<quicktype::Lambda, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Lambda, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Lazy, double>> {
    static void from_json(const json & j, std::variant<quicktype::Lazy, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Lazy, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Left, double>> {
    static void from_json(const json & j, std::variant<quicktype::Left, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Left, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Let, double>> {
    static void from_json(const json & j, std::variant<quicktype::Let, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Let, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::List, double>> {
    static void from_json(const json & j, std::variant<quicktype::List, double> & x);
    static void to_json(json & j, const std::variant<quicktype::List, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::LocalDate, double>> {
    static void from_json(const json & j, std::variant<quicktype::LocalDate, double> & x);
    static void to_json(json & j, const std::variant<quicktype::LocalDate, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Locale, double>> {
    static void from_json(const json & j, std::variant<quicktype::Locale, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Locale, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Lock, double>> {
    static void from_json(const json & j, std::variant<quicktype::Lock, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Lock, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::LongNode, double>> {
    static void from_json(const json & j, std::variant<quicktype::LongNode, double> & x);
    static void to_json(json & j, const std::variant<quicktype::LongNode, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Map, double>> {
    static void from_json(const json & j, std::variant<quicktype::Map, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Map, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::MapEntry, double>> {
    static void from_json(const json & j, std::variant<quicktype::MapEntry, double> & x);
    static void to_json(json & j, const std::variant<quicktype::MapEntry, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::MarshalJson, double>> {
    static void from_json(const json & j, std::variant<quicktype::MarshalJson, double> & x);
    static void to_json(json & j, const std::variant<quicktype::MarshalJson, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::MetadataPropertyHandling, double>> {
    static void from_json(const json & j, std::variant<quicktype::MetadataPropertyHandling, double> & x);
    static void to_json(json & j, const std::variant<quicktype::MetadataPropertyHandling, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Mutating, double>> {
    static void from_json(const json & j, std::variant<quicktype::Mutating, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Mutating, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Native, double>> {
    static void from_json(const json & j, std::variant<quicktype::Native, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Native, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Newtonsoft, double>> {
    static void from_json(const json & j, std::variant<quicktype::Newtonsoft, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Newtonsoft, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Nil, double>> {
    static void from_json(const json & j, std::variant<quicktype::Nil, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Nil, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::No, double>> {
    static void from_json(const json & j, std::variant<quicktype::No, double> & x);
    static void to_json(json & j, const std::variant<quicktype::No, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::NoSuchMethod, double>> {
    static void from_json(const json & j, std::variant<quicktype::NoSuchMethod, double> & x);
    static void to_json(json & j, const std::variant<quicktype::NoSuchMethod, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Nonatomic, double>> {
    static void from_json(const json & j, std::variant<quicktype::Nonatomic, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Nonatomic, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::None, double>> {
    static void from_json(const json & j, std::variant<quicktype::None, double> & x);
    static void to_json(json & j, const std::variant<quicktype::None, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Nonlocal, double>> {
    static void from_json(const json & j, std::variant<quicktype::Nonlocal, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Nonlocal, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Nonmutating, double>> {
    static void from_json(const json & j, std::variant<quicktype::Nonmutating, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Nonmutating, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::NsError, double>> {
    static void from_json(const json & j, std::variant<quicktype::NsError, double> & x);
    static void to_json(json & j, const std::variant<quicktype::NsError, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::NsObject, double>> {
    static void from_json(const json & j, std::variant<quicktype::NsObject, double> & x);
    static void to_json(json & j, const std::variant<quicktype::NsObject, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::NsString, double>> {
    static void from_json(const json & j, std::variant<quicktype::NsString, double> & x);
    static void to_json(json & j, const std::variant<quicktype::NsString, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Null, double>> {
    static void from_json(const json & j, std::variant<quicktype::Null, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Null, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::NullNode, double>> {
    static void from_json(const json & j, std::variant<quicktype::NullNode, double> & x);
    static void to_json(json & j, const std::variant<quicktype::NullNode, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Number, double>> {
    static void from_json(const json & j, std::variant<quicktype::Number, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Number, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Object, double>> {
    static void from_json(const json & j, std::variant<quicktype::Object, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Object, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ObjectMapper, double>> {
    static void from_json(const json & j, std::variant<quicktype::ObjectMapper, double> & x);
    static void to_json(json & j, const std::variant<quicktype::ObjectMapper, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ObjectNode, double>> {
    static void from_json(const json & j, std::variant<quicktype::ObjectNode, double> & x);
    static void to_json(json & j, const std::variant<quicktype::ObjectNode, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ObjectReader, double>> {
    static void from_json(const json & j, std::variant<quicktype::ObjectReader, double> & x);
    static void to_json(json & j, const std::variant<quicktype::ObjectReader, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ObjectWriter, double>> {
    static void from_json(const json & j, std::variant<quicktype::ObjectWriter, double> & x);
    static void to_json(json & j, const std::variant<quicktype::ObjectWriter, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Of, double>> {
    static void from_json(const json & j, std::variant<quicktype::Of, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Of, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::OffsetDateTime, double>> {
    static void from_json(const json & j, std::variant<quicktype::OffsetDateTime, double> & x);
    static void to_json(json & j, const std::variant<quicktype::OffsetDateTime, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::OffsetTime, double>> {
    static void from_json(const json & j, std::variant<quicktype::OffsetTime, double> & x);
    static void to_json(json & j, const std::variant<quicktype::OffsetTime, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Oneway, double>> {
    static void from_json(const json & j, std::variant<quicktype::Oneway, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Oneway, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Open, double>> {
    static void from_json(const json & j, std::variant<quicktype::Open, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Open, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Optional, double>> {
    static void from_json(const json & j, std::variant<quicktype::Optional, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Optional, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Out, double>> {
    static void from_json(const json & j, std::variant<quicktype::Out, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Out, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Package, double>> {
    static void from_json(const json & j, std::variant<quicktype::Package, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Package, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Params, double>> {
    static void from_json(const json & j, std::variant<quicktype::Params, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Params, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Pass, double>> {
    static void from_json(const json & j, std::variant<quicktype::Pass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Pass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Port, double>> {
    static void from_json(const json & j, std::variant<quicktype::Port, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Port, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Postfix, double>> {
    static void from_json(const json & j, std::variant<quicktype::Postfix, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Postfix, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Precedence, double>> {
    static void from_json(const json & j, std::variant<quicktype::Precedence, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Precedence, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Prefix, double>> {
    static void from_json(const json & j, std::variant<quicktype::Prefix, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Prefix, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::PrimitiveKind, double>> {
    static void from_json(const json & j, std::variant<quicktype::PrimitiveKind, double> & x);
    static void to_json(json & j, const std::variant<quicktype::PrimitiveKind, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Print, double>> {
    static void from_json(const json & j, std::variant<quicktype::Print, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Print, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::PrintMembers, double>> {
    static void from_json(const json & j, std::variant<quicktype::PrintMembers, double> & x);
    static void to_json(json & j, const std::variant<quicktype::PrintMembers, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Printf, double>> {
    static void from_json(const json & j, std::variant<quicktype::Printf, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Printf, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Protocol, double>> {
    static void from_json(const json & j, std::variant<quicktype::Protocol, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Protocol, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::BoolClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::BoolClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::BoolClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ClassClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::ClassClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::ClassClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::FalseClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::FalseClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::FalseClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::TrueClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::TrueClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::TrueClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Quicktype, double>> {
    static void from_json(const json & j, std::variant<quicktype::Quicktype, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Quicktype, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Raise, double>> {
    static void from_json(const json & j, std::variant<quicktype::Raise, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Raise, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Range, double>> {
    static void from_json(const json & j, std::variant<quicktype::Range, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Range, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Readonly, double>> {
    static void from_json(const json & j, std::variant<quicktype::Readonly, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Readonly, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Ref, double>> {
    static void from_json(const json & j, std::variant<quicktype::Ref, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Ref, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::RegExp, double>> {
    static void from_json(const json & j, std::variant<quicktype::RegExp, double> & x);
    static void to_json(json & j, const std::variant<quicktype::RegExp, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Repeat, double>> {
    static void from_json(const json & j, std::variant<quicktype::Repeat, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Repeat, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Require, double>> {
    static void from_json(const json & j, std::variant<quicktype::Require, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Require, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Required, double>> {
    static void from_json(const json & j, std::variant<quicktype::Required, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Required, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Restrict, double>> {
    static void from_json(const json & j, std::variant<quicktype::Restrict, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Restrict, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Retain, double>> {
    static void from_json(const json & j, std::variant<quicktype::Retain, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Retain, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Rethrows, double>> {
    static void from_json(const json & j, std::variant<quicktype::Rethrows, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Rethrows, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Right, double>> {
    static void from_json(const json & j, std::variant<quicktype::Right, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Right, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::RuntimeType, double>> {
    static void from_json(const json & j, std::variant<quicktype::RuntimeType, double> & x);
    static void to_json(json & j, const std::variant<quicktype::RuntimeType, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::S, double>> {
    static void from_json(const json & j, std::variant<quicktype::S, double> & x);
    static void to_json(json & j, const std::variant<quicktype::S, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Sbyte, double>> {
    static void from_json(const json & j, std::variant<quicktype::Sbyte, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Sbyte, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Sealed, double>> {
    static void from_json(const json & j, std::variant<quicktype::Sealed, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Sealed, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Sel, double>> {
    static void from_json(const json & j, std::variant<quicktype::Sel, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Sel, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Select, double>> {
    static void from_json(const json & j, std::variant<quicktype::Select, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Select, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Self, double>> {
    static void from_json(const json & j, std::variant<quicktype::Self, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Self, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Sendable, double>> {
    static void from_json(const json & j, std::variant<quicktype::Sendable, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Sendable, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::SerialDescriptor, double>> {
    static void from_json(const json & j, std::variant<quicktype::SerialDescriptor, double> & x);
    static void to_json(json & j, const std::variant<quicktype::SerialDescriptor, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::SerialName, double>> {
    static void from_json(const json & j, std::variant<quicktype::SerialName, double> & x);
    static void to_json(json & j, const std::variant<quicktype::SerialName, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Serializable, double>> {
    static void from_json(const json & j, std::variant<quicktype::Serializable, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Serializable, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::SerializationFeature, double>> {
    static void from_json(const json & j, std::variant<quicktype::SerializationFeature, double> & x);
    static void to_json(json & j, const std::variant<quicktype::SerializationFeature, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Serialize, double>> {
    static void from_json(const json & j, std::variant<quicktype::Serialize, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Serialize, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::SerializerProvider, double>> {
    static void from_json(const json & j, std::variant<quicktype::SerializerProvider, double> & x);
    static void to_json(json & j, const std::variant<quicktype::SerializerProvider, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Set, double>> {
    static void from_json(const json & j, std::variant<quicktype::Set, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Set, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::SimpleModule, double>> {
    static void from_json(const json & j, std::variant<quicktype::SimpleModule, double> & x);
    static void to_json(json & j, const std::variant<quicktype::SimpleModule, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Stackalloc, double>> {
    static void from_json(const json & j, std::variant<quicktype::Stackalloc, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Stackalloc, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Standards, double>> {
    static void from_json(const json & j, std::variant<quicktype::Standards, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Standards, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::StdDeserializer, double>> {
    static void from_json(const json & j, std::variant<quicktype::StdDeserializer, double> & x);
    static void to_json(json & j, const std::variant<quicktype::StdDeserializer, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::StdSerializer, double>> {
    static void from_json(const json & j, std::variant<quicktype::StdSerializer, double> & x);
    static void to_json(json & j, const std::variant<quicktype::StdSerializer, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Strictfp, double>> {
    static void from_json(const json & j, std::variant<quicktype::Strictfp, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Strictfp, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::String, double>> {
    static void from_json(const json & j, std::variant<quicktype::String, double> & x);
    static void to_json(json & j, const std::variant<quicktype::String, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Subscript, double>> {
    static void from_json(const json & j, std::variant<quicktype::Subscript, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Subscript, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Super, double>> {
    static void from_json(const json & j, std::variant<quicktype::Super, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Super, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Symbol, double>> {
    static void from_json(const json & j, std::variant<quicktype::Symbol, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Symbol, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::System, double>> {
    static void from_json(const json & j, std::variant<quicktype::System, double> & x);
    static void to_json(json & j, const std::variant<quicktype::System, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::TextNode, double>> {
    static void from_json(const json & j, std::variant<quicktype::TextNode, double> & x);
    static void to_json(json & j, const std::variant<quicktype::TextNode, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Then, double>> {
    static void from_json(const json & j, std::variant<quicktype::Then, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Then, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Throws, double>> {
    static void from_json(const json & j, std::variant<quicktype::Throws, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Throws, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::TimeOnly, double>> {
    static void from_json(const json & j, std::variant<quicktype::TimeOnly, double> & x);
    static void to_json(json & j, const std::variant<quicktype::TimeOnly, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::TimeOnlyConverter, double>> {
    static void from_json(const json & j, std::variant<quicktype::TimeOnlyConverter, double> & x);
    static void to_json(json & j, const std::variant<quicktype::TimeOnlyConverter, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::TimeZone, double>> {
    static void from_json(const json & j, std::variant<quicktype::TimeZone, double> & x);
    static void to_json(json & j, const std::variant<quicktype::TimeZone, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ToDict, double>> {
    static void from_json(const json & j, std::variant<quicktype::ToDict, double> & x);
    static void to_json(json & j, const std::variant<quicktype::ToDict, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ToJson, double>> {
    static void from_json(const json & j, std::variant<quicktype::ToJson, double> & x);
    static void to_json(json & j, const std::variant<quicktype::ToJson, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ToString, double>> {
    static void from_json(const json & j, std::variant<quicktype::ToString, double> & x);
    static void to_json(json & j, const std::variant<quicktype::ToString, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::TopLevelClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::TopLevelClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::TopLevelClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Alignas, double>> {
    static void from_json(const json & j, std::variant<quicktype::Alignas, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Alignas, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Alignof, double>> {
    static void from_json(const json & j, std::variant<quicktype::Alignof, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Alignof, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::And, double>> {
    static void from_json(const json & j, std::variant<quicktype::And, double> & x);
    static void to_json(json & j, const std::variant<quicktype::And, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::AndEq, double>> {
    static void from_json(const json & j, std::variant<quicktype::AndEq, double> & x);
    static void to_json(json & j, const std::variant<quicktype::AndEq, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::AnyClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::AnyClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::AnyClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Asm, double>> {
    static void from_json(const json & j, std::variant<quicktype::Asm, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Asm, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::AtomicCancel, double>> {
    static void from_json(const json & j, std::variant<quicktype::AtomicCancel, double> & x);
    static void to_json(json & j, const std::variant<quicktype::AtomicCancel, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::AtomicCommit, double>> {
    static void from_json(const json & j, std::variant<quicktype::AtomicCommit, double> & x);
    static void to_json(json & j, const std::variant<quicktype::AtomicCommit, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::AtomicNoexcept, double>> {
    static void from_json(const json & j, std::variant<quicktype::AtomicNoexcept, double> & x);
    static void to_json(json & j, const std::variant<quicktype::AtomicNoexcept, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Auto, double>> {
    static void from_json(const json & j, std::variant<quicktype::Auto, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Auto, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Bitand, double>> {
    static void from_json(const json & j, std::variant<quicktype::Bitand, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Bitand, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Bitor, double>> {
    static void from_json(const json & j, std::variant<quicktype::Bitor, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Bitor, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Bool, double>> {
    static void from_json(const json & j, std::variant<quicktype::Bool, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Bool, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Break, double>> {
    static void from_json(const json & j, std::variant<quicktype::Break, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Break, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Case, double>> {
    static void from_json(const json & j, std::variant<quicktype::Case, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Case, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Catch, double>> {
    static void from_json(const json & j, std::variant<quicktype::Catch, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Catch, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Char, double>> {
    static void from_json(const json & j, std::variant<quicktype::Char, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Char, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Char16T, double>> {
    static void from_json(const json & j, std::variant<quicktype::Char16T, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Char16T, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Char32T, double>> {
    static void from_json(const json & j, std::variant<quicktype::Char32T, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Char32T, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Class, double>> {
    static void from_json(const json & j, std::variant<quicktype::Class, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Class, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CoAwait, double>> {
    static void from_json(const json & j, std::variant<quicktype::CoAwait, double> & x);
    static void to_json(json & j, const std::variant<quicktype::CoAwait, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CoReturn, double>> {
    static void from_json(const json & j, std::variant<quicktype::CoReturn, double> & x);
    static void to_json(json & j, const std::variant<quicktype::CoReturn, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CoYield, double>> {
    static void from_json(const json & j, std::variant<quicktype::CoYield, double> & x);
    static void to_json(json & j, const std::variant<quicktype::CoYield, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Compl, double>> {
    static void from_json(const json & j, std::variant<quicktype::Compl, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Compl, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Concept, double>> {
    static void from_json(const json & j, std::variant<quicktype::Concept, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Concept, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Const, double>> {
    static void from_json(const json & j, std::variant<quicktype::Const, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Const, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ConstCast, double>> {
    static void from_json(const json & j, std::variant<quicktype::ConstCast, double> & x);
    static void to_json(json & j, const std::variant<quicktype::ConstCast, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Constexpr, double>> {
    static void from_json(const json & j, std::variant<quicktype::Constexpr, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Constexpr, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Continue, double>> {
    static void from_json(const json & j, std::variant<quicktype::Continue, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Continue, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Decltype, double>> {
    static void from_json(const json & j, std::variant<quicktype::Decltype, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Decltype, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Default, double>> {
    static void from_json(const json & j, std::variant<quicktype::Default, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Default, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Delete, double>> {
    static void from_json(const json & j, std::variant<quicktype::Delete, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Delete, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Do, double>> {
    static void from_json(const json & j, std::variant<quicktype::Do, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Do, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Double, double>> {
    static void from_json(const json & j, std::variant<quicktype::Double, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Double, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DynamicCast, double>> {
    static void from_json(const json & j, std::variant<quicktype::DynamicCast, double> & x);
    static void to_json(json & j, const std::variant<quicktype::DynamicCast, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Else, double>> {
    static void from_json(const json & j, std::variant<quicktype::Else, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Else, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Enum, double>> {
    static void from_json(const json & j, std::variant<quicktype::Enum, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Enum, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Explicit, double>> {
    static void from_json(const json & j, std::variant<quicktype::Explicit, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Explicit, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Export, double>> {
    static void from_json(const json & j, std::variant<quicktype::Export, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Export, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Extern, double>> {
    static void from_json(const json & j, std::variant<quicktype::Extern, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Extern, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::False, double>> {
    static void from_json(const json & j, std::variant<quicktype::False, double> & x);
    static void to_json(json & j, const std::variant<quicktype::False, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Final, double>> {
    static void from_json(const json & j, std::variant<quicktype::Final, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Final, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Float, double>> {
    static void from_json(const json & j, std::variant<quicktype::Float, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Float, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::For, double>> {
    static void from_json(const json & j, std::variant<quicktype::For, double> & x);
    static void to_json(json & j, const std::variant<quicktype::For, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Friend, double>> {
    static void from_json(const json & j, std::variant<quicktype::Friend, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Friend, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Goto, double>> {
    static void from_json(const json & j, std::variant<quicktype::Goto, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Goto, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::If, double>> {
    static void from_json(const json & j, std::variant<quicktype::If, double> & x);
    static void to_json(json & j, const std::variant<quicktype::If, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Import, double>> {
    static void from_json(const json & j, std::variant<quicktype::Import, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Import, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Inline, double>> {
    static void from_json(const json & j, std::variant<quicktype::Inline, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Inline, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Int, double>> {
    static void from_json(const json & j, std::variant<quicktype::Int, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Int, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Long, double>> {
    static void from_json(const json & j, std::variant<quicktype::Long, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Long, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Module, double>> {
    static void from_json(const json & j, std::variant<quicktype::Module, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Module, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Mutable, double>> {
    static void from_json(const json & j, std::variant<quicktype::Mutable, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Mutable, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Namespace, double>> {
    static void from_json(const json & j, std::variant<quicktype::Namespace, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Namespace, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::New, double>> {
    static void from_json(const json & j, std::variant<quicktype::New, double> & x);
    static void to_json(json & j, const std::variant<quicktype::New, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Noexcept, double>> {
    static void from_json(const json & j, std::variant<quicktype::Noexcept, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Noexcept, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::NoneClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::NoneClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::NoneClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Not, double>> {
    static void from_json(const json & j, std::variant<quicktype::Not, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Not, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::NotEq, double>> {
    static void from_json(const json & j, std::variant<quicktype::NotEq, double> & x);
    static void to_json(json & j, const std::variant<quicktype::NotEq, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::NullClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::NullClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::NullClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Nullptr, double>> {
    static void from_json(const json & j, std::variant<quicktype::Nullptr, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Nullptr, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Operator, double>> {
    static void from_json(const json & j, std::variant<quicktype::Operator, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Operator, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Or, double>> {
    static void from_json(const json & j, std::variant<quicktype::Or, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Or, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::OrEq, double>> {
    static void from_json(const json & j, std::variant<quicktype::OrEq, double> & x);
    static void to_json(json & j, const std::variant<quicktype::OrEq, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Override, double>> {
    static void from_json(const json & j, std::variant<quicktype::Override, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Override, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Private, double>> {
    static void from_json(const json & j, std::variant<quicktype::Private, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Private, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Protected, double>> {
    static void from_json(const json & j, std::variant<quicktype::Protected, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Protected, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ProtocolClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::ProtocolClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::ProtocolClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Public, double>> {
    static void from_json(const json & j, std::variant<quicktype::Public, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Public, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Register, double>> {
    static void from_json(const json & j, std::variant<quicktype::Register, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Register, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ReinterpretCast, double>> {
    static void from_json(const json & j, std::variant<quicktype::ReinterpretCast, double> & x);
    static void to_json(json & j, const std::variant<quicktype::ReinterpretCast, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Requires, double>> {
    static void from_json(const json & j, std::variant<quicktype::Requires, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Requires, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Return, double>> {
    static void from_json(const json & j, std::variant<quicktype::Return, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Return, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::SelfClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::SelfClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::SelfClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Short, double>> {
    static void from_json(const json & j, std::variant<quicktype::Short, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Short, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Signed, double>> {
    static void from_json(const json & j, std::variant<quicktype::Signed, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Signed, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Sizeof, double>> {
    static void from_json(const json & j, std::variant<quicktype::Sizeof, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Sizeof, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Static, double>> {
    static void from_json(const json & j, std::variant<quicktype::Static, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Static, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::StaticAssert, double>> {
    static void from_json(const json & j, std::variant<quicktype::StaticAssert, double> & x);
    static void to_json(json & j, const std::variant<quicktype::StaticAssert, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::StaticCast, double>> {
    static void from_json(const json & j, std::variant<quicktype::StaticCast, double> & x);
    static void to_json(json & j, const std::variant<quicktype::StaticCast, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Struct, double>> {
    static void from_json(const json & j, std::variant<quicktype::Struct, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Struct, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Switch, double>> {
    static void from_json(const json & j, std::variant<quicktype::Switch, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Switch, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Synchronized, double>> {
    static void from_json(const json & j, std::variant<quicktype::Synchronized, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Synchronized, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Template, double>> {
    static void from_json(const json & j, std::variant<quicktype::Template, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Template, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::This, double>> {
    static void from_json(const json & j, std::variant<quicktype::This, double> & x);
    static void to_json(json & j, const std::variant<quicktype::This, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ThreadLocal, double>> {
    static void from_json(const json & j, std::variant<quicktype::ThreadLocal, double> & x);
    static void to_json(json & j, const std::variant<quicktype::ThreadLocal, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Throw, double>> {
    static void from_json(const json & j, std::variant<quicktype::Throw, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Throw, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::True, double>> {
    static void from_json(const json & j, std::variant<quicktype::True, double> & x);
    static void to_json(json & j, const std::variant<quicktype::True, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Try, double>> {
    static void from_json(const json & j, std::variant<quicktype::Try, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Try, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::TypeClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::TypeClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::TypeClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Typedef, double>> {
    static void from_json(const json & j, std::variant<quicktype::Typedef, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Typedef, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Typeid, double>> {
    static void from_json(const json & j, std::variant<quicktype::Typeid, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Typeid, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Typename, double>> {
    static void from_json(const json & j, std::variant<quicktype::Typename, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Typename, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Union, double>> {
    static void from_json(const json & j, std::variant<quicktype::Union, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Union, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Unsigned, double>> {
    static void from_json(const json & j, std::variant<quicktype::Unsigned, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Unsigned, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Using, double>> {
    static void from_json(const json & j, std::variant<quicktype::Using, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Using, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Virtual, double>> {
    static void from_json(const json & j, std::variant<quicktype::Virtual, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Virtual, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Void, double>> {
    static void from_json(const json & j, std::variant<quicktype::Void, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Void, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Volatile, double>> {
    static void from_json(const json & j, std::variant<quicktype::Volatile, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Volatile, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::WcharT, double>> {
    static void from_json(const json & j, std::variant<quicktype::WcharT, double> & x);
    static void to_json(json & j, const std::variant<quicktype::WcharT, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::While, double>> {
    static void from_json(const json & j, std::variant<quicktype::While, double> & x);
    static void to_json(json & j, const std::variant<quicktype::While, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Xor, double>> {
    static void from_json(const json & j, std::variant<quicktype::Xor, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Xor, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::XorEq, double>> {
    static void from_json(const json & j, std::variant<quicktype::XorEq, double> & x);
    static void to_json(json & j, const std::variant<quicktype::XorEq, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Transient, double>> {
    static void from_json(const json & j, std::variant<quicktype::Transient, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Transient, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Type, double>> {
    static void from_json(const json & j, std::variant<quicktype::Type, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Type, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Typealias, double>> {
    static void from_json(const json & j, std::variant<quicktype::Typealias, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Typealias, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Typeof, double>> {
    static void from_json(const json & j, std::variant<quicktype::Typeof, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Typeof, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Uint, double>> {
    static void from_json(const json & j, std::variant<quicktype::Uint, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Uint, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Ulong, double>> {
    static void from_json(const json & j, std::variant<quicktype::Ulong, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Ulong, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Unchecked, double>> {
    static void from_json(const json & j, std::variant<quicktype::Unchecked, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Unchecked, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Undefined, double>> {
    static void from_json(const json & j, std::variant<quicktype::Undefined, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Undefined, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::UnmarshalJson, double>> {
    static void from_json(const json & j, std::variant<quicktype::UnmarshalJson, double> & x);
    static void to_json(json & j, const std::variant<quicktype::UnmarshalJson, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Unowned, double>> {
    static void from_json(const json & j, std::variant<quicktype::Unowned, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Unowned, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Unsafe, double>> {
    static void from_json(const json & j, std::variant<quicktype::Unsafe, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Unsafe, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::UseSerializers, double>> {
    static void from_json(const json & j, std::variant<quicktype::UseSerializers, double> & x);
    static void to_json(json & j, const std::variant<quicktype::UseSerializers, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Ushort, double>> {
    static void from_json(const json & j, std::variant<quicktype::Ushort, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Ushort, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Utf8JsonReader, double>> {
    static void from_json(const json & j, std::variant<quicktype::Utf8JsonReader, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Utf8JsonReader, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Utf8JsonWriter, double>> {
    static void from_json(const json & j, std::variant<quicktype::Utf8JsonWriter, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Utf8JsonWriter, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Uuid, double>> {
    static void from_json(const json & j, std::variant<quicktype::Uuid, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Uuid, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Var, double>> {
    static void from_json(const json & j, std::variant<quicktype::Var, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Var, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Weak, double>> {
    static void from_json(const json & j, std::variant<quicktype::Weak, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Weak, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Where, double>> {
    static void from_json(const json & j, std::variant<quicktype::Where, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Where, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::WillSet, double>> {
    static void from_json(const json & j, std::variant<quicktype::WillSet, double> & x);
    static void to_json(json & j, const std::variant<quicktype::WillSet, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::With, double>> {
    static void from_json(const json & j, std::variant<quicktype::With, double> & x);
    static void to_json(json & j, const std::variant<quicktype::With, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Yes, double>> {
    static void from_json(const json & j, std::variant<quicktype::Yes, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Yes, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Yield, double>> {
    static void from_json(const json & j, std::variant<quicktype::Yield, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Yield, double> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, Abstract& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Abstract & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Any& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Any & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Array& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Array & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ArrayNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ArrayNode & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, As& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const As & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Assert& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Assert & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Associatedtype& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Associatedtype & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Associativity& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Associativity & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Async& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Async & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Atomic& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Atomic & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Await& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Await & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Base& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Base & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Boolean& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Boolean & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, BooleanNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const BooleanNode & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Bycopy& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Bycopy & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Byref& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Byref & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Byte& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Byte & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Calendar& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Calendar & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Chan& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Chan & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Checked& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Checked & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Clone& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Clone & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Codable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Codable & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, CodingKey& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const CodingKey & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, CodingKeys& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const CodingKeys & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Complex& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Complex & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Console& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Console & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Constructor& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Constructor & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Convenience& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Convenience & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Convert& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Convert & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Converter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Converter & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, CultureInfo& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const CultureInfo & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Date& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Date & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, DateFormatter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const DateFormatter & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, DateOnly& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const DateOnly & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, DateOnlyConverter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const DateOnlyConverter & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, DateParseHandling& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const DateParseHandling & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, DateTime& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const DateTime & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, DateTimeStyles& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const DateTimeStyles & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Debugger& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Debugger & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Decimal& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Decimal & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Declare& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Declare & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, DecodeString& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const DecodeString & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Decoder& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Decoder & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, DecodingError& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const DecodingError & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Def& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Def & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Defer& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Defer & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Deinit& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Deinit & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Del& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Del & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Delegate& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Delegate & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, DeserializationFeature& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const DeserializationFeature & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Dict& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Dict & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Dictionary& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Dictionary & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, DidSet& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const DidSet & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, DoubleNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const DoubleNode & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Dynamic& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Dynamic & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Elif& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Elif & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Empty& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Empty & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, EncodeQuickType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const EncodeQuickType & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Encoder& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Encoder & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, EnumValues& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const EnumValues & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, EqualityContract& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const EqualityContract & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Equatable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Equatable & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Event& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Event & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Except& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Except & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Exception& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Exception & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Exposing& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Exposing & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Extends& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Extends & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Extension& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Extension & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Fallthrough& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Fallthrough & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Fileprivate& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Fileprivate & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Finally& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Finally & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Fixed& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Fixed & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, UnionBoolBool& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const UnionBoolBool & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Foreach& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Foreach & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, FormatException& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const FormatException & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, From& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const From & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, FromDict& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const FromDict & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, FromJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const FromJson & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Func& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Func & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Function& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Function & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Get& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Get & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Global& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Global & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Go& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Go & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Guard& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Guard & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, HasOwnProperty& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const HasOwnProperty & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, HashCode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const HashCode & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Hashable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Hashable & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Hasher& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Hasher & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Id& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Id & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Imaginery& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Imaginery & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Imp& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Imp & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Implements& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Implements & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Implicit& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Implicit & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, In& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const In & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Indirect& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Indirect & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Infix& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Infix & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Init& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Init & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Inout& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Inout & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Instanceof& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Instanceof & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, IntNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const IntNode & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Interface& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Interface & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Internal& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Internal & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Is& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Is & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, IsoDateTimeOffsetConverter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const IsoDateTimeOffsetConverter & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Iterable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Iterable & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Jdec& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Jdec & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Jenc& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Jenc & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Jpipe& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Jpipe & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Json& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Json & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonAny& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonAny & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonCodingKey& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonCodingKey & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonConverter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonConverter & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonDecoder& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonDecoder & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonEncoder& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonEncoder & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonException& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonException & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonGenerator& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonGenerator & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonNode & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonNull& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonNull & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonParser& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonParser & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonReader& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonReader & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonSerializer& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonSerializer & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonToken& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonToken & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonTokenType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonTokenType & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, JsonWriter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const JsonWriter & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, KSerializer& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const KSerializer & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Lambda& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Lambda & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Lazy& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Lazy & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Left& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Left & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Let& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Let & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, List& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const List & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, LocalDate& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const LocalDate & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Locale& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Locale & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Lock& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Lock & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, LongNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const LongNode & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Map& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Map & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, MapEntry& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const MapEntry & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, MarshalJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const MarshalJson & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, MetadataPropertyHandling& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const MetadataPropertyHandling & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Mutating& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Mutating & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Native& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Native & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Newtonsoft& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Newtonsoft & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Nil& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Nil & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, No& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const No & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, NoSuchMethod& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const NoSuchMethod & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Nonatomic& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Nonatomic & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, None& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const None & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Nonlocal& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Nonlocal & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Nonmutating& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Nonmutating & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, NsError& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const NsError & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, NsObject& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const NsObject & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, NsString& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const NsString & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Null& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Null & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, NullNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const NullNode & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Number& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Number & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Object& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Object & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ObjectMapper& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ObjectMapper & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ObjectNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ObjectNode & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ObjectReader& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ObjectReader & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ObjectWriter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ObjectWriter & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Of& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Of & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, OffsetDateTime& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const OffsetDateTime & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, OffsetTime& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const OffsetTime & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Oneway& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Oneway & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Open& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Open & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Optional& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Optional & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Out& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Out & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Package& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Package & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Params& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Params & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Pass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Pass & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Port& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Port & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Postfix& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Postfix & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Precedence& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Precedence & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Prefix& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Prefix & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, PrimitiveKind& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const PrimitiveKind & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Print& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Print & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, PrintMembers& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const PrintMembers & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Printf& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Printf & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Protocol& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Protocol & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, BoolClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const BoolClass & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ClassClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ClassClass & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, FalseClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const FalseClass & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, TrueClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const TrueClass & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Quicktype& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Quicktype & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Raise& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Raise & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Range& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Range & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Readonly& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Readonly & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Ref& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Ref & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, RegExp& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const RegExp & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Repeat& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Repeat & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Require& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Require & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Required& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Required & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Restrict& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Restrict & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Retain& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Retain & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Rethrows& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Rethrows & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Right& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Right & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, RuntimeType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const RuntimeType & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, S& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const S & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Sbyte& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Sbyte & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Sealed& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Sealed & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Sel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Sel & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Select& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Select & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Self& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Self & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Sendable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Sendable & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, SerialDescriptor& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const SerialDescriptor & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, SerialName& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const SerialName & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Serializable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Serializable & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, SerializationFeature& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const SerializationFeature & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Serialize& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Serialize & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, SerializerProvider& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const SerializerProvider & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Set& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Set & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, SimpleModule& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const SimpleModule & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Stackalloc& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Stackalloc & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Standards& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Standards & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, StdDeserializer& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const StdDeserializer & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, StdSerializer& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const StdSerializer & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Strictfp& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Strictfp & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, String& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const String & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Subscript& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Subscript & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Super& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Super & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Symbol& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Symbol & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, System& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const System & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, TextNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const TextNode & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Then& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Then & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Throws& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Throws & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, TimeOnly& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const TimeOnly & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, TimeOnlyConverter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const TimeOnlyConverter & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, TimeZone& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const TimeZone & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ToDict& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ToDict & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ToJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ToJson & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ToString& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ToString & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, TopLevelClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const TopLevelClass & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Alignas& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Alignas & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Alignof& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Alignof & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, And& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const And & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, AndEq& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const AndEq & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, AnyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const AnyClass & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Asm& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Asm & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, AtomicCancel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const AtomicCancel & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, AtomicCommit& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const AtomicCommit & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, AtomicNoexcept& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const AtomicNoexcept & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Auto& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Auto & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Bitand& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Bitand & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Bitor& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Bitor & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Bool& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Bool & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Break& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Break & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Case& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Case & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Catch& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Catch & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Char& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Char & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Char16T& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Char16T & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Char32T& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Char32T & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Class& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Class & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, CoAwait& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const CoAwait & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, CoReturn& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const CoReturn & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, CoYield& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const CoYield & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Compl& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Compl & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Concept& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Concept & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Const& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Const & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ConstCast& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ConstCast & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Constexpr& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Constexpr & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Continue& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Continue & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Decltype& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Decltype & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Default& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Default & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Delete& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Delete & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Do& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Do & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Double& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Double & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, DynamicCast& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const DynamicCast & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Else& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Else & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Enum& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Enum & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Explicit& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Explicit & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Export& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Export & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Extern& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Extern & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, False& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const False & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Final& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Final & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Float& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Float & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, For& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const For & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Friend& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Friend & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Goto& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Goto & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, If& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const If & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Import& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Import & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Inline& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Inline & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Int& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Int & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Long& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Long & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Module& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Module & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Mutable& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Mutable & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Namespace& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Namespace & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, New& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const New & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Noexcept& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Noexcept & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, NoneClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const NoneClass & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Not& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Not & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, NotEq& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const NotEq & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, NullClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const NullClass & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Nullptr& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Nullptr & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Operator& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Operator & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Or& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Or & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, OrEq& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const OrEq & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Override& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Override & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Private& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Private & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Protected& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Protected & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ProtocolClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ProtocolClass & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Public& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Public & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Register& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Register & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ReinterpretCast& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ReinterpretCast & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Requires& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Requires & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Return& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Return & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, SelfClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const SelfClass & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Short& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Short & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Signed& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Signed & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Sizeof& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Sizeof & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Static& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Static & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, StaticAssert& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const StaticAssert & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, StaticCast& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const StaticCast & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Struct& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Struct & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Switch& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Switch & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Synchronized& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Synchronized & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Template& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Template & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, This& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const This & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ThreadLocal& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ThreadLocal & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Throw& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Throw & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, True& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const True & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Try& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Try & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, TypeClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const TypeClass & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Typedef& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Typedef & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Typeid& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Typeid & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Typename& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Typename & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Union& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Union & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Unsigned& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Unsigned & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Using& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Using & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Virtual& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Virtual & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Void& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Void & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Volatile& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Volatile & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, WcharT& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const WcharT & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, While& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const While & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Xor& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Xor & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, XorEq& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const XorEq & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Transient& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Transient & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Type& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Type & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Typealias& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Typealias & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Typeof& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Typeof & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Uint& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Uint & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Ulong& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Ulong & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Unchecked& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Unchecked & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Undefined& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Undefined & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, UnmarshalJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const UnmarshalJson & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Unowned& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Unowned & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Unsafe& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Unsafe & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, UseSerializers& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const UseSerializers & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Ushort& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Ushort & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Utf8JsonReader& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Utf8JsonReader & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Utf8JsonWriter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Utf8JsonWriter & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Uuid& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Uuid & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Var& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Var & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Weak& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Weak & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Where& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Where & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, WillSet& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const WillSet & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, With& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const With & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Yes& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Yes & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Yield& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Yield & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("_") != j.end() && j.at("_").is_null()) throw std::runtime_error("Unexpected null");
        x.set_empty(get_stack_optional<std::variant<Empty, double>>(j, "_"));
        if (j.find("_Bool") != j.end() && j.at("_Bool").is_null()) throw std::runtime_error("Unexpected null");
        x.set_purple_bool(get_stack_optional<std::variant<BoolClass, double>>(j, "_Bool"));
        if (j.find("_Complex") != j.end() && j.at("_Complex").is_null()) throw std::runtime_error("Unexpected null");
        x.set_complex(get_stack_optional<std::variant<Complex, double>>(j, "_Complex"));
        if (j.find("_Imaginery") != j.end() && j.at("_Imaginery").is_null()) throw std::runtime_error("Unexpected null");
        x.set_imaginery(get_stack_optional<std::variant<Imaginery, double>>(j, "_Imaginery"));
        if (j.find("abstract") != j.end() && j.at("abstract").is_null()) throw std::runtime_error("Unexpected null");
        x.set_abstract(get_stack_optional<std::variant<Abstract, double>>(j, "abstract"));
        if (j.find("alignas") != j.end() && j.at("alignas").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_alignas(get_stack_optional<std::variant<Alignas, double>>(j, "alignas"));
        if (j.find("alignof") != j.end() && j.at("alignof").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_alignof(get_stack_optional<std::variant<Alignof, double>>(j, "alignof"));
        if (j.find("and") != j.end() && j.at("and").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_and(get_stack_optional<std::variant<And, double>>(j, "and"));
        if (j.find("and_eq") != j.end() && j.at("and_eq").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_and_eq(get_stack_optional<std::variant<AndEq, double>>(j, "and_eq"));
        if (j.find("any") != j.end() && j.at("any").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_any(get_stack_optional<std::variant<AnyClass, double>>(j, "any"));
        if (j.find("Any") != j.end() && j.at("Any").is_null()) throw std::runtime_error("Unexpected null");
        x.set_any(get_stack_optional<std::variant<Any, double>>(j, "Any"));
        if (j.find("array") != j.end() && j.at("array").is_null()) throw std::runtime_error("Unexpected null");
        x.set_array(get_stack_optional<std::variant<Array, double>>(j, "array"));
        if (j.find("ArrayNode") != j.end() && j.at("ArrayNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_array_node(get_stack_optional<std::variant<ArrayNode, double>>(j, "ArrayNode"));
        if (j.find("as") != j.end() && j.at("as").is_null()) throw std::runtime_error("Unexpected null");
        x.set_as(get_stack_optional<std::variant<As, double>>(j, "as"));
        if (j.find("asm") != j.end() && j.at("asm").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_asm(get_stack_optional<std::variant<Asm, double>>(j, "asm"));
        if (j.find("assert") != j.end() && j.at("assert").is_null()) throw std::runtime_error("Unexpected null");
        x.set_assert(get_stack_optional<std::variant<Assert, double>>(j, "assert"));
        if (j.find("associatedtype") != j.end() && j.at("associatedtype").is_null()) throw std::runtime_error("Unexpected null");
        x.set_associatedtype(get_stack_optional<std::variant<Associatedtype, double>>(j, "associatedtype"));
        if (j.find("associativity") != j.end() && j.at("associativity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_associativity(get_stack_optional<std::variant<Associativity, double>>(j, "associativity"));
        if (j.find("async") != j.end() && j.at("async").is_null()) throw std::runtime_error("Unexpected null");
        x.set_async(get_stack_optional<std::variant<Async, double>>(j, "async"));
        if (j.find("atomic") != j.end() && j.at("atomic").is_null()) throw std::runtime_error("Unexpected null");
        x.set_atomic(get_stack_optional<std::variant<Atomic, double>>(j, "atomic"));
        if (j.find("atomic_cancel") != j.end() && j.at("atomic_cancel").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_atomic_cancel(get_stack_optional<std::variant<AtomicCancel, double>>(j, "atomic_cancel"));
        if (j.find("atomic_commit") != j.end() && j.at("atomic_commit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_atomic_commit(get_stack_optional<std::variant<AtomicCommit, double>>(j, "atomic_commit"));
        if (j.find("atomic_noexcept") != j.end() && j.at("atomic_noexcept").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_atomic_noexcept(get_stack_optional<std::variant<AtomicNoexcept, double>>(j, "atomic_noexcept"));
        if (j.find("auto") != j.end() && j.at("auto").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_auto(get_stack_optional<std::variant<Auto, double>>(j, "auto"));
        if (j.find("await") != j.end() && j.at("await").is_null()) throw std::runtime_error("Unexpected null");
        x.set_await(get_stack_optional<std::variant<Await, double>>(j, "await"));
        if (j.find("base") != j.end() && j.at("base").is_null()) throw std::runtime_error("Unexpected null");
        x.set_base(get_stack_optional<std::variant<Base, double>>(j, "base"));
        if (j.find("bitand") != j.end() && j.at("bitand").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_bitand(get_stack_optional<std::variant<Bitand, double>>(j, "bitand"));
        if (j.find("bitor") != j.end() && j.at("bitor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_bitor(get_stack_optional<std::variant<Bitor, double>>(j, "bitor"));
        if (j.find("BOOL") != j.end() && j.at("BOOL").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_bool(get_stack_optional<std::variant<Bool, double>>(j, "BOOL"));
        if (j.find("bool") != j.end() && j.at("bool").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fluffy_bool(get_stack_optional<std::variant<UnionBoolBool, double>>(j, "bool"));
        if (j.find("boolean") != j.end() && j.at("boolean").is_null()) throw std::runtime_error("Unexpected null");
        x.set_boolean(get_stack_optional<std::variant<Boolean, double>>(j, "boolean"));
        if (j.find("BooleanNode") != j.end() && j.at("BooleanNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_boolean_node(get_stack_optional<std::variant<BooleanNode, double>>(j, "BooleanNode"));
        if (j.find("break") != j.end() && j.at("break").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_break(get_stack_optional<std::variant<Break, double>>(j, "break"));
        if (j.find("bycopy") != j.end() && j.at("bycopy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bycopy(get_stack_optional<std::variant<Bycopy, double>>(j, "bycopy"));
        if (j.find("byref") != j.end() && j.at("byref").is_null()) throw std::runtime_error("Unexpected null");
        x.set_byref(get_stack_optional<std::variant<Byref, double>>(j, "byref"));
        if (j.find("byte") != j.end() && j.at("byte").is_null()) throw std::runtime_error("Unexpected null");
        x.set_byte(get_stack_optional<std::variant<Byte, double>>(j, "byte"));
        if (j.find("Calendar") != j.end() && j.at("Calendar").is_null()) throw std::runtime_error("Unexpected null");
        x.set_calendar(get_stack_optional<std::variant<Calendar, double>>(j, "Calendar"));
        if (j.find("case") != j.end() && j.at("case").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_case(get_stack_optional<std::variant<Case, double>>(j, "case"));
        if (j.find("catch") != j.end() && j.at("catch").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_catch(get_stack_optional<std::variant<Catch, double>>(j, "catch"));
        if (j.find("chan") != j.end() && j.at("chan").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chan(get_stack_optional<std::variant<Chan, double>>(j, "chan"));
        if (j.find("char") != j.end() && j.at("char").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_char(get_stack_optional<std::variant<Char, double>>(j, "char"));
        if (j.find("char16_t") != j.end() && j.at("char16_t").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_char16_t(get_stack_optional<std::variant<Char16T, double>>(j, "char16_t"));
        if (j.find("char32_t") != j.end() && j.at("char32_t").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_char32_t(get_stack_optional<std::variant<Char32T, double>>(j, "char32_t"));
        if (j.find("checked") != j.end() && j.at("checked").is_null()) throw std::runtime_error("Unexpected null");
        x.set_checked(get_stack_optional<std::variant<Checked, double>>(j, "checked"));
        if (j.find("class") != j.end() && j.at("class").is_null()) throw std::runtime_error("Unexpected null");
        x.set_purple_class(get_stack_optional<std::variant<ClassClass, double>>(j, "class"));
        if (j.find("Class") != j.end() && j.at("Class").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_class(get_stack_optional<std::variant<Class, double>>(j, "Class"));
        if (j.find("clone") != j.end() && j.at("clone").is_null()) throw std::runtime_error("Unexpected null");
        x.set_clone(get_stack_optional<std::variant<Clone, double>>(j, "clone"));
        if (j.find("co_await") != j.end() && j.at("co_await").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_co_await(get_stack_optional<std::variant<CoAwait, double>>(j, "co_await"));
        if (j.find("co_return") != j.end() && j.at("co_return").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_co_return(get_stack_optional<std::variant<CoReturn, double>>(j, "co_return"));
        if (j.find("co_yield") != j.end() && j.at("co_yield").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_co_yield(get_stack_optional<std::variant<CoYield, double>>(j, "co_yield"));
        if (j.find("Codable") != j.end() && j.at("Codable").is_null()) throw std::runtime_error("Unexpected null");
        x.set_codable(get_stack_optional<std::variant<Codable, double>>(j, "Codable"));
        if (j.find("CodingKey") != j.end() && j.at("CodingKey").is_null()) throw std::runtime_error("Unexpected null");
        x.set_coding_key(get_stack_optional<std::variant<CodingKey, double>>(j, "CodingKey"));
        if (j.find("CodingKeys") != j.end() && j.at("CodingKeys").is_null()) throw std::runtime_error("Unexpected null");
        x.set_coding_keys(get_stack_optional<std::variant<CodingKeys, double>>(j, "CodingKeys"));
        if (j.find("compl") != j.end() && j.at("compl").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_compl(get_stack_optional<std::variant<Compl, double>>(j, "compl"));
        if (j.find("concept") != j.end() && j.at("concept").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_concept(get_stack_optional<std::variant<Concept, double>>(j, "concept"));
        if (j.find("console") != j.end() && j.at("console").is_null()) throw std::runtime_error("Unexpected null");
        x.set_console(get_stack_optional<std::variant<Console, double>>(j, "console"));
        if (j.find("const") != j.end() && j.at("const").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_const(get_stack_optional<std::variant<Const, double>>(j, "const"));
        if (j.find("const_cast") != j.end() && j.at("const_cast").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_const_cast(get_stack_optional<std::variant<ConstCast, double>>(j, "const_cast"));
        if (j.find("constexpr") != j.end() && j.at("constexpr").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_constexpr(get_stack_optional<std::variant<Constexpr, double>>(j, "constexpr"));
        if (j.find("constructor") != j.end() && j.at("constructor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_constructor(get_stack_optional<std::variant<Constructor, double>>(j, "constructor"));
        if (j.find("continue") != j.end() && j.at("continue").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_continue(get_stack_optional<std::variant<Continue, double>>(j, "continue"));
        if (j.find("convenience") != j.end() && j.at("convenience").is_null()) throw std::runtime_error("Unexpected null");
        x.set_convenience(get_stack_optional<std::variant<Convenience, double>>(j, "convenience"));
        if (j.find("convert") != j.end() && j.at("convert").is_null()) throw std::runtime_error("Unexpected null");
        x.set_convert(get_stack_optional<std::variant<Convert, double>>(j, "convert"));
        if (j.find("converter") != j.end() && j.at("converter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_converter(get_stack_optional<std::variant<Converter, double>>(j, "converter"));
        if (j.find("CultureInfo") != j.end() && j.at("CultureInfo").is_null()) throw std::runtime_error("Unexpected null");
        x.set_culture_info(get_stack_optional<std::variant<CultureInfo, double>>(j, "CultureInfo"));
        if (j.find("date") != j.end() && j.at("date").is_null()) throw std::runtime_error("Unexpected null");
        x.set_date(get_stack_optional<std::variant<Date, double>>(j, "date"));
        if (j.find("date_parse_handling") != j.end() && j.at("date_parse_handling").is_null()) throw std::runtime_error("Unexpected null");
        x.set_date_parse_handling(get_stack_optional<std::variant<DateParseHandling, double>>(j, "date_parse_handling"));
        if (j.find("DateFormatter") != j.end() && j.at("DateFormatter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_date_formatter(get_stack_optional<std::variant<DateFormatter, double>>(j, "DateFormatter"));
        if (j.find("DateOnly") != j.end() && j.at("DateOnly").is_null()) throw std::runtime_error("Unexpected null");
        x.set_date_only(get_stack_optional<std::variant<DateOnly, double>>(j, "DateOnly"));
        if (j.find("DateOnlyConverter") != j.end() && j.at("DateOnlyConverter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_date_only_converter(get_stack_optional<std::variant<DateOnlyConverter, double>>(j, "DateOnlyConverter"));
        if (j.find("DateTime") != j.end() && j.at("DateTime").is_null()) throw std::runtime_error("Unexpected null");
        x.set_date_time(get_stack_optional<std::variant<DateTime, double>>(j, "DateTime"));
        if (j.find("DateTimeStyles") != j.end() && j.at("DateTimeStyles").is_null()) throw std::runtime_error("Unexpected null");
        x.set_date_time_styles(get_stack_optional<std::variant<DateTimeStyles, double>>(j, "DateTimeStyles"));
        if (j.find("debugger") != j.end() && j.at("debugger").is_null()) throw std::runtime_error("Unexpected null");
        x.set_debugger(get_stack_optional<std::variant<Debugger, double>>(j, "debugger"));
        if (j.find("decimal") != j.end() && j.at("decimal").is_null()) throw std::runtime_error("Unexpected null");
        x.set_decimal(get_stack_optional<std::variant<Decimal, double>>(j, "decimal"));
        if (j.find("declare") != j.end() && j.at("declare").is_null()) throw std::runtime_error("Unexpected null");
        x.set_declare(get_stack_optional<std::variant<Declare, double>>(j, "declare"));
        if (j.find("decltype") != j.end() && j.at("decltype").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_decltype(get_stack_optional<std::variant<Decltype, double>>(j, "decltype"));
        if (j.find("decode_string") != j.end() && j.at("decode_string").is_null()) throw std::runtime_error("Unexpected null");
        x.set_decode_string(get_stack_optional<std::variant<DecodeString, double>>(j, "decode_string"));
        if (j.find("Decoder") != j.end() && j.at("Decoder").is_null()) throw std::runtime_error("Unexpected null");
        x.set_decoder(get_stack_optional<std::variant<Decoder, double>>(j, "Decoder"));
        if (j.find("DecodingError") != j.end() && j.at("DecodingError").is_null()) throw std::runtime_error("Unexpected null");
        x.set_decoding_error(get_stack_optional<std::variant<DecodingError, double>>(j, "DecodingError"));
        if (j.find("def") != j.end() && j.at("def").is_null()) throw std::runtime_error("Unexpected null");
        x.set_def(get_stack_optional<std::variant<Def, double>>(j, "def"));
        if (j.find("default") != j.end() && j.at("default").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_default(get_stack_optional<std::variant<Default, double>>(j, "default"));
        if (j.find("defer") != j.end() && j.at("defer").is_null()) throw std::runtime_error("Unexpected null");
        x.set_defer(get_stack_optional<std::variant<Defer, double>>(j, "defer"));
        if (j.find("deinit") != j.end() && j.at("deinit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_deinit(get_stack_optional<std::variant<Deinit, double>>(j, "deinit"));
        if (j.find("del") != j.end() && j.at("del").is_null()) throw std::runtime_error("Unexpected null");
        x.set_del(get_stack_optional<std::variant<Del, double>>(j, "del"));
        if (j.find("delegate") != j.end() && j.at("delegate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_delegate(get_stack_optional<std::variant<Delegate, double>>(j, "delegate"));
        if (j.find("delete") != j.end() && j.at("delete").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_delete(get_stack_optional<std::variant<Delete, double>>(j, "delete"));
        if (j.find("DeserializationFeature") != j.end() && j.at("DeserializationFeature").is_null()) throw std::runtime_error("Unexpected null");
        x.set_deserialization_feature(get_stack_optional<std::variant<DeserializationFeature, double>>(j, "DeserializationFeature"));
        if (j.find("dict") != j.end() && j.at("dict").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dict(get_stack_optional<std::variant<Dict, double>>(j, "dict"));
        if (j.find("dictionary") != j.end() && j.at("dictionary").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dictionary(get_stack_optional<std::variant<Dictionary, double>>(j, "dictionary"));
        if (j.find("didSet") != j.end() && j.at("didSet").is_null()) throw std::runtime_error("Unexpected null");
        x.set_did_set(get_stack_optional<std::variant<DidSet, double>>(j, "didSet"));
        if (j.find("do") != j.end() && j.at("do").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_do(get_stack_optional<std::variant<Do, double>>(j, "do"));
        if (j.find("double") != j.end() && j.at("double").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_double(get_stack_optional<std::variant<Double, double>>(j, "double"));
        if (j.find("DoubleNode") != j.end() && j.at("DoubleNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_double_node(get_stack_optional<std::variant<DoubleNode, double>>(j, "DoubleNode"));
        if (j.find("dummy") != j.end() && j.at("dummy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dummy(get_stack_optional<double>(j, "dummy"));
        if (j.find("dynamic") != j.end() && j.at("dynamic").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dynamic(get_stack_optional<std::variant<Dynamic, double>>(j, "dynamic"));
        if (j.find("dynamic_cast") != j.end() && j.at("dynamic_cast").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_dynamic_cast(get_stack_optional<std::variant<DynamicCast, double>>(j, "dynamic_cast"));
        if (j.find("elif") != j.end() && j.at("elif").is_null()) throw std::runtime_error("Unexpected null");
        x.set_elif(get_stack_optional<std::variant<Elif, double>>(j, "elif"));
        if (j.find("else") != j.end() && j.at("else").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_else(get_stack_optional<std::variant<Else, double>>(j, "else"));
        if (j.find("encode_quick_type") != j.end() && j.at("encode_quick_type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_encode_quick_type(get_stack_optional<std::variant<EncodeQuickType, double>>(j, "encode_quick_type"));
        if (j.find("Encoder") != j.end() && j.at("Encoder").is_null()) throw std::runtime_error("Unexpected null");
        x.set_encoder(get_stack_optional<std::variant<Encoder, double>>(j, "Encoder"));
        if (j.find("enum") != j.end() && j.at("enum").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_enum(get_stack_optional<std::variant<Enum, double>>(j, "enum"));
        if (j.find("EnumValues") != j.end() && j.at("EnumValues").is_null()) throw std::runtime_error("Unexpected null");
        x.set_enum_values(get_stack_optional<std::variant<EnumValues, double>>(j, "EnumValues"));
        if (j.find("equalityContract") != j.end() && j.at("equalityContract").is_null()) throw std::runtime_error("Unexpected null");
        x.set_equality_contract(get_stack_optional<std::variant<EqualityContract, double>>(j, "equalityContract"));
        if (j.find("Equatable") != j.end() && j.at("Equatable").is_null()) throw std::runtime_error("Unexpected null");
        x.set_equatable(get_stack_optional<std::variant<Equatable, double>>(j, "Equatable"));
        if (j.find("event") != j.end() && j.at("event").is_null()) throw std::runtime_error("Unexpected null");
        x.set_event(get_stack_optional<std::variant<Event, double>>(j, "event"));
        if (j.find("except") != j.end() && j.at("except").is_null()) throw std::runtime_error("Unexpected null");
        x.set_except(get_stack_optional<std::variant<Except, double>>(j, "except"));
        if (j.find("exception") != j.end() && j.at("exception").is_null()) throw std::runtime_error("Unexpected null");
        x.set_exception(get_stack_optional<std::variant<Exception, double>>(j, "exception"));
        if (j.find("explicit") != j.end() && j.at("explicit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_explicit(get_stack_optional<std::variant<Explicit, double>>(j, "explicit"));
        if (j.find("export") != j.end() && j.at("export").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_export(get_stack_optional<std::variant<Export, double>>(j, "export"));
        if (j.find("exposing") != j.end() && j.at("exposing").is_null()) throw std::runtime_error("Unexpected null");
        x.set_exposing(get_stack_optional<std::variant<Exposing, double>>(j, "exposing"));
        if (j.find("extends") != j.end() && j.at("extends").is_null()) throw std::runtime_error("Unexpected null");
        x.set_extends(get_stack_optional<std::variant<Extends, double>>(j, "extends"));
        if (j.find("extension") != j.end() && j.at("extension").is_null()) throw std::runtime_error("Unexpected null");
        x.set_extension(get_stack_optional<std::variant<Extension, double>>(j, "extension"));
        if (j.find("extern") != j.end() && j.at("extern").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_extern(get_stack_optional<std::variant<Extern, double>>(j, "extern"));
        if (j.find("fallthrough") != j.end() && j.at("fallthrough").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fallthrough(get_stack_optional<std::variant<Fallthrough, double>>(j, "fallthrough"));
        if (j.find("false") != j.end() && j.at("false").is_null()) throw std::runtime_error("Unexpected null");
        x.set_purple_false(get_stack_optional<std::variant<FalseClass, double>>(j, "false"));
        if (j.find("False") != j.end() && j.at("False").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_false(get_stack_optional<std::variant<False, double>>(j, "False"));
        if (j.find("fileprivate") != j.end() && j.at("fileprivate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fileprivate(get_stack_optional<std::variant<Fileprivate, double>>(j, "fileprivate"));
        if (j.find("final") != j.end() && j.at("final").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_final(get_stack_optional<std::variant<Final, double>>(j, "final"));
        if (j.find("finally") != j.end() && j.at("finally").is_null()) throw std::runtime_error("Unexpected null");
        x.set_finally(get_stack_optional<std::variant<Finally, double>>(j, "finally"));
        if (j.find("fixed") != j.end() && j.at("fixed").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fixed(get_stack_optional<std::variant<Fixed, double>>(j, "fixed"));
        if (j.find("float") != j.end() && j.at("float").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_float(get_stack_optional<std::variant<Float, double>>(j, "float"));
        if (j.find("for") != j.end() && j.at("for").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_for(get_stack_optional<std::variant<For, double>>(j, "for"));
        if (j.find("foreach") != j.end() && j.at("foreach").is_null()) throw std::runtime_error("Unexpected null");
        x.set_foreach(get_stack_optional<std::variant<Foreach, double>>(j, "foreach"));
        if (j.find("FormatException") != j.end() && j.at("FormatException").is_null()) throw std::runtime_error("Unexpected null");
        x.set_format_exception(get_stack_optional<std::variant<FormatException, double>>(j, "FormatException"));
        if (j.find("friend") != j.end() && j.at("friend").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_friend(get_stack_optional<std::variant<Friend, double>>(j, "friend"));
        if (j.find("from") != j.end() && j.at("from").is_null()) throw std::runtime_error("Unexpected null");
        x.set_from(get_stack_optional<std::variant<From, double>>(j, "from"));
        if (j.find("from_dict") != j.end() && j.at("from_dict").is_null()) throw std::runtime_error("Unexpected null");
        x.set_from_dict(get_stack_optional<std::variant<FromDict, double>>(j, "from_dict"));
        if (j.find("from_json") != j.end() && j.at("from_json").is_null()) throw std::runtime_error("Unexpected null");
        x.set_from_json(get_stack_optional<std::variant<FromJson, double>>(j, "from_json"));
        if (j.find("func") != j.end() && j.at("func").is_null()) throw std::runtime_error("Unexpected null");
        x.set_func(get_stack_optional<std::variant<Func, double>>(j, "func"));
        if (j.find("function") != j.end() && j.at("function").is_null()) throw std::runtime_error("Unexpected null");
        x.set_function(get_stack_optional<std::variant<Function, double>>(j, "function"));
        if (j.find("get") != j.end() && j.at("get").is_null()) throw std::runtime_error("Unexpected null");
        x.set_get(get_stack_optional<std::variant<Get, double>>(j, "get"));
        if (j.find("global") != j.end() && j.at("global").is_null()) throw std::runtime_error("Unexpected null");
        x.set_global(get_stack_optional<std::variant<Global, double>>(j, "global"));
        if (j.find("go") != j.end() && j.at("go").is_null()) throw std::runtime_error("Unexpected null");
        x.set_go(get_stack_optional<std::variant<Go, double>>(j, "go"));
        if (j.find("goto") != j.end() && j.at("goto").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_goto(get_stack_optional<std::variant<Goto, double>>(j, "goto"));
        if (j.find("guard") != j.end() && j.at("guard").is_null()) throw std::runtime_error("Unexpected null");
        x.set_guard(get_stack_optional<std::variant<Guard, double>>(j, "guard"));
        if (j.find("Hashable") != j.end() && j.at("Hashable").is_null()) throw std::runtime_error("Unexpected null");
        x.set_hashable(get_stack_optional<std::variant<Hashable, double>>(j, "Hashable"));
        if (j.find("hashCode") != j.end() && j.at("hashCode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_hash_code(get_stack_optional<std::variant<HashCode, double>>(j, "hashCode"));
        if (j.find("Hasher") != j.end() && j.at("Hasher").is_null()) throw std::runtime_error("Unexpected null");
        x.set_hasher(get_stack_optional<std::variant<Hasher, double>>(j, "Hasher"));
        if (j.find("hasOwnProperty") != j.end() && j.at("hasOwnProperty").is_null()) throw std::runtime_error("Unexpected null");
        x.set_has_own_property(get_stack_optional<std::variant<HasOwnProperty, double>>(j, "hasOwnProperty"));
        if (j.find("id") != j.end() && j.at("id").is_null()) throw std::runtime_error("Unexpected null");
        x.set_id(get_stack_optional<std::variant<Id, double>>(j, "id"));
        if (j.find("if") != j.end() && j.at("if").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_if(get_stack_optional<std::variant<If, double>>(j, "if"));
        if (j.find("IMP") != j.end() && j.at("IMP").is_null()) throw std::runtime_error("Unexpected null");
        x.set_imp(get_stack_optional<std::variant<Imp, double>>(j, "IMP"));
        if (j.find("implements") != j.end() && j.at("implements").is_null()) throw std::runtime_error("Unexpected null");
        x.set_implements(get_stack_optional<std::variant<Implements, double>>(j, "implements"));
        if (j.find("implicit") != j.end() && j.at("implicit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_implicit(get_stack_optional<std::variant<Implicit, double>>(j, "implicit"));
        if (j.find("import") != j.end() && j.at("import").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_import(get_stack_optional<std::variant<Import, double>>(j, "import"));
        if (j.find("in") != j.end() && j.at("in").is_null()) throw std::runtime_error("Unexpected null");
        x.set_in(get_stack_optional<std::variant<In, double>>(j, "in"));
        if (j.find("indirect") != j.end() && j.at("indirect").is_null()) throw std::runtime_error("Unexpected null");
        x.set_indirect(get_stack_optional<std::variant<Indirect, double>>(j, "indirect"));
        if (j.find("infix") != j.end() && j.at("infix").is_null()) throw std::runtime_error("Unexpected null");
        x.set_infix(get_stack_optional<std::variant<Infix, double>>(j, "infix"));
        if (j.find("init") != j.end() && j.at("init").is_null()) throw std::runtime_error("Unexpected null");
        x.set_init(get_stack_optional<std::variant<Init, double>>(j, "init"));
        if (j.find("inline") != j.end() && j.at("inline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_inline(get_stack_optional<std::variant<Inline, double>>(j, "inline"));
        if (j.find("inout") != j.end() && j.at("inout").is_null()) throw std::runtime_error("Unexpected null");
        x.set_inout(get_stack_optional<std::variant<Inout, double>>(j, "inout"));
        if (j.find("instanceof") != j.end() && j.at("instanceof").is_null()) throw std::runtime_error("Unexpected null");
        x.set_instanceof(get_stack_optional<std::variant<Instanceof, double>>(j, "instanceof"));
        if (j.find("int") != j.end() && j.at("int").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_int(get_stack_optional<std::variant<Int, double>>(j, "int"));
        if (j.find("interface") != j.end() && j.at("interface").is_null()) throw std::runtime_error("Unexpected null");
        x.set_interface(get_stack_optional<std::variant<Interface, double>>(j, "interface"));
        if (j.find("internal") != j.end() && j.at("internal").is_null()) throw std::runtime_error("Unexpected null");
        x.set_internal(get_stack_optional<std::variant<Internal, double>>(j, "internal"));
        if (j.find("IntNode") != j.end() && j.at("IntNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_int_node(get_stack_optional<std::variant<IntNode, double>>(j, "IntNode"));
        if (j.find("is") != j.end() && j.at("is").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is(get_stack_optional<std::variant<Is, double>>(j, "is"));
        if (j.find("IsoDateTimeOffsetConverter") != j.end() && j.at("IsoDateTimeOffsetConverter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_iso_date_time_offset_converter(get_stack_optional<std::variant<IsoDateTimeOffsetConverter, double>>(j, "IsoDateTimeOffsetConverter"));
        if (j.find("iterable") != j.end() && j.at("iterable").is_null()) throw std::runtime_error("Unexpected null");
        x.set_iterable(get_stack_optional<std::variant<Iterable, double>>(j, "iterable"));
        if (j.find("jdec") != j.end() && j.at("jdec").is_null()) throw std::runtime_error("Unexpected null");
        x.set_jdec(get_stack_optional<std::variant<Jdec, double>>(j, "jdec"));
        if (j.find("jenc") != j.end() && j.at("jenc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_jenc(get_stack_optional<std::variant<Jenc, double>>(j, "jenc"));
        if (j.find("jpipe") != j.end() && j.at("jpipe").is_null()) throw std::runtime_error("Unexpected null");
        x.set_jpipe(get_stack_optional<std::variant<Jpipe, double>>(j, "jpipe"));
        if (j.find("json") != j.end() && j.at("json").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json(get_stack_optional<std::variant<Json, double>>(j, "json"));
        if (j.find("json_converter") != j.end() && j.at("json_converter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_converter(get_stack_optional<std::variant<JsonConverter, double>>(j, "json_converter"));
        if (j.find("json_serializer") != j.end() && j.at("json_serializer").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_serializer(get_stack_optional<std::variant<JsonSerializer, double>>(j, "json_serializer"));
        if (j.find("json_token") != j.end() && j.at("json_token").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_token(get_stack_optional<std::variant<JsonToken, double>>(j, "json_token"));
        if (j.find("json_writer") != j.end() && j.at("json_writer").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_writer(get_stack_optional<std::variant<JsonWriter, double>>(j, "json_writer"));
        if (j.find("JSONAny") != j.end() && j.at("JSONAny").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_any(get_stack_optional<std::variant<JsonAny, double>>(j, "JSONAny"));
        if (j.find("JSONCodingKey") != j.end() && j.at("JSONCodingKey").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_coding_key(get_stack_optional<std::variant<JsonCodingKey, double>>(j, "JSONCodingKey"));
        if (j.find("JSONDecoder") != j.end() && j.at("JSONDecoder").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_decoder(get_stack_optional<std::variant<JsonDecoder, double>>(j, "JSONDecoder"));
        if (j.find("JSONEncoder") != j.end() && j.at("JSONEncoder").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_encoder(get_stack_optional<std::variant<JsonEncoder, double>>(j, "JSONEncoder"));
        if (j.find("JsonException") != j.end() && j.at("JsonException").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_exception(get_stack_optional<std::variant<JsonException, double>>(j, "JsonException"));
        if (j.find("JsonGenerator") != j.end() && j.at("JsonGenerator").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_generator(get_stack_optional<std::variant<JsonGenerator, double>>(j, "JsonGenerator"));
        if (j.find("JsonNode") != j.end() && j.at("JsonNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_node(get_stack_optional<std::variant<JsonNode, double>>(j, "JsonNode"));
        if (j.find("JSONNull") != j.end() && j.at("JSONNull").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_null(get_stack_optional<std::variant<JsonNull, double>>(j, "JSONNull"));
        if (j.find("JsonParser") != j.end() && j.at("JsonParser").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_parser(get_stack_optional<std::variant<JsonParser, double>>(j, "JsonParser"));
        if (j.find("JsonReader") != j.end() && j.at("JsonReader").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_reader(get_stack_optional<std::variant<JsonReader, double>>(j, "JsonReader"));
        if (j.find("JsonTokenType") != j.end() && j.at("JsonTokenType").is_null()) throw std::runtime_error("Unexpected null");
        x.set_json_token_type(get_stack_optional<std::variant<JsonTokenType, double>>(j, "JsonTokenType"));
        if (j.find("KSerializer") != j.end() && j.at("KSerializer").is_null()) throw std::runtime_error("Unexpected null");
        x.set_k_serializer(get_stack_optional<std::variant<KSerializer, double>>(j, "KSerializer"));
        if (j.find("lambda") != j.end() && j.at("lambda").is_null()) throw std::runtime_error("Unexpected null");
        x.set_lambda(get_stack_optional<std::variant<Lambda, double>>(j, "lambda"));
        if (j.find("lazy") != j.end() && j.at("lazy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_lazy(get_stack_optional<std::variant<Lazy, double>>(j, "lazy"));
        if (j.find("left") != j.end() && j.at("left").is_null()) throw std::runtime_error("Unexpected null");
        x.set_left(get_stack_optional<std::variant<Left, double>>(j, "left"));
        if (j.find("let") != j.end() && j.at("let").is_null()) throw std::runtime_error("Unexpected null");
        x.set_let(get_stack_optional<std::variant<Let, double>>(j, "let"));
        if (j.find("list") != j.end() && j.at("list").is_null()) throw std::runtime_error("Unexpected null");
        x.set_list(get_stack_optional<std::variant<List, double>>(j, "list"));
        if (j.find("LocalDate") != j.end() && j.at("LocalDate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_local_date(get_stack_optional<std::variant<LocalDate, double>>(j, "LocalDate"));
        if (j.find("Locale") != j.end() && j.at("Locale").is_null()) throw std::runtime_error("Unexpected null");
        x.set_locale(get_stack_optional<std::variant<Locale, double>>(j, "Locale"));
        if (j.find("lock") != j.end() && j.at("lock").is_null()) throw std::runtime_error("Unexpected null");
        x.set_lock(get_stack_optional<std::variant<Lock, double>>(j, "lock"));
        if (j.find("long") != j.end() && j.at("long").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_long(get_stack_optional<std::variant<Long, double>>(j, "long"));
        if (j.find("LongNode") != j.end() && j.at("LongNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_long_node(get_stack_optional<std::variant<LongNode, double>>(j, "LongNode"));
        if (j.find("map") != j.end() && j.at("map").is_null()) throw std::runtime_error("Unexpected null");
        x.set_map(get_stack_optional<std::variant<Map, double>>(j, "map"));
        if (j.find("MapEntry") != j.end() && j.at("MapEntry").is_null()) throw std::runtime_error("Unexpected null");
        x.set_map_entry(get_stack_optional<std::variant<MapEntry, double>>(j, "MapEntry"));
        if (j.find("MarshalJSON") != j.end() && j.at("MarshalJSON").is_null()) throw std::runtime_error("Unexpected null");
        x.set_marshal_json(get_stack_optional<std::variant<MarshalJson, double>>(j, "MarshalJSON"));
        if (j.find("metadata_property_handling") != j.end() && j.at("metadata_property_handling").is_null()) throw std::runtime_error("Unexpected null");
        x.set_metadata_property_handling(get_stack_optional<std::variant<MetadataPropertyHandling, double>>(j, "metadata_property_handling"));
        if (j.find("module") != j.end() && j.at("module").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_module(get_stack_optional<std::variant<Module, double>>(j, "module"));
        if (j.find("mutable") != j.end() && j.at("mutable").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_mutable(get_stack_optional<std::variant<Mutable, double>>(j, "mutable"));
        if (j.find("mutating") != j.end() && j.at("mutating").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mutating(get_stack_optional<std::variant<Mutating, double>>(j, "mutating"));
        if (j.find("namespace") != j.end() && j.at("namespace").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_namespace(get_stack_optional<std::variant<Namespace, double>>(j, "namespace"));
        if (j.find("native") != j.end() && j.at("native").is_null()) throw std::runtime_error("Unexpected null");
        x.set_native(get_stack_optional<std::variant<Native, double>>(j, "native"));
        if (j.find("new") != j.end() && j.at("new").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_new(get_stack_optional<std::variant<New, double>>(j, "new"));
        if (j.find("newtonsoft") != j.end() && j.at("newtonsoft").is_null()) throw std::runtime_error("Unexpected null");
        x.set_newtonsoft(get_stack_optional<std::variant<Newtonsoft, double>>(j, "newtonsoft"));
        if (j.find("nil") != j.end() && j.at("nil").is_null()) throw std::runtime_error("Unexpected null");
        x.set_nil(get_stack_optional<std::variant<Nil, double>>(j, "nil"));
        if (j.find("NO") != j.end() && j.at("NO").is_null()) throw std::runtime_error("Unexpected null");
        x.set_no(get_stack_optional<std::variant<No, double>>(j, "NO"));
        if (j.find("noexcept") != j.end() && j.at("noexcept").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_noexcept(get_stack_optional<std::variant<Noexcept, double>>(j, "noexcept"));
        if (j.find("nonatomic") != j.end() && j.at("nonatomic").is_null()) throw std::runtime_error("Unexpected null");
        x.set_nonatomic(get_stack_optional<std::variant<Nonatomic, double>>(j, "nonatomic"));
        if (j.find("none") != j.end() && j.at("none").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_none(get_stack_optional<std::variant<NoneClass, double>>(j, "none"));
        if (j.find("None") != j.end() && j.at("None").is_null()) throw std::runtime_error("Unexpected null");
        x.set_none(get_stack_optional<std::variant<None, double>>(j, "None"));
        if (j.find("nonlocal") != j.end() && j.at("nonlocal").is_null()) throw std::runtime_error("Unexpected null");
        x.set_nonlocal(get_stack_optional<std::variant<Nonlocal, double>>(j, "nonlocal"));
        if (j.find("nonmutating") != j.end() && j.at("nonmutating").is_null()) throw std::runtime_error("Unexpected null");
        x.set_nonmutating(get_stack_optional<std::variant<Nonmutating, double>>(j, "nonmutating"));
        if (j.find("noSuchMethod") != j.end() && j.at("noSuchMethod").is_null()) throw std::runtime_error("Unexpected null");
        x.set_no_such_method(get_stack_optional<std::variant<NoSuchMethod, double>>(j, "noSuchMethod"));
        if (j.find("not") != j.end() && j.at("not").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_not(get_stack_optional<std::variant<Not, double>>(j, "not"));
        if (j.find("not_eq") != j.end() && j.at("not_eq").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_not_eq(get_stack_optional<std::variant<NotEq, double>>(j, "not_eq"));
        if (j.find("NSError") != j.end() && j.at("NSError").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ns_error(get_stack_optional<std::variant<NsError, double>>(j, "NSError"));
        if (j.find("NSObject") != j.end() && j.at("NSObject").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ns_object(get_stack_optional<std::variant<NsObject, double>>(j, "NSObject"));
        if (j.find("NSString") != j.end() && j.at("NSString").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ns_string(get_stack_optional<std::variant<NsString, double>>(j, "NSString"));
        if (j.find("NULL") != j.end() && j.at("NULL").is_null()) throw std::runtime_error("Unexpected null");
        x.set_null(get_stack_optional<std::variant<Null, double>>(j, "NULL"));
        if (j.find("null") != j.end() && j.at("null").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_null(get_stack_optional<std::variant<NullClass, double>>(j, "null"));
        if (j.find("NullNode") != j.end() && j.at("NullNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_null_node(get_stack_optional<std::variant<NullNode, double>>(j, "NullNode"));
        if (j.find("nullptr") != j.end() && j.at("nullptr").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_nullptr(get_stack_optional<std::variant<Nullptr, double>>(j, "nullptr"));
        if (j.find("number") != j.end() && j.at("number").is_null()) throw std::runtime_error("Unexpected null");
        x.set_number(get_stack_optional<std::variant<Number, double>>(j, "number"));
        if (j.find("object") != j.end() && j.at("object").is_null()) throw std::runtime_error("Unexpected null");
        x.set_object(get_stack_optional<std::variant<Object, double>>(j, "object"));
        if (j.find("ObjectMapper") != j.end() && j.at("ObjectMapper").is_null()) throw std::runtime_error("Unexpected null");
        x.set_object_mapper(get_stack_optional<std::variant<ObjectMapper, double>>(j, "ObjectMapper"));
        if (j.find("ObjectNode") != j.end() && j.at("ObjectNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_object_node(get_stack_optional<std::variant<ObjectNode, double>>(j, "ObjectNode"));
        if (j.find("ObjectReader") != j.end() && j.at("ObjectReader").is_null()) throw std::runtime_error("Unexpected null");
        x.set_object_reader(get_stack_optional<std::variant<ObjectReader, double>>(j, "ObjectReader"));
        if (j.find("ObjectWriter") != j.end() && j.at("ObjectWriter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_object_writer(get_stack_optional<std::variant<ObjectWriter, double>>(j, "ObjectWriter"));
        if (j.find("of") != j.end() && j.at("of").is_null()) throw std::runtime_error("Unexpected null");
        x.set_of(get_stack_optional<std::variant<Of, double>>(j, "of"));
        if (j.find("OffsetDateTime") != j.end() && j.at("OffsetDateTime").is_null()) throw std::runtime_error("Unexpected null");
        x.set_offset_date_time(get_stack_optional<std::variant<OffsetDateTime, double>>(j, "OffsetDateTime"));
        if (j.find("OffsetTime") != j.end() && j.at("OffsetTime").is_null()) throw std::runtime_error("Unexpected null");
        x.set_offset_time(get_stack_optional<std::variant<OffsetTime, double>>(j, "OffsetTime"));
        if (j.find("oneway") != j.end() && j.at("oneway").is_null()) throw std::runtime_error("Unexpected null");
        x.set_oneway(get_stack_optional<std::variant<Oneway, double>>(j, "oneway"));
        if (j.find("open") != j.end() && j.at("open").is_null()) throw std::runtime_error("Unexpected null");
        x.set_open(get_stack_optional<std::variant<Open, double>>(j, "open"));
        if (j.find("operator") != j.end() && j.at("operator").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_operator(get_stack_optional<std::variant<Operator, double>>(j, "operator"));
        if (j.find("optional") != j.end() && j.at("optional").is_null()) throw std::runtime_error("Unexpected null");
        x.set_optional(get_stack_optional<std::variant<Optional, double>>(j, "optional"));
        if (j.find("or") != j.end() && j.at("or").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_or(get_stack_optional<std::variant<Or, double>>(j, "or"));
        if (j.find("or_eq") != j.end() && j.at("or_eq").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_or_eq(get_stack_optional<std::variant<OrEq, double>>(j, "or_eq"));
        if (j.find("out") != j.end() && j.at("out").is_null()) throw std::runtime_error("Unexpected null");
        x.set_out(get_stack_optional<std::variant<Out, double>>(j, "out"));
        if (j.find("override") != j.end() && j.at("override").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_override(get_stack_optional<std::variant<Override, double>>(j, "override"));
        if (j.find("package") != j.end() && j.at("package").is_null()) throw std::runtime_error("Unexpected null");
        x.set_package(get_stack_optional<std::variant<Package, double>>(j, "package"));
        if (j.find("params") != j.end() && j.at("params").is_null()) throw std::runtime_error("Unexpected null");
        x.set_params(get_stack_optional<std::variant<Params, double>>(j, "params"));
        if (j.find("pass") != j.end() && j.at("pass").is_null()) throw std::runtime_error("Unexpected null");
        x.set_pass(get_stack_optional<std::variant<Pass, double>>(j, "pass"));
        if (j.find("port") != j.end() && j.at("port").is_null()) throw std::runtime_error("Unexpected null");
        x.set_port(get_stack_optional<std::variant<Port, double>>(j, "port"));
        if (j.find("postfix") != j.end() && j.at("postfix").is_null()) throw std::runtime_error("Unexpected null");
        x.set_postfix(get_stack_optional<std::variant<Postfix, double>>(j, "postfix"));
        if (j.find("precedence") != j.end() && j.at("precedence").is_null()) throw std::runtime_error("Unexpected null");
        x.set_precedence(get_stack_optional<std::variant<Precedence, double>>(j, "precedence"));
        if (j.find("prefix") != j.end() && j.at("prefix").is_null()) throw std::runtime_error("Unexpected null");
        x.set_prefix(get_stack_optional<std::variant<Prefix, double>>(j, "prefix"));
        if (j.find("PrimitiveKind") != j.end() && j.at("PrimitiveKind").is_null()) throw std::runtime_error("Unexpected null");
        x.set_primitive_kind(get_stack_optional<std::variant<PrimitiveKind, double>>(j, "PrimitiveKind"));
        if (j.find("print") != j.end() && j.at("print").is_null()) throw std::runtime_error("Unexpected null");
        x.set_print(get_stack_optional<std::variant<Print, double>>(j, "print"));
        if (j.find("printf") != j.end() && j.at("printf").is_null()) throw std::runtime_error("Unexpected null");
        x.set_printf(get_stack_optional<std::variant<Printf, double>>(j, "printf"));
        if (j.find("printMembers") != j.end() && j.at("printMembers").is_null()) throw std::runtime_error("Unexpected null");
        x.set_print_members(get_stack_optional<std::variant<PrintMembers, double>>(j, "printMembers"));
        if (j.find("private") != j.end() && j.at("private").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_private(get_stack_optional<std::variant<Private, double>>(j, "private"));
        if (j.find("protected") != j.end() && j.at("protected").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_protected(get_stack_optional<std::variant<Protected, double>>(j, "protected"));
        if (j.find("Protocol") != j.end() && j.at("Protocol").is_null()) throw std::runtime_error("Unexpected null");
        x.set_protocol(get_stack_optional<std::variant<Protocol, double>>(j, "Protocol"));
        if (j.find("protocol") != j.end() && j.at("protocol").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_protocol(get_stack_optional<std::variant<ProtocolClass, double>>(j, "protocol"));
        if (j.find("public") != j.end() && j.at("public").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_public(get_stack_optional<std::variant<Public, double>>(j, "public"));
        if (j.find("quicktype") != j.end() && j.at("quicktype").is_null()) throw std::runtime_error("Unexpected null");
        x.set_quicktype(get_stack_optional<std::variant<Quicktype, double>>(j, "quicktype"));
        if (j.find("raise") != j.end() && j.at("raise").is_null()) throw std::runtime_error("Unexpected null");
        x.set_raise(get_stack_optional<std::variant<Raise, double>>(j, "raise"));
        if (j.find("range") != j.end() && j.at("range").is_null()) throw std::runtime_error("Unexpected null");
        x.set_range(get_stack_optional<std::variant<Range, double>>(j, "range"));
        if (j.find("readonly") != j.end() && j.at("readonly").is_null()) throw std::runtime_error("Unexpected null");
        x.set_readonly(get_stack_optional<std::variant<Readonly, double>>(j, "readonly"));
        if (j.find("ref") != j.end() && j.at("ref").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ref(get_stack_optional<std::variant<Ref, double>>(j, "ref"));
        if (j.find("RegExp") != j.end() && j.at("RegExp").is_null()) throw std::runtime_error("Unexpected null");
        x.set_reg_exp(get_stack_optional<std::variant<RegExp, double>>(j, "RegExp"));
        if (j.find("register") != j.end() && j.at("register").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_register(get_stack_optional<std::variant<Register, double>>(j, "register"));
        if (j.find("reinterpret_cast") != j.end() && j.at("reinterpret_cast").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_reinterpret_cast(get_stack_optional<std::variant<ReinterpretCast, double>>(j, "reinterpret_cast"));
        if (j.find("repeat") != j.end() && j.at("repeat").is_null()) throw std::runtime_error("Unexpected null");
        x.set_repeat(get_stack_optional<std::variant<Repeat, double>>(j, "repeat"));
        if (j.find("require") != j.end() && j.at("require").is_null()) throw std::runtime_error("Unexpected null");
        x.set_require(get_stack_optional<std::variant<Require, double>>(j, "require"));
        if (j.find("required") != j.end() && j.at("required").is_null()) throw std::runtime_error("Unexpected null");
        x.set_required(get_stack_optional<std::variant<Required, double>>(j, "required"));
        if (j.find("requires") != j.end() && j.at("requires").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_requires(get_stack_optional<std::variant<Requires, double>>(j, "requires"));
        if (j.find("restrict") != j.end() && j.at("restrict").is_null()) throw std::runtime_error("Unexpected null");
        x.set_restrict(get_stack_optional<std::variant<Restrict, double>>(j, "restrict"));
        if (j.find("retain") != j.end() && j.at("retain").is_null()) throw std::runtime_error("Unexpected null");
        x.set_retain(get_stack_optional<std::variant<Retain, double>>(j, "retain"));
        if (j.find("rethrows") != j.end() && j.at("rethrows").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rethrows(get_stack_optional<std::variant<Rethrows, double>>(j, "rethrows"));
        if (j.find("return") != j.end() && j.at("return").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_return(get_stack_optional<std::variant<Return, double>>(j, "return"));
        if (j.find("right") != j.end() && j.at("right").is_null()) throw std::runtime_error("Unexpected null");
        x.set_right(get_stack_optional<std::variant<Right, double>>(j, "right"));
        if (j.find("runtimeType") != j.end() && j.at("runtimeType").is_null()) throw std::runtime_error("Unexpected null");
        x.set_runtime_type(get_stack_optional<std::variant<RuntimeType, double>>(j, "runtimeType"));
        if (j.find("s") != j.end() && j.at("s").is_null()) throw std::runtime_error("Unexpected null");
        x.set_s(get_stack_optional<std::variant<S, double>>(j, "s"));
        if (j.find("sbyte") != j.end() && j.at("sbyte").is_null()) throw std::runtime_error("Unexpected null");
        x.set_sbyte(get_stack_optional<std::variant<Sbyte, double>>(j, "sbyte"));
        if (j.find("sealed") != j.end() && j.at("sealed").is_null()) throw std::runtime_error("Unexpected null");
        x.set_sealed(get_stack_optional<std::variant<Sealed, double>>(j, "sealed"));
        if (j.find("SEL") != j.end() && j.at("SEL").is_null()) throw std::runtime_error("Unexpected null");
        x.set_sel(get_stack_optional<std::variant<Sel, double>>(j, "SEL"));
        if (j.find("select") != j.end() && j.at("select").is_null()) throw std::runtime_error("Unexpected null");
        x.set_select(get_stack_optional<std::variant<Select, double>>(j, "select"));
        if (j.find("Self") != j.end() && j.at("Self").is_null()) throw std::runtime_error("Unexpected null");
        x.set_self(get_stack_optional<std::variant<Self, double>>(j, "Self"));
        if (j.find("self") != j.end() && j.at("self").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_self(get_stack_optional<std::variant<SelfClass, double>>(j, "self"));
        if (j.find("Sendable") != j.end() && j.at("Sendable").is_null()) throw std::runtime_error("Unexpected null");
        x.set_sendable(get_stack_optional<std::variant<Sendable, double>>(j, "Sendable"));
        if (j.find("SerialDescriptor") != j.end() && j.at("SerialDescriptor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_serial_descriptor(get_stack_optional<std::variant<SerialDescriptor, double>>(j, "SerialDescriptor"));
        if (j.find("Serializable") != j.end() && j.at("Serializable").is_null()) throw std::runtime_error("Unexpected null");
        x.set_serializable(get_stack_optional<std::variant<Serializable, double>>(j, "Serializable"));
        if (j.find("SerializationFeature") != j.end() && j.at("SerializationFeature").is_null()) throw std::runtime_error("Unexpected null");
        x.set_serialization_feature(get_stack_optional<std::variant<SerializationFeature, double>>(j, "SerializationFeature"));
        if (j.find("serialize") != j.end() && j.at("serialize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_serialize(get_stack_optional<std::variant<Serialize, double>>(j, "serialize"));
        if (j.find("SerializerProvider") != j.end() && j.at("SerializerProvider").is_null()) throw std::runtime_error("Unexpected null");
        x.set_serializer_provider(get_stack_optional<std::variant<SerializerProvider, double>>(j, "SerializerProvider"));
        if (j.find("SerialName") != j.end() && j.at("SerialName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_serial_name(get_stack_optional<std::variant<SerialName, double>>(j, "SerialName"));
        if (j.find("set") != j.end() && j.at("set").is_null()) throw std::runtime_error("Unexpected null");
        x.set_set(get_stack_optional<std::variant<Set, double>>(j, "set"));
        if (j.find("short") != j.end() && j.at("short").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_short(get_stack_optional<std::variant<Short, double>>(j, "short"));
        if (j.find("signed") != j.end() && j.at("signed").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_signed(get_stack_optional<std::variant<Signed, double>>(j, "signed"));
        if (j.find("SimpleModule") != j.end() && j.at("SimpleModule").is_null()) throw std::runtime_error("Unexpected null");
        x.set_simple_module(get_stack_optional<std::variant<SimpleModule, double>>(j, "SimpleModule"));
        if (j.find("sizeof") != j.end() && j.at("sizeof").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_sizeof(get_stack_optional<std::variant<Sizeof, double>>(j, "sizeof"));
        if (j.find("stackalloc") != j.end() && j.at("stackalloc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stackalloc(get_stack_optional<std::variant<Stackalloc, double>>(j, "stackalloc"));
        if (j.find("Standards") != j.end() && j.at("Standards").is_null()) throw std::runtime_error("Unexpected null");
        x.set_standards(get_stack_optional<std::variant<Standards, double>>(j, "Standards"));
        if (j.find("static") != j.end() && j.at("static").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_static(get_stack_optional<std::variant<Static, double>>(j, "static"));
        if (j.find("static_assert") != j.end() && j.at("static_assert").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_static_assert(get_stack_optional<std::variant<StaticAssert, double>>(j, "static_assert"));
        if (j.find("static_cast") != j.end() && j.at("static_cast").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_static_cast(get_stack_optional<std::variant<StaticCast, double>>(j, "static_cast"));
        if (j.find("StdDeserializer") != j.end() && j.at("StdDeserializer").is_null()) throw std::runtime_error("Unexpected null");
        x.set_std_deserializer(get_stack_optional<std::variant<StdDeserializer, double>>(j, "StdDeserializer"));
        if (j.find("StdSerializer") != j.end() && j.at("StdSerializer").is_null()) throw std::runtime_error("Unexpected null");
        x.set_std_serializer(get_stack_optional<std::variant<StdSerializer, double>>(j, "StdSerializer"));
        if (j.find("strictfp") != j.end() && j.at("strictfp").is_null()) throw std::runtime_error("Unexpected null");
        x.set_strictfp(get_stack_optional<std::variant<Strictfp, double>>(j, "strictfp"));
        if (j.find("string") != j.end() && j.at("string").is_null()) throw std::runtime_error("Unexpected null");
        x.set_string(get_stack_optional<std::variant<String, double>>(j, "string"));
        if (j.find("struct") != j.end() && j.at("struct").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_struct(get_stack_optional<std::variant<Struct, double>>(j, "struct"));
        if (j.find("subscript") != j.end() && j.at("subscript").is_null()) throw std::runtime_error("Unexpected null");
        x.set_subscript(get_stack_optional<std::variant<Subscript, double>>(j, "subscript"));
        if (j.find("super") != j.end() && j.at("super").is_null()) throw std::runtime_error("Unexpected null");
        x.set_super(get_stack_optional<std::variant<Super, double>>(j, "super"));
        if (j.find("switch") != j.end() && j.at("switch").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_switch(get_stack_optional<std::variant<Switch, double>>(j, "switch"));
        if (j.find("symbol") != j.end() && j.at("symbol").is_null()) throw std::runtime_error("Unexpected null");
        x.set_symbol(get_stack_optional<std::variant<Symbol, double>>(j, "symbol"));
        if (j.find("synchronized") != j.end() && j.at("synchronized").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_synchronized(get_stack_optional<std::variant<Synchronized, double>>(j, "synchronized"));
        if (j.find("system") != j.end() && j.at("system").is_null()) throw std::runtime_error("Unexpected null");
        x.set_system(get_stack_optional<std::variant<System, double>>(j, "system"));
        if (j.find("template") != j.end() && j.at("template").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_template(get_stack_optional<std::variant<Template, double>>(j, "template"));
        if (j.find("TextNode") != j.end() && j.at("TextNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text_node(get_stack_optional<std::variant<TextNode, double>>(j, "TextNode"));
        if (j.find("then") != j.end() && j.at("then").is_null()) throw std::runtime_error("Unexpected null");
        x.set_then(get_stack_optional<std::variant<Then, double>>(j, "then"));
        if (j.find("this") != j.end() && j.at("this").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_this(get_stack_optional<std::variant<This, double>>(j, "this"));
        if (j.find("thread_local") != j.end() && j.at("thread_local").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_thread_local(get_stack_optional<std::variant<ThreadLocal, double>>(j, "thread_local"));
        if (j.find("throw") != j.end() && j.at("throw").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_throw(get_stack_optional<std::variant<Throw, double>>(j, "throw"));
        if (j.find("throws") != j.end() && j.at("throws").is_null()) throw std::runtime_error("Unexpected null");
        x.set_throws(get_stack_optional<std::variant<Throws, double>>(j, "throws"));
        if (j.find("TimeOnly") != j.end() && j.at("TimeOnly").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_only(get_stack_optional<std::variant<TimeOnly, double>>(j, "TimeOnly"));
        if (j.find("TimeOnlyConverter") != j.end() && j.at("TimeOnlyConverter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_only_converter(get_stack_optional<std::variant<TimeOnlyConverter, double>>(j, "TimeOnlyConverter"));
        if (j.find("TimeZone") != j.end() && j.at("TimeZone").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_zone(get_stack_optional<std::variant<TimeZone, double>>(j, "TimeZone"));
        if (j.find("to_dict") != j.end() && j.at("to_dict").is_null()) throw std::runtime_error("Unexpected null");
        x.set_to_dict(get_stack_optional<std::variant<ToDict, double>>(j, "to_dict"));
        if (j.find("to_json") != j.end() && j.at("to_json").is_null()) throw std::runtime_error("Unexpected null");
        x.set_to_json(get_stack_optional<std::variant<ToJson, double>>(j, "to_json"));
        if (j.find("top_level") != j.end() && j.at("top_level").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level(get_stack_optional<std::variant<TopLevelClass, double>>(j, "top_level"));
        if (j.find("toString") != j.end() && j.at("toString").is_null()) throw std::runtime_error("Unexpected null");
        x.set_to_string(get_stack_optional<std::variant<ToString, double>>(j, "toString"));
        if (j.find("transient") != j.end() && j.at("transient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_transient(get_stack_optional<std::variant<Transient, double>>(j, "transient"));
        if (j.find("True") != j.end() && j.at("True").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_true(get_stack_optional<std::variant<True, double>>(j, "True"));
        if (j.find("true") != j.end() && j.at("true").is_null()) throw std::runtime_error("Unexpected null");
        x.set_purple_true(get_stack_optional<std::variant<TrueClass, double>>(j, "true"));
        if (j.find("try") != j.end() && j.at("try").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_try(get_stack_optional<std::variant<Try, double>>(j, "try"));
        if (j.find("Type") != j.end() && j.at("Type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<std::variant<Type, double>>(j, "Type"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_type(get_stack_optional<std::variant<TypeClass, double>>(j, "type"));
        if (j.find("typealias") != j.end() && j.at("typealias").is_null()) throw std::runtime_error("Unexpected null");
        x.set_typealias(get_stack_optional<std::variant<Typealias, double>>(j, "typealias"));
        if (j.find("typedef") != j.end() && j.at("typedef").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_typedef(get_stack_optional<std::variant<Typedef, double>>(j, "typedef"));
        if (j.find("typeid") != j.end() && j.at("typeid").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_typeid(get_stack_optional<std::variant<Typeid, double>>(j, "typeid"));
        if (j.find("typename") != j.end() && j.at("typename").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_typename(get_stack_optional<std::variant<Typename, double>>(j, "typename"));
        if (j.find("typeof") != j.end() && j.at("typeof").is_null()) throw std::runtime_error("Unexpected null");
        x.set_typeof(get_stack_optional<std::variant<Typeof, double>>(j, "typeof"));
        if (j.find("uint") != j.end() && j.at("uint").is_null()) throw std::runtime_error("Unexpected null");
        x.set_uint(get_stack_optional<std::variant<Uint, double>>(j, "uint"));
        if (j.find("ulong") != j.end() && j.at("ulong").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ulong(get_stack_optional<std::variant<Ulong, double>>(j, "ulong"));
        if (j.find("unchecked") != j.end() && j.at("unchecked").is_null()) throw std::runtime_error("Unexpected null");
        x.set_unchecked(get_stack_optional<std::variant<Unchecked, double>>(j, "unchecked"));
        if (j.find("undefined") != j.end() && j.at("undefined").is_null()) throw std::runtime_error("Unexpected null");
        x.set_undefined(get_stack_optional<std::variant<Undefined, double>>(j, "undefined"));
        if (j.find("union") != j.end() && j.at("union").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_union(get_stack_optional<std::variant<Union, double>>(j, "union"));
        if (j.find("UnmarshalJSON") != j.end() && j.at("UnmarshalJSON").is_null()) throw std::runtime_error("Unexpected null");
        x.set_unmarshal_json(get_stack_optional<std::variant<UnmarshalJson, double>>(j, "UnmarshalJSON"));
        if (j.find("unowned") != j.end() && j.at("unowned").is_null()) throw std::runtime_error("Unexpected null");
        x.set_unowned(get_stack_optional<std::variant<Unowned, double>>(j, "unowned"));
        if (j.find("unsafe") != j.end() && j.at("unsafe").is_null()) throw std::runtime_error("Unexpected null");
        x.set_unsafe(get_stack_optional<std::variant<Unsafe, double>>(j, "unsafe"));
        if (j.find("unsigned") != j.end() && j.at("unsigned").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_unsigned(get_stack_optional<std::variant<Unsigned, double>>(j, "unsigned"));
        if (j.find("UseSerializers") != j.end() && j.at("UseSerializers").is_null()) throw std::runtime_error("Unexpected null");
        x.set_use_serializers(get_stack_optional<std::variant<UseSerializers, double>>(j, "UseSerializers"));
        if (j.find("ushort") != j.end() && j.at("ushort").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ushort(get_stack_optional<std::variant<Ushort, double>>(j, "ushort"));
        if (j.find("using") != j.end() && j.at("using").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_using(get_stack_optional<std::variant<Using, double>>(j, "using"));
        if (j.find("Utf8JsonReader") != j.end() && j.at("Utf8JsonReader").is_null()) throw std::runtime_error("Unexpected null");
        x.set_utf8_json_reader(get_stack_optional<std::variant<Utf8JsonReader, double>>(j, "Utf8JsonReader"));
        if (j.find("Utf8JsonWriter") != j.end() && j.at("Utf8JsonWriter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_utf8_json_writer(get_stack_optional<std::variant<Utf8JsonWriter, double>>(j, "Utf8JsonWriter"));
        if (j.find("UUID") != j.end() && j.at("UUID").is_null()) throw std::runtime_error("Unexpected null");
        x.set_uuid(get_stack_optional<std::variant<Uuid, double>>(j, "UUID"));
        if (j.find("var") != j.end() && j.at("var").is_null()) throw std::runtime_error("Unexpected null");
        x.set_var(get_stack_optional<std::variant<Var, double>>(j, "var"));
        if (j.find("virtual") != j.end() && j.at("virtual").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_virtual(get_stack_optional<std::variant<Virtual, double>>(j, "virtual"));
        if (j.find("void") != j.end() && j.at("void").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_void(get_stack_optional<std::variant<Void, double>>(j, "void"));
        if (j.find("volatile") != j.end() && j.at("volatile").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_volatile(get_stack_optional<std::variant<Volatile, double>>(j, "volatile"));
        if (j.find("wchar_t") != j.end() && j.at("wchar_t").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_wchar_t(get_stack_optional<std::variant<WcharT, double>>(j, "wchar_t"));
        if (j.find("weak") != j.end() && j.at("weak").is_null()) throw std::runtime_error("Unexpected null");
        x.set_weak(get_stack_optional<std::variant<Weak, double>>(j, "weak"));
        if (j.find("where") != j.end() && j.at("where").is_null()) throw std::runtime_error("Unexpected null");
        x.set_where(get_stack_optional<std::variant<Where, double>>(j, "where"));
        if (j.find("while") != j.end() && j.at("while").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_while(get_stack_optional<std::variant<While, double>>(j, "while"));
        if (j.find("willSet") != j.end() && j.at("willSet").is_null()) throw std::runtime_error("Unexpected null");
        x.set_will_set(get_stack_optional<std::variant<WillSet, double>>(j, "willSet"));
        if (j.find("with") != j.end() && j.at("with").is_null()) throw std::runtime_error("Unexpected null");
        x.set_with(get_stack_optional<std::variant<With, double>>(j, "with"));
        if (j.find("xor") != j.end() && j.at("xor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_xor(get_stack_optional<std::variant<Xor, double>>(j, "xor"));
        if (j.find("xor_eq") != j.end() && j.at("xor_eq").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_xor_eq(get_stack_optional<std::variant<XorEq, double>>(j, "xor_eq"));
        if (j.find("YES") != j.end() && j.at("YES").is_null()) throw std::runtime_error("Unexpected null");
        x.set_yes(get_stack_optional<std::variant<Yes, double>>(j, "YES"));
        if (j.find("yield") != j.end() && j.at("yield").is_null()) throw std::runtime_error("Unexpected null");
        x.set_yield(get_stack_optional<std::variant<Yield, double>>(j, "yield"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["_"] = x.get_empty();
        j["_Bool"] = x.get_purple_bool();
        j["_Complex"] = x.get_complex();
        j["_Imaginery"] = x.get_imaginery();
        j["abstract"] = x.get_abstract();
        j["alignas"] = x.get_top_level_alignas();
        j["alignof"] = x.get_top_level_alignof();
        j["and"] = x.get_top_level_and();
        j["and_eq"] = x.get_top_level_and_eq();
        j["any"] = x.get_top_level_any();
        j["Any"] = x.get_any();
        j["array"] = x.get_array();
        j["ArrayNode"] = x.get_array_node();
        j["as"] = x.get_as();
        j["asm"] = x.get_top_level_asm();
        j["assert"] = x.get_assert();
        j["associatedtype"] = x.get_associatedtype();
        j["associativity"] = x.get_associativity();
        j["async"] = x.get_async();
        j["atomic"] = x.get_atomic();
        j["atomic_cancel"] = x.get_top_level_atomic_cancel();
        j["atomic_commit"] = x.get_top_level_atomic_commit();
        j["atomic_noexcept"] = x.get_top_level_atomic_noexcept();
        j["auto"] = x.get_top_level_auto();
        j["await"] = x.get_await();
        j["base"] = x.get_base();
        j["bitand"] = x.get_top_level_bitand();
        j["bitor"] = x.get_top_level_bitor();
        j["BOOL"] = x.get_top_level_bool();
        j["bool"] = x.get_fluffy_bool();
        j["boolean"] = x.get_boolean();
        j["BooleanNode"] = x.get_boolean_node();
        j["break"] = x.get_top_level_break();
        j["bycopy"] = x.get_bycopy();
        j["byref"] = x.get_byref();
        j["byte"] = x.get_byte();
        j["Calendar"] = x.get_calendar();
        j["case"] = x.get_top_level_case();
        j["catch"] = x.get_top_level_catch();
        j["chan"] = x.get_chan();
        j["char"] = x.get_top_level_char();
        j["char16_t"] = x.get_top_level_char16_t();
        j["char32_t"] = x.get_top_level_char32_t();
        j["checked"] = x.get_checked();
        j["class"] = x.get_purple_class();
        j["Class"] = x.get_top_level_class();
        j["clone"] = x.get_clone();
        j["co_await"] = x.get_top_level_co_await();
        j["co_return"] = x.get_top_level_co_return();
        j["co_yield"] = x.get_top_level_co_yield();
        j["Codable"] = x.get_codable();
        j["CodingKey"] = x.get_coding_key();
        j["CodingKeys"] = x.get_coding_keys();
        j["compl"] = x.get_top_level_compl();
        j["concept"] = x.get_top_level_concept();
        j["console"] = x.get_console();
        j["const"] = x.get_top_level_const();
        j["const_cast"] = x.get_top_level_const_cast();
        j["constexpr"] = x.get_top_level_constexpr();
        j["constructor"] = x.get_constructor();
        j["continue"] = x.get_top_level_continue();
        j["convenience"] = x.get_convenience();
        j["convert"] = x.get_convert();
        j["converter"] = x.get_converter();
        j["CultureInfo"] = x.get_culture_info();
        j["date"] = x.get_date();
        j["date_parse_handling"] = x.get_date_parse_handling();
        j["DateFormatter"] = x.get_date_formatter();
        j["DateOnly"] = x.get_date_only();
        j["DateOnlyConverter"] = x.get_date_only_converter();
        j["DateTime"] = x.get_date_time();
        j["DateTimeStyles"] = x.get_date_time_styles();
        j["debugger"] = x.get_debugger();
        j["decimal"] = x.get_decimal();
        j["declare"] = x.get_declare();
        j["decltype"] = x.get_top_level_decltype();
        j["decode_string"] = x.get_decode_string();
        j["Decoder"] = x.get_decoder();
        j["DecodingError"] = x.get_decoding_error();
        j["def"] = x.get_def();
        j["default"] = x.get_top_level_default();
        j["defer"] = x.get_defer();
        j["deinit"] = x.get_deinit();
        j["del"] = x.get_del();
        j["delegate"] = x.get_delegate();
        j["delete"] = x.get_top_level_delete();
        j["DeserializationFeature"] = x.get_deserialization_feature();
        j["dict"] = x.get_dict();
        j["dictionary"] = x.get_dictionary();
        j["didSet"] = x.get_did_set();
        j["do"] = x.get_top_level_do();
        j["double"] = x.get_top_level_double();
        j["DoubleNode"] = x.get_double_node();
        j["dummy"] = x.get_dummy();
        j["dynamic"] = x.get_dynamic();
        j["dynamic_cast"] = x.get_top_level_dynamic_cast();
        j["elif"] = x.get_elif();
        j["else"] = x.get_top_level_else();
        j["encode_quick_type"] = x.get_encode_quick_type();
        j["Encoder"] = x.get_encoder();
        j["enum"] = x.get_top_level_enum();
        j["EnumValues"] = x.get_enum_values();
        j["equalityContract"] = x.get_equality_contract();
        j["Equatable"] = x.get_equatable();
        j["event"] = x.get_event();
        j["except"] = x.get_except();
        j["exception"] = x.get_exception();
        j["explicit"] = x.get_top_level_explicit();
        j["export"] = x.get_top_level_export();
        j["exposing"] = x.get_exposing();
        j["extends"] = x.get_extends();
        j["extension"] = x.get_extension();
        j["extern"] = x.get_top_level_extern();
        j["fallthrough"] = x.get_fallthrough();
        j["false"] = x.get_purple_false();
        j["False"] = x.get_top_level_false();
        j["fileprivate"] = x.get_fileprivate();
        j["final"] = x.get_top_level_final();
        j["finally"] = x.get_finally();
        j["fixed"] = x.get_fixed();
        j["float"] = x.get_top_level_float();
        j["for"] = x.get_top_level_for();
        j["foreach"] = x.get_foreach();
        j["FormatException"] = x.get_format_exception();
        j["friend"] = x.get_top_level_friend();
        j["from"] = x.get_from();
        j["from_dict"] = x.get_from_dict();
        j["from_json"] = x.get_from_json();
        j["func"] = x.get_func();
        j["function"] = x.get_function();
        j["get"] = x.get_get();
        j["global"] = x.get_global();
        j["go"] = x.get_go();
        j["goto"] = x.get_top_level_goto();
        j["guard"] = x.get_guard();
        j["Hashable"] = x.get_hashable();
        j["hashCode"] = x.get_hash_code();
        j["Hasher"] = x.get_hasher();
        j["hasOwnProperty"] = x.get_has_own_property();
        j["id"] = x.get_id();
        j["if"] = x.get_top_level_if();
        j["IMP"] = x.get_imp();
        j["implements"] = x.get_implements();
        j["implicit"] = x.get_implicit();
        j["import"] = x.get_top_level_import();
        j["in"] = x.get_in();
        j["indirect"] = x.get_indirect();
        j["infix"] = x.get_infix();
        j["init"] = x.get_init();
        j["inline"] = x.get_top_level_inline();
        j["inout"] = x.get_inout();
        j["instanceof"] = x.get_instanceof();
        j["int"] = x.get_top_level_int();
        j["interface"] = x.get_interface();
        j["internal"] = x.get_internal();
        j["IntNode"] = x.get_int_node();
        j["is"] = x.get_is();
        j["IsoDateTimeOffsetConverter"] = x.get_iso_date_time_offset_converter();
        j["iterable"] = x.get_iterable();
        j["jdec"] = x.get_jdec();
        j["jenc"] = x.get_jenc();
        j["jpipe"] = x.get_jpipe();
        j["json"] = x.get_json();
        j["json_converter"] = x.get_json_converter();
        j["json_serializer"] = x.get_json_serializer();
        j["json_token"] = x.get_json_token();
        j["json_writer"] = x.get_json_writer();
        j["JSONAny"] = x.get_json_any();
        j["JSONCodingKey"] = x.get_json_coding_key();
        j["JSONDecoder"] = x.get_json_decoder();
        j["JSONEncoder"] = x.get_json_encoder();
        j["JsonException"] = x.get_json_exception();
        j["JsonGenerator"] = x.get_json_generator();
        j["JsonNode"] = x.get_json_node();
        j["JSONNull"] = x.get_json_null();
        j["JsonParser"] = x.get_json_parser();
        j["JsonReader"] = x.get_json_reader();
        j["JsonTokenType"] = x.get_json_token_type();
        j["KSerializer"] = x.get_k_serializer();
        j["lambda"] = x.get_lambda();
        j["lazy"] = x.get_lazy();
        j["left"] = x.get_left();
        j["let"] = x.get_let();
        j["list"] = x.get_list();
        j["LocalDate"] = x.get_local_date();
        j["Locale"] = x.get_locale();
        j["lock"] = x.get_lock();
        j["long"] = x.get_top_level_long();
        j["LongNode"] = x.get_long_node();
        j["map"] = x.get_map();
        j["MapEntry"] = x.get_map_entry();
        j["MarshalJSON"] = x.get_marshal_json();
        j["metadata_property_handling"] = x.get_metadata_property_handling();
        j["module"] = x.get_top_level_module();
        j["mutable"] = x.get_top_level_mutable();
        j["mutating"] = x.get_mutating();
        j["namespace"] = x.get_top_level_namespace();
        j["native"] = x.get_native();
        j["new"] = x.get_top_level_new();
        j["newtonsoft"] = x.get_newtonsoft();
        j["nil"] = x.get_nil();
        j["NO"] = x.get_no();
        j["noexcept"] = x.get_top_level_noexcept();
        j["nonatomic"] = x.get_nonatomic();
        j["none"] = x.get_top_level_none();
        j["None"] = x.get_none();
        j["nonlocal"] = x.get_nonlocal();
        j["nonmutating"] = x.get_nonmutating();
        j["noSuchMethod"] = x.get_no_such_method();
        j["not"] = x.get_top_level_not();
        j["not_eq"] = x.get_top_level_not_eq();
        j["NSError"] = x.get_ns_error();
        j["NSObject"] = x.get_ns_object();
        j["NSString"] = x.get_ns_string();
        j["NULL"] = x.get_null();
        j["null"] = x.get_top_level_null();
        j["NullNode"] = x.get_null_node();
        j["nullptr"] = x.get_top_level_nullptr();
        j["number"] = x.get_number();
        j["object"] = x.get_object();
        j["ObjectMapper"] = x.get_object_mapper();
        j["ObjectNode"] = x.get_object_node();
        j["ObjectReader"] = x.get_object_reader();
        j["ObjectWriter"] = x.get_object_writer();
        j["of"] = x.get_of();
        j["OffsetDateTime"] = x.get_offset_date_time();
        j["OffsetTime"] = x.get_offset_time();
        j["oneway"] = x.get_oneway();
        j["open"] = x.get_open();
        j["operator"] = x.get_top_level_operator();
        j["optional"] = x.get_optional();
        j["or"] = x.get_top_level_or();
        j["or_eq"] = x.get_top_level_or_eq();
        j["out"] = x.get_out();
        j["override"] = x.get_top_level_override();
        j["package"] = x.get_package();
        j["params"] = x.get_params();
        j["pass"] = x.get_pass();
        j["port"] = x.get_port();
        j["postfix"] = x.get_postfix();
        j["precedence"] = x.get_precedence();
        j["prefix"] = x.get_prefix();
        j["PrimitiveKind"] = x.get_primitive_kind();
        j["print"] = x.get_print();
        j["printf"] = x.get_printf();
        j["printMembers"] = x.get_print_members();
        j["private"] = x.get_top_level_private();
        j["protected"] = x.get_top_level_protected();
        j["Protocol"] = x.get_protocol();
        j["protocol"] = x.get_top_level_protocol();
        j["public"] = x.get_top_level_public();
        j["quicktype"] = x.get_quicktype();
        j["raise"] = x.get_raise();
        j["range"] = x.get_range();
        j["readonly"] = x.get_readonly();
        j["ref"] = x.get_ref();
        j["RegExp"] = x.get_reg_exp();
        j["register"] = x.get_top_level_register();
        j["reinterpret_cast"] = x.get_top_level_reinterpret_cast();
        j["repeat"] = x.get_repeat();
        j["require"] = x.get_require();
        j["required"] = x.get_required();
        j["requires"] = x.get_top_level_requires();
        j["restrict"] = x.get_restrict();
        j["retain"] = x.get_retain();
        j["rethrows"] = x.get_rethrows();
        j["return"] = x.get_top_level_return();
        j["right"] = x.get_right();
        j["runtimeType"] = x.get_runtime_type();
        j["s"] = x.get_s();
        j["sbyte"] = x.get_sbyte();
        j["sealed"] = x.get_sealed();
        j["SEL"] = x.get_sel();
        j["select"] = x.get_select();
        j["Self"] = x.get_self();
        j["self"] = x.get_top_level_self();
        j["Sendable"] = x.get_sendable();
        j["SerialDescriptor"] = x.get_serial_descriptor();
        j["Serializable"] = x.get_serializable();
        j["SerializationFeature"] = x.get_serialization_feature();
        j["serialize"] = x.get_serialize();
        j["SerializerProvider"] = x.get_serializer_provider();
        j["SerialName"] = x.get_serial_name();
        j["set"] = x.get_set();
        j["short"] = x.get_top_level_short();
        j["signed"] = x.get_top_level_signed();
        j["SimpleModule"] = x.get_simple_module();
        j["sizeof"] = x.get_top_level_sizeof();
        j["stackalloc"] = x.get_stackalloc();
        j["Standards"] = x.get_standards();
        j["static"] = x.get_top_level_static();
        j["static_assert"] = x.get_top_level_static_assert();
        j["static_cast"] = x.get_top_level_static_cast();
        j["StdDeserializer"] = x.get_std_deserializer();
        j["StdSerializer"] = x.get_std_serializer();
        j["strictfp"] = x.get_strictfp();
        j["string"] = x.get_string();
        j["struct"] = x.get_top_level_struct();
        j["subscript"] = x.get_subscript();
        j["super"] = x.get_super();
        j["switch"] = x.get_top_level_switch();
        j["symbol"] = x.get_symbol();
        j["synchronized"] = x.get_top_level_synchronized();
        j["system"] = x.get_system();
        j["template"] = x.get_top_level_template();
        j["TextNode"] = x.get_text_node();
        j["then"] = x.get_then();
        j["this"] = x.get_top_level_this();
        j["thread_local"] = x.get_top_level_thread_local();
        j["throw"] = x.get_top_level_throw();
        j["throws"] = x.get_throws();
        j["TimeOnly"] = x.get_time_only();
        j["TimeOnlyConverter"] = x.get_time_only_converter();
        j["TimeZone"] = x.get_time_zone();
        j["to_dict"] = x.get_to_dict();
        j["to_json"] = x.get_to_json();
        j["top_level"] = x.get_top_level();
        j["toString"] = x.get_to_string();
        j["transient"] = x.get_transient();
        j["True"] = x.get_top_level_true();
        j["true"] = x.get_purple_true();
        j["try"] = x.get_top_level_try();
        j["Type"] = x.get_type();
        j["type"] = x.get_top_level_type();
        j["typealias"] = x.get_typealias();
        j["typedef"] = x.get_top_level_typedef();
        j["typeid"] = x.get_top_level_typeid();
        j["typename"] = x.get_top_level_typename();
        j["typeof"] = x.get_typeof();
        j["uint"] = x.get_uint();
        j["ulong"] = x.get_ulong();
        j["unchecked"] = x.get_unchecked();
        j["undefined"] = x.get_undefined();
        j["union"] = x.get_top_level_union();
        j["UnmarshalJSON"] = x.get_unmarshal_json();
        j["unowned"] = x.get_unowned();
        j["unsafe"] = x.get_unsafe();
        j["unsigned"] = x.get_top_level_unsigned();
        j["UseSerializers"] = x.get_use_serializers();
        j["ushort"] = x.get_ushort();
        j["using"] = x.get_top_level_using();
        j["Utf8JsonReader"] = x.get_utf8_json_reader();
        j["Utf8JsonWriter"] = x.get_utf8_json_writer();
        j["UUID"] = x.get_uuid();
        j["var"] = x.get_var();
        j["virtual"] = x.get_top_level_virtual();
        j["void"] = x.get_top_level_void();
        j["volatile"] = x.get_top_level_volatile();
        j["wchar_t"] = x.get_top_level_wchar_t();
        j["weak"] = x.get_weak();
        j["where"] = x.get_where();
        j["while"] = x.get_top_level_while();
        j["willSet"] = x.get_will_set();
        j["with"] = x.get_with();
        j["xor"] = x.get_top_level_xor();
        j["xor_eq"] = x.get_top_level_xor_eq();
        j["YES"] = x.get_yes();
        j["yield"] = x.get_yield();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<quicktype::Abstract, double>>::from_json(const json & j, std::variant<quicktype::Abstract, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Abstract>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Abstract, double>>::to_json(json & j, const std::variant<quicktype::Abstract, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Abstract>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Any, double>>::from_json(const json & j, std::variant<quicktype::Any, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Any>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Any, double>>::to_json(json & j, const std::variant<quicktype::Any, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Any>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Array, double>>::from_json(const json & j, std::variant<quicktype::Array, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Array>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Array, double>>::to_json(json & j, const std::variant<quicktype::Array, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Array>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ArrayNode, double>>::from_json(const json & j, std::variant<quicktype::ArrayNode, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::ArrayNode>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ArrayNode, double>>::to_json(json & j, const std::variant<quicktype::ArrayNode, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ArrayNode>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::As, double>>::from_json(const json & j, std::variant<quicktype::As, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::As>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::As, double>>::to_json(json & j, const std::variant<quicktype::As, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::As>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Assert, double>>::from_json(const json & j, std::variant<quicktype::Assert, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Assert>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Assert, double>>::to_json(json & j, const std::variant<quicktype::Assert, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Assert>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Associatedtype, double>>::from_json(const json & j, std::variant<quicktype::Associatedtype, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Associatedtype>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Associatedtype, double>>::to_json(json & j, const std::variant<quicktype::Associatedtype, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Associatedtype>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Associativity, double>>::from_json(const json & j, std::variant<quicktype::Associativity, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Associativity>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Associativity, double>>::to_json(json & j, const std::variant<quicktype::Associativity, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Associativity>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Async, double>>::from_json(const json & j, std::variant<quicktype::Async, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Async>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Async, double>>::to_json(json & j, const std::variant<quicktype::Async, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Async>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Atomic, double>>::from_json(const json & j, std::variant<quicktype::Atomic, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Atomic>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Atomic, double>>::to_json(json & j, const std::variant<quicktype::Atomic, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Atomic>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Await, double>>::from_json(const json & j, std::variant<quicktype::Await, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Await>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Await, double>>::to_json(json & j, const std::variant<quicktype::Await, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Await>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Base, double>>::from_json(const json & j, std::variant<quicktype::Base, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Base>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Base, double>>::to_json(json & j, const std::variant<quicktype::Base, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Base>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Boolean, double>>::from_json(const json & j, std::variant<quicktype::Boolean, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Boolean>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Boolean, double>>::to_json(json & j, const std::variant<quicktype::Boolean, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Boolean>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::BooleanNode, double>>::from_json(const json & j, std::variant<quicktype::BooleanNode, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::BooleanNode>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::BooleanNode, double>>::to_json(json & j, const std::variant<quicktype::BooleanNode, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::BooleanNode>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Bycopy, double>>::from_json(const json & j, std::variant<quicktype::Bycopy, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Bycopy>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Bycopy, double>>::to_json(json & j, const std::variant<quicktype::Bycopy, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Bycopy>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Byref, double>>::from_json(const json & j, std::variant<quicktype::Byref, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Byref>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Byref, double>>::to_json(json & j, const std::variant<quicktype::Byref, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Byref>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Byte, double>>::from_json(const json & j, std::variant<quicktype::Byte, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Byte>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Byte, double>>::to_json(json & j, const std::variant<quicktype::Byte, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Byte>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Calendar, double>>::from_json(const json & j, std::variant<quicktype::Calendar, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Calendar>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Calendar, double>>::to_json(json & j, const std::variant<quicktype::Calendar, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Calendar>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Chan, double>>::from_json(const json & j, std::variant<quicktype::Chan, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Chan>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Chan, double>>::to_json(json & j, const std::variant<quicktype::Chan, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Chan>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Checked, double>>::from_json(const json & j, std::variant<quicktype::Checked, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Checked>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Checked, double>>::to_json(json & j, const std::variant<quicktype::Checked, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Checked>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Clone, double>>::from_json(const json & j, std::variant<quicktype::Clone, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Clone>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Clone, double>>::to_json(json & j, const std::variant<quicktype::Clone, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Clone>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Codable, double>>::from_json(const json & j, std::variant<quicktype::Codable, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Codable>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Codable, double>>::to_json(json & j, const std::variant<quicktype::Codable, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Codable>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::CodingKey, double>>::from_json(const json & j, std::variant<quicktype::CodingKey, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::CodingKey>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CodingKey, double>>::to_json(json & j, const std::variant<quicktype::CodingKey, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::CodingKey>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::CodingKeys, double>>::from_json(const json & j, std::variant<quicktype::CodingKeys, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::CodingKeys>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CodingKeys, double>>::to_json(json & j, const std::variant<quicktype::CodingKeys, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::CodingKeys>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Complex, double>>::from_json(const json & j, std::variant<quicktype::Complex, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Complex>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Complex, double>>::to_json(json & j, const std::variant<quicktype::Complex, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Complex>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Console, double>>::from_json(const json & j, std::variant<quicktype::Console, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Console>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Console, double>>::to_json(json & j, const std::variant<quicktype::Console, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Console>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Constructor, double>>::from_json(const json & j, std::variant<quicktype::Constructor, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Constructor>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Constructor, double>>::to_json(json & j, const std::variant<quicktype::Constructor, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Constructor>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Convenience, double>>::from_json(const json & j, std::variant<quicktype::Convenience, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Convenience>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Convenience, double>>::to_json(json & j, const std::variant<quicktype::Convenience, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Convenience>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Convert, double>>::from_json(const json & j, std::variant<quicktype::Convert, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Convert>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Convert, double>>::to_json(json & j, const std::variant<quicktype::Convert, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Convert>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Converter, double>>::from_json(const json & j, std::variant<quicktype::Converter, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Converter>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Converter, double>>::to_json(json & j, const std::variant<quicktype::Converter, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Converter>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::CultureInfo, double>>::from_json(const json & j, std::variant<quicktype::CultureInfo, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::CultureInfo>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CultureInfo, double>>::to_json(json & j, const std::variant<quicktype::CultureInfo, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::CultureInfo>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Date, double>>::from_json(const json & j, std::variant<quicktype::Date, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Date>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Date, double>>::to_json(json & j, const std::variant<quicktype::Date, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Date>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DateFormatter, double>>::from_json(const json & j, std::variant<quicktype::DateFormatter, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::DateFormatter>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DateFormatter, double>>::to_json(json & j, const std::variant<quicktype::DateFormatter, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DateFormatter>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DateOnly, double>>::from_json(const json & j, std::variant<quicktype::DateOnly, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::DateOnly>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DateOnly, double>>::to_json(json & j, const std::variant<quicktype::DateOnly, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DateOnly>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DateOnlyConverter, double>>::from_json(const json & j, std::variant<quicktype::DateOnlyConverter, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::DateOnlyConverter>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DateOnlyConverter, double>>::to_json(json & j, const std::variant<quicktype::DateOnlyConverter, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DateOnlyConverter>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DateParseHandling, double>>::from_json(const json & j, std::variant<quicktype::DateParseHandling, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::DateParseHandling>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DateParseHandling, double>>::to_json(json & j, const std::variant<quicktype::DateParseHandling, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DateParseHandling>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DateTime, double>>::from_json(const json & j, std::variant<quicktype::DateTime, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::DateTime>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DateTime, double>>::to_json(json & j, const std::variant<quicktype::DateTime, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DateTime>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DateTimeStyles, double>>::from_json(const json & j, std::variant<quicktype::DateTimeStyles, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::DateTimeStyles>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DateTimeStyles, double>>::to_json(json & j, const std::variant<quicktype::DateTimeStyles, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DateTimeStyles>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Debugger, double>>::from_json(const json & j, std::variant<quicktype::Debugger, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Debugger>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Debugger, double>>::to_json(json & j, const std::variant<quicktype::Debugger, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Debugger>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Decimal, double>>::from_json(const json & j, std::variant<quicktype::Decimal, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Decimal>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Decimal, double>>::to_json(json & j, const std::variant<quicktype::Decimal, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Decimal>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Declare, double>>::from_json(const json & j, std::variant<quicktype::Declare, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Declare>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Declare, double>>::to_json(json & j, const std::variant<quicktype::Declare, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Declare>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DecodeString, double>>::from_json(const json & j, std::variant<quicktype::DecodeString, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::DecodeString>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DecodeString, double>>::to_json(json & j, const std::variant<quicktype::DecodeString, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DecodeString>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Decoder, double>>::from_json(const json & j, std::variant<quicktype::Decoder, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Decoder>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Decoder, double>>::to_json(json & j, const std::variant<quicktype::Decoder, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Decoder>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DecodingError, double>>::from_json(const json & j, std::variant<quicktype::DecodingError, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::DecodingError>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DecodingError, double>>::to_json(json & j, const std::variant<quicktype::DecodingError, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DecodingError>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Def, double>>::from_json(const json & j, std::variant<quicktype::Def, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Def>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Def, double>>::to_json(json & j, const std::variant<quicktype::Def, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Def>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Defer, double>>::from_json(const json & j, std::variant<quicktype::Defer, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Defer>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Defer, double>>::to_json(json & j, const std::variant<quicktype::Defer, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Defer>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Deinit, double>>::from_json(const json & j, std::variant<quicktype::Deinit, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Deinit>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Deinit, double>>::to_json(json & j, const std::variant<quicktype::Deinit, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Deinit>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Del, double>>::from_json(const json & j, std::variant<quicktype::Del, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Del>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Del, double>>::to_json(json & j, const std::variant<quicktype::Del, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Del>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Delegate, double>>::from_json(const json & j, std::variant<quicktype::Delegate, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Delegate>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Delegate, double>>::to_json(json & j, const std::variant<quicktype::Delegate, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Delegate>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DeserializationFeature, double>>::from_json(const json & j, std::variant<quicktype::DeserializationFeature, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::DeserializationFeature>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DeserializationFeature, double>>::to_json(json & j, const std::variant<quicktype::DeserializationFeature, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DeserializationFeature>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Dict, double>>::from_json(const json & j, std::variant<quicktype::Dict, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Dict>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Dict, double>>::to_json(json & j, const std::variant<quicktype::Dict, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Dict>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Dictionary, double>>::from_json(const json & j, std::variant<quicktype::Dictionary, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Dictionary>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Dictionary, double>>::to_json(json & j, const std::variant<quicktype::Dictionary, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Dictionary>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DidSet, double>>::from_json(const json & j, std::variant<quicktype::DidSet, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::DidSet>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DidSet, double>>::to_json(json & j, const std::variant<quicktype::DidSet, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DidSet>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DoubleNode, double>>::from_json(const json & j, std::variant<quicktype::DoubleNode, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::DoubleNode>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DoubleNode, double>>::to_json(json & j, const std::variant<quicktype::DoubleNode, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DoubleNode>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Dynamic, double>>::from_json(const json & j, std::variant<quicktype::Dynamic, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Dynamic>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Dynamic, double>>::to_json(json & j, const std::variant<quicktype::Dynamic, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Dynamic>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Elif, double>>::from_json(const json & j, std::variant<quicktype::Elif, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Elif>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Elif, double>>::to_json(json & j, const std::variant<quicktype::Elif, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Elif>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Empty, double>>::from_json(const json & j, std::variant<quicktype::Empty, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Empty>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Empty, double>>::to_json(json & j, const std::variant<quicktype::Empty, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Empty>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::EncodeQuickType, double>>::from_json(const json & j, std::variant<quicktype::EncodeQuickType, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::EncodeQuickType>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::EncodeQuickType, double>>::to_json(json & j, const std::variant<quicktype::EncodeQuickType, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::EncodeQuickType>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Encoder, double>>::from_json(const json & j, std::variant<quicktype::Encoder, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Encoder>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Encoder, double>>::to_json(json & j, const std::variant<quicktype::Encoder, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Encoder>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::EnumValues, double>>::from_json(const json & j, std::variant<quicktype::EnumValues, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::EnumValues>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::EnumValues, double>>::to_json(json & j, const std::variant<quicktype::EnumValues, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::EnumValues>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::EqualityContract, double>>::from_json(const json & j, std::variant<quicktype::EqualityContract, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::EqualityContract>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::EqualityContract, double>>::to_json(json & j, const std::variant<quicktype::EqualityContract, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::EqualityContract>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Equatable, double>>::from_json(const json & j, std::variant<quicktype::Equatable, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Equatable>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Equatable, double>>::to_json(json & j, const std::variant<quicktype::Equatable, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Equatable>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Event, double>>::from_json(const json & j, std::variant<quicktype::Event, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Event>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Event, double>>::to_json(json & j, const std::variant<quicktype::Event, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Event>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Except, double>>::from_json(const json & j, std::variant<quicktype::Except, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Except>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Except, double>>::to_json(json & j, const std::variant<quicktype::Except, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Except>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Exception, double>>::from_json(const json & j, std::variant<quicktype::Exception, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Exception>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Exception, double>>::to_json(json & j, const std::variant<quicktype::Exception, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Exception>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Exposing, double>>::from_json(const json & j, std::variant<quicktype::Exposing, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Exposing>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Exposing, double>>::to_json(json & j, const std::variant<quicktype::Exposing, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Exposing>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Extends, double>>::from_json(const json & j, std::variant<quicktype::Extends, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Extends>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Extends, double>>::to_json(json & j, const std::variant<quicktype::Extends, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Extends>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Extension, double>>::from_json(const json & j, std::variant<quicktype::Extension, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Extension>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Extension, double>>::to_json(json & j, const std::variant<quicktype::Extension, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Extension>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Fallthrough, double>>::from_json(const json & j, std::variant<quicktype::Fallthrough, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Fallthrough>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Fallthrough, double>>::to_json(json & j, const std::variant<quicktype::Fallthrough, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Fallthrough>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Fileprivate, double>>::from_json(const json & j, std::variant<quicktype::Fileprivate, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Fileprivate>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Fileprivate, double>>::to_json(json & j, const std::variant<quicktype::Fileprivate, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Fileprivate>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Finally, double>>::from_json(const json & j, std::variant<quicktype::Finally, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Finally>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Finally, double>>::to_json(json & j, const std::variant<quicktype::Finally, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Finally>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Fixed, double>>::from_json(const json & j, std::variant<quicktype::Fixed, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Fixed>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Fixed, double>>::to_json(json & j, const std::variant<quicktype::Fixed, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Fixed>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::UnionBoolBool, double>>::from_json(const json & j, std::variant<quicktype::UnionBoolBool, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::UnionBoolBool>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::UnionBoolBool, double>>::to_json(json & j, const std::variant<quicktype::UnionBoolBool, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::UnionBoolBool>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Foreach, double>>::from_json(const json & j, std::variant<quicktype::Foreach, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Foreach>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Foreach, double>>::to_json(json & j, const std::variant<quicktype::Foreach, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Foreach>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::FormatException, double>>::from_json(const json & j, std::variant<quicktype::FormatException, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::FormatException>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::FormatException, double>>::to_json(json & j, const std::variant<quicktype::FormatException, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::FormatException>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::From, double>>::from_json(const json & j, std::variant<quicktype::From, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::From>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::From, double>>::to_json(json & j, const std::variant<quicktype::From, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::From>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::FromDict, double>>::from_json(const json & j, std::variant<quicktype::FromDict, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::FromDict>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::FromDict, double>>::to_json(json & j, const std::variant<quicktype::FromDict, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::FromDict>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::FromJson, double>>::from_json(const json & j, std::variant<quicktype::FromJson, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::FromJson>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::FromJson, double>>::to_json(json & j, const std::variant<quicktype::FromJson, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::FromJson>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Func, double>>::from_json(const json & j, std::variant<quicktype::Func, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Func>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Func, double>>::to_json(json & j, const std::variant<quicktype::Func, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Func>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Function, double>>::from_json(const json & j, std::variant<quicktype::Function, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Function>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Function, double>>::to_json(json & j, const std::variant<quicktype::Function, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Function>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Get, double>>::from_json(const json & j, std::variant<quicktype::Get, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Get>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Get, double>>::to_json(json & j, const std::variant<quicktype::Get, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Get>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Global, double>>::from_json(const json & j, std::variant<quicktype::Global, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Global>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Global, double>>::to_json(json & j, const std::variant<quicktype::Global, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Global>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Go, double>>::from_json(const json & j, std::variant<quicktype::Go, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Go>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Go, double>>::to_json(json & j, const std::variant<quicktype::Go, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Go>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Guard, double>>::from_json(const json & j, std::variant<quicktype::Guard, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Guard>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Guard, double>>::to_json(json & j, const std::variant<quicktype::Guard, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Guard>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::HasOwnProperty, double>>::from_json(const json & j, std::variant<quicktype::HasOwnProperty, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::HasOwnProperty>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::HasOwnProperty, double>>::to_json(json & j, const std::variant<quicktype::HasOwnProperty, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::HasOwnProperty>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::HashCode, double>>::from_json(const json & j, std::variant<quicktype::HashCode, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::HashCode>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::HashCode, double>>::to_json(json & j, const std::variant<quicktype::HashCode, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::HashCode>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Hashable, double>>::from_json(const json & j, std::variant<quicktype::Hashable, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Hashable>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Hashable, double>>::to_json(json & j, const std::variant<quicktype::Hashable, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Hashable>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Hasher, double>>::from_json(const json & j, std::variant<quicktype::Hasher, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Hasher>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Hasher, double>>::to_json(json & j, const std::variant<quicktype::Hasher, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Hasher>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Id, double>>::from_json(const json & j, std::variant<quicktype::Id, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Id>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Id, double>>::to_json(json & j, const std::variant<quicktype::Id, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Id>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Imaginery, double>>::from_json(const json & j, std::variant<quicktype::Imaginery, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Imaginery>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Imaginery, double>>::to_json(json & j, const std::variant<quicktype::Imaginery, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Imaginery>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Imp, double>>::from_json(const json & j, std::variant<quicktype::Imp, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Imp>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Imp, double>>::to_json(json & j, const std::variant<quicktype::Imp, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Imp>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Implements, double>>::from_json(const json & j, std::variant<quicktype::Implements, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Implements>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Implements, double>>::to_json(json & j, const std::variant<quicktype::Implements, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Implements>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Implicit, double>>::from_json(const json & j, std::variant<quicktype::Implicit, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Implicit>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Implicit, double>>::to_json(json & j, const std::variant<quicktype::Implicit, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Implicit>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::In, double>>::from_json(const json & j, std::variant<quicktype::In, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::In>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::In, double>>::to_json(json & j, const std::variant<quicktype::In, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::In>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Indirect, double>>::from_json(const json & j, std::variant<quicktype::Indirect, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Indirect>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Indirect, double>>::to_json(json & j, const std::variant<quicktype::Indirect, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Indirect>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Infix, double>>::from_json(const json & j, std::variant<quicktype::Infix, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Infix>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Infix, double>>::to_json(json & j, const std::variant<quicktype::Infix, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Infix>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Init, double>>::from_json(const json & j, std::variant<quicktype::Init, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Init>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Init, double>>::to_json(json & j, const std::variant<quicktype::Init, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Init>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Inout, double>>::from_json(const json & j, std::variant<quicktype::Inout, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Inout>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Inout, double>>::to_json(json & j, const std::variant<quicktype::Inout, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Inout>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Instanceof, double>>::from_json(const json & j, std::variant<quicktype::Instanceof, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Instanceof>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Instanceof, double>>::to_json(json & j, const std::variant<quicktype::Instanceof, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Instanceof>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::IntNode, double>>::from_json(const json & j, std::variant<quicktype::IntNode, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::IntNode>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::IntNode, double>>::to_json(json & j, const std::variant<quicktype::IntNode, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::IntNode>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Interface, double>>::from_json(const json & j, std::variant<quicktype::Interface, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Interface>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Interface, double>>::to_json(json & j, const std::variant<quicktype::Interface, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Interface>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Internal, double>>::from_json(const json & j, std::variant<quicktype::Internal, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Internal>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Internal, double>>::to_json(json & j, const std::variant<quicktype::Internal, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Internal>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Is, double>>::from_json(const json & j, std::variant<quicktype::Is, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Is>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Is, double>>::to_json(json & j, const std::variant<quicktype::Is, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Is>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::IsoDateTimeOffsetConverter, double>>::from_json(const json & j, std::variant<quicktype::IsoDateTimeOffsetConverter, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::IsoDateTimeOffsetConverter>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::IsoDateTimeOffsetConverter, double>>::to_json(json & j, const std::variant<quicktype::IsoDateTimeOffsetConverter, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::IsoDateTimeOffsetConverter>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Iterable, double>>::from_json(const json & j, std::variant<quicktype::Iterable, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Iterable>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Iterable, double>>::to_json(json & j, const std::variant<quicktype::Iterable, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Iterable>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Jdec, double>>::from_json(const json & j, std::variant<quicktype::Jdec, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Jdec>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Jdec, double>>::to_json(json & j, const std::variant<quicktype::Jdec, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Jdec>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Jenc, double>>::from_json(const json & j, std::variant<quicktype::Jenc, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Jenc>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Jenc, double>>::to_json(json & j, const std::variant<quicktype::Jenc, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Jenc>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Jpipe, double>>::from_json(const json & j, std::variant<quicktype::Jpipe, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Jpipe>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Jpipe, double>>::to_json(json & j, const std::variant<quicktype::Jpipe, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Jpipe>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Json, double>>::from_json(const json & j, std::variant<quicktype::Json, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Json>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Json, double>>::to_json(json & j, const std::variant<quicktype::Json, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Json>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonAny, double>>::from_json(const json & j, std::variant<quicktype::JsonAny, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonAny>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonAny, double>>::to_json(json & j, const std::variant<quicktype::JsonAny, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonAny>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonCodingKey, double>>::from_json(const json & j, std::variant<quicktype::JsonCodingKey, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonCodingKey>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonCodingKey, double>>::to_json(json & j, const std::variant<quicktype::JsonCodingKey, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonCodingKey>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonConverter, double>>::from_json(const json & j, std::variant<quicktype::JsonConverter, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonConverter>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonConverter, double>>::to_json(json & j, const std::variant<quicktype::JsonConverter, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonConverter>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonDecoder, double>>::from_json(const json & j, std::variant<quicktype::JsonDecoder, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonDecoder>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonDecoder, double>>::to_json(json & j, const std::variant<quicktype::JsonDecoder, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonDecoder>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonEncoder, double>>::from_json(const json & j, std::variant<quicktype::JsonEncoder, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonEncoder>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonEncoder, double>>::to_json(json & j, const std::variant<quicktype::JsonEncoder, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonEncoder>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonException, double>>::from_json(const json & j, std::variant<quicktype::JsonException, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonException>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonException, double>>::to_json(json & j, const std::variant<quicktype::JsonException, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonException>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonGenerator, double>>::from_json(const json & j, std::variant<quicktype::JsonGenerator, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonGenerator>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonGenerator, double>>::to_json(json & j, const std::variant<quicktype::JsonGenerator, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonGenerator>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonNode, double>>::from_json(const json & j, std::variant<quicktype::JsonNode, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonNode>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonNode, double>>::to_json(json & j, const std::variant<quicktype::JsonNode, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonNode>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonNull, double>>::from_json(const json & j, std::variant<quicktype::JsonNull, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonNull>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonNull, double>>::to_json(json & j, const std::variant<quicktype::JsonNull, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonNull>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonParser, double>>::from_json(const json & j, std::variant<quicktype::JsonParser, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonParser>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonParser, double>>::to_json(json & j, const std::variant<quicktype::JsonParser, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonParser>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonReader, double>>::from_json(const json & j, std::variant<quicktype::JsonReader, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonReader>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonReader, double>>::to_json(json & j, const std::variant<quicktype::JsonReader, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonReader>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonSerializer, double>>::from_json(const json & j, std::variant<quicktype::JsonSerializer, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonSerializer>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonSerializer, double>>::to_json(json & j, const std::variant<quicktype::JsonSerializer, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonSerializer>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonToken, double>>::from_json(const json & j, std::variant<quicktype::JsonToken, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonToken>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonToken, double>>::to_json(json & j, const std::variant<quicktype::JsonToken, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonToken>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonTokenType, double>>::from_json(const json & j, std::variant<quicktype::JsonTokenType, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonTokenType>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonTokenType, double>>::to_json(json & j, const std::variant<quicktype::JsonTokenType, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonTokenType>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::JsonWriter, double>>::from_json(const json & j, std::variant<quicktype::JsonWriter, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::JsonWriter>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::JsonWriter, double>>::to_json(json & j, const std::variant<quicktype::JsonWriter, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::JsonWriter>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::KSerializer, double>>::from_json(const json & j, std::variant<quicktype::KSerializer, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::KSerializer>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::KSerializer, double>>::to_json(json & j, const std::variant<quicktype::KSerializer, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::KSerializer>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Lambda, double>>::from_json(const json & j, std::variant<quicktype::Lambda, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Lambda>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Lambda, double>>::to_json(json & j, const std::variant<quicktype::Lambda, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Lambda>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Lazy, double>>::from_json(const json & j, std::variant<quicktype::Lazy, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Lazy>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Lazy, double>>::to_json(json & j, const std::variant<quicktype::Lazy, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Lazy>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Left, double>>::from_json(const json & j, std::variant<quicktype::Left, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Left>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Left, double>>::to_json(json & j, const std::variant<quicktype::Left, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Left>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Let, double>>::from_json(const json & j, std::variant<quicktype::Let, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Let>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Let, double>>::to_json(json & j, const std::variant<quicktype::Let, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Let>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::List, double>>::from_json(const json & j, std::variant<quicktype::List, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::List>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::List, double>>::to_json(json & j, const std::variant<quicktype::List, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::List>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::LocalDate, double>>::from_json(const json & j, std::variant<quicktype::LocalDate, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::LocalDate>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::LocalDate, double>>::to_json(json & j, const std::variant<quicktype::LocalDate, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::LocalDate>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Locale, double>>::from_json(const json & j, std::variant<quicktype::Locale, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Locale>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Locale, double>>::to_json(json & j, const std::variant<quicktype::Locale, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Locale>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Lock, double>>::from_json(const json & j, std::variant<quicktype::Lock, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Lock>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Lock, double>>::to_json(json & j, const std::variant<quicktype::Lock, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Lock>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::LongNode, double>>::from_json(const json & j, std::variant<quicktype::LongNode, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::LongNode>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::LongNode, double>>::to_json(json & j, const std::variant<quicktype::LongNode, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::LongNode>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Map, double>>::from_json(const json & j, std::variant<quicktype::Map, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Map>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Map, double>>::to_json(json & j, const std::variant<quicktype::Map, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Map>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::MapEntry, double>>::from_json(const json & j, std::variant<quicktype::MapEntry, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::MapEntry>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::MapEntry, double>>::to_json(json & j, const std::variant<quicktype::MapEntry, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::MapEntry>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::MarshalJson, double>>::from_json(const json & j, std::variant<quicktype::MarshalJson, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::MarshalJson>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::MarshalJson, double>>::to_json(json & j, const std::variant<quicktype::MarshalJson, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::MarshalJson>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::MetadataPropertyHandling, double>>::from_json(const json & j, std::variant<quicktype::MetadataPropertyHandling, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::MetadataPropertyHandling>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::MetadataPropertyHandling, double>>::to_json(json & j, const std::variant<quicktype::MetadataPropertyHandling, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::MetadataPropertyHandling>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Mutating, double>>::from_json(const json & j, std::variant<quicktype::Mutating, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Mutating>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Mutating, double>>::to_json(json & j, const std::variant<quicktype::Mutating, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Mutating>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Native, double>>::from_json(const json & j, std::variant<quicktype::Native, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Native>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Native, double>>::to_json(json & j, const std::variant<quicktype::Native, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Native>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Newtonsoft, double>>::from_json(const json & j, std::variant<quicktype::Newtonsoft, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Newtonsoft>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Newtonsoft, double>>::to_json(json & j, const std::variant<quicktype::Newtonsoft, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Newtonsoft>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Nil, double>>::from_json(const json & j, std::variant<quicktype::Nil, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Nil>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Nil, double>>::to_json(json & j, const std::variant<quicktype::Nil, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Nil>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::No, double>>::from_json(const json & j, std::variant<quicktype::No, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::No>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::No, double>>::to_json(json & j, const std::variant<quicktype::No, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::No>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::NoSuchMethod, double>>::from_json(const json & j, std::variant<quicktype::NoSuchMethod, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::NoSuchMethod>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::NoSuchMethod, double>>::to_json(json & j, const std::variant<quicktype::NoSuchMethod, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::NoSuchMethod>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Nonatomic, double>>::from_json(const json & j, std::variant<quicktype::Nonatomic, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Nonatomic>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Nonatomic, double>>::to_json(json & j, const std::variant<quicktype::Nonatomic, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Nonatomic>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::None, double>>::from_json(const json & j, std::variant<quicktype::None, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::None>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::None, double>>::to_json(json & j, const std::variant<quicktype::None, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::None>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Nonlocal, double>>::from_json(const json & j, std::variant<quicktype::Nonlocal, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Nonlocal>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Nonlocal, double>>::to_json(json & j, const std::variant<quicktype::Nonlocal, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Nonlocal>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Nonmutating, double>>::from_json(const json & j, std::variant<quicktype::Nonmutating, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Nonmutating>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Nonmutating, double>>::to_json(json & j, const std::variant<quicktype::Nonmutating, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Nonmutating>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::NsError, double>>::from_json(const json & j, std::variant<quicktype::NsError, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::NsError>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::NsError, double>>::to_json(json & j, const std::variant<quicktype::NsError, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::NsError>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::NsObject, double>>::from_json(const json & j, std::variant<quicktype::NsObject, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::NsObject>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::NsObject, double>>::to_json(json & j, const std::variant<quicktype::NsObject, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::NsObject>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::NsString, double>>::from_json(const json & j, std::variant<quicktype::NsString, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::NsString>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::NsString, double>>::to_json(json & j, const std::variant<quicktype::NsString, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::NsString>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Null, double>>::from_json(const json & j, std::variant<quicktype::Null, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Null>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Null, double>>::to_json(json & j, const std::variant<quicktype::Null, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Null>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::NullNode, double>>::from_json(const json & j, std::variant<quicktype::NullNode, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::NullNode>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::NullNode, double>>::to_json(json & j, const std::variant<quicktype::NullNode, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::NullNode>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Number, double>>::from_json(const json & j, std::variant<quicktype::Number, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Number>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Number, double>>::to_json(json & j, const std::variant<quicktype::Number, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Number>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Object, double>>::from_json(const json & j, std::variant<quicktype::Object, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Object>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Object, double>>::to_json(json & j, const std::variant<quicktype::Object, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Object>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ObjectMapper, double>>::from_json(const json & j, std::variant<quicktype::ObjectMapper, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::ObjectMapper>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ObjectMapper, double>>::to_json(json & j, const std::variant<quicktype::ObjectMapper, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ObjectMapper>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ObjectNode, double>>::from_json(const json & j, std::variant<quicktype::ObjectNode, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::ObjectNode>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ObjectNode, double>>::to_json(json & j, const std::variant<quicktype::ObjectNode, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ObjectNode>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ObjectReader, double>>::from_json(const json & j, std::variant<quicktype::ObjectReader, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::ObjectReader>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ObjectReader, double>>::to_json(json & j, const std::variant<quicktype::ObjectReader, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ObjectReader>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ObjectWriter, double>>::from_json(const json & j, std::variant<quicktype::ObjectWriter, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::ObjectWriter>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ObjectWriter, double>>::to_json(json & j, const std::variant<quicktype::ObjectWriter, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ObjectWriter>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Of, double>>::from_json(const json & j, std::variant<quicktype::Of, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Of>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Of, double>>::to_json(json & j, const std::variant<quicktype::Of, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Of>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::OffsetDateTime, double>>::from_json(const json & j, std::variant<quicktype::OffsetDateTime, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::OffsetDateTime>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::OffsetDateTime, double>>::to_json(json & j, const std::variant<quicktype::OffsetDateTime, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::OffsetDateTime>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::OffsetTime, double>>::from_json(const json & j, std::variant<quicktype::OffsetTime, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::OffsetTime>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::OffsetTime, double>>::to_json(json & j, const std::variant<quicktype::OffsetTime, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::OffsetTime>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Oneway, double>>::from_json(const json & j, std::variant<quicktype::Oneway, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Oneway>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Oneway, double>>::to_json(json & j, const std::variant<quicktype::Oneway, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Oneway>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Open, double>>::from_json(const json & j, std::variant<quicktype::Open, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Open>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Open, double>>::to_json(json & j, const std::variant<quicktype::Open, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Open>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Optional, double>>::from_json(const json & j, std::variant<quicktype::Optional, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Optional>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Optional, double>>::to_json(json & j, const std::variant<quicktype::Optional, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Optional>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Out, double>>::from_json(const json & j, std::variant<quicktype::Out, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Out>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Out, double>>::to_json(json & j, const std::variant<quicktype::Out, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Out>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Package, double>>::from_json(const json & j, std::variant<quicktype::Package, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Package>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Package, double>>::to_json(json & j, const std::variant<quicktype::Package, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Package>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Params, double>>::from_json(const json & j, std::variant<quicktype::Params, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Params>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Params, double>>::to_json(json & j, const std::variant<quicktype::Params, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Params>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Pass, double>>::from_json(const json & j, std::variant<quicktype::Pass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Pass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Pass, double>>::to_json(json & j, const std::variant<quicktype::Pass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Pass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Port, double>>::from_json(const json & j, std::variant<quicktype::Port, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Port>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Port, double>>::to_json(json & j, const std::variant<quicktype::Port, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Port>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Postfix, double>>::from_json(const json & j, std::variant<quicktype::Postfix, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Postfix>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Postfix, double>>::to_json(json & j, const std::variant<quicktype::Postfix, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Postfix>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Precedence, double>>::from_json(const json & j, std::variant<quicktype::Precedence, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Precedence>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Precedence, double>>::to_json(json & j, const std::variant<quicktype::Precedence, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Precedence>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Prefix, double>>::from_json(const json & j, std::variant<quicktype::Prefix, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Prefix>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Prefix, double>>::to_json(json & j, const std::variant<quicktype::Prefix, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Prefix>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::PrimitiveKind, double>>::from_json(const json & j, std::variant<quicktype::PrimitiveKind, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::PrimitiveKind>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::PrimitiveKind, double>>::to_json(json & j, const std::variant<quicktype::PrimitiveKind, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::PrimitiveKind>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Print, double>>::from_json(const json & j, std::variant<quicktype::Print, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Print>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Print, double>>::to_json(json & j, const std::variant<quicktype::Print, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Print>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::PrintMembers, double>>::from_json(const json & j, std::variant<quicktype::PrintMembers, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::PrintMembers>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::PrintMembers, double>>::to_json(json & j, const std::variant<quicktype::PrintMembers, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::PrintMembers>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Printf, double>>::from_json(const json & j, std::variant<quicktype::Printf, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Printf>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Printf, double>>::to_json(json & j, const std::variant<quicktype::Printf, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Printf>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Protocol, double>>::from_json(const json & j, std::variant<quicktype::Protocol, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Protocol>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Protocol, double>>::to_json(json & j, const std::variant<quicktype::Protocol, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Protocol>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::BoolClass, double>>::from_json(const json & j, std::variant<quicktype::BoolClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::BoolClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::BoolClass, double>>::to_json(json & j, const std::variant<quicktype::BoolClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::BoolClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ClassClass, double>>::from_json(const json & j, std::variant<quicktype::ClassClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::ClassClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ClassClass, double>>::to_json(json & j, const std::variant<quicktype::ClassClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ClassClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::FalseClass, double>>::from_json(const json & j, std::variant<quicktype::FalseClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::FalseClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::FalseClass, double>>::to_json(json & j, const std::variant<quicktype::FalseClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::FalseClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::TrueClass, double>>::from_json(const json & j, std::variant<quicktype::TrueClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::TrueClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::TrueClass, double>>::to_json(json & j, const std::variant<quicktype::TrueClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::TrueClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Quicktype, double>>::from_json(const json & j, std::variant<quicktype::Quicktype, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Quicktype>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Quicktype, double>>::to_json(json & j, const std::variant<quicktype::Quicktype, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Quicktype>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Raise, double>>::from_json(const json & j, std::variant<quicktype::Raise, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Raise>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Raise, double>>::to_json(json & j, const std::variant<quicktype::Raise, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Raise>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Range, double>>::from_json(const json & j, std::variant<quicktype::Range, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Range>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Range, double>>::to_json(json & j, const std::variant<quicktype::Range, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Range>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Readonly, double>>::from_json(const json & j, std::variant<quicktype::Readonly, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Readonly>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Readonly, double>>::to_json(json & j, const std::variant<quicktype::Readonly, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Readonly>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Ref, double>>::from_json(const json & j, std::variant<quicktype::Ref, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Ref>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Ref, double>>::to_json(json & j, const std::variant<quicktype::Ref, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Ref>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::RegExp, double>>::from_json(const json & j, std::variant<quicktype::RegExp, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::RegExp>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::RegExp, double>>::to_json(json & j, const std::variant<quicktype::RegExp, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::RegExp>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Repeat, double>>::from_json(const json & j, std::variant<quicktype::Repeat, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Repeat>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Repeat, double>>::to_json(json & j, const std::variant<quicktype::Repeat, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Repeat>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Require, double>>::from_json(const json & j, std::variant<quicktype::Require, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Require>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Require, double>>::to_json(json & j, const std::variant<quicktype::Require, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Require>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Required, double>>::from_json(const json & j, std::variant<quicktype::Required, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Required>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Required, double>>::to_json(json & j, const std::variant<quicktype::Required, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Required>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Restrict, double>>::from_json(const json & j, std::variant<quicktype::Restrict, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Restrict>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Restrict, double>>::to_json(json & j, const std::variant<quicktype::Restrict, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Restrict>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Retain, double>>::from_json(const json & j, std::variant<quicktype::Retain, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Retain>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Retain, double>>::to_json(json & j, const std::variant<quicktype::Retain, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Retain>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Rethrows, double>>::from_json(const json & j, std::variant<quicktype::Rethrows, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Rethrows>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Rethrows, double>>::to_json(json & j, const std::variant<quicktype::Rethrows, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Rethrows>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Right, double>>::from_json(const json & j, std::variant<quicktype::Right, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Right>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Right, double>>::to_json(json & j, const std::variant<quicktype::Right, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Right>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::RuntimeType, double>>::from_json(const json & j, std::variant<quicktype::RuntimeType, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::RuntimeType>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::RuntimeType, double>>::to_json(json & j, const std::variant<quicktype::RuntimeType, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::RuntimeType>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::S, double>>::from_json(const json & j, std::variant<quicktype::S, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::S>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::S, double>>::to_json(json & j, const std::variant<quicktype::S, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::S>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Sbyte, double>>::from_json(const json & j, std::variant<quicktype::Sbyte, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Sbyte>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Sbyte, double>>::to_json(json & j, const std::variant<quicktype::Sbyte, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Sbyte>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Sealed, double>>::from_json(const json & j, std::variant<quicktype::Sealed, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Sealed>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Sealed, double>>::to_json(json & j, const std::variant<quicktype::Sealed, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Sealed>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Sel, double>>::from_json(const json & j, std::variant<quicktype::Sel, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Sel>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Sel, double>>::to_json(json & j, const std::variant<quicktype::Sel, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Sel>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Select, double>>::from_json(const json & j, std::variant<quicktype::Select, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Select>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Select, double>>::to_json(json & j, const std::variant<quicktype::Select, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Select>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Self, double>>::from_json(const json & j, std::variant<quicktype::Self, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Self>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Self, double>>::to_json(json & j, const std::variant<quicktype::Self, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Self>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Sendable, double>>::from_json(const json & j, std::variant<quicktype::Sendable, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Sendable>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Sendable, double>>::to_json(json & j, const std::variant<quicktype::Sendable, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Sendable>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::SerialDescriptor, double>>::from_json(const json & j, std::variant<quicktype::SerialDescriptor, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::SerialDescriptor>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::SerialDescriptor, double>>::to_json(json & j, const std::variant<quicktype::SerialDescriptor, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::SerialDescriptor>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::SerialName, double>>::from_json(const json & j, std::variant<quicktype::SerialName, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::SerialName>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::SerialName, double>>::to_json(json & j, const std::variant<quicktype::SerialName, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::SerialName>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Serializable, double>>::from_json(const json & j, std::variant<quicktype::Serializable, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Serializable>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Serializable, double>>::to_json(json & j, const std::variant<quicktype::Serializable, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Serializable>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::SerializationFeature, double>>::from_json(const json & j, std::variant<quicktype::SerializationFeature, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::SerializationFeature>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::SerializationFeature, double>>::to_json(json & j, const std::variant<quicktype::SerializationFeature, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::SerializationFeature>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Serialize, double>>::from_json(const json & j, std::variant<quicktype::Serialize, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Serialize>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Serialize, double>>::to_json(json & j, const std::variant<quicktype::Serialize, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Serialize>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::SerializerProvider, double>>::from_json(const json & j, std::variant<quicktype::SerializerProvider, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::SerializerProvider>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::SerializerProvider, double>>::to_json(json & j, const std::variant<quicktype::SerializerProvider, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::SerializerProvider>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Set, double>>::from_json(const json & j, std::variant<quicktype::Set, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Set>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Set, double>>::to_json(json & j, const std::variant<quicktype::Set, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Set>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::SimpleModule, double>>::from_json(const json & j, std::variant<quicktype::SimpleModule, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::SimpleModule>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::SimpleModule, double>>::to_json(json & j, const std::variant<quicktype::SimpleModule, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::SimpleModule>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Stackalloc, double>>::from_json(const json & j, std::variant<quicktype::Stackalloc, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Stackalloc>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Stackalloc, double>>::to_json(json & j, const std::variant<quicktype::Stackalloc, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Stackalloc>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Standards, double>>::from_json(const json & j, std::variant<quicktype::Standards, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Standards>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Standards, double>>::to_json(json & j, const std::variant<quicktype::Standards, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Standards>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::StdDeserializer, double>>::from_json(const json & j, std::variant<quicktype::StdDeserializer, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::StdDeserializer>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::StdDeserializer, double>>::to_json(json & j, const std::variant<quicktype::StdDeserializer, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::StdDeserializer>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::StdSerializer, double>>::from_json(const json & j, std::variant<quicktype::StdSerializer, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::StdSerializer>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::StdSerializer, double>>::to_json(json & j, const std::variant<quicktype::StdSerializer, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::StdSerializer>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Strictfp, double>>::from_json(const json & j, std::variant<quicktype::Strictfp, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Strictfp>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Strictfp, double>>::to_json(json & j, const std::variant<quicktype::Strictfp, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Strictfp>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::String, double>>::from_json(const json & j, std::variant<quicktype::String, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::String>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::String, double>>::to_json(json & j, const std::variant<quicktype::String, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::String>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Subscript, double>>::from_json(const json & j, std::variant<quicktype::Subscript, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Subscript>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Subscript, double>>::to_json(json & j, const std::variant<quicktype::Subscript, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Subscript>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Super, double>>::from_json(const json & j, std::variant<quicktype::Super, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Super>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Super, double>>::to_json(json & j, const std::variant<quicktype::Super, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Super>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Symbol, double>>::from_json(const json & j, std::variant<quicktype::Symbol, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Symbol>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Symbol, double>>::to_json(json & j, const std::variant<quicktype::Symbol, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Symbol>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::System, double>>::from_json(const json & j, std::variant<quicktype::System, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::System>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::System, double>>::to_json(json & j, const std::variant<quicktype::System, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::System>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::TextNode, double>>::from_json(const json & j, std::variant<quicktype::TextNode, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::TextNode>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::TextNode, double>>::to_json(json & j, const std::variant<quicktype::TextNode, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::TextNode>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Then, double>>::from_json(const json & j, std::variant<quicktype::Then, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Then>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Then, double>>::to_json(json & j, const std::variant<quicktype::Then, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Then>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Throws, double>>::from_json(const json & j, std::variant<quicktype::Throws, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Throws>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Throws, double>>::to_json(json & j, const std::variant<quicktype::Throws, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Throws>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::TimeOnly, double>>::from_json(const json & j, std::variant<quicktype::TimeOnly, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::TimeOnly>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::TimeOnly, double>>::to_json(json & j, const std::variant<quicktype::TimeOnly, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::TimeOnly>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::TimeOnlyConverter, double>>::from_json(const json & j, std::variant<quicktype::TimeOnlyConverter, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::TimeOnlyConverter>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::TimeOnlyConverter, double>>::to_json(json & j, const std::variant<quicktype::TimeOnlyConverter, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::TimeOnlyConverter>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::TimeZone, double>>::from_json(const json & j, std::variant<quicktype::TimeZone, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::TimeZone>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::TimeZone, double>>::to_json(json & j, const std::variant<quicktype::TimeZone, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::TimeZone>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ToDict, double>>::from_json(const json & j, std::variant<quicktype::ToDict, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::ToDict>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ToDict, double>>::to_json(json & j, const std::variant<quicktype::ToDict, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ToDict>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ToJson, double>>::from_json(const json & j, std::variant<quicktype::ToJson, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::ToJson>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ToJson, double>>::to_json(json & j, const std::variant<quicktype::ToJson, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ToJson>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ToString, double>>::from_json(const json & j, std::variant<quicktype::ToString, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::ToString>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ToString, double>>::to_json(json & j, const std::variant<quicktype::ToString, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ToString>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::TopLevelClass, double>>::from_json(const json & j, std::variant<quicktype::TopLevelClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::TopLevelClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::TopLevelClass, double>>::to_json(json & j, const std::variant<quicktype::TopLevelClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::TopLevelClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Alignas, double>>::from_json(const json & j, std::variant<quicktype::Alignas, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Alignas>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Alignas, double>>::to_json(json & j, const std::variant<quicktype::Alignas, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Alignas>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Alignof, double>>::from_json(const json & j, std::variant<quicktype::Alignof, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Alignof>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Alignof, double>>::to_json(json & j, const std::variant<quicktype::Alignof, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Alignof>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::And, double>>::from_json(const json & j, std::variant<quicktype::And, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::And>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::And, double>>::to_json(json & j, const std::variant<quicktype::And, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::And>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::AndEq, double>>::from_json(const json & j, std::variant<quicktype::AndEq, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::AndEq>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::AndEq, double>>::to_json(json & j, const std::variant<quicktype::AndEq, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::AndEq>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::AnyClass, double>>::from_json(const json & j, std::variant<quicktype::AnyClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::AnyClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::AnyClass, double>>::to_json(json & j, const std::variant<quicktype::AnyClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::AnyClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Asm, double>>::from_json(const json & j, std::variant<quicktype::Asm, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Asm>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Asm, double>>::to_json(json & j, const std::variant<quicktype::Asm, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Asm>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::AtomicCancel, double>>::from_json(const json & j, std::variant<quicktype::AtomicCancel, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::AtomicCancel>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::AtomicCancel, double>>::to_json(json & j, const std::variant<quicktype::AtomicCancel, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::AtomicCancel>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::AtomicCommit, double>>::from_json(const json & j, std::variant<quicktype::AtomicCommit, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::AtomicCommit>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::AtomicCommit, double>>::to_json(json & j, const std::variant<quicktype::AtomicCommit, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::AtomicCommit>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::AtomicNoexcept, double>>::from_json(const json & j, std::variant<quicktype::AtomicNoexcept, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::AtomicNoexcept>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::AtomicNoexcept, double>>::to_json(json & j, const std::variant<quicktype::AtomicNoexcept, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::AtomicNoexcept>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Auto, double>>::from_json(const json & j, std::variant<quicktype::Auto, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Auto>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Auto, double>>::to_json(json & j, const std::variant<quicktype::Auto, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Auto>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Bitand, double>>::from_json(const json & j, std::variant<quicktype::Bitand, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Bitand>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Bitand, double>>::to_json(json & j, const std::variant<quicktype::Bitand, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Bitand>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Bitor, double>>::from_json(const json & j, std::variant<quicktype::Bitor, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Bitor>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Bitor, double>>::to_json(json & j, const std::variant<quicktype::Bitor, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Bitor>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Bool, double>>::from_json(const json & j, std::variant<quicktype::Bool, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Bool>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Bool, double>>::to_json(json & j, const std::variant<quicktype::Bool, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Bool>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Break, double>>::from_json(const json & j, std::variant<quicktype::Break, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Break>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Break, double>>::to_json(json & j, const std::variant<quicktype::Break, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Break>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Case, double>>::from_json(const json & j, std::variant<quicktype::Case, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Case>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Case, double>>::to_json(json & j, const std::variant<quicktype::Case, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Case>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Catch, double>>::from_json(const json & j, std::variant<quicktype::Catch, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Catch>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Catch, double>>::to_json(json & j, const std::variant<quicktype::Catch, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Catch>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Char, double>>::from_json(const json & j, std::variant<quicktype::Char, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Char>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Char, double>>::to_json(json & j, const std::variant<quicktype::Char, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Char>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Char16T, double>>::from_json(const json & j, std::variant<quicktype::Char16T, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Char16T>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Char16T, double>>::to_json(json & j, const std::variant<quicktype::Char16T, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Char16T>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Char32T, double>>::from_json(const json & j, std::variant<quicktype::Char32T, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Char32T>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Char32T, double>>::to_json(json & j, const std::variant<quicktype::Char32T, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Char32T>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Class, double>>::from_json(const json & j, std::variant<quicktype::Class, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Class>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Class, double>>::to_json(json & j, const std::variant<quicktype::Class, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Class>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::CoAwait, double>>::from_json(const json & j, std::variant<quicktype::CoAwait, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::CoAwait>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CoAwait, double>>::to_json(json & j, const std::variant<quicktype::CoAwait, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::CoAwait>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::CoReturn, double>>::from_json(const json & j, std::variant<quicktype::CoReturn, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::CoReturn>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CoReturn, double>>::to_json(json & j, const std::variant<quicktype::CoReturn, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::CoReturn>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::CoYield, double>>::from_json(const json & j, std::variant<quicktype::CoYield, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::CoYield>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CoYield, double>>::to_json(json & j, const std::variant<quicktype::CoYield, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::CoYield>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Compl, double>>::from_json(const json & j, std::variant<quicktype::Compl, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Compl>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Compl, double>>::to_json(json & j, const std::variant<quicktype::Compl, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Compl>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Concept, double>>::from_json(const json & j, std::variant<quicktype::Concept, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Concept>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Concept, double>>::to_json(json & j, const std::variant<quicktype::Concept, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Concept>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Const, double>>::from_json(const json & j, std::variant<quicktype::Const, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Const>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Const, double>>::to_json(json & j, const std::variant<quicktype::Const, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Const>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ConstCast, double>>::from_json(const json & j, std::variant<quicktype::ConstCast, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::ConstCast>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ConstCast, double>>::to_json(json & j, const std::variant<quicktype::ConstCast, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ConstCast>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Constexpr, double>>::from_json(const json & j, std::variant<quicktype::Constexpr, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Constexpr>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Constexpr, double>>::to_json(json & j, const std::variant<quicktype::Constexpr, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Constexpr>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Continue, double>>::from_json(const json & j, std::variant<quicktype::Continue, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Continue>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Continue, double>>::to_json(json & j, const std::variant<quicktype::Continue, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Continue>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Decltype, double>>::from_json(const json & j, std::variant<quicktype::Decltype, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Decltype>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Decltype, double>>::to_json(json & j, const std::variant<quicktype::Decltype, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Decltype>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Default, double>>::from_json(const json & j, std::variant<quicktype::Default, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Default>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Default, double>>::to_json(json & j, const std::variant<quicktype::Default, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Default>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Delete, double>>::from_json(const json & j, std::variant<quicktype::Delete, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Delete>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Delete, double>>::to_json(json & j, const std::variant<quicktype::Delete, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Delete>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Do, double>>::from_json(const json & j, std::variant<quicktype::Do, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Do>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Do, double>>::to_json(json & j, const std::variant<quicktype::Do, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Do>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Double, double>>::from_json(const json & j, std::variant<quicktype::Double, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Double>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Double, double>>::to_json(json & j, const std::variant<quicktype::Double, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Double>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DynamicCast, double>>::from_json(const json & j, std::variant<quicktype::DynamicCast, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::DynamicCast>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DynamicCast, double>>::to_json(json & j, const std::variant<quicktype::DynamicCast, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DynamicCast>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Else, double>>::from_json(const json & j, std::variant<quicktype::Else, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Else>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Else, double>>::to_json(json & j, const std::variant<quicktype::Else, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Else>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Enum, double>>::from_json(const json & j, std::variant<quicktype::Enum, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Enum>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Enum, double>>::to_json(json & j, const std::variant<quicktype::Enum, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Enum>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Explicit, double>>::from_json(const json & j, std::variant<quicktype::Explicit, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Explicit>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Explicit, double>>::to_json(json & j, const std::variant<quicktype::Explicit, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Explicit>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Export, double>>::from_json(const json & j, std::variant<quicktype::Export, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Export>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Export, double>>::to_json(json & j, const std::variant<quicktype::Export, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Export>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Extern, double>>::from_json(const json & j, std::variant<quicktype::Extern, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Extern>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Extern, double>>::to_json(json & j, const std::variant<quicktype::Extern, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Extern>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::False, double>>::from_json(const json & j, std::variant<quicktype::False, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::False>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::False, double>>::to_json(json & j, const std::variant<quicktype::False, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::False>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Final, double>>::from_json(const json & j, std::variant<quicktype::Final, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Final>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Final, double>>::to_json(json & j, const std::variant<quicktype::Final, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Final>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Float, double>>::from_json(const json & j, std::variant<quicktype::Float, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Float>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Float, double>>::to_json(json & j, const std::variant<quicktype::Float, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Float>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::For, double>>::from_json(const json & j, std::variant<quicktype::For, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::For>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::For, double>>::to_json(json & j, const std::variant<quicktype::For, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::For>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Friend, double>>::from_json(const json & j, std::variant<quicktype::Friend, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Friend>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Friend, double>>::to_json(json & j, const std::variant<quicktype::Friend, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Friend>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Goto, double>>::from_json(const json & j, std::variant<quicktype::Goto, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Goto>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Goto, double>>::to_json(json & j, const std::variant<quicktype::Goto, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Goto>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::If, double>>::from_json(const json & j, std::variant<quicktype::If, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::If>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::If, double>>::to_json(json & j, const std::variant<quicktype::If, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::If>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Import, double>>::from_json(const json & j, std::variant<quicktype::Import, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Import>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Import, double>>::to_json(json & j, const std::variant<quicktype::Import, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Import>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Inline, double>>::from_json(const json & j, std::variant<quicktype::Inline, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Inline>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Inline, double>>::to_json(json & j, const std::variant<quicktype::Inline, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Inline>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Int, double>>::from_json(const json & j, std::variant<quicktype::Int, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Int>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Int, double>>::to_json(json & j, const std::variant<quicktype::Int, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Int>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Long, double>>::from_json(const json & j, std::variant<quicktype::Long, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Long>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Long, double>>::to_json(json & j, const std::variant<quicktype::Long, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Long>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Module, double>>::from_json(const json & j, std::variant<quicktype::Module, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Module>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Module, double>>::to_json(json & j, const std::variant<quicktype::Module, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Module>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Mutable, double>>::from_json(const json & j, std::variant<quicktype::Mutable, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Mutable>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Mutable, double>>::to_json(json & j, const std::variant<quicktype::Mutable, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Mutable>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Namespace, double>>::from_json(const json & j, std::variant<quicktype::Namespace, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Namespace>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Namespace, double>>::to_json(json & j, const std::variant<quicktype::Namespace, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Namespace>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::New, double>>::from_json(const json & j, std::variant<quicktype::New, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::New>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::New, double>>::to_json(json & j, const std::variant<quicktype::New, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::New>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Noexcept, double>>::from_json(const json & j, std::variant<quicktype::Noexcept, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Noexcept>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Noexcept, double>>::to_json(json & j, const std::variant<quicktype::Noexcept, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Noexcept>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::NoneClass, double>>::from_json(const json & j, std::variant<quicktype::NoneClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::NoneClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::NoneClass, double>>::to_json(json & j, const std::variant<quicktype::NoneClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::NoneClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Not, double>>::from_json(const json & j, std::variant<quicktype::Not, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Not>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Not, double>>::to_json(json & j, const std::variant<quicktype::Not, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Not>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::NotEq, double>>::from_json(const json & j, std::variant<quicktype::NotEq, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::NotEq>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::NotEq, double>>::to_json(json & j, const std::variant<quicktype::NotEq, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::NotEq>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::NullClass, double>>::from_json(const json & j, std::variant<quicktype::NullClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::NullClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::NullClass, double>>::to_json(json & j, const std::variant<quicktype::NullClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::NullClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Nullptr, double>>::from_json(const json & j, std::variant<quicktype::Nullptr, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Nullptr>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Nullptr, double>>::to_json(json & j, const std::variant<quicktype::Nullptr, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Nullptr>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Operator, double>>::from_json(const json & j, std::variant<quicktype::Operator, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Operator>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Operator, double>>::to_json(json & j, const std::variant<quicktype::Operator, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Operator>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Or, double>>::from_json(const json & j, std::variant<quicktype::Or, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Or>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Or, double>>::to_json(json & j, const std::variant<quicktype::Or, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Or>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::OrEq, double>>::from_json(const json & j, std::variant<quicktype::OrEq, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::OrEq>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::OrEq, double>>::to_json(json & j, const std::variant<quicktype::OrEq, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::OrEq>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Override, double>>::from_json(const json & j, std::variant<quicktype::Override, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Override>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Override, double>>::to_json(json & j, const std::variant<quicktype::Override, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Override>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Private, double>>::from_json(const json & j, std::variant<quicktype::Private, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Private>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Private, double>>::to_json(json & j, const std::variant<quicktype::Private, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Private>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Protected, double>>::from_json(const json & j, std::variant<quicktype::Protected, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Protected>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Protected, double>>::to_json(json & j, const std::variant<quicktype::Protected, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Protected>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ProtocolClass, double>>::from_json(const json & j, std::variant<quicktype::ProtocolClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::ProtocolClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ProtocolClass, double>>::to_json(json & j, const std::variant<quicktype::ProtocolClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ProtocolClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Public, double>>::from_json(const json & j, std::variant<quicktype::Public, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Public>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Public, double>>::to_json(json & j, const std::variant<quicktype::Public, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Public>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Register, double>>::from_json(const json & j, std::variant<quicktype::Register, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Register>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Register, double>>::to_json(json & j, const std::variant<quicktype::Register, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Register>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ReinterpretCast, double>>::from_json(const json & j, std::variant<quicktype::ReinterpretCast, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::ReinterpretCast>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ReinterpretCast, double>>::to_json(json & j, const std::variant<quicktype::ReinterpretCast, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ReinterpretCast>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Requires, double>>::from_json(const json & j, std::variant<quicktype::Requires, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Requires>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Requires, double>>::to_json(json & j, const std::variant<quicktype::Requires, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Requires>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Return, double>>::from_json(const json & j, std::variant<quicktype::Return, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Return>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Return, double>>::to_json(json & j, const std::variant<quicktype::Return, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Return>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::SelfClass, double>>::from_json(const json & j, std::variant<quicktype::SelfClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::SelfClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::SelfClass, double>>::to_json(json & j, const std::variant<quicktype::SelfClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::SelfClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Short, double>>::from_json(const json & j, std::variant<quicktype::Short, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Short>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Short, double>>::to_json(json & j, const std::variant<quicktype::Short, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Short>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Signed, double>>::from_json(const json & j, std::variant<quicktype::Signed, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Signed>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Signed, double>>::to_json(json & j, const std::variant<quicktype::Signed, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Signed>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Sizeof, double>>::from_json(const json & j, std::variant<quicktype::Sizeof, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Sizeof>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Sizeof, double>>::to_json(json & j, const std::variant<quicktype::Sizeof, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Sizeof>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Static, double>>::from_json(const json & j, std::variant<quicktype::Static, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Static>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Static, double>>::to_json(json & j, const std::variant<quicktype::Static, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Static>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::StaticAssert, double>>::from_json(const json & j, std::variant<quicktype::StaticAssert, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::StaticAssert>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::StaticAssert, double>>::to_json(json & j, const std::variant<quicktype::StaticAssert, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::StaticAssert>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::StaticCast, double>>::from_json(const json & j, std::variant<quicktype::StaticCast, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::StaticCast>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::StaticCast, double>>::to_json(json & j, const std::variant<quicktype::StaticCast, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::StaticCast>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Struct, double>>::from_json(const json & j, std::variant<quicktype::Struct, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Struct>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Struct, double>>::to_json(json & j, const std::variant<quicktype::Struct, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Struct>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Switch, double>>::from_json(const json & j, std::variant<quicktype::Switch, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Switch>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Switch, double>>::to_json(json & j, const std::variant<quicktype::Switch, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Switch>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Synchronized, double>>::from_json(const json & j, std::variant<quicktype::Synchronized, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Synchronized>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Synchronized, double>>::to_json(json & j, const std::variant<quicktype::Synchronized, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Synchronized>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Template, double>>::from_json(const json & j, std::variant<quicktype::Template, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Template>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Template, double>>::to_json(json & j, const std::variant<quicktype::Template, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Template>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::This, double>>::from_json(const json & j, std::variant<quicktype::This, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::This>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::This, double>>::to_json(json & j, const std::variant<quicktype::This, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::This>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ThreadLocal, double>>::from_json(const json & j, std::variant<quicktype::ThreadLocal, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::ThreadLocal>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ThreadLocal, double>>::to_json(json & j, const std::variant<quicktype::ThreadLocal, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ThreadLocal>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Throw, double>>::from_json(const json & j, std::variant<quicktype::Throw, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Throw>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Throw, double>>::to_json(json & j, const std::variant<quicktype::Throw, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Throw>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::True, double>>::from_json(const json & j, std::variant<quicktype::True, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::True>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::True, double>>::to_json(json & j, const std::variant<quicktype::True, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::True>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Try, double>>::from_json(const json & j, std::variant<quicktype::Try, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Try>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Try, double>>::to_json(json & j, const std::variant<quicktype::Try, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Try>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::TypeClass, double>>::from_json(const json & j, std::variant<quicktype::TypeClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::TypeClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::TypeClass, double>>::to_json(json & j, const std::variant<quicktype::TypeClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::TypeClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Typedef, double>>::from_json(const json & j, std::variant<quicktype::Typedef, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Typedef>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Typedef, double>>::to_json(json & j, const std::variant<quicktype::Typedef, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Typedef>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Typeid, double>>::from_json(const json & j, std::variant<quicktype::Typeid, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Typeid>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Typeid, double>>::to_json(json & j, const std::variant<quicktype::Typeid, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Typeid>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Typename, double>>::from_json(const json & j, std::variant<quicktype::Typename, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Typename>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Typename, double>>::to_json(json & j, const std::variant<quicktype::Typename, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Typename>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Union, double>>::from_json(const json & j, std::variant<quicktype::Union, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Union>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Union, double>>::to_json(json & j, const std::variant<quicktype::Union, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Union>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Unsigned, double>>::from_json(const json & j, std::variant<quicktype::Unsigned, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Unsigned>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Unsigned, double>>::to_json(json & j, const std::variant<quicktype::Unsigned, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Unsigned>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Using, double>>::from_json(const json & j, std::variant<quicktype::Using, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Using>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Using, double>>::to_json(json & j, const std::variant<quicktype::Using, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Using>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Virtual, double>>::from_json(const json & j, std::variant<quicktype::Virtual, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Virtual>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Virtual, double>>::to_json(json & j, const std::variant<quicktype::Virtual, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Virtual>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Void, double>>::from_json(const json & j, std::variant<quicktype::Void, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Void>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Void, double>>::to_json(json & j, const std::variant<quicktype::Void, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Void>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Volatile, double>>::from_json(const json & j, std::variant<quicktype::Volatile, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Volatile>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Volatile, double>>::to_json(json & j, const std::variant<quicktype::Volatile, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Volatile>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::WcharT, double>>::from_json(const json & j, std::variant<quicktype::WcharT, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::WcharT>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::WcharT, double>>::to_json(json & j, const std::variant<quicktype::WcharT, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::WcharT>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::While, double>>::from_json(const json & j, std::variant<quicktype::While, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::While>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::While, double>>::to_json(json & j, const std::variant<quicktype::While, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::While>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Xor, double>>::from_json(const json & j, std::variant<quicktype::Xor, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Xor>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Xor, double>>::to_json(json & j, const std::variant<quicktype::Xor, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Xor>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::XorEq, double>>::from_json(const json & j, std::variant<quicktype::XorEq, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::XorEq>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::XorEq, double>>::to_json(json & j, const std::variant<quicktype::XorEq, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::XorEq>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Transient, double>>::from_json(const json & j, std::variant<quicktype::Transient, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Transient>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Transient, double>>::to_json(json & j, const std::variant<quicktype::Transient, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Transient>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Type, double>>::from_json(const json & j, std::variant<quicktype::Type, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Type>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Type, double>>::to_json(json & j, const std::variant<quicktype::Type, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Type>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Typealias, double>>::from_json(const json & j, std::variant<quicktype::Typealias, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Typealias>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Typealias, double>>::to_json(json & j, const std::variant<quicktype::Typealias, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Typealias>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Typeof, double>>::from_json(const json & j, std::variant<quicktype::Typeof, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Typeof>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Typeof, double>>::to_json(json & j, const std::variant<quicktype::Typeof, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Typeof>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Uint, double>>::from_json(const json & j, std::variant<quicktype::Uint, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Uint>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Uint, double>>::to_json(json & j, const std::variant<quicktype::Uint, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Uint>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Ulong, double>>::from_json(const json & j, std::variant<quicktype::Ulong, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Ulong>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Ulong, double>>::to_json(json & j, const std::variant<quicktype::Ulong, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Ulong>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Unchecked, double>>::from_json(const json & j, std::variant<quicktype::Unchecked, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Unchecked>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Unchecked, double>>::to_json(json & j, const std::variant<quicktype::Unchecked, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Unchecked>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Undefined, double>>::from_json(const json & j, std::variant<quicktype::Undefined, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Undefined>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Undefined, double>>::to_json(json & j, const std::variant<quicktype::Undefined, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Undefined>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::UnmarshalJson, double>>::from_json(const json & j, std::variant<quicktype::UnmarshalJson, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::UnmarshalJson>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::UnmarshalJson, double>>::to_json(json & j, const std::variant<quicktype::UnmarshalJson, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::UnmarshalJson>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Unowned, double>>::from_json(const json & j, std::variant<quicktype::Unowned, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Unowned>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Unowned, double>>::to_json(json & j, const std::variant<quicktype::Unowned, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Unowned>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Unsafe, double>>::from_json(const json & j, std::variant<quicktype::Unsafe, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Unsafe>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Unsafe, double>>::to_json(json & j, const std::variant<quicktype::Unsafe, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Unsafe>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::UseSerializers, double>>::from_json(const json & j, std::variant<quicktype::UseSerializers, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::UseSerializers>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::UseSerializers, double>>::to_json(json & j, const std::variant<quicktype::UseSerializers, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::UseSerializers>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Ushort, double>>::from_json(const json & j, std::variant<quicktype::Ushort, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Ushort>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Ushort, double>>::to_json(json & j, const std::variant<quicktype::Ushort, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Ushort>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Utf8JsonReader, double>>::from_json(const json & j, std::variant<quicktype::Utf8JsonReader, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Utf8JsonReader>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Utf8JsonReader, double>>::to_json(json & j, const std::variant<quicktype::Utf8JsonReader, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Utf8JsonReader>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Utf8JsonWriter, double>>::from_json(const json & j, std::variant<quicktype::Utf8JsonWriter, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Utf8JsonWriter>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Utf8JsonWriter, double>>::to_json(json & j, const std::variant<quicktype::Utf8JsonWriter, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Utf8JsonWriter>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Uuid, double>>::from_json(const json & j, std::variant<quicktype::Uuid, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Uuid>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Uuid, double>>::to_json(json & j, const std::variant<quicktype::Uuid, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Uuid>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Var, double>>::from_json(const json & j, std::variant<quicktype::Var, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Var>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Var, double>>::to_json(json & j, const std::variant<quicktype::Var, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Var>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Weak, double>>::from_json(const json & j, std::variant<quicktype::Weak, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Weak>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Weak, double>>::to_json(json & j, const std::variant<quicktype::Weak, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Weak>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Where, double>>::from_json(const json & j, std::variant<quicktype::Where, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Where>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Where, double>>::to_json(json & j, const std::variant<quicktype::Where, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Where>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::WillSet, double>>::from_json(const json & j, std::variant<quicktype::WillSet, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::WillSet>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::WillSet, double>>::to_json(json & j, const std::variant<quicktype::WillSet, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::WillSet>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::With, double>>::from_json(const json & j, std::variant<quicktype::With, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::With>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::With, double>>::to_json(json & j, const std::variant<quicktype::With, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::With>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Yes, double>>::from_json(const json & j, std::variant<quicktype::Yes, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Yes>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Yes, double>>::to_json(json & j, const std::variant<quicktype::Yes, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Yes>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Yield, double>>::from_json(const json & j, std::variant<quicktype::Yield, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Yield>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Yield, double>>::to_json(json & j, const std::variant<quicktype::Yield, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Yield>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
