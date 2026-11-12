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

    class PurpleComment {
        public:
        PurpleComment() = default;
        virtual ~PurpleComment() = default;

        private:
        std::string short_text;

        public:
        const std::string & get_short_text() const { return short_text; }
        std::string & get_mutable_short_text() { return short_text; }
        void set_short_text(const std::string & value) { this->short_text = value; }
    };

    class PurpleFlags {
        public:
        PurpleFlags() = default;
        virtual ~PurpleFlags() = default;

        private:
        std::optional<bool> is_exported;

        public:
        const std::optional<bool> & get_is_exported() const { return is_exported; }
        std::optional<bool> & get_mutable_is_exported() { return is_exported; }
        void set_is_exported(const std::optional<bool> & value) { this->is_exported = value; }
    };

    enum class PurpleKindString : int { VARIABLE, FUNCTION, PROPERTY, METHOD, CONSTRUCTOR, ACCESSOR, ENUMERATION_MEMBER, MODULE, OBJECT_LITERAL };

    class GetSignatureFlags {
        public:
        GetSignatureFlags() = default;
        virtual ~GetSignatureFlags() = default;

        private:

        public:
    };

    enum class SignatureKindString : int { CALL_SIGNATURE, CONSTRUCTOR_SIGNATURE };

    enum class Name : int { STRING, NUMBER, VOID, T, BOOLEAN, BASE_CLASS, ANY, ARRAY, MY_NUMBER };

    enum class TypeEnum : int { INTRINSIC, REFLECTION, ARRAY, REFERENCE, TYPE_PARAMETER, TUPLE, UNION, STRING_LITERAL };

    class ElementType {
        public:
        ElementType() = default;
        virtual ~ElementType() = default;

        private:
        Name name;
        TypeEnum type;

        public:
        const Name & get_name() const { return name; }
        Name & get_mutable_name() { return name; }
        void set_name(const Name & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }
    };

    class FluffyComment {
        public:
        FluffyComment() = default;
        virtual ~FluffyComment() = default;

        private:
        std::string text;

        public:
        const std::string & get_text() const { return text; }
        std::string & get_mutable_text() { return text; }
        void set_text(const std::string & value) { this->text = value; }
    };

    class FluffyFlags {
        public:
        FluffyFlags() = default;
        virtual ~FluffyFlags() = default;

        private:
        std::optional<bool> is_optional;

        public:
        const std::optional<bool> & get_is_optional() const { return is_optional; }
        std::optional<bool> & get_mutable_is_optional() { return is_optional; }
        void set_is_optional(const std::optional<bool> & value) { this->is_optional = value; }
    };

    enum class FileName : int { MODULES_TS, CLASSES_TS, FLATTENED_TS, ACCESS_TS, DEFAULT_EXPORT_TS, ENUMERATIONS_TS, FUNCTIONS_TS, GENERICS_TS, SINGLE_EXPORT_TS, TYPESCRIPT_13_TS, TYPESCRIPT_14_TS, TYPESCRIPT_15_TS, VARIABLES_TS };

    class Source {
        public:
        Source() = default;
        virtual ~Source() = default;

        private:
        int64_t character;
        FileName file_name;
        int64_t line;

        public:
        const int64_t & get_character() const { return character; }
        int64_t & get_mutable_character() { return character; }
        void set_character(const int64_t & value) { this->character = value; }

        const FileName & get_file_name() const { return file_name; }
        FileName & get_mutable_file_name() { return file_name; }
        void set_file_name(const FileName & value) { this->file_name = value; }

        const int64_t & get_line() const { return line; }
        int64_t & get_mutable_line() { return line; }
        void set_line(const int64_t & value) { this->line = value; }
    };

    class GetSignatureComment {
        public:
        GetSignatureComment() = default;
        virtual ~GetSignatureComment() = default;

        private:
        std::optional<std::string> returns;
        std::optional<std::string> short_text;
        std::optional<std::string> text;

        public:
        const std::optional<std::string> & get_returns() const { return returns; }
        std::optional<std::string> & get_mutable_returns() { return returns; }
        void set_returns(const std::optional<std::string> & value) { this->returns = value; }

        const std::optional<std::string> & get_short_text() const { return short_text; }
        std::optional<std::string> & get_mutable_short_text() { return short_text; }
        void set_short_text(const std::optional<std::string> & value) { this->short_text = value; }

        const std::optional<std::string> & get_text() const { return text; }
        std::optional<std::string> & get_mutable_text() { return text; }
        void set_text(const std::optional<std::string> & value) { this->text = value; }
    };

    class Group {
        public:
        Group() = default;
        virtual ~Group() = default;

        private:
        std::vector<int64_t> children;
        int64_t kind;
        std::string title;

        public:
        const std::vector<int64_t> & get_children() const { return children; }
        std::vector<int64_t> & get_mutable_children() { return children; }
        void set_children(const std::vector<int64_t> & value) { this->children = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }
    };

    class TentacledComment {
        public:
        TentacledComment() = default;
        virtual ~TentacledComment() = default;

        private:
        std::optional<std::string> short_text;
        std::optional<std::string> text;

        public:
        const std::optional<std::string> & get_short_text() const { return short_text; }
        std::optional<std::string> & get_mutable_short_text() { return short_text; }
        void set_short_text(const std::optional<std::string> & value) { this->short_text = value; }

        const std::optional<std::string> & get_text() const { return text; }
        std::optional<std::string> & get_mutable_text() { return text; }
        void set_text(const std::optional<std::string> & value) { this->text = value; }
    };

    class TentacledFlags {
        public:
        TentacledFlags() = default;
        virtual ~TentacledFlags() = default;

        private:
        std::optional<bool> is_optional;
        std::optional<bool> is_rest;

        public:
        const std::optional<bool> & get_is_optional() const { return is_optional; }
        std::optional<bool> & get_mutable_is_optional() { return is_optional; }
        void set_is_optional(const std::optional<bool> & value) { this->is_optional = value; }

        const std::optional<bool> & get_is_rest() const { return is_rest; }
        std::optional<bool> & get_mutable_is_rest() { return is_rest; }
        void set_is_rest(const std::optional<bool> & value) { this->is_rest = value; }
    };

    enum class ParameterKindString : int { PARAMETER };

    class FluffyType {
        public:
        FluffyType() = default;
        virtual ~FluffyType() = default;

        private:
        std::optional<ElementType> element_type;
        std::optional<Name> name;
        TypeEnum type;
        std::optional<std::vector<ElementType>> type_arguments;

        public:
        const std::optional<ElementType> & get_element_type() const { return element_type; }
        std::optional<ElementType> & get_mutable_element_type() { return element_type; }
        void set_element_type(const std::optional<ElementType> & value) { this->element_type = value; }

        const std::optional<Name> & get_name() const { return name; }
        std::optional<Name> & get_mutable_name() { return name; }
        void set_name(const std::optional<Name> & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }

        const std::optional<std::vector<ElementType>> & get_type_arguments() const { return type_arguments; }
        std::optional<std::vector<ElementType>> & get_mutable_type_arguments() { return type_arguments; }
        void set_type_arguments(const std::optional<std::vector<ElementType>> & value) { this->type_arguments = value; }
    };

    class GetSignatureParameter {
        public:
        GetSignatureParameter() = default;
        virtual ~GetSignatureParameter() = default;

        private:
        std::optional<TentacledComment> comment;
        TentacledFlags flags;
        int64_t id;
        int64_t kind;
        ParameterKindString kind_string;
        std::string name;
        FluffyType type;

        public:
        const std::optional<TentacledComment> & get_comment() const { return comment; }
        std::optional<TentacledComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<TentacledComment> & value) { this->comment = value; }

        const TentacledFlags & get_flags() const { return flags; }
        TentacledFlags & get_mutable_flags() { return flags; }
        void set_flags(const TentacledFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const ParameterKindString & get_kind_string() const { return kind_string; }
        ParameterKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const ParameterKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const FluffyType & get_type() const { return type; }
        FluffyType & get_mutable_type() { return type; }
        void set_type(const FluffyType & value) { this->type = value; }
    };

    class GetSignatureType;

    class IndexSignatureElement;

    class PurpleType;

    class GetSignatureChild;

    class GetSignature;

    class GetSignatureType {
        public:
        GetSignatureType() = default;
        virtual ~GetSignatureType() = default;

        private:
        std::shared_ptr<GetSignature> declaration;
        std::optional<ElementType> element_type;
        std::optional<Name> name;
        TypeEnum type;

        public:
        const std::shared_ptr<GetSignature> & get_declaration() const { return declaration; }
        std::shared_ptr<GetSignature> & get_mutable_declaration() { return declaration; }
        void set_declaration(const std::shared_ptr<GetSignature> & value) { this->declaration = value; }

        const std::optional<ElementType> & get_element_type() const { return element_type; }
        std::optional<ElementType> & get_mutable_element_type() { return element_type; }
        void set_element_type(const std::optional<ElementType> & value) { this->element_type = value; }

        const std::optional<Name> & get_name() const { return name; }
        std::optional<Name> & get_mutable_name() { return name; }
        void set_name(const std::optional<Name> & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }
    };

    class IndexSignatureElement {
        public:
        IndexSignatureElement() = default;
        virtual ~IndexSignatureElement() = default;

        private:
        GetSignatureFlags flags;
        int64_t id;
        int64_t kind;
        std::string kind_string;
        std::string name;
        std::optional<std::vector<GetSignature>> parameters;
        std::shared_ptr<PurpleType> type;

        public:
        const GetSignatureFlags & get_flags() const { return flags; }
        GetSignatureFlags & get_mutable_flags() { return flags; }
        void set_flags(const GetSignatureFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const std::string & get_kind_string() const { return kind_string; }
        std::string & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const std::string & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<std::vector<GetSignature>> & get_parameters() const { return parameters; }
        std::optional<std::vector<GetSignature>> & get_mutable_parameters() { return parameters; }
        void set_parameters(const std::optional<std::vector<GetSignature>> & value) { this->parameters = value; }

        const std::shared_ptr<PurpleType> & get_type() const { return type; }
        std::shared_ptr<PurpleType> & get_mutable_type() { return type; }
        void set_type(const std::shared_ptr<PurpleType> & value) { this->type = value; }
    };

    class PurpleType {
        public:
        PurpleType() = default;
        virtual ~PurpleType() = default;

        private:
        std::shared_ptr<GetSignature> declaration;
        std::optional<Name> name;
        TypeEnum type;

        public:
        const std::shared_ptr<GetSignature> & get_declaration() const { return declaration; }
        std::shared_ptr<GetSignature> & get_mutable_declaration() { return declaration; }
        void set_declaration(const std::shared_ptr<GetSignature> & value) { this->declaration = value; }

        const std::optional<Name> & get_name() const { return name; }
        std::optional<Name> & get_mutable_name() { return name; }
        void set_name(const std::optional<Name> & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }
    };

    class GetSignatureChild {
        public:
        GetSignatureChild() = default;
        virtual ~GetSignatureChild() = default;

        private:
        std::optional<FluffyComment> comment;
        FluffyFlags flags;
        int64_t id;
        int64_t kind;
        PurpleKindString kind_string;
        std::string name;
        std::vector<Source> sources;
        std::shared_ptr<PurpleType> type;

        public:
        const std::optional<FluffyComment> & get_comment() const { return comment; }
        std::optional<FluffyComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<FluffyComment> & value) { this->comment = value; }

        const FluffyFlags & get_flags() const { return flags; }
        FluffyFlags & get_mutable_flags() { return flags; }
        void set_flags(const FluffyFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const PurpleKindString & get_kind_string() const { return kind_string; }
        PurpleKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const PurpleKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::vector<Source> & get_sources() const { return sources; }
        std::vector<Source> & get_mutable_sources() { return sources; }
        void set_sources(const std::vector<Source> & value) { this->sources = value; }

        const std::shared_ptr<PurpleType> & get_type() const { return type; }
        std::shared_ptr<PurpleType> & get_mutable_type() { return type; }
        void set_type(const std::shared_ptr<PurpleType> & value) { this->type = value; }
    };

    class GetSignature {
        public:
        GetSignature() = default;
        virtual ~GetSignature() = default;

        private:
        std::optional<std::vector<GetSignatureChild>> children;
        std::optional<GetSignatureComment> comment;
        std::optional<std::string> default_value;
        GetSignatureFlags flags;
        std::optional<std::vector<Group>> groups;
        int64_t id;
        int64_t kind;
        std::string kind_string;
        std::string name;
        std::optional<std::vector<GetSignatureParameter>> parameters;
        std::optional<std::vector<IndexSignatureElement>> signatures;
        std::optional<std::vector<Source>> sources;
        std::shared_ptr<GetSignatureType> type;
        std::optional<std::vector<GetSignature>> type_parameter;

        public:
        const std::optional<std::vector<GetSignatureChild>> & get_children() const { return children; }
        std::optional<std::vector<GetSignatureChild>> & get_mutable_children() { return children; }
        void set_children(const std::optional<std::vector<GetSignatureChild>> & value) { this->children = value; }

        const std::optional<GetSignatureComment> & get_comment() const { return comment; }
        std::optional<GetSignatureComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<GetSignatureComment> & value) { this->comment = value; }

        const std::optional<std::string> & get_default_value() const { return default_value; }
        std::optional<std::string> & get_mutable_default_value() { return default_value; }
        void set_default_value(const std::optional<std::string> & value) { this->default_value = value; }

        const GetSignatureFlags & get_flags() const { return flags; }
        GetSignatureFlags & get_mutable_flags() { return flags; }
        void set_flags(const GetSignatureFlags & value) { this->flags = value; }

        const std::optional<std::vector<Group>> & get_groups() const { return groups; }
        std::optional<std::vector<Group>> & get_mutable_groups() { return groups; }
        void set_groups(const std::optional<std::vector<Group>> & value) { this->groups = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const std::string & get_kind_string() const { return kind_string; }
        std::string & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const std::string & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<std::vector<GetSignatureParameter>> & get_parameters() const { return parameters; }
        std::optional<std::vector<GetSignatureParameter>> & get_mutable_parameters() { return parameters; }
        void set_parameters(const std::optional<std::vector<GetSignatureParameter>> & value) { this->parameters = value; }

        const std::optional<std::vector<IndexSignatureElement>> & get_signatures() const { return signatures; }
        std::optional<std::vector<IndexSignatureElement>> & get_mutable_signatures() { return signatures; }
        void set_signatures(const std::optional<std::vector<IndexSignatureElement>> & value) { this->signatures = value; }

        const std::optional<std::vector<Source>> & get_sources() const { return sources; }
        std::optional<std::vector<Source>> & get_mutable_sources() { return sources; }
        void set_sources(const std::optional<std::vector<Source>> & value) { this->sources = value; }

        const std::shared_ptr<GetSignatureType> & get_type() const { return type; }
        std::shared_ptr<GetSignatureType> & get_mutable_type() { return type; }
        void set_type(const std::shared_ptr<GetSignatureType> & value) { this->type = value; }

        const std::optional<std::vector<GetSignature>> & get_type_parameter() const { return type_parameter; }
        std::optional<std::vector<GetSignature>> & get_mutable_type_parameter() { return type_parameter; }
        void set_type_parameter(const std::optional<std::vector<GetSignature>> & value) { this->type_parameter = value; }
    };

    class PurpleDeclaration {
        public:
        PurpleDeclaration() = default;
        virtual ~PurpleDeclaration() = default;

        private:
        std::vector<GetSignature> children;
        GetSignatureFlags flags;
        std::vector<Group> groups;
        int64_t id;
        int64_t kind;
        std::string kind_string;
        std::string name;

        public:
        const std::vector<GetSignature> & get_children() const { return children; }
        std::vector<GetSignature> & get_mutable_children() { return children; }
        void set_children(const std::vector<GetSignature> & value) { this->children = value; }

        const GetSignatureFlags & get_flags() const { return flags; }
        GetSignatureFlags & get_mutable_flags() { return flags; }
        void set_flags(const GetSignatureFlags & value) { this->flags = value; }

        const std::vector<Group> & get_groups() const { return groups; }
        std::vector<Group> & get_mutable_groups() { return groups; }
        void set_groups(const std::vector<Group> & value) { this->groups = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const std::string & get_kind_string() const { return kind_string; }
        std::string & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const std::string & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }
    };

    class TentacledType {
        public:
        TentacledType() = default;
        virtual ~TentacledType() = default;

        private:
        std::optional<PurpleDeclaration> declaration;
        std::optional<Name> name;
        TypeEnum type;

        public:
        const std::optional<PurpleDeclaration> & get_declaration() const { return declaration; }
        std::optional<PurpleDeclaration> & get_mutable_declaration() { return declaration; }
        void set_declaration(const std::optional<PurpleDeclaration> & value) { this->declaration = value; }

        const std::optional<Name> & get_name() const { return name; }
        std::optional<Name> & get_mutable_name() { return name; }
        void set_name(const std::optional<Name> & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }
    };

    class PurpleSignature {
        public:
        PurpleSignature() = default;
        virtual ~PurpleSignature() = default;

        private:
        std::optional<PurpleComment> comment;
        GetSignatureFlags flags;
        int64_t id;
        int64_t kind;
        SignatureKindString kind_string;
        std::string name;
        std::vector<GetSignature> parameters;
        TentacledType type;

        public:
        const std::optional<PurpleComment> & get_comment() const { return comment; }
        std::optional<PurpleComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<PurpleComment> & value) { this->comment = value; }

        const GetSignatureFlags & get_flags() const { return flags; }
        GetSignatureFlags & get_mutable_flags() { return flags; }
        void set_flags(const GetSignatureFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const SignatureKindString & get_kind_string() const { return kind_string; }
        SignatureKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const SignatureKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::vector<GetSignature> & get_parameters() const { return parameters; }
        std::vector<GetSignature> & get_mutable_parameters() { return parameters; }
        void set_parameters(const std::vector<GetSignature> & value) { this->parameters = value; }

        const TentacledType & get_type() const { return type; }
        TentacledType & get_mutable_type() { return type; }
        void set_type(const TentacledType & value) { this->type = value; }
    };

    class TypeElement {
        public:
        TypeElement() = default;
        virtual ~TypeElement() = default;

        private:
        std::shared_ptr<GetSignature> declaration;
        std::optional<ElementType> element_type;
        std::optional<Name> name;
        TypeEnum type;
        std::optional<std::vector<ElementType>> type_arguments;

        public:
        const std::shared_ptr<GetSignature> & get_declaration() const { return declaration; }
        std::shared_ptr<GetSignature> & get_mutable_declaration() { return declaration; }
        void set_declaration(const std::shared_ptr<GetSignature> & value) { this->declaration = value; }

        const std::optional<ElementType> & get_element_type() const { return element_type; }
        std::optional<ElementType> & get_mutable_element_type() { return element_type; }
        void set_element_type(const std::optional<ElementType> & value) { this->element_type = value; }

        const std::optional<Name> & get_name() const { return name; }
        std::optional<Name> & get_mutable_name() { return name; }
        void set_name(const std::optional<Name> & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }

        const std::optional<std::vector<ElementType>> & get_type_arguments() const { return type_arguments; }
        std::optional<std::vector<ElementType>> & get_mutable_type_arguments() { return type_arguments; }
        void set_type_arguments(const std::optional<std::vector<ElementType>> & value) { this->type_arguments = value; }
    };

    class TentacledChild {
        public:
        TentacledChild() = default;
        virtual ~TentacledChild() = default;

        private:
        std::optional<PurpleComment> comment;
        std::optional<std::string> default_value;
        PurpleFlags flags;
        int64_t id;
        int64_t kind;
        PurpleKindString kind_string;
        std::string name;
        std::optional<std::vector<PurpleSignature>> signatures;
        std::vector<Source> sources;
        std::optional<TypeElement> type;

        public:
        const std::optional<PurpleComment> & get_comment() const { return comment; }
        std::optional<PurpleComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<PurpleComment> & value) { this->comment = value; }

        const std::optional<std::string> & get_default_value() const { return default_value; }
        std::optional<std::string> & get_mutable_default_value() { return default_value; }
        void set_default_value(const std::optional<std::string> & value) { this->default_value = value; }

        const PurpleFlags & get_flags() const { return flags; }
        PurpleFlags & get_mutable_flags() { return flags; }
        void set_flags(const PurpleFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const PurpleKindString & get_kind_string() const { return kind_string; }
        PurpleKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const PurpleKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<std::vector<PurpleSignature>> & get_signatures() const { return signatures; }
        std::optional<std::vector<PurpleSignature>> & get_mutable_signatures() { return signatures; }
        void set_signatures(const std::optional<std::vector<PurpleSignature>> & value) { this->signatures = value; }

        const std::vector<Source> & get_sources() const { return sources; }
        std::vector<Source> & get_mutable_sources() { return sources; }
        void set_sources(const std::vector<Source> & value) { this->sources = value; }

        const std::optional<TypeElement> & get_type() const { return type; }
        std::optional<TypeElement> & get_mutable_type() { return type; }
        void set_type(const std::optional<TypeElement> & value) { this->type = value; }
    };

    class Tag {
        public:
        Tag() = default;
        virtual ~Tag() = default;

        private:
        std::string tag;
        std::string text;

        public:
        const std::string & get_tag() const { return tag; }
        std::string & get_mutable_tag() { return tag; }
        void set_tag(const std::string & value) { this->tag = value; }

        const std::string & get_text() const { return text; }
        std::string & get_mutable_text() { return text; }
        void set_text(const std::string & value) { this->text = value; }
    };

    class StickyComment {
        public:
        StickyComment() = default;
        virtual ~StickyComment() = default;

        private:
        std::optional<std::string> returns;
        std::optional<std::string> short_text;
        std::optional<std::vector<Tag>> tags;
        std::optional<std::string> text;

        public:
        const std::optional<std::string> & get_returns() const { return returns; }
        std::optional<std::string> & get_mutable_returns() { return returns; }
        void set_returns(const std::optional<std::string> & value) { this->returns = value; }

        const std::optional<std::string> & get_short_text() const { return short_text; }
        std::optional<std::string> & get_mutable_short_text() { return short_text; }
        void set_short_text(const std::optional<std::string> & value) { this->short_text = value; }

        const std::optional<std::vector<Tag>> & get_tags() const { return tags; }
        std::optional<std::vector<Tag>> & get_mutable_tags() { return tags; }
        void set_tags(const std::optional<std::vector<Tag>> & value) { this->tags = value; }

        const std::optional<std::string> & get_text() const { return text; }
        std::optional<std::string> & get_mutable_text() { return text; }
        void set_text(const std::optional<std::string> & value) { this->text = value; }
    };

    class StickyFlags {
        public:
        StickyFlags() = default;
        virtual ~StickyFlags() = default;

        private:
        std::optional<bool> is_abstract;
        std::optional<bool> is_constructor_property;
        std::optional<bool> is_exported;
        std::optional<bool> is_private;
        std::optional<bool> is_protected;
        std::optional<bool> is_public;
        std::optional<bool> is_static;

        public:
        const std::optional<bool> & get_is_abstract() const { return is_abstract; }
        std::optional<bool> & get_mutable_is_abstract() { return is_abstract; }
        void set_is_abstract(const std::optional<bool> & value) { this->is_abstract = value; }

        const std::optional<bool> & get_is_constructor_property() const { return is_constructor_property; }
        std::optional<bool> & get_mutable_is_constructor_property() { return is_constructor_property; }
        void set_is_constructor_property(const std::optional<bool> & value) { this->is_constructor_property = value; }

        const std::optional<bool> & get_is_exported() const { return is_exported; }
        std::optional<bool> & get_mutable_is_exported() { return is_exported; }
        void set_is_exported(const std::optional<bool> & value) { this->is_exported = value; }

        const std::optional<bool> & get_is_private() const { return is_private; }
        std::optional<bool> & get_mutable_is_private() { return is_private; }
        void set_is_private(const std::optional<bool> & value) { this->is_private = value; }

        const std::optional<bool> & get_is_protected() const { return is_protected; }
        std::optional<bool> & get_mutable_is_protected() { return is_protected; }
        void set_is_protected(const std::optional<bool> & value) { this->is_protected = value; }

        const std::optional<bool> & get_is_public() const { return is_public; }
        std::optional<bool> & get_mutable_is_public() { return is_public; }
        void set_is_public(const std::optional<bool> & value) { this->is_public = value; }

        const std::optional<bool> & get_is_static() const { return is_static; }
        std::optional<bool> & get_mutable_is_static() { return is_static; }
        void set_is_static(const std::optional<bool> & value) { this->is_static = value; }
    };

    class ExtendedBy {
        public:
        ExtendedBy() = default;
        virtual ~ExtendedBy() = default;

        private:
        std::shared_ptr<ExtendedBy> constraint;
        std::optional<int64_t> id;
        std::string name;
        TypeEnum type;
        std::optional<std::vector<ExtendedBy>> type_arguments;

        public:
        const std::shared_ptr<ExtendedBy> & get_constraint() const { return constraint; }
        std::shared_ptr<ExtendedBy> & get_mutable_constraint() { return constraint; }
        void set_constraint(const std::shared_ptr<ExtendedBy> & value) { this->constraint = value; }

        const std::optional<int64_t> & get_id() const { return id; }
        std::optional<int64_t> & get_mutable_id() { return id; }
        void set_id(const std::optional<int64_t> & value) { this->id = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }

        const std::optional<std::vector<ExtendedBy>> & get_type_arguments() const { return type_arguments; }
        std::optional<std::vector<ExtendedBy>> & get_mutable_type_arguments() { return type_arguments; }
        void set_type_arguments(const std::optional<std::vector<ExtendedBy>> & value) { this->type_arguments = value; }
    };

    class IndigoFlags {
        public:
        IndigoFlags() = default;
        virtual ~IndigoFlags() = default;

        private:
        std::optional<bool> is_private;
        std::optional<bool> is_protected;

        public:
        const std::optional<bool> & get_is_private() const { return is_private; }
        std::optional<bool> & get_mutable_is_private() { return is_private; }
        void set_is_private(const std::optional<bool> & value) { this->is_private = value; }

        const std::optional<bool> & get_is_protected() const { return is_protected; }
        std::optional<bool> & get_mutable_is_protected() { return is_protected; }
        void set_is_protected(const std::optional<bool> & value) { this->is_protected = value; }
    };

    class StickyType {
        public:
        StickyType() = default;
        virtual ~StickyType() = default;

        private:
        std::shared_ptr<ExtendedBy> constraint;
        std::shared_ptr<GetSignature> declaration;
        std::optional<ElementType> element_type;
        std::optional<std::vector<ExtendedBy>> elements;
        std::optional<int64_t> id;
        std::optional<std::string> name;
        TypeEnum type;
        std::optional<std::vector<ElementType>> type_arguments;

        public:
        const std::shared_ptr<ExtendedBy> & get_constraint() const { return constraint; }
        std::shared_ptr<ExtendedBy> & get_mutable_constraint() { return constraint; }
        void set_constraint(const std::shared_ptr<ExtendedBy> & value) { this->constraint = value; }

        const std::shared_ptr<GetSignature> & get_declaration() const { return declaration; }
        std::shared_ptr<GetSignature> & get_mutable_declaration() { return declaration; }
        void set_declaration(const std::shared_ptr<GetSignature> & value) { this->declaration = value; }

        const std::optional<ElementType> & get_element_type() const { return element_type; }
        std::optional<ElementType> & get_mutable_element_type() { return element_type; }
        void set_element_type(const std::optional<ElementType> & value) { this->element_type = value; }

        const std::optional<std::vector<ExtendedBy>> & get_elements() const { return elements; }
        std::optional<std::vector<ExtendedBy>> & get_mutable_elements() { return elements; }
        void set_elements(const std::optional<std::vector<ExtendedBy>> & value) { this->elements = value; }

        const std::optional<int64_t> & get_id() const { return id; }
        std::optional<int64_t> & get_mutable_id() { return id; }
        void set_id(const std::optional<int64_t> & value) { this->id = value; }

        const std::optional<std::string> & get_name() const { return name; }
        std::optional<std::string> & get_mutable_name() { return name; }
        void set_name(const std::optional<std::string> & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }

        const std::optional<std::vector<ElementType>> & get_type_arguments() const { return type_arguments; }
        std::optional<std::vector<ElementType>> & get_mutable_type_arguments() { return type_arguments; }
        void set_type_arguments(const std::optional<std::vector<ElementType>> & value) { this->type_arguments = value; }
    };

    class PurpleParameter {
        public:
        PurpleParameter() = default;
        virtual ~PurpleParameter() = default;

        private:
        std::optional<TentacledComment> comment;
        GetSignatureFlags flags;
        int64_t id;
        int64_t kind;
        ParameterKindString kind_string;
        std::string name;
        StickyType type;

        public:
        const std::optional<TentacledComment> & get_comment() const { return comment; }
        std::optional<TentacledComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<TentacledComment> & value) { this->comment = value; }

        const GetSignatureFlags & get_flags() const { return flags; }
        GetSignatureFlags & get_mutable_flags() { return flags; }
        void set_flags(const GetSignatureFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const ParameterKindString & get_kind_string() const { return kind_string; }
        ParameterKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const ParameterKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const StickyType & get_type() const { return type; }
        StickyType & get_mutable_type() { return type; }
        void set_type(const StickyType & value) { this->type = value; }
    };

    class FluffySignature {
        public:
        FluffySignature() = default;
        virtual ~FluffySignature() = default;

        private:
        std::optional<StickyComment> comment;
        IndigoFlags flags;
        int64_t id;
        std::shared_ptr<ExtendedBy> implementation_of;
        std::shared_ptr<ExtendedBy> inherited_from;
        int64_t kind;
        SignatureKindString kind_string;
        std::string name;
        std::shared_ptr<ExtendedBy> overwrites;
        std::optional<std::vector<PurpleParameter>> parameters;
        ExtendedBy type;
        std::optional<std::vector<GetSignature>> type_parameter;

        public:
        const std::optional<StickyComment> & get_comment() const { return comment; }
        std::optional<StickyComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<StickyComment> & value) { this->comment = value; }

        const IndigoFlags & get_flags() const { return flags; }
        IndigoFlags & get_mutable_flags() { return flags; }
        void set_flags(const IndigoFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::shared_ptr<ExtendedBy> & get_implementation_of() const { return implementation_of; }
        std::shared_ptr<ExtendedBy> & get_mutable_implementation_of() { return implementation_of; }
        void set_implementation_of(const std::shared_ptr<ExtendedBy> & value) { this->implementation_of = value; }

        const std::shared_ptr<ExtendedBy> & get_inherited_from() const { return inherited_from; }
        std::shared_ptr<ExtendedBy> & get_mutable_inherited_from() { return inherited_from; }
        void set_inherited_from(const std::shared_ptr<ExtendedBy> & value) { this->inherited_from = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const SignatureKindString & get_kind_string() const { return kind_string; }
        SignatureKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const SignatureKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::shared_ptr<ExtendedBy> & get_overwrites() const { return overwrites; }
        std::shared_ptr<ExtendedBy> & get_mutable_overwrites() { return overwrites; }
        void set_overwrites(const std::shared_ptr<ExtendedBy> & value) { this->overwrites = value; }

        const std::optional<std::vector<PurpleParameter>> & get_parameters() const { return parameters; }
        std::optional<std::vector<PurpleParameter>> & get_mutable_parameters() { return parameters; }
        void set_parameters(const std::optional<std::vector<PurpleParameter>> & value) { this->parameters = value; }

        const ExtendedBy & get_type() const { return type; }
        ExtendedBy & get_mutable_type() { return type; }
        void set_type(const ExtendedBy & value) { this->type = value; }

        const std::optional<std::vector<GetSignature>> & get_type_parameter() const { return type_parameter; }
        std::optional<std::vector<GetSignature>> & get_mutable_type_parameter() { return type_parameter; }
        void set_type_parameter(const std::optional<std::vector<GetSignature>> & value) { this->type_parameter = value; }
    };

    class IndecentType {
        public:
        IndecentType() = default;
        virtual ~IndecentType() = default;

        private:
        std::shared_ptr<GetSignature> declaration;
        std::optional<std::vector<ElementType>> elements;
        std::optional<Name> name;
        TypeEnum type;

        public:
        const std::shared_ptr<GetSignature> & get_declaration() const { return declaration; }
        std::shared_ptr<GetSignature> & get_mutable_declaration() { return declaration; }
        void set_declaration(const std::shared_ptr<GetSignature> & value) { this->declaration = value; }

        const std::optional<std::vector<ElementType>> & get_elements() const { return elements; }
        std::optional<std::vector<ElementType>> & get_mutable_elements() { return elements; }
        void set_elements(const std::optional<std::vector<ElementType>> & value) { this->elements = value; }

        const std::optional<Name> & get_name() const { return name; }
        std::optional<Name> & get_mutable_name() { return name; }
        void set_name(const std::optional<Name> & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }
    };

    class StickyChild {
        public:
        StickyChild() = default;
        virtual ~StickyChild() = default;

        private:
        std::optional<FluffyComment> comment;
        FluffyFlags flags;
        int64_t id;
        int64_t kind;
        PurpleKindString kind_string;
        std::string name;
        std::vector<Source> sources;
        IndecentType type;

        public:
        const std::optional<FluffyComment> & get_comment() const { return comment; }
        std::optional<FluffyComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<FluffyComment> & value) { this->comment = value; }

        const FluffyFlags & get_flags() const { return flags; }
        FluffyFlags & get_mutable_flags() { return flags; }
        void set_flags(const FluffyFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const PurpleKindString & get_kind_string() const { return kind_string; }
        PurpleKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const PurpleKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::vector<Source> & get_sources() const { return sources; }
        std::vector<Source> & get_mutable_sources() { return sources; }
        void set_sources(const std::vector<Source> & value) { this->sources = value; }

        const IndecentType & get_type() const { return type; }
        IndecentType & get_mutable_type() { return type; }
        void set_type(const IndecentType & value) { this->type = value; }
    };

    class HilariousType {
        public:
        HilariousType() = default;
        virtual ~HilariousType() = default;

        private:
        std::shared_ptr<GetSignature> declaration;
        TypeEnum type;

        public:
        const std::shared_ptr<GetSignature> & get_declaration() const { return declaration; }
        std::shared_ptr<GetSignature> & get_mutable_declaration() { return declaration; }
        void set_declaration(const std::shared_ptr<GetSignature> & value) { this->declaration = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }
    };

    class IndexSignature {
        public:
        IndexSignature() = default;
        virtual ~IndexSignature() = default;

        private:
        GetSignatureFlags flags;
        int64_t id;
        int64_t kind;
        std::string kind_string;
        std::string name;
        std::vector<GetSignature> parameters;
        HilariousType type;

        public:
        const GetSignatureFlags & get_flags() const { return flags; }
        GetSignatureFlags & get_mutable_flags() { return flags; }
        void set_flags(const GetSignatureFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const std::string & get_kind_string() const { return kind_string; }
        std::string & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const std::string & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::vector<GetSignature> & get_parameters() const { return parameters; }
        std::vector<GetSignature> & get_mutable_parameters() { return parameters; }
        void set_parameters(const std::vector<GetSignature> & value) { this->parameters = value; }

        const HilariousType & get_type() const { return type; }
        HilariousType & get_mutable_type() { return type; }
        void set_type(const HilariousType & value) { this->type = value; }
    };

    class IndigoComment {
        public:
        IndigoComment() = default;
        virtual ~IndigoComment() = default;

        private:
        std::string returns;
        std::string short_text;

        public:
        const std::string & get_returns() const { return returns; }
        std::string & get_mutable_returns() { return returns; }
        void set_returns(const std::string & value) { this->returns = value; }

        const std::string & get_short_text() const { return short_text; }
        std::string & get_mutable_short_text() { return short_text; }
        void set_short_text(const std::string & value) { this->short_text = value; }
    };

    class FluffyParameter {
        public:
        FluffyParameter() = default;
        virtual ~FluffyParameter() = default;

        private:
        std::optional<FluffyComment> comment;
        FluffyFlags flags;
        int64_t id;
        int64_t kind;
        std::string kind_string;
        std::string name;
        std::optional<std::vector<Source>> sources;
        ElementType type;

        public:
        const std::optional<FluffyComment> & get_comment() const { return comment; }
        std::optional<FluffyComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<FluffyComment> & value) { this->comment = value; }

        const FluffyFlags & get_flags() const { return flags; }
        FluffyFlags & get_mutable_flags() { return flags; }
        void set_flags(const FluffyFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const std::string & get_kind_string() const { return kind_string; }
        std::string & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const std::string & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<std::vector<Source>> & get_sources() const { return sources; }
        std::optional<std::vector<Source>> & get_mutable_sources() { return sources; }
        void set_sources(const std::optional<std::vector<Source>> & value) { this->sources = value; }

        const ElementType & get_type() const { return type; }
        ElementType & get_mutable_type() { return type; }
        void set_type(const ElementType & value) { this->type = value; }
    };

    class TentacledSignature {
        public:
        TentacledSignature() = default;
        virtual ~TentacledSignature() = default;

        private:
        std::optional<IndigoComment> comment;
        GetSignatureFlags flags;
        int64_t id;
        int64_t kind;
        SignatureKindString kind_string;
        std::string name;
        std::optional<std::vector<FluffyParameter>> parameters;
        ExtendedBy type;

        public:
        const std::optional<IndigoComment> & get_comment() const { return comment; }
        std::optional<IndigoComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<IndigoComment> & value) { this->comment = value; }

        const GetSignatureFlags & get_flags() const { return flags; }
        GetSignatureFlags & get_mutable_flags() { return flags; }
        void set_flags(const GetSignatureFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const SignatureKindString & get_kind_string() const { return kind_string; }
        SignatureKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const SignatureKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<std::vector<FluffyParameter>> & get_parameters() const { return parameters; }
        std::optional<std::vector<FluffyParameter>> & get_mutable_parameters() { return parameters; }
        void set_parameters(const std::optional<std::vector<FluffyParameter>> & value) { this->parameters = value; }

        const ExtendedBy & get_type() const { return type; }
        ExtendedBy & get_mutable_type() { return type; }
        void set_type(const ExtendedBy & value) { this->type = value; }
    };

    class FluffyDeclaration {
        public:
        FluffyDeclaration() = default;
        virtual ~FluffyDeclaration() = default;

        private:
        std::optional<std::vector<StickyChild>> children;
        GetSignatureFlags flags;
        std::optional<std::vector<Group>> groups;
        int64_t id;
        std::optional<IndexSignature> index_signature;
        int64_t kind;
        std::string kind_string;
        std::string name;
        std::optional<std::vector<TentacledSignature>> signatures;
        std::vector<Source> sources;

        public:
        const std::optional<std::vector<StickyChild>> & get_children() const { return children; }
        std::optional<std::vector<StickyChild>> & get_mutable_children() { return children; }
        void set_children(const std::optional<std::vector<StickyChild>> & value) { this->children = value; }

        const GetSignatureFlags & get_flags() const { return flags; }
        GetSignatureFlags & get_mutable_flags() { return flags; }
        void set_flags(const GetSignatureFlags & value) { this->flags = value; }

        const std::optional<std::vector<Group>> & get_groups() const { return groups; }
        std::optional<std::vector<Group>> & get_mutable_groups() { return groups; }
        void set_groups(const std::optional<std::vector<Group>> & value) { this->groups = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::optional<IndexSignature> & get_index_signature() const { return index_signature; }
        std::optional<IndexSignature> & get_mutable_index_signature() { return index_signature; }
        void set_index_signature(const std::optional<IndexSignature> & value) { this->index_signature = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const std::string & get_kind_string() const { return kind_string; }
        std::string & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const std::string & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<std::vector<TentacledSignature>> & get_signatures() const { return signatures; }
        std::optional<std::vector<TentacledSignature>> & get_mutable_signatures() { return signatures; }
        void set_signatures(const std::optional<std::vector<TentacledSignature>> & value) { this->signatures = value; }

        const std::vector<Source> & get_sources() const { return sources; }
        std::vector<Source> & get_mutable_sources() { return sources; }
        void set_sources(const std::vector<Source> & value) { this->sources = value; }
    };

    class PurpleTypeArgument {
        public:
        PurpleTypeArgument() = default;
        virtual ~PurpleTypeArgument() = default;

        private:
        ElementType target;
        std::string type;
        std::string type_argument_operator;

        public:
        const ElementType & get_target() const { return target; }
        ElementType & get_mutable_target() { return target; }
        void set_target(const ElementType & value) { this->target = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }

        const std::string & get_type_argument_operator() const { return type_argument_operator; }
        std::string & get_mutable_type_argument_operator() { return type_argument_operator; }
        void set_type_argument_operator(const std::string & value) { this->type_argument_operator = value; }
    };

    class IndigoType {
        public:
        IndigoType() = default;
        virtual ~IndigoType() = default;

        private:
        std::shared_ptr<ExtendedBy> constraint;
        std::optional<FluffyDeclaration> declaration;
        std::shared_ptr<ExtendedBy> element_type;
        std::optional<std::vector<ElementType>> elements;
        std::optional<int64_t> id;
        std::optional<std::string> name;
        TypeEnum type;
        std::optional<std::vector<PurpleTypeArgument>> type_arguments;
        std::optional<std::vector<TypeElement>> types;

        public:
        const std::shared_ptr<ExtendedBy> & get_constraint() const { return constraint; }
        std::shared_ptr<ExtendedBy> & get_mutable_constraint() { return constraint; }
        void set_constraint(const std::shared_ptr<ExtendedBy> & value) { this->constraint = value; }

        const std::optional<FluffyDeclaration> & get_declaration() const { return declaration; }
        std::optional<FluffyDeclaration> & get_mutable_declaration() { return declaration; }
        void set_declaration(const std::optional<FluffyDeclaration> & value) { this->declaration = value; }

        const std::shared_ptr<ExtendedBy> & get_element_type() const { return element_type; }
        std::shared_ptr<ExtendedBy> & get_mutable_element_type() { return element_type; }
        void set_element_type(const std::shared_ptr<ExtendedBy> & value) { this->element_type = value; }

        const std::optional<std::vector<ElementType>> & get_elements() const { return elements; }
        std::optional<std::vector<ElementType>> & get_mutable_elements() { return elements; }
        void set_elements(const std::optional<std::vector<ElementType>> & value) { this->elements = value; }

        const std::optional<int64_t> & get_id() const { return id; }
        std::optional<int64_t> & get_mutable_id() { return id; }
        void set_id(const std::optional<int64_t> & value) { this->id = value; }

        const std::optional<std::string> & get_name() const { return name; }
        std::optional<std::string> & get_mutable_name() { return name; }
        void set_name(const std::optional<std::string> & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }

        const std::optional<std::vector<PurpleTypeArgument>> & get_type_arguments() const { return type_arguments; }
        std::optional<std::vector<PurpleTypeArgument>> & get_mutable_type_arguments() { return type_arguments; }
        void set_type_arguments(const std::optional<std::vector<PurpleTypeArgument>> & value) { this->type_arguments = value; }

        const std::optional<std::vector<TypeElement>> & get_types() const { return types; }
        std::optional<std::vector<TypeElement>> & get_mutable_types() { return types; }
        void set_types(const std::optional<std::vector<TypeElement>> & value) { this->types = value; }
    };

    class FluffyChild {
        public:
        FluffyChild() = default;
        virtual ~FluffyChild() = default;

        private:
        std::optional<std::vector<TentacledChild>> children;
        std::optional<StickyComment> comment;
        std::optional<std::string> default_value;
        StickyFlags flags;
        std::shared_ptr<GetSignature> get_signature;
        std::optional<std::vector<Group>> groups;
        int64_t id;
        std::shared_ptr<ExtendedBy> implementation_of;
        std::shared_ptr<ExtendedBy> inherited_from;
        int64_t kind;
        PurpleKindString kind_string;
        std::string name;
        std::shared_ptr<ExtendedBy> overwrites;
        std::shared_ptr<GetSignature> set_signature;
        std::optional<std::vector<FluffySignature>> signatures;
        std::vector<Source> sources;
        std::optional<IndigoType> type;

        public:
        const std::optional<std::vector<TentacledChild>> & get_children() const { return children; }
        std::optional<std::vector<TentacledChild>> & get_mutable_children() { return children; }
        void set_children(const std::optional<std::vector<TentacledChild>> & value) { this->children = value; }

        const std::optional<StickyComment> & get_comment() const { return comment; }
        std::optional<StickyComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<StickyComment> & value) { this->comment = value; }

        const std::optional<std::string> & get_default_value() const { return default_value; }
        std::optional<std::string> & get_mutable_default_value() { return default_value; }
        void set_default_value(const std::optional<std::string> & value) { this->default_value = value; }

        const StickyFlags & get_flags() const { return flags; }
        StickyFlags & get_mutable_flags() { return flags; }
        void set_flags(const StickyFlags & value) { this->flags = value; }

        const std::shared_ptr<GetSignature> & get_get_signature() const { return get_signature; }
        std::shared_ptr<GetSignature> & get_mutable_get_signature() { return get_signature; }
        void set_get_signature(const std::shared_ptr<GetSignature> & value) { this->get_signature = value; }

        const std::optional<std::vector<Group>> & get_groups() const { return groups; }
        std::optional<std::vector<Group>> & get_mutable_groups() { return groups; }
        void set_groups(const std::optional<std::vector<Group>> & value) { this->groups = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::shared_ptr<ExtendedBy> & get_implementation_of() const { return implementation_of; }
        std::shared_ptr<ExtendedBy> & get_mutable_implementation_of() { return implementation_of; }
        void set_implementation_of(const std::shared_ptr<ExtendedBy> & value) { this->implementation_of = value; }

        const std::shared_ptr<ExtendedBy> & get_inherited_from() const { return inherited_from; }
        std::shared_ptr<ExtendedBy> & get_mutable_inherited_from() { return inherited_from; }
        void set_inherited_from(const std::shared_ptr<ExtendedBy> & value) { this->inherited_from = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const PurpleKindString & get_kind_string() const { return kind_string; }
        PurpleKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const PurpleKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::shared_ptr<ExtendedBy> & get_overwrites() const { return overwrites; }
        std::shared_ptr<ExtendedBy> & get_mutable_overwrites() { return overwrites; }
        void set_overwrites(const std::shared_ptr<ExtendedBy> & value) { this->overwrites = value; }

        const std::shared_ptr<GetSignature> & get_set_signature() const { return set_signature; }
        std::shared_ptr<GetSignature> & get_mutable_set_signature() { return set_signature; }
        void set_set_signature(const std::shared_ptr<GetSignature> & value) { this->set_signature = value; }

        const std::optional<std::vector<FluffySignature>> & get_signatures() const { return signatures; }
        std::optional<std::vector<FluffySignature>> & get_mutable_signatures() { return signatures; }
        void set_signatures(const std::optional<std::vector<FluffySignature>> & value) { this->signatures = value; }

        const std::vector<Source> & get_sources() const { return sources; }
        std::vector<Source> & get_mutable_sources() { return sources; }
        void set_sources(const std::vector<Source> & value) { this->sources = value; }

        const std::optional<IndigoType> & get_type() const { return type; }
        std::optional<IndigoType> & get_mutable_type() { return type; }
        void set_type(const std::optional<IndigoType> & value) { this->type = value; }
    };

    class IndecentFlags {
        public:
        IndecentFlags() = default;
        virtual ~IndecentFlags() = default;

        private:
        std::optional<bool> has_export_assignment;
        std::optional<bool> is_abstract;
        std::optional<bool> is_const;
        std::optional<bool> is_exported;
        std::optional<bool> is_let;
        std::optional<bool> is_private;
        std::optional<bool> is_protected;

        public:
        const std::optional<bool> & get_has_export_assignment() const { return has_export_assignment; }
        std::optional<bool> & get_mutable_has_export_assignment() { return has_export_assignment; }
        void set_has_export_assignment(const std::optional<bool> & value) { this->has_export_assignment = value; }

        const std::optional<bool> & get_is_abstract() const { return is_abstract; }
        std::optional<bool> & get_mutable_is_abstract() { return is_abstract; }
        void set_is_abstract(const std::optional<bool> & value) { this->is_abstract = value; }

        const std::optional<bool> & get_is_const() const { return is_const; }
        std::optional<bool> & get_mutable_is_const() { return is_const; }
        void set_is_const(const std::optional<bool> & value) { this->is_const = value; }

        const std::optional<bool> & get_is_exported() const { return is_exported; }
        std::optional<bool> & get_mutable_is_exported() { return is_exported; }
        void set_is_exported(const std::optional<bool> & value) { this->is_exported = value; }

        const std::optional<bool> & get_is_let() const { return is_let; }
        std::optional<bool> & get_mutable_is_let() { return is_let; }
        void set_is_let(const std::optional<bool> & value) { this->is_let = value; }

        const std::optional<bool> & get_is_private() const { return is_private; }
        std::optional<bool> & get_mutable_is_private() { return is_private; }
        void set_is_private(const std::optional<bool> & value) { this->is_private = value; }

        const std::optional<bool> & get_is_protected() const { return is_protected; }
        std::optional<bool> & get_mutable_is_protected() { return is_protected; }
        void set_is_protected(const std::optional<bool> & value) { this->is_protected = value; }
    };

    enum class FluffyKindString : int { MODULE, CLASS, VARIABLE, FUNCTION, INTERFACE, ENUMERATION, OBJECT_LITERAL, TYPE_ALIAS };

    class IndigoChild {
        public:
        IndigoChild() = default;
        virtual ~IndigoChild() = default;

        private:
        FluffyComment comment;
        std::optional<std::string> default_value;
        FluffyFlags flags;
        int64_t id;
        int64_t kind;
        PurpleKindString kind_string;
        std::string name;
        std::vector<Source> sources;
        IndecentType type;

        public:
        const FluffyComment & get_comment() const { return comment; }
        FluffyComment & get_mutable_comment() { return comment; }
        void set_comment(const FluffyComment & value) { this->comment = value; }

        const std::optional<std::string> & get_default_value() const { return default_value; }
        std::optional<std::string> & get_mutable_default_value() { return default_value; }
        void set_default_value(const std::optional<std::string> & value) { this->default_value = value; }

        const FluffyFlags & get_flags() const { return flags; }
        FluffyFlags & get_mutable_flags() { return flags; }
        void set_flags(const FluffyFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const PurpleKindString & get_kind_string() const { return kind_string; }
        PurpleKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const PurpleKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::vector<Source> & get_sources() const { return sources; }
        std::vector<Source> & get_mutable_sources() { return sources; }
        void set_sources(const std::vector<Source> & value) { this->sources = value; }

        const IndecentType & get_type() const { return type; }
        IndecentType & get_mutable_type() { return type; }
        void set_type(const IndecentType & value) { this->type = value; }
    };

    class TentacledDeclaration {
        public:
        TentacledDeclaration() = default;
        virtual ~TentacledDeclaration() = default;

        private:
        std::optional<std::vector<IndigoChild>> children;
        GetSignatureFlags flags;
        std::optional<std::vector<Group>> groups;
        int64_t id;
        std::shared_ptr<IndexSignatureElement> index_signature;
        int64_t kind;
        std::string kind_string;
        std::string name;
        std::optional<std::vector<GetSignature>> signatures;
        std::vector<Source> sources;

        public:
        const std::optional<std::vector<IndigoChild>> & get_children() const { return children; }
        std::optional<std::vector<IndigoChild>> & get_mutable_children() { return children; }
        void set_children(const std::optional<std::vector<IndigoChild>> & value) { this->children = value; }

        const GetSignatureFlags & get_flags() const { return flags; }
        GetSignatureFlags & get_mutable_flags() { return flags; }
        void set_flags(const GetSignatureFlags & value) { this->flags = value; }

        const std::optional<std::vector<Group>> & get_groups() const { return groups; }
        std::optional<std::vector<Group>> & get_mutable_groups() { return groups; }
        void set_groups(const std::optional<std::vector<Group>> & value) { this->groups = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::shared_ptr<IndexSignatureElement> & get_index_signature() const { return index_signature; }
        std::shared_ptr<IndexSignatureElement> & get_mutable_index_signature() { return index_signature; }
        void set_index_signature(const std::shared_ptr<IndexSignatureElement> & value) { this->index_signature = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const std::string & get_kind_string() const { return kind_string; }
        std::string & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const std::string & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<std::vector<GetSignature>> & get_signatures() const { return signatures; }
        std::optional<std::vector<GetSignature>> & get_mutable_signatures() { return signatures; }
        void set_signatures(const std::optional<std::vector<GetSignature>> & value) { this->signatures = value; }

        const std::vector<Source> & get_sources() const { return sources; }
        std::vector<Source> & get_mutable_sources() { return sources; }
        void set_sources(const std::vector<Source> & value) { this->sources = value; }
    };

    class AmbitiousType {
        public:
        AmbitiousType() = default;
        virtual ~AmbitiousType() = default;

        private:
        std::optional<TentacledDeclaration> declaration;
        std::optional<ElementType> element_type;
        std::optional<int64_t> id;
        std::optional<std::string> name;
        TypeEnum type;
        std::optional<std::vector<ElementType>> type_arguments;

        public:
        const std::optional<TentacledDeclaration> & get_declaration() const { return declaration; }
        std::optional<TentacledDeclaration> & get_mutable_declaration() { return declaration; }
        void set_declaration(const std::optional<TentacledDeclaration> & value) { this->declaration = value; }

        const std::optional<ElementType> & get_element_type() const { return element_type; }
        std::optional<ElementType> & get_mutable_element_type() { return element_type; }
        void set_element_type(const std::optional<ElementType> & value) { this->element_type = value; }

        const std::optional<int64_t> & get_id() const { return id; }
        std::optional<int64_t> & get_mutable_id() { return id; }
        void set_id(const std::optional<int64_t> & value) { this->id = value; }

        const std::optional<std::string> & get_name() const { return name; }
        std::optional<std::string> & get_mutable_name() { return name; }
        void set_name(const std::optional<std::string> & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }

        const std::optional<std::vector<ElementType>> & get_type_arguments() const { return type_arguments; }
        std::optional<std::vector<ElementType>> & get_mutable_type_arguments() { return type_arguments; }
        void set_type_arguments(const std::optional<std::vector<ElementType>> & value) { this->type_arguments = value; }
    };

    class TentacledParameter {
        public:
        TentacledParameter() = default;
        virtual ~TentacledParameter() = default;

        private:
        std::optional<TentacledComment> comment;
        std::optional<std::string> default_value;
        TentacledFlags flags;
        int64_t id;
        int64_t kind;
        ParameterKindString kind_string;
        std::string name;
        std::optional<std::string> original_name;
        AmbitiousType type;

        public:
        const std::optional<TentacledComment> & get_comment() const { return comment; }
        std::optional<TentacledComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<TentacledComment> & value) { this->comment = value; }

        const std::optional<std::string> & get_default_value() const { return default_value; }
        std::optional<std::string> & get_mutable_default_value() { return default_value; }
        void set_default_value(const std::optional<std::string> & value) { this->default_value = value; }

        const TentacledFlags & get_flags() const { return flags; }
        TentacledFlags & get_mutable_flags() { return flags; }
        void set_flags(const TentacledFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const ParameterKindString & get_kind_string() const { return kind_string; }
        ParameterKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const ParameterKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<std::string> & get_original_name() const { return original_name; }
        std::optional<std::string> & get_mutable_original_name() { return original_name; }
        void set_original_name(const std::optional<std::string> & value) { this->original_name = value; }

        const AmbitiousType & get_type() const { return type; }
        AmbitiousType & get_mutable_type() { return type; }
        void set_type(const AmbitiousType & value) { this->type = value; }
    };

    class CunningType {
        public:
        CunningType() = default;
        virtual ~CunningType() = default;

        private:
        std::optional<PurpleDeclaration> declaration;
        std::optional<int64_t> id;
        std::optional<Name> name;
        TypeEnum type;
        std::optional<std::vector<ElementType>> type_arguments;

        public:
        const std::optional<PurpleDeclaration> & get_declaration() const { return declaration; }
        std::optional<PurpleDeclaration> & get_mutable_declaration() { return declaration; }
        void set_declaration(const std::optional<PurpleDeclaration> & value) { this->declaration = value; }

        const std::optional<int64_t> & get_id() const { return id; }
        std::optional<int64_t> & get_mutable_id() { return id; }
        void set_id(const std::optional<int64_t> & value) { this->id = value; }

        const std::optional<Name> & get_name() const { return name; }
        std::optional<Name> & get_mutable_name() { return name; }
        void set_name(const std::optional<Name> & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }

        const std::optional<std::vector<ElementType>> & get_type_arguments() const { return type_arguments; }
        std::optional<std::vector<ElementType>> & get_mutable_type_arguments() { return type_arguments; }
        void set_type_arguments(const std::optional<std::vector<ElementType>> & value) { this->type_arguments = value; }
    };

    class StickySignature {
        public:
        StickySignature() = default;
        virtual ~StickySignature() = default;

        private:
        StickyComment comment;
        IndigoFlags flags;
        int64_t id;
        int64_t kind;
        SignatureKindString kind_string;
        std::string name;
        std::optional<std::vector<TentacledParameter>> parameters;
        CunningType type;
        std::optional<std::vector<GetSignature>> type_parameter;

        public:
        const StickyComment & get_comment() const { return comment; }
        StickyComment & get_mutable_comment() { return comment; }
        void set_comment(const StickyComment & value) { this->comment = value; }

        const IndigoFlags & get_flags() const { return flags; }
        IndigoFlags & get_mutable_flags() { return flags; }
        void set_flags(const IndigoFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const SignatureKindString & get_kind_string() const { return kind_string; }
        SignatureKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const SignatureKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<std::vector<TentacledParameter>> & get_parameters() const { return parameters; }
        std::optional<std::vector<TentacledParameter>> & get_mutable_parameters() { return parameters; }
        void set_parameters(const std::optional<std::vector<TentacledParameter>> & value) { this->parameters = value; }

        const CunningType & get_type() const { return type; }
        CunningType & get_mutable_type() { return type; }
        void set_type(const CunningType & value) { this->type = value; }

        const std::optional<std::vector<GetSignature>> & get_type_parameter() const { return type_parameter; }
        std::optional<std::vector<GetSignature>> & get_mutable_type_parameter() { return type_parameter; }
        void set_type_parameter(const std::optional<std::vector<GetSignature>> & value) { this->type_parameter = value; }
    };

    class IndigoDeclaration {
        public:
        IndigoDeclaration() = default;
        virtual ~IndigoDeclaration() = default;

        private:
        std::optional<std::vector<GetSignature>> children;
        GetSignatureFlags flags;
        std::optional<std::vector<Group>> groups;
        int64_t id;
        int64_t kind;
        std::string kind_string;
        std::string name;
        std::optional<std::vector<GetSignature>> signatures;
        std::vector<Source> sources;

        public:
        const std::optional<std::vector<GetSignature>> & get_children() const { return children; }
        std::optional<std::vector<GetSignature>> & get_mutable_children() { return children; }
        void set_children(const std::optional<std::vector<GetSignature>> & value) { this->children = value; }

        const GetSignatureFlags & get_flags() const { return flags; }
        GetSignatureFlags & get_mutable_flags() { return flags; }
        void set_flags(const GetSignatureFlags & value) { this->flags = value; }

        const std::optional<std::vector<Group>> & get_groups() const { return groups; }
        std::optional<std::vector<Group>> & get_mutable_groups() { return groups; }
        void set_groups(const std::optional<std::vector<Group>> & value) { this->groups = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const std::string & get_kind_string() const { return kind_string; }
        std::string & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const std::string & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<std::vector<GetSignature>> & get_signatures() const { return signatures; }
        std::optional<std::vector<GetSignature>> & get_mutable_signatures() { return signatures; }
        void set_signatures(const std::optional<std::vector<GetSignature>> & value) { this->signatures = value; }

        const std::vector<Source> & get_sources() const { return sources; }
        std::vector<Source> & get_mutable_sources() { return sources; }
        void set_sources(const std::vector<Source> & value) { this->sources = value; }
    };

    class FriskyType {
        public:
        FriskyType() = default;
        virtual ~FriskyType() = default;

        private:
        std::optional<IndigoDeclaration> declaration;
        std::optional<Name> name;
        TypeEnum type;

        public:
        const std::optional<IndigoDeclaration> & get_declaration() const { return declaration; }
        std::optional<IndigoDeclaration> & get_mutable_declaration() { return declaration; }
        void set_declaration(const std::optional<IndigoDeclaration> & value) { this->declaration = value; }

        const std::optional<Name> & get_name() const { return name; }
        std::optional<Name> & get_mutable_name() { return name; }
        void set_name(const std::optional<Name> & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }
    };

    class IndecentChild {
        public:
        IndecentChild() = default;
        virtual ~IndecentChild() = default;

        private:
        FluffyFlags flags;
        int64_t id;
        int64_t kind;
        PurpleKindString kind_string;
        std::string name;
        std::vector<Source> sources;
        FriskyType type;

        public:
        const FluffyFlags & get_flags() const { return flags; }
        FluffyFlags & get_mutable_flags() { return flags; }
        void set_flags(const FluffyFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const PurpleKindString & get_kind_string() const { return kind_string; }
        PurpleKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const PurpleKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::vector<Source> & get_sources() const { return sources; }
        std::vector<Source> & get_mutable_sources() { return sources; }
        void set_sources(const std::vector<Source> & value) { this->sources = value; }

        const FriskyType & get_type() const { return type; }
        FriskyType & get_mutable_type() { return type; }
        void set_type(const FriskyType & value) { this->type = value; }
    };

    class StickyDeclaration {
        public:
        StickyDeclaration() = default;
        virtual ~StickyDeclaration() = default;

        private:
        std::optional<std::vector<IndecentChild>> children;
        GetSignatureFlags flags;
        std::optional<std::vector<Group>> groups;
        int64_t id;
        int64_t kind;
        std::string kind_string;
        std::string name;
        std::vector<GetSignature> signatures;
        std::vector<Source> sources;

        public:
        const std::optional<std::vector<IndecentChild>> & get_children() const { return children; }
        std::optional<std::vector<IndecentChild>> & get_mutable_children() { return children; }
        void set_children(const std::optional<std::vector<IndecentChild>> & value) { this->children = value; }

        const GetSignatureFlags & get_flags() const { return flags; }
        GetSignatureFlags & get_mutable_flags() { return flags; }
        void set_flags(const GetSignatureFlags & value) { this->flags = value; }

        const std::optional<std::vector<Group>> & get_groups() const { return groups; }
        std::optional<std::vector<Group>> & get_mutable_groups() { return groups; }
        void set_groups(const std::optional<std::vector<Group>> & value) { this->groups = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const std::string & get_kind_string() const { return kind_string; }
        std::string & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const std::string & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::vector<GetSignature> & get_signatures() const { return signatures; }
        std::vector<GetSignature> & get_mutable_signatures() { return signatures; }
        void set_signatures(const std::vector<GetSignature> & value) { this->signatures = value; }

        const std::vector<Source> & get_sources() const { return sources; }
        std::vector<Source> & get_mutable_sources() { return sources; }
        void set_sources(const std::vector<Source> & value) { this->sources = value; }
    };

    class FluffyTypeArgument {
        public:
        FluffyTypeArgument() = default;
        virtual ~FluffyTypeArgument() = default;

        private:
        TypeEnum type;
        std::vector<ElementType> types;

        public:
        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }

        const std::vector<ElementType> & get_types() const { return types; }
        std::vector<ElementType> & get_mutable_types() { return types; }
        void set_types(const std::vector<ElementType> & value) { this->types = value; }
    };

    class MagentaType {
        public:
        MagentaType() = default;
        virtual ~MagentaType() = default;

        private:
        std::optional<StickyDeclaration> declaration;
        std::optional<ElementType> element_type;
        std::optional<std::vector<ExtendedBy>> elements;
        std::optional<int64_t> id;
        std::optional<std::string> name;
        TypeEnum type;
        std::optional<std::vector<FluffyTypeArgument>> type_arguments;
        std::optional<std::vector<ExtendedBy>> types;
        std::optional<std::string> value;

        public:
        const std::optional<StickyDeclaration> & get_declaration() const { return declaration; }
        std::optional<StickyDeclaration> & get_mutable_declaration() { return declaration; }
        void set_declaration(const std::optional<StickyDeclaration> & value) { this->declaration = value; }

        const std::optional<ElementType> & get_element_type() const { return element_type; }
        std::optional<ElementType> & get_mutable_element_type() { return element_type; }
        void set_element_type(const std::optional<ElementType> & value) { this->element_type = value; }

        const std::optional<std::vector<ExtendedBy>> & get_elements() const { return elements; }
        std::optional<std::vector<ExtendedBy>> & get_mutable_elements() { return elements; }
        void set_elements(const std::optional<std::vector<ExtendedBy>> & value) { this->elements = value; }

        const std::optional<int64_t> & get_id() const { return id; }
        std::optional<int64_t> & get_mutable_id() { return id; }
        void set_id(const std::optional<int64_t> & value) { this->id = value; }

        const std::optional<std::string> & get_name() const { return name; }
        std::optional<std::string> & get_mutable_name() { return name; }
        void set_name(const std::optional<std::string> & value) { this->name = value; }

        const TypeEnum & get_type() const { return type; }
        TypeEnum & get_mutable_type() { return type; }
        void set_type(const TypeEnum & value) { this->type = value; }

        const std::optional<std::vector<FluffyTypeArgument>> & get_type_arguments() const { return type_arguments; }
        std::optional<std::vector<FluffyTypeArgument>> & get_mutable_type_arguments() { return type_arguments; }
        void set_type_arguments(const std::optional<std::vector<FluffyTypeArgument>> & value) { this->type_arguments = value; }

        const std::optional<std::vector<ExtendedBy>> & get_types() const { return types; }
        std::optional<std::vector<ExtendedBy>> & get_mutable_types() { return types; }
        void set_types(const std::optional<std::vector<ExtendedBy>> & value) { this->types = value; }

        const std::optional<std::string> & get_value() const { return value; }
        std::optional<std::string> & get_mutable_value() { return value; }
        void set_value(const std::optional<std::string> & value) { this->value = value; }
    };

    class MischievousType {
        public:
        MischievousType() = default;
        virtual ~MischievousType() = default;

        private:
        std::optional<int64_t> id;
        std::optional<Name> name;
        std::optional<ElementType> target;
        std::string type;
        std::optional<std::string> type_operator;

        public:
        const std::optional<int64_t> & get_id() const { return id; }
        std::optional<int64_t> & get_mutable_id() { return id; }
        void set_id(const std::optional<int64_t> & value) { this->id = value; }

        const std::optional<Name> & get_name() const { return name; }
        std::optional<Name> & get_mutable_name() { return name; }
        void set_name(const std::optional<Name> & value) { this->name = value; }

        const std::optional<ElementType> & get_target() const { return target; }
        std::optional<ElementType> & get_mutable_target() { return target; }
        void set_target(const std::optional<ElementType> & value) { this->target = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }

        const std::optional<std::string> & get_type_operator() const { return type_operator; }
        std::optional<std::string> & get_mutable_type_operator() { return type_operator; }
        void set_type_operator(const std::optional<std::string> & value) { this->type_operator = value; }
    };

    class TypeParameter {
        public:
        TypeParameter() = default;
        virtual ~TypeParameter() = default;

        private:
        std::optional<PurpleComment> comment;
        GetSignatureFlags flags;
        int64_t id;
        int64_t kind;
        std::string kind_string;
        std::string name;
        std::optional<MischievousType> type;

        public:
        const std::optional<PurpleComment> & get_comment() const { return comment; }
        std::optional<PurpleComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<PurpleComment> & value) { this->comment = value; }

        const GetSignatureFlags & get_flags() const { return flags; }
        GetSignatureFlags & get_mutable_flags() { return flags; }
        void set_flags(const GetSignatureFlags & value) { this->flags = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const std::string & get_kind_string() const { return kind_string; }
        std::string & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const std::string & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<MischievousType> & get_type() const { return type; }
        std::optional<MischievousType> & get_mutable_type() { return type; }
        void set_type(const std::optional<MischievousType> & value) { this->type = value; }
    };

    class PurpleChild {
        public:
        PurpleChild() = default;
        virtual ~PurpleChild() = default;

        private:
        std::optional<std::vector<FluffyChild>> children;
        std::optional<StickyComment> comment;
        std::optional<std::string> default_value;
        std::optional<std::vector<ExtendedBy>> extended_by;
        std::optional<std::vector<ExtendedBy>> extended_types;
        IndecentFlags flags;
        std::optional<std::vector<Group>> groups;
        int64_t id;
        std::optional<std::vector<ExtendedBy>> implemented_by;
        std::optional<std::vector<ExtendedBy>> implemented_types;
        int64_t kind;
        FluffyKindString kind_string;
        std::string name;
        std::optional<std::vector<StickySignature>> signatures;
        std::vector<Source> sources;
        std::optional<MagentaType> type;
        std::optional<std::vector<TypeParameter>> type_parameter;

        public:
        const std::optional<std::vector<FluffyChild>> & get_children() const { return children; }
        std::optional<std::vector<FluffyChild>> & get_mutable_children() { return children; }
        void set_children(const std::optional<std::vector<FluffyChild>> & value) { this->children = value; }

        const std::optional<StickyComment> & get_comment() const { return comment; }
        std::optional<StickyComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<StickyComment> & value) { this->comment = value; }

        const std::optional<std::string> & get_default_value() const { return default_value; }
        std::optional<std::string> & get_mutable_default_value() { return default_value; }
        void set_default_value(const std::optional<std::string> & value) { this->default_value = value; }

        const std::optional<std::vector<ExtendedBy>> & get_extended_by() const { return extended_by; }
        std::optional<std::vector<ExtendedBy>> & get_mutable_extended_by() { return extended_by; }
        void set_extended_by(const std::optional<std::vector<ExtendedBy>> & value) { this->extended_by = value; }

        const std::optional<std::vector<ExtendedBy>> & get_extended_types() const { return extended_types; }
        std::optional<std::vector<ExtendedBy>> & get_mutable_extended_types() { return extended_types; }
        void set_extended_types(const std::optional<std::vector<ExtendedBy>> & value) { this->extended_types = value; }

        const IndecentFlags & get_flags() const { return flags; }
        IndecentFlags & get_mutable_flags() { return flags; }
        void set_flags(const IndecentFlags & value) { this->flags = value; }

        const std::optional<std::vector<Group>> & get_groups() const { return groups; }
        std::optional<std::vector<Group>> & get_mutable_groups() { return groups; }
        void set_groups(const std::optional<std::vector<Group>> & value) { this->groups = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::optional<std::vector<ExtendedBy>> & get_implemented_by() const { return implemented_by; }
        std::optional<std::vector<ExtendedBy>> & get_mutable_implemented_by() { return implemented_by; }
        void set_implemented_by(const std::optional<std::vector<ExtendedBy>> & value) { this->implemented_by = value; }

        const std::optional<std::vector<ExtendedBy>> & get_implemented_types() const { return implemented_types; }
        std::optional<std::vector<ExtendedBy>> & get_mutable_implemented_types() { return implemented_types; }
        void set_implemented_types(const std::optional<std::vector<ExtendedBy>> & value) { this->implemented_types = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const FluffyKindString & get_kind_string() const { return kind_string; }
        FluffyKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const FluffyKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<std::vector<StickySignature>> & get_signatures() const { return signatures; }
        std::optional<std::vector<StickySignature>> & get_mutable_signatures() { return signatures; }
        void set_signatures(const std::optional<std::vector<StickySignature>> & value) { this->signatures = value; }

        const std::vector<Source> & get_sources() const { return sources; }
        std::vector<Source> & get_mutable_sources() { return sources; }
        void set_sources(const std::vector<Source> & value) { this->sources = value; }

        const std::optional<MagentaType> & get_type() const { return type; }
        std::optional<MagentaType> & get_mutable_type() { return type; }
        void set_type(const std::optional<MagentaType> & value) { this->type = value; }

        const std::optional<std::vector<TypeParameter>> & get_type_parameter() const { return type_parameter; }
        std::optional<std::vector<TypeParameter>> & get_mutable_type_parameter() { return type_parameter; }
        void set_type_parameter(const std::optional<std::vector<TypeParameter>> & value) { this->type_parameter = value; }
    };

    class IndecentComment {
        public:
        IndecentComment() = default;
        virtual ~IndecentComment() = default;

        private:
        std::string short_text;
        std::optional<std::vector<Tag>> tags;

        public:
        const std::string & get_short_text() const { return short_text; }
        std::string & get_mutable_short_text() { return short_text; }
        void set_short_text(const std::string & value) { this->short_text = value; }

        const std::optional<std::vector<Tag>> & get_tags() const { return tags; }
        std::optional<std::vector<Tag>> & get_mutable_tags() { return tags; }
        void set_tags(const std::optional<std::vector<Tag>> & value) { this->tags = value; }
    };

    enum class TentacledKindString : int { EXTERNAL_MODULE };

    class TopLevelChild {
        public:
        TopLevelChild() = default;
        virtual ~TopLevelChild() = default;

        private:
        std::vector<PurpleChild> children;
        std::optional<IndecentComment> comment;
        PurpleFlags flags;
        std::vector<Group> groups;
        int64_t id;
        int64_t kind;
        TentacledKindString kind_string;
        std::string name;
        std::string original_name;
        std::vector<Source> sources;

        public:
        const std::vector<PurpleChild> & get_children() const { return children; }
        std::vector<PurpleChild> & get_mutable_children() { return children; }
        void set_children(const std::vector<PurpleChild> & value) { this->children = value; }

        const std::optional<IndecentComment> & get_comment() const { return comment; }
        std::optional<IndecentComment> & get_mutable_comment() { return comment; }
        void set_comment(const std::optional<IndecentComment> & value) { this->comment = value; }

        const PurpleFlags & get_flags() const { return flags; }
        PurpleFlags & get_mutable_flags() { return flags; }
        void set_flags(const PurpleFlags & value) { this->flags = value; }

        const std::vector<Group> & get_groups() const { return groups; }
        std::vector<Group> & get_mutable_groups() { return groups; }
        void set_groups(const std::vector<Group> & value) { this->groups = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const TentacledKindString & get_kind_string() const { return kind_string; }
        TentacledKindString & get_mutable_kind_string() { return kind_string; }
        void set_kind_string(const TentacledKindString & value) { this->kind_string = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_original_name() const { return original_name; }
        std::string & get_mutable_original_name() { return original_name; }
        void set_original_name(const std::string & value) { this->original_name = value; }

        const std::vector<Source> & get_sources() const { return sources; }
        std::vector<Source> & get_mutable_sources() { return sources; }
        void set_sources(const std::vector<Source> & value) { this->sources = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<TopLevelChild> children;
        GetSignatureFlags flags;
        std::vector<Group> groups;
        int64_t id;
        int64_t kind;
        std::string name;

        public:
        const std::vector<TopLevelChild> & get_children() const { return children; }
        std::vector<TopLevelChild> & get_mutable_children() { return children; }
        void set_children(const std::vector<TopLevelChild> & value) { this->children = value; }

        const GetSignatureFlags & get_flags() const { return flags; }
        GetSignatureFlags & get_mutable_flags() { return flags; }
        void set_flags(const GetSignatureFlags & value) { this->flags = value; }

        const std::vector<Group> & get_groups() const { return groups; }
        std::vector<Group> & get_mutable_groups() { return groups; }
        void set_groups(const std::vector<Group> & value) { this->groups = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const int64_t & get_kind() const { return kind; }
        int64_t & get_mutable_kind() { return kind; }
        void set_kind(const int64_t & value) { this->kind = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, PurpleComment & x);
    void to_json(json & j, const PurpleComment & x);

    void from_json(const json & j, PurpleFlags & x);
    void to_json(json & j, const PurpleFlags & x);

    void from_json(const json & j, GetSignatureFlags & x);
    void to_json(json & j, const GetSignatureFlags & x);

    void from_json(const json & j, ElementType & x);
    void to_json(json & j, const ElementType & x);

    void from_json(const json & j, FluffyComment & x);
    void to_json(json & j, const FluffyComment & x);

    void from_json(const json & j, FluffyFlags & x);
    void to_json(json & j, const FluffyFlags & x);

    void from_json(const json & j, Source & x);
    void to_json(json & j, const Source & x);

    void from_json(const json & j, GetSignatureComment & x);
    void to_json(json & j, const GetSignatureComment & x);

    void from_json(const json & j, Group & x);
    void to_json(json & j, const Group & x);

    void from_json(const json & j, TentacledComment & x);
    void to_json(json & j, const TentacledComment & x);

    void from_json(const json & j, TentacledFlags & x);
    void to_json(json & j, const TentacledFlags & x);

    void from_json(const json & j, FluffyType & x);
    void to_json(json & j, const FluffyType & x);

    void from_json(const json & j, GetSignatureParameter & x);
    void to_json(json & j, const GetSignatureParameter & x);

    void from_json(const json & j, GetSignatureType & x);
    void to_json(json & j, const GetSignatureType & x);

    void from_json(const json & j, IndexSignatureElement & x);
    void to_json(json & j, const IndexSignatureElement & x);

    void from_json(const json & j, PurpleType & x);
    void to_json(json & j, const PurpleType & x);

    void from_json(const json & j, GetSignatureChild & x);
    void to_json(json & j, const GetSignatureChild & x);

    void from_json(const json & j, GetSignature & x);
    void to_json(json & j, const GetSignature & x);

    void from_json(const json & j, PurpleDeclaration & x);
    void to_json(json & j, const PurpleDeclaration & x);

    void from_json(const json & j, TentacledType & x);
    void to_json(json & j, const TentacledType & x);

    void from_json(const json & j, PurpleSignature & x);
    void to_json(json & j, const PurpleSignature & x);

    void from_json(const json & j, TypeElement & x);
    void to_json(json & j, const TypeElement & x);

    void from_json(const json & j, TentacledChild & x);
    void to_json(json & j, const TentacledChild & x);

    void from_json(const json & j, Tag & x);
    void to_json(json & j, const Tag & x);

    void from_json(const json & j, StickyComment & x);
    void to_json(json & j, const StickyComment & x);

    void from_json(const json & j, StickyFlags & x);
    void to_json(json & j, const StickyFlags & x);

    void from_json(const json & j, ExtendedBy & x);
    void to_json(json & j, const ExtendedBy & x);

    void from_json(const json & j, IndigoFlags & x);
    void to_json(json & j, const IndigoFlags & x);

    void from_json(const json & j, StickyType & x);
    void to_json(json & j, const StickyType & x);

    void from_json(const json & j, PurpleParameter & x);
    void to_json(json & j, const PurpleParameter & x);

    void from_json(const json & j, FluffySignature & x);
    void to_json(json & j, const FluffySignature & x);

    void from_json(const json & j, IndecentType & x);
    void to_json(json & j, const IndecentType & x);

    void from_json(const json & j, StickyChild & x);
    void to_json(json & j, const StickyChild & x);

    void from_json(const json & j, HilariousType & x);
    void to_json(json & j, const HilariousType & x);

    void from_json(const json & j, IndexSignature & x);
    void to_json(json & j, const IndexSignature & x);

    void from_json(const json & j, IndigoComment & x);
    void to_json(json & j, const IndigoComment & x);

    void from_json(const json & j, FluffyParameter & x);
    void to_json(json & j, const FluffyParameter & x);

    void from_json(const json & j, TentacledSignature & x);
    void to_json(json & j, const TentacledSignature & x);

    void from_json(const json & j, FluffyDeclaration & x);
    void to_json(json & j, const FluffyDeclaration & x);

    void from_json(const json & j, PurpleTypeArgument & x);
    void to_json(json & j, const PurpleTypeArgument & x);

    void from_json(const json & j, IndigoType & x);
    void to_json(json & j, const IndigoType & x);

    void from_json(const json & j, FluffyChild & x);
    void to_json(json & j, const FluffyChild & x);

    void from_json(const json & j, IndecentFlags & x);
    void to_json(json & j, const IndecentFlags & x);

    void from_json(const json & j, IndigoChild & x);
    void to_json(json & j, const IndigoChild & x);

    void from_json(const json & j, TentacledDeclaration & x);
    void to_json(json & j, const TentacledDeclaration & x);

    void from_json(const json & j, AmbitiousType & x);
    void to_json(json & j, const AmbitiousType & x);

    void from_json(const json & j, TentacledParameter & x);
    void to_json(json & j, const TentacledParameter & x);

    void from_json(const json & j, CunningType & x);
    void to_json(json & j, const CunningType & x);

    void from_json(const json & j, StickySignature & x);
    void to_json(json & j, const StickySignature & x);

    void from_json(const json & j, IndigoDeclaration & x);
    void to_json(json & j, const IndigoDeclaration & x);

    void from_json(const json & j, FriskyType & x);
    void to_json(json & j, const FriskyType & x);

    void from_json(const json & j, IndecentChild & x);
    void to_json(json & j, const IndecentChild & x);

    void from_json(const json & j, StickyDeclaration & x);
    void to_json(json & j, const StickyDeclaration & x);

    void from_json(const json & j, FluffyTypeArgument & x);
    void to_json(json & j, const FluffyTypeArgument & x);

    void from_json(const json & j, MagentaType & x);
    void to_json(json & j, const MagentaType & x);

    void from_json(const json & j, MischievousType & x);
    void to_json(json & j, const MischievousType & x);

    void from_json(const json & j, TypeParameter & x);
    void to_json(json & j, const TypeParameter & x);

    void from_json(const json & j, PurpleChild & x);
    void to_json(json & j, const PurpleChild & x);

    void from_json(const json & j, IndecentComment & x);
    void to_json(json & j, const IndecentComment & x);

    void from_json(const json & j, TopLevelChild & x);
    void to_json(json & j, const TopLevelChild & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, PurpleKindString & x);
    void to_json(json & j, const PurpleKindString & x);

    void from_json(const json & j, SignatureKindString & x);
    void to_json(json & j, const SignatureKindString & x);

    void from_json(const json & j, Name & x);
    void to_json(json & j, const Name & x);

    void from_json(const json & j, TypeEnum & x);
    void to_json(json & j, const TypeEnum & x);

    void from_json(const json & j, FileName & x);
    void to_json(json & j, const FileName & x);

    void from_json(const json & j, ParameterKindString & x);
    void to_json(json & j, const ParameterKindString & x);

    void from_json(const json & j, FluffyKindString & x);
    void to_json(json & j, const FluffyKindString & x);

    void from_json(const json & j, TentacledKindString & x);
    void to_json(json & j, const TentacledKindString & x);

    inline void from_json(const json & j, PurpleComment& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_short_text(j.at("shortText").get<std::string>());
    }

    inline void to_json(json & j, const PurpleComment & x) {
        j = json::object();
        j["shortText"] = x.get_short_text();
    }

    inline void from_json(const json & j, PurpleFlags& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("isExported") != j.end() && j.at("isExported").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_exported(get_stack_optional<bool>(j, "isExported"));
    }

    inline void to_json(json & j, const PurpleFlags & x) {
        j = json::object();
        j["isExported"] = x.get_is_exported();
    }

    inline void from_json(const json & j, GetSignatureFlags& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const GetSignatureFlags & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, ElementType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_name(j.at("name").get<Name>());
        x.set_type(j.at("type").get<TypeEnum>());
    }

    inline void to_json(json & j, const ElementType & x) {
        j = json::object();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, FluffyComment& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_text(j.at("text").get<std::string>());
    }

    inline void to_json(json & j, const FluffyComment & x) {
        j = json::object();
        j["text"] = x.get_text();
    }

    inline void from_json(const json & j, FluffyFlags& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("isOptional") != j.end() && j.at("isOptional").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_optional(get_stack_optional<bool>(j, "isOptional"));
    }

    inline void to_json(json & j, const FluffyFlags & x) {
        j = json::object();
        j["isOptional"] = x.get_is_optional();
    }

    inline void from_json(const json & j, Source& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("character") != j.end() && !j.at("character").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_character(j.at("character").get<int64_t>());
        x.set_file_name(j.at("fileName").get<FileName>());
        if (j.find("line") != j.end() && !j.at("line").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_line(j.at("line").get<int64_t>());
    }

    inline void to_json(json & j, const Source & x) {
        j = json::object();
        j["character"] = x.get_character();
        j["fileName"] = x.get_file_name();
        j["line"] = x.get_line();
    }

    inline void from_json(const json & j, GetSignatureComment& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("returns") != j.end() && j.at("returns").is_null()) throw std::runtime_error("Unexpected null");
        x.set_returns(get_stack_optional<std::string>(j, "returns"));
        if (j.find("shortText") != j.end() && j.at("shortText").is_null()) throw std::runtime_error("Unexpected null");
        x.set_short_text(get_stack_optional<std::string>(j, "shortText"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<std::string>(j, "text"));
    }

    inline void to_json(json & j, const GetSignatureComment & x) {
        j = json::object();
        j["returns"] = x.get_returns();
        j["shortText"] = x.get_short_text();
        j["text"] = x.get_text();
    }

    inline void from_json(const json & j, Group& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_children(j.at("children").get<std::vector<int64_t>>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_title(j.at("title").get<std::string>());
    }

    inline void to_json(json & j, const Group & x) {
        j = json::object();
        j["children"] = x.get_children();
        j["kind"] = x.get_kind();
        j["title"] = x.get_title();
    }

    inline void from_json(const json & j, TentacledComment& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("shortText") != j.end() && j.at("shortText").is_null()) throw std::runtime_error("Unexpected null");
        x.set_short_text(get_stack_optional<std::string>(j, "shortText"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<std::string>(j, "text"));
    }

    inline void to_json(json & j, const TentacledComment & x) {
        j = json::object();
        j["shortText"] = x.get_short_text();
        j["text"] = x.get_text();
    }

    inline void from_json(const json & j, TentacledFlags& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("isOptional") != j.end() && j.at("isOptional").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_optional(get_stack_optional<bool>(j, "isOptional"));
        if (j.find("isRest") != j.end() && j.at("isRest").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_rest(get_stack_optional<bool>(j, "isRest"));
    }

    inline void to_json(json & j, const TentacledFlags & x) {
        j = json::object();
        j["isOptional"] = x.get_is_optional();
        j["isRest"] = x.get_is_rest();
    }

    inline void from_json(const json & j, FluffyType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("elementType") != j.end() && j.at("elementType").is_null()) throw std::runtime_error("Unexpected null");
        x.set_element_type(get_stack_optional<ElementType>(j, "elementType"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<Name>(j, "name"));
        x.set_type(j.at("type").get<TypeEnum>());
        if (j.find("typeArguments") != j.end() && j.at("typeArguments").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type_arguments(get_stack_optional<std::vector<ElementType>>(j, "typeArguments"));
    }

    inline void to_json(json & j, const FluffyType & x) {
        j = json::object();
        j["elementType"] = x.get_element_type();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
        j["typeArguments"] = x.get_type_arguments();
    }

    inline void from_json(const json & j, GetSignatureParameter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<TentacledComment>(j, "comment"));
        x.set_flags(j.at("flags").get<TentacledFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<ParameterKindString>());
        x.set_name(j.at("name").get<std::string>());
        x.set_type(j.at("type").get<FluffyType>());
    }

    inline void to_json(json & j, const GetSignatureParameter & x) {
        j = json::object();
        j["comment"] = x.get_comment();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, GetSignatureType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("declaration") != j.end() && j.at("declaration").is_null()) throw std::runtime_error("Unexpected null");
        x.set_declaration(get_heap_optional<GetSignature>(j, "declaration"));
        if (j.find("elementType") != j.end() && j.at("elementType").is_null()) throw std::runtime_error("Unexpected null");
        x.set_element_type(get_stack_optional<ElementType>(j, "elementType"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<Name>(j, "name"));
        x.set_type(j.at("type").get<TypeEnum>());
    }

    inline void to_json(json & j, const GetSignatureType & x) {
        j = json::object();
        j["declaration"] = x.get_declaration();
        j["elementType"] = x.get_element_type();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, IndexSignatureElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_flags(j.at("flags").get<GetSignatureFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("parameters") != j.end() && j.at("parameters").is_null()) throw std::runtime_error("Unexpected null");
        x.set_parameters(get_stack_optional<std::vector<GetSignature>>(j, "parameters"));
        x.set_type(j.at("type").get<std::shared_ptr<PurpleType>>());
    }

    inline void to_json(json & j, const IndexSignatureElement & x) {
        j = json::object();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["parameters"] = x.get_parameters();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, PurpleType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("declaration") != j.end() && j.at("declaration").is_null()) throw std::runtime_error("Unexpected null");
        x.set_declaration(get_heap_optional<GetSignature>(j, "declaration"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<Name>(j, "name"));
        x.set_type(j.at("type").get<TypeEnum>());
    }

    inline void to_json(json & j, const PurpleType & x) {
        j = json::object();
        j["declaration"] = x.get_declaration();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, GetSignatureChild& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<FluffyComment>(j, "comment"));
        x.set_flags(j.at("flags").get<FluffyFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<PurpleKindString>());
        x.set_name(j.at("name").get<std::string>());
        x.set_sources(j.at("sources").get<std::vector<Source>>());
        x.set_type(j.at("type").get<std::shared_ptr<PurpleType>>());
    }

    inline void to_json(json & j, const GetSignatureChild & x) {
        j = json::object();
        j["comment"] = x.get_comment();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["sources"] = x.get_sources();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, GetSignature& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("children") != j.end() && j.at("children").is_null()) throw std::runtime_error("Unexpected null");
        x.set_children(get_stack_optional<std::vector<GetSignatureChild>>(j, "children"));
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<GetSignatureComment>(j, "comment"));
        if (j.find("defaultValue") != j.end() && j.at("defaultValue").is_null()) throw std::runtime_error("Unexpected null");
        x.set_default_value(get_stack_optional<std::string>(j, "defaultValue"));
        x.set_flags(j.at("flags").get<GetSignatureFlags>());
        if (j.find("groups") != j.end() && j.at("groups").is_null()) throw std::runtime_error("Unexpected null");
        x.set_groups(get_stack_optional<std::vector<Group>>(j, "groups"));
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("parameters") != j.end() && j.at("parameters").is_null()) throw std::runtime_error("Unexpected null");
        x.set_parameters(get_stack_optional<std::vector<GetSignatureParameter>>(j, "parameters"));
        if (j.find("signatures") != j.end() && j.at("signatures").is_null()) throw std::runtime_error("Unexpected null");
        x.set_signatures(get_stack_optional<std::vector<IndexSignatureElement>>(j, "signatures"));
        if (j.find("sources") != j.end() && j.at("sources").is_null()) throw std::runtime_error("Unexpected null");
        x.set_sources(get_stack_optional<std::vector<Source>>(j, "sources"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_heap_optional<GetSignatureType>(j, "type"));
        if (j.find("typeParameter") != j.end() && j.at("typeParameter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type_parameter(get_stack_optional<std::vector<GetSignature>>(j, "typeParameter"));
    }

    inline void to_json(json & j, const GetSignature & x) {
        j = json::object();
        j["children"] = x.get_children();
        j["comment"] = x.get_comment();
        j["defaultValue"] = x.get_default_value();
        j["flags"] = x.get_flags();
        j["groups"] = x.get_groups();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["parameters"] = x.get_parameters();
        j["signatures"] = x.get_signatures();
        j["sources"] = x.get_sources();
        j["type"] = x.get_type();
        j["typeParameter"] = x.get_type_parameter();
    }

    inline void from_json(const json & j, PurpleDeclaration& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_children(j.at("children").get<std::vector<GetSignature>>());
        x.set_flags(j.at("flags").get<GetSignatureFlags>());
        x.set_groups(j.at("groups").get<std::vector<Group>>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const PurpleDeclaration & x) {
        j = json::object();
        j["children"] = x.get_children();
        j["flags"] = x.get_flags();
        j["groups"] = x.get_groups();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, TentacledType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("declaration") != j.end() && j.at("declaration").is_null()) throw std::runtime_error("Unexpected null");
        x.set_declaration(get_stack_optional<PurpleDeclaration>(j, "declaration"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<Name>(j, "name"));
        x.set_type(j.at("type").get<TypeEnum>());
    }

    inline void to_json(json & j, const TentacledType & x) {
        j = json::object();
        j["declaration"] = x.get_declaration();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, PurpleSignature& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<PurpleComment>(j, "comment"));
        x.set_flags(j.at("flags").get<GetSignatureFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<SignatureKindString>());
        x.set_name(j.at("name").get<std::string>());
        x.set_parameters(j.at("parameters").get<std::vector<GetSignature>>());
        x.set_type(j.at("type").get<TentacledType>());
    }

    inline void to_json(json & j, const PurpleSignature & x) {
        j = json::object();
        j["comment"] = x.get_comment();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["parameters"] = x.get_parameters();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, TypeElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("declaration") != j.end() && j.at("declaration").is_null()) throw std::runtime_error("Unexpected null");
        x.set_declaration(get_heap_optional<GetSignature>(j, "declaration"));
        if (j.find("elementType") != j.end() && j.at("elementType").is_null()) throw std::runtime_error("Unexpected null");
        x.set_element_type(get_stack_optional<ElementType>(j, "elementType"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<Name>(j, "name"));
        x.set_type(j.at("type").get<TypeEnum>());
        if (j.find("typeArguments") != j.end() && j.at("typeArguments").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type_arguments(get_stack_optional<std::vector<ElementType>>(j, "typeArguments"));
    }

    inline void to_json(json & j, const TypeElement & x) {
        j = json::object();
        j["declaration"] = x.get_declaration();
        j["elementType"] = x.get_element_type();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
        j["typeArguments"] = x.get_type_arguments();
    }

    inline void from_json(const json & j, TentacledChild& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<PurpleComment>(j, "comment"));
        if (j.find("defaultValue") != j.end() && j.at("defaultValue").is_null()) throw std::runtime_error("Unexpected null");
        x.set_default_value(get_stack_optional<std::string>(j, "defaultValue"));
        x.set_flags(j.at("flags").get<PurpleFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<PurpleKindString>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("signatures") != j.end() && j.at("signatures").is_null()) throw std::runtime_error("Unexpected null");
        x.set_signatures(get_stack_optional<std::vector<PurpleSignature>>(j, "signatures"));
        x.set_sources(j.at("sources").get<std::vector<Source>>());
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<TypeElement>(j, "type"));
    }

    inline void to_json(json & j, const TentacledChild & x) {
        j = json::object();
        j["comment"] = x.get_comment();
        j["defaultValue"] = x.get_default_value();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["signatures"] = x.get_signatures();
        j["sources"] = x.get_sources();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Tag& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_tag(j.at("tag").get<std::string>());
        x.set_text(j.at("text").get<std::string>());
    }

    inline void to_json(json & j, const Tag & x) {
        j = json::object();
        j["tag"] = x.get_tag();
        j["text"] = x.get_text();
    }

    inline void from_json(const json & j, StickyComment& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("returns") != j.end() && j.at("returns").is_null()) throw std::runtime_error("Unexpected null");
        x.set_returns(get_stack_optional<std::string>(j, "returns"));
        if (j.find("shortText") != j.end() && j.at("shortText").is_null()) throw std::runtime_error("Unexpected null");
        x.set_short_text(get_stack_optional<std::string>(j, "shortText"));
        if (j.find("tags") != j.end() && j.at("tags").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tags(get_stack_optional<std::vector<Tag>>(j, "tags"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<std::string>(j, "text"));
    }

    inline void to_json(json & j, const StickyComment & x) {
        j = json::object();
        j["returns"] = x.get_returns();
        j["shortText"] = x.get_short_text();
        j["tags"] = x.get_tags();
        j["text"] = x.get_text();
    }

    inline void from_json(const json & j, StickyFlags& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("isAbstract") != j.end() && j.at("isAbstract").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_abstract(get_stack_optional<bool>(j, "isAbstract"));
        if (j.find("isConstructorProperty") != j.end() && j.at("isConstructorProperty").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_constructor_property(get_stack_optional<bool>(j, "isConstructorProperty"));
        if (j.find("isExported") != j.end() && j.at("isExported").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_exported(get_stack_optional<bool>(j, "isExported"));
        if (j.find("isPrivate") != j.end() && j.at("isPrivate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_private(get_stack_optional<bool>(j, "isPrivate"));
        if (j.find("isProtected") != j.end() && j.at("isProtected").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_protected(get_stack_optional<bool>(j, "isProtected"));
        if (j.find("isPublic") != j.end() && j.at("isPublic").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_public(get_stack_optional<bool>(j, "isPublic"));
        if (j.find("isStatic") != j.end() && j.at("isStatic").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_static(get_stack_optional<bool>(j, "isStatic"));
    }

    inline void to_json(json & j, const StickyFlags & x) {
        j = json::object();
        j["isAbstract"] = x.get_is_abstract();
        j["isConstructorProperty"] = x.get_is_constructor_property();
        j["isExported"] = x.get_is_exported();
        j["isPrivate"] = x.get_is_private();
        j["isProtected"] = x.get_is_protected();
        j["isPublic"] = x.get_is_public();
        j["isStatic"] = x.get_is_static();
    }

    inline void from_json(const json & j, ExtendedBy& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("constraint") != j.end() && j.at("constraint").is_null()) throw std::runtime_error("Unexpected null");
        x.set_constraint(get_heap_optional<ExtendedBy>(j, "constraint"));
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("id") != j.end() && j.at("id").is_null()) throw std::runtime_error("Unexpected null");
        x.set_id(get_stack_optional<int64_t>(j, "id"));
        x.set_name(j.at("name").get<std::string>());
        x.set_type(j.at("type").get<TypeEnum>());
        if (j.find("typeArguments") != j.end() && j.at("typeArguments").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type_arguments(get_stack_optional<std::vector<ExtendedBy>>(j, "typeArguments"));
    }

    inline void to_json(json & j, const ExtendedBy & x) {
        j = json::object();
        j["constraint"] = x.get_constraint();
        j["id"] = x.get_id();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
        j["typeArguments"] = x.get_type_arguments();
    }

    inline void from_json(const json & j, IndigoFlags& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("isPrivate") != j.end() && j.at("isPrivate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_private(get_stack_optional<bool>(j, "isPrivate"));
        if (j.find("isProtected") != j.end() && j.at("isProtected").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_protected(get_stack_optional<bool>(j, "isProtected"));
    }

    inline void to_json(json & j, const IndigoFlags & x) {
        j = json::object();
        j["isPrivate"] = x.get_is_private();
        j["isProtected"] = x.get_is_protected();
    }

    inline void from_json(const json & j, StickyType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("constraint") != j.end() && j.at("constraint").is_null()) throw std::runtime_error("Unexpected null");
        x.set_constraint(get_heap_optional<ExtendedBy>(j, "constraint"));
        if (j.find("declaration") != j.end() && j.at("declaration").is_null()) throw std::runtime_error("Unexpected null");
        x.set_declaration(get_heap_optional<GetSignature>(j, "declaration"));
        if (j.find("elementType") != j.end() && j.at("elementType").is_null()) throw std::runtime_error("Unexpected null");
        x.set_element_type(get_stack_optional<ElementType>(j, "elementType"));
        if (j.find("elements") != j.end() && j.at("elements").is_null()) throw std::runtime_error("Unexpected null");
        x.set_elements(get_stack_optional<std::vector<ExtendedBy>>(j, "elements"));
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("id") != j.end() && j.at("id").is_null()) throw std::runtime_error("Unexpected null");
        x.set_id(get_stack_optional<int64_t>(j, "id"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<std::string>(j, "name"));
        x.set_type(j.at("type").get<TypeEnum>());
        if (j.find("typeArguments") != j.end() && j.at("typeArguments").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type_arguments(get_stack_optional<std::vector<ElementType>>(j, "typeArguments"));
    }

    inline void to_json(json & j, const StickyType & x) {
        j = json::object();
        j["constraint"] = x.get_constraint();
        j["declaration"] = x.get_declaration();
        j["elementType"] = x.get_element_type();
        j["elements"] = x.get_elements();
        j["id"] = x.get_id();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
        j["typeArguments"] = x.get_type_arguments();
    }

    inline void from_json(const json & j, PurpleParameter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<TentacledComment>(j, "comment"));
        x.set_flags(j.at("flags").get<GetSignatureFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<ParameterKindString>());
        x.set_name(j.at("name").get<std::string>());
        x.set_type(j.at("type").get<StickyType>());
    }

    inline void to_json(json & j, const PurpleParameter & x) {
        j = json::object();
        j["comment"] = x.get_comment();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, FluffySignature& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<StickyComment>(j, "comment"));
        x.set_flags(j.at("flags").get<IndigoFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("implementationOf") != j.end() && j.at("implementationOf").is_null()) throw std::runtime_error("Unexpected null");
        x.set_implementation_of(get_heap_optional<ExtendedBy>(j, "implementationOf"));
        if (j.find("inheritedFrom") != j.end() && j.at("inheritedFrom").is_null()) throw std::runtime_error("Unexpected null");
        x.set_inherited_from(get_heap_optional<ExtendedBy>(j, "inheritedFrom"));
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<SignatureKindString>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("overwrites") != j.end() && j.at("overwrites").is_null()) throw std::runtime_error("Unexpected null");
        x.set_overwrites(get_heap_optional<ExtendedBy>(j, "overwrites"));
        if (j.find("parameters") != j.end() && j.at("parameters").is_null()) throw std::runtime_error("Unexpected null");
        x.set_parameters(get_stack_optional<std::vector<PurpleParameter>>(j, "parameters"));
        x.set_type(j.at("type").get<ExtendedBy>());
        if (j.find("typeParameter") != j.end() && j.at("typeParameter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type_parameter(get_stack_optional<std::vector<GetSignature>>(j, "typeParameter"));
    }

    inline void to_json(json & j, const FluffySignature & x) {
        j = json::object();
        j["comment"] = x.get_comment();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["implementationOf"] = x.get_implementation_of();
        j["inheritedFrom"] = x.get_inherited_from();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["overwrites"] = x.get_overwrites();
        j["parameters"] = x.get_parameters();
        j["type"] = x.get_type();
        j["typeParameter"] = x.get_type_parameter();
    }

    inline void from_json(const json & j, IndecentType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("declaration") != j.end() && j.at("declaration").is_null()) throw std::runtime_error("Unexpected null");
        x.set_declaration(get_heap_optional<GetSignature>(j, "declaration"));
        if (j.find("elements") != j.end() && j.at("elements").is_null()) throw std::runtime_error("Unexpected null");
        x.set_elements(get_stack_optional<std::vector<ElementType>>(j, "elements"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<Name>(j, "name"));
        x.set_type(j.at("type").get<TypeEnum>());
    }

    inline void to_json(json & j, const IndecentType & x) {
        j = json::object();
        j["declaration"] = x.get_declaration();
        j["elements"] = x.get_elements();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, StickyChild& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<FluffyComment>(j, "comment"));
        x.set_flags(j.at("flags").get<FluffyFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<PurpleKindString>());
        x.set_name(j.at("name").get<std::string>());
        x.set_sources(j.at("sources").get<std::vector<Source>>());
        x.set_type(j.at("type").get<IndecentType>());
    }

    inline void to_json(json & j, const StickyChild & x) {
        j = json::object();
        j["comment"] = x.get_comment();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["sources"] = x.get_sources();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, HilariousType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_declaration(j.at("declaration").get<std::shared_ptr<GetSignature>>());
        x.set_type(j.at("type").get<TypeEnum>());
    }

    inline void to_json(json & j, const HilariousType & x) {
        j = json::object();
        j["declaration"] = x.get_declaration();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, IndexSignature& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_flags(j.at("flags").get<GetSignatureFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        x.set_parameters(j.at("parameters").get<std::vector<GetSignature>>());
        x.set_type(j.at("type").get<HilariousType>());
    }

    inline void to_json(json & j, const IndexSignature & x) {
        j = json::object();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["parameters"] = x.get_parameters();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, IndigoComment& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_returns(j.at("returns").get<std::string>());
        x.set_short_text(j.at("shortText").get<std::string>());
    }

    inline void to_json(json & j, const IndigoComment & x) {
        j = json::object();
        j["returns"] = x.get_returns();
        j["shortText"] = x.get_short_text();
    }

    inline void from_json(const json & j, FluffyParameter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<FluffyComment>(j, "comment"));
        x.set_flags(j.at("flags").get<FluffyFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("sources") != j.end() && j.at("sources").is_null()) throw std::runtime_error("Unexpected null");
        x.set_sources(get_stack_optional<std::vector<Source>>(j, "sources"));
        x.set_type(j.at("type").get<ElementType>());
    }

    inline void to_json(json & j, const FluffyParameter & x) {
        j = json::object();
        j["comment"] = x.get_comment();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["sources"] = x.get_sources();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, TentacledSignature& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<IndigoComment>(j, "comment"));
        x.set_flags(j.at("flags").get<GetSignatureFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<SignatureKindString>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("parameters") != j.end() && j.at("parameters").is_null()) throw std::runtime_error("Unexpected null");
        x.set_parameters(get_stack_optional<std::vector<FluffyParameter>>(j, "parameters"));
        x.set_type(j.at("type").get<ExtendedBy>());
    }

    inline void to_json(json & j, const TentacledSignature & x) {
        j = json::object();
        j["comment"] = x.get_comment();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["parameters"] = x.get_parameters();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, FluffyDeclaration& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("children") != j.end() && j.at("children").is_null()) throw std::runtime_error("Unexpected null");
        x.set_children(get_stack_optional<std::vector<StickyChild>>(j, "children"));
        x.set_flags(j.at("flags").get<GetSignatureFlags>());
        if (j.find("groups") != j.end() && j.at("groups").is_null()) throw std::runtime_error("Unexpected null");
        x.set_groups(get_stack_optional<std::vector<Group>>(j, "groups"));
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("indexSignature") != j.end() && j.at("indexSignature").is_null()) throw std::runtime_error("Unexpected null");
        x.set_index_signature(get_stack_optional<IndexSignature>(j, "indexSignature"));
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("signatures") != j.end() && j.at("signatures").is_null()) throw std::runtime_error("Unexpected null");
        x.set_signatures(get_stack_optional<std::vector<TentacledSignature>>(j, "signatures"));
        x.set_sources(j.at("sources").get<std::vector<Source>>());
    }

    inline void to_json(json & j, const FluffyDeclaration & x) {
        j = json::object();
        j["children"] = x.get_children();
        j["flags"] = x.get_flags();
        j["groups"] = x.get_groups();
        j["id"] = x.get_id();
        j["indexSignature"] = x.get_index_signature();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["signatures"] = x.get_signatures();
        j["sources"] = x.get_sources();
    }

    inline void from_json(const json & j, PurpleTypeArgument& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_target(j.at("target").get<ElementType>());
        x.set_type(j.at("type").get<std::string>());
        x.set_type_argument_operator(j.at("operator").get<std::string>());
    }

    inline void to_json(json & j, const PurpleTypeArgument & x) {
        j = json::object();
        j["target"] = x.get_target();
        j["type"] = x.get_type();
        j["operator"] = x.get_type_argument_operator();
    }

    inline void from_json(const json & j, IndigoType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("constraint") != j.end() && j.at("constraint").is_null()) throw std::runtime_error("Unexpected null");
        x.set_constraint(get_heap_optional<ExtendedBy>(j, "constraint"));
        if (j.find("declaration") != j.end() && j.at("declaration").is_null()) throw std::runtime_error("Unexpected null");
        x.set_declaration(get_stack_optional<FluffyDeclaration>(j, "declaration"));
        if (j.find("elementType") != j.end() && j.at("elementType").is_null()) throw std::runtime_error("Unexpected null");
        x.set_element_type(get_heap_optional<ExtendedBy>(j, "elementType"));
        if (j.find("elements") != j.end() && j.at("elements").is_null()) throw std::runtime_error("Unexpected null");
        x.set_elements(get_stack_optional<std::vector<ElementType>>(j, "elements"));
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("id") != j.end() && j.at("id").is_null()) throw std::runtime_error("Unexpected null");
        x.set_id(get_stack_optional<int64_t>(j, "id"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<std::string>(j, "name"));
        x.set_type(j.at("type").get<TypeEnum>());
        if (j.find("typeArguments") != j.end() && j.at("typeArguments").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type_arguments(get_stack_optional<std::vector<PurpleTypeArgument>>(j, "typeArguments"));
        if (j.find("types") != j.end() && j.at("types").is_null()) throw std::runtime_error("Unexpected null");
        x.set_types(get_stack_optional<std::vector<TypeElement>>(j, "types"));
    }

    inline void to_json(json & j, const IndigoType & x) {
        j = json::object();
        j["constraint"] = x.get_constraint();
        j["declaration"] = x.get_declaration();
        j["elementType"] = x.get_element_type();
        j["elements"] = x.get_elements();
        j["id"] = x.get_id();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
        j["typeArguments"] = x.get_type_arguments();
        j["types"] = x.get_types();
    }

    inline void from_json(const json & j, FluffyChild& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("children") != j.end() && j.at("children").is_null()) throw std::runtime_error("Unexpected null");
        x.set_children(get_stack_optional<std::vector<TentacledChild>>(j, "children"));
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<StickyComment>(j, "comment"));
        if (j.find("defaultValue") != j.end() && j.at("defaultValue").is_null()) throw std::runtime_error("Unexpected null");
        x.set_default_value(get_stack_optional<std::string>(j, "defaultValue"));
        x.set_flags(j.at("flags").get<StickyFlags>());
        if (j.find("getSignature") != j.end() && j.at("getSignature").is_null()) throw std::runtime_error("Unexpected null");
        x.set_get_signature(get_heap_optional<GetSignature>(j, "getSignature"));
        if (j.find("groups") != j.end() && j.at("groups").is_null()) throw std::runtime_error("Unexpected null");
        x.set_groups(get_stack_optional<std::vector<Group>>(j, "groups"));
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("implementationOf") != j.end() && j.at("implementationOf").is_null()) throw std::runtime_error("Unexpected null");
        x.set_implementation_of(get_heap_optional<ExtendedBy>(j, "implementationOf"));
        if (j.find("inheritedFrom") != j.end() && j.at("inheritedFrom").is_null()) throw std::runtime_error("Unexpected null");
        x.set_inherited_from(get_heap_optional<ExtendedBy>(j, "inheritedFrom"));
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<PurpleKindString>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("overwrites") != j.end() && j.at("overwrites").is_null()) throw std::runtime_error("Unexpected null");
        x.set_overwrites(get_heap_optional<ExtendedBy>(j, "overwrites"));
        if (j.find("setSignature") != j.end() && j.at("setSignature").is_null()) throw std::runtime_error("Unexpected null");
        x.set_set_signature(get_heap_optional<GetSignature>(j, "setSignature"));
        if (j.find("signatures") != j.end() && j.at("signatures").is_null()) throw std::runtime_error("Unexpected null");
        x.set_signatures(get_stack_optional<std::vector<FluffySignature>>(j, "signatures"));
        x.set_sources(j.at("sources").get<std::vector<Source>>());
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<IndigoType>(j, "type"));
    }

    inline void to_json(json & j, const FluffyChild & x) {
        j = json::object();
        j["children"] = x.get_children();
        j["comment"] = x.get_comment();
        j["defaultValue"] = x.get_default_value();
        j["flags"] = x.get_flags();
        j["getSignature"] = x.get_get_signature();
        j["groups"] = x.get_groups();
        j["id"] = x.get_id();
        j["implementationOf"] = x.get_implementation_of();
        j["inheritedFrom"] = x.get_inherited_from();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["overwrites"] = x.get_overwrites();
        j["setSignature"] = x.get_set_signature();
        j["signatures"] = x.get_signatures();
        j["sources"] = x.get_sources();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, IndecentFlags& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("hasExportAssignment") != j.end() && j.at("hasExportAssignment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_has_export_assignment(get_stack_optional<bool>(j, "hasExportAssignment"));
        if (j.find("isAbstract") != j.end() && j.at("isAbstract").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_abstract(get_stack_optional<bool>(j, "isAbstract"));
        if (j.find("isConst") != j.end() && j.at("isConst").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_const(get_stack_optional<bool>(j, "isConst"));
        if (j.find("isExported") != j.end() && j.at("isExported").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_exported(get_stack_optional<bool>(j, "isExported"));
        if (j.find("isLet") != j.end() && j.at("isLet").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_let(get_stack_optional<bool>(j, "isLet"));
        if (j.find("isPrivate") != j.end() && j.at("isPrivate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_private(get_stack_optional<bool>(j, "isPrivate"));
        if (j.find("isProtected") != j.end() && j.at("isProtected").is_null()) throw std::runtime_error("Unexpected null");
        x.set_is_protected(get_stack_optional<bool>(j, "isProtected"));
    }

    inline void to_json(json & j, const IndecentFlags & x) {
        j = json::object();
        j["hasExportAssignment"] = x.get_has_export_assignment();
        j["isAbstract"] = x.get_is_abstract();
        j["isConst"] = x.get_is_const();
        j["isExported"] = x.get_is_exported();
        j["isLet"] = x.get_is_let();
        j["isPrivate"] = x.get_is_private();
        j["isProtected"] = x.get_is_protected();
    }

    inline void from_json(const json & j, IndigoChild& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_comment(j.at("comment").get<FluffyComment>());
        if (j.find("defaultValue") != j.end() && j.at("defaultValue").is_null()) throw std::runtime_error("Unexpected null");
        x.set_default_value(get_stack_optional<std::string>(j, "defaultValue"));
        x.set_flags(j.at("flags").get<FluffyFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<PurpleKindString>());
        x.set_name(j.at("name").get<std::string>());
        x.set_sources(j.at("sources").get<std::vector<Source>>());
        x.set_type(j.at("type").get<IndecentType>());
    }

    inline void to_json(json & j, const IndigoChild & x) {
        j = json::object();
        j["comment"] = x.get_comment();
        j["defaultValue"] = x.get_default_value();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["sources"] = x.get_sources();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, TentacledDeclaration& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("children") != j.end() && j.at("children").is_null()) throw std::runtime_error("Unexpected null");
        x.set_children(get_stack_optional<std::vector<IndigoChild>>(j, "children"));
        x.set_flags(j.at("flags").get<GetSignatureFlags>());
        if (j.find("groups") != j.end() && j.at("groups").is_null()) throw std::runtime_error("Unexpected null");
        x.set_groups(get_stack_optional<std::vector<Group>>(j, "groups"));
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("indexSignature") != j.end() && j.at("indexSignature").is_null()) throw std::runtime_error("Unexpected null");
        x.set_index_signature(get_heap_optional<IndexSignatureElement>(j, "indexSignature"));
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("signatures") != j.end() && j.at("signatures").is_null()) throw std::runtime_error("Unexpected null");
        x.set_signatures(get_stack_optional<std::vector<GetSignature>>(j, "signatures"));
        x.set_sources(j.at("sources").get<std::vector<Source>>());
    }

    inline void to_json(json & j, const TentacledDeclaration & x) {
        j = json::object();
        j["children"] = x.get_children();
        j["flags"] = x.get_flags();
        j["groups"] = x.get_groups();
        j["id"] = x.get_id();
        j["indexSignature"] = x.get_index_signature();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["signatures"] = x.get_signatures();
        j["sources"] = x.get_sources();
    }

    inline void from_json(const json & j, AmbitiousType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("declaration") != j.end() && j.at("declaration").is_null()) throw std::runtime_error("Unexpected null");
        x.set_declaration(get_stack_optional<TentacledDeclaration>(j, "declaration"));
        if (j.find("elementType") != j.end() && j.at("elementType").is_null()) throw std::runtime_error("Unexpected null");
        x.set_element_type(get_stack_optional<ElementType>(j, "elementType"));
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("id") != j.end() && j.at("id").is_null()) throw std::runtime_error("Unexpected null");
        x.set_id(get_stack_optional<int64_t>(j, "id"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<std::string>(j, "name"));
        x.set_type(j.at("type").get<TypeEnum>());
        if (j.find("typeArguments") != j.end() && j.at("typeArguments").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type_arguments(get_stack_optional<std::vector<ElementType>>(j, "typeArguments"));
    }

    inline void to_json(json & j, const AmbitiousType & x) {
        j = json::object();
        j["declaration"] = x.get_declaration();
        j["elementType"] = x.get_element_type();
        j["id"] = x.get_id();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
        j["typeArguments"] = x.get_type_arguments();
    }

    inline void from_json(const json & j, TentacledParameter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<TentacledComment>(j, "comment"));
        if (j.find("defaultValue") != j.end() && j.at("defaultValue").is_null()) throw std::runtime_error("Unexpected null");
        x.set_default_value(get_stack_optional<std::string>(j, "defaultValue"));
        x.set_flags(j.at("flags").get<TentacledFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<ParameterKindString>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("originalName") != j.end() && j.at("originalName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_original_name(get_stack_optional<std::string>(j, "originalName"));
        x.set_type(j.at("type").get<AmbitiousType>());
    }

    inline void to_json(json & j, const TentacledParameter & x) {
        j = json::object();
        j["comment"] = x.get_comment();
        j["defaultValue"] = x.get_default_value();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["originalName"] = x.get_original_name();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, CunningType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("declaration") != j.end() && j.at("declaration").is_null()) throw std::runtime_error("Unexpected null");
        x.set_declaration(get_stack_optional<PurpleDeclaration>(j, "declaration"));
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("id") != j.end() && j.at("id").is_null()) throw std::runtime_error("Unexpected null");
        x.set_id(get_stack_optional<int64_t>(j, "id"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<Name>(j, "name"));
        x.set_type(j.at("type").get<TypeEnum>());
        if (j.find("typeArguments") != j.end() && j.at("typeArguments").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type_arguments(get_stack_optional<std::vector<ElementType>>(j, "typeArguments"));
    }

    inline void to_json(json & j, const CunningType & x) {
        j = json::object();
        j["declaration"] = x.get_declaration();
        j["id"] = x.get_id();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
        j["typeArguments"] = x.get_type_arguments();
    }

    inline void from_json(const json & j, StickySignature& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_comment(j.at("comment").get<StickyComment>());
        x.set_flags(j.at("flags").get<IndigoFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<SignatureKindString>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("parameters") != j.end() && j.at("parameters").is_null()) throw std::runtime_error("Unexpected null");
        x.set_parameters(get_stack_optional<std::vector<TentacledParameter>>(j, "parameters"));
        x.set_type(j.at("type").get<CunningType>());
        if (j.find("typeParameter") != j.end() && j.at("typeParameter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type_parameter(get_stack_optional<std::vector<GetSignature>>(j, "typeParameter"));
    }

    inline void to_json(json & j, const StickySignature & x) {
        j = json::object();
        j["comment"] = x.get_comment();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["parameters"] = x.get_parameters();
        j["type"] = x.get_type();
        j["typeParameter"] = x.get_type_parameter();
    }

    inline void from_json(const json & j, IndigoDeclaration& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("children") != j.end() && j.at("children").is_null()) throw std::runtime_error("Unexpected null");
        x.set_children(get_stack_optional<std::vector<GetSignature>>(j, "children"));
        x.set_flags(j.at("flags").get<GetSignatureFlags>());
        if (j.find("groups") != j.end() && j.at("groups").is_null()) throw std::runtime_error("Unexpected null");
        x.set_groups(get_stack_optional<std::vector<Group>>(j, "groups"));
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("signatures") != j.end() && j.at("signatures").is_null()) throw std::runtime_error("Unexpected null");
        x.set_signatures(get_stack_optional<std::vector<GetSignature>>(j, "signatures"));
        x.set_sources(j.at("sources").get<std::vector<Source>>());
    }

    inline void to_json(json & j, const IndigoDeclaration & x) {
        j = json::object();
        j["children"] = x.get_children();
        j["flags"] = x.get_flags();
        j["groups"] = x.get_groups();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["signatures"] = x.get_signatures();
        j["sources"] = x.get_sources();
    }

    inline void from_json(const json & j, FriskyType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("declaration") != j.end() && j.at("declaration").is_null()) throw std::runtime_error("Unexpected null");
        x.set_declaration(get_stack_optional<IndigoDeclaration>(j, "declaration"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<Name>(j, "name"));
        x.set_type(j.at("type").get<TypeEnum>());
    }

    inline void to_json(json & j, const FriskyType & x) {
        j = json::object();
        j["declaration"] = x.get_declaration();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, IndecentChild& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_flags(j.at("flags").get<FluffyFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<PurpleKindString>());
        x.set_name(j.at("name").get<std::string>());
        x.set_sources(j.at("sources").get<std::vector<Source>>());
        x.set_type(j.at("type").get<FriskyType>());
    }

    inline void to_json(json & j, const IndecentChild & x) {
        j = json::object();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["sources"] = x.get_sources();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, StickyDeclaration& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("children") != j.end() && j.at("children").is_null()) throw std::runtime_error("Unexpected null");
        x.set_children(get_stack_optional<std::vector<IndecentChild>>(j, "children"));
        x.set_flags(j.at("flags").get<GetSignatureFlags>());
        if (j.find("groups") != j.end() && j.at("groups").is_null()) throw std::runtime_error("Unexpected null");
        x.set_groups(get_stack_optional<std::vector<Group>>(j, "groups"));
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        x.set_signatures(j.at("signatures").get<std::vector<GetSignature>>());
        x.set_sources(j.at("sources").get<std::vector<Source>>());
    }

    inline void to_json(json & j, const StickyDeclaration & x) {
        j = json::object();
        j["children"] = x.get_children();
        j["flags"] = x.get_flags();
        j["groups"] = x.get_groups();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["signatures"] = x.get_signatures();
        j["sources"] = x.get_sources();
    }

    inline void from_json(const json & j, FluffyTypeArgument& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_type(j.at("type").get<TypeEnum>());
        x.set_types(j.at("types").get<std::vector<ElementType>>());
    }

    inline void to_json(json & j, const FluffyTypeArgument & x) {
        j = json::object();
        j["type"] = x.get_type();
        j["types"] = x.get_types();
    }

    inline void from_json(const json & j, MagentaType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("declaration") != j.end() && j.at("declaration").is_null()) throw std::runtime_error("Unexpected null");
        x.set_declaration(get_stack_optional<StickyDeclaration>(j, "declaration"));
        if (j.find("elementType") != j.end() && j.at("elementType").is_null()) throw std::runtime_error("Unexpected null");
        x.set_element_type(get_stack_optional<ElementType>(j, "elementType"));
        if (j.find("elements") != j.end() && j.at("elements").is_null()) throw std::runtime_error("Unexpected null");
        x.set_elements(get_stack_optional<std::vector<ExtendedBy>>(j, "elements"));
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("id") != j.end() && j.at("id").is_null()) throw std::runtime_error("Unexpected null");
        x.set_id(get_stack_optional<int64_t>(j, "id"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<std::string>(j, "name"));
        x.set_type(j.at("type").get<TypeEnum>());
        if (j.find("typeArguments") != j.end() && j.at("typeArguments").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type_arguments(get_stack_optional<std::vector<FluffyTypeArgument>>(j, "typeArguments"));
        if (j.find("types") != j.end() && j.at("types").is_null()) throw std::runtime_error("Unexpected null");
        x.set_types(get_stack_optional<std::vector<ExtendedBy>>(j, "types"));
        if (j.find("value") != j.end() && j.at("value").is_null()) throw std::runtime_error("Unexpected null");
        x.set_value(get_stack_optional<std::string>(j, "value"));
    }

    inline void to_json(json & j, const MagentaType & x) {
        j = json::object();
        j["declaration"] = x.get_declaration();
        j["elementType"] = x.get_element_type();
        j["elements"] = x.get_elements();
        j["id"] = x.get_id();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
        j["typeArguments"] = x.get_type_arguments();
        j["types"] = x.get_types();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, MischievousType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("id") != j.end() && j.at("id").is_null()) throw std::runtime_error("Unexpected null");
        x.set_id(get_stack_optional<int64_t>(j, "id"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<Name>(j, "name"));
        if (j.find("target") != j.end() && j.at("target").is_null()) throw std::runtime_error("Unexpected null");
        x.set_target(get_stack_optional<ElementType>(j, "target"));
        x.set_type(j.at("type").get<std::string>());
        if (j.find("operator") != j.end() && j.at("operator").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type_operator(get_stack_optional<std::string>(j, "operator"));
    }

    inline void to_json(json & j, const MischievousType & x) {
        j = json::object();
        j["id"] = x.get_id();
        j["name"] = x.get_name();
        j["target"] = x.get_target();
        j["type"] = x.get_type();
        j["operator"] = x.get_type_operator();
    }

    inline void from_json(const json & j, TypeParameter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<PurpleComment>(j, "comment"));
        x.set_flags(j.at("flags").get<GetSignatureFlags>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<MischievousType>(j, "type"));
    }

    inline void to_json(json & j, const TypeParameter & x) {
        j = json::object();
        j["comment"] = x.get_comment();
        j["flags"] = x.get_flags();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, PurpleChild& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("children") != j.end() && j.at("children").is_null()) throw std::runtime_error("Unexpected null");
        x.set_children(get_stack_optional<std::vector<FluffyChild>>(j, "children"));
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<StickyComment>(j, "comment"));
        if (j.find("defaultValue") != j.end() && j.at("defaultValue").is_null()) throw std::runtime_error("Unexpected null");
        x.set_default_value(get_stack_optional<std::string>(j, "defaultValue"));
        if (j.find("extendedBy") != j.end() && j.at("extendedBy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_extended_by(get_stack_optional<std::vector<ExtendedBy>>(j, "extendedBy"));
        if (j.find("extendedTypes") != j.end() && j.at("extendedTypes").is_null()) throw std::runtime_error("Unexpected null");
        x.set_extended_types(get_stack_optional<std::vector<ExtendedBy>>(j, "extendedTypes"));
        x.set_flags(j.at("flags").get<IndecentFlags>());
        if (j.find("groups") != j.end() && j.at("groups").is_null()) throw std::runtime_error("Unexpected null");
        x.set_groups(get_stack_optional<std::vector<Group>>(j, "groups"));
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("implementedBy") != j.end() && j.at("implementedBy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_implemented_by(get_stack_optional<std::vector<ExtendedBy>>(j, "implementedBy"));
        if (j.find("implementedTypes") != j.end() && j.at("implementedTypes").is_null()) throw std::runtime_error("Unexpected null");
        x.set_implemented_types(get_stack_optional<std::vector<ExtendedBy>>(j, "implementedTypes"));
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<FluffyKindString>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("signatures") != j.end() && j.at("signatures").is_null()) throw std::runtime_error("Unexpected null");
        x.set_signatures(get_stack_optional<std::vector<StickySignature>>(j, "signatures"));
        x.set_sources(j.at("sources").get<std::vector<Source>>());
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<MagentaType>(j, "type"));
        if (j.find("typeParameter") != j.end() && j.at("typeParameter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type_parameter(get_stack_optional<std::vector<TypeParameter>>(j, "typeParameter"));
    }

    inline void to_json(json & j, const PurpleChild & x) {
        j = json::object();
        j["children"] = x.get_children();
        j["comment"] = x.get_comment();
        j["defaultValue"] = x.get_default_value();
        j["extendedBy"] = x.get_extended_by();
        j["extendedTypes"] = x.get_extended_types();
        j["flags"] = x.get_flags();
        j["groups"] = x.get_groups();
        j["id"] = x.get_id();
        j["implementedBy"] = x.get_implemented_by();
        j["implementedTypes"] = x.get_implemented_types();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["signatures"] = x.get_signatures();
        j["sources"] = x.get_sources();
        j["type"] = x.get_type();
        j["typeParameter"] = x.get_type_parameter();
    }

    inline void from_json(const json & j, IndecentComment& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_short_text(j.at("shortText").get<std::string>());
        if (j.find("tags") != j.end() && j.at("tags").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tags(get_stack_optional<std::vector<Tag>>(j, "tags"));
    }

    inline void to_json(json & j, const IndecentComment & x) {
        j = json::object();
        j["shortText"] = x.get_short_text();
        j["tags"] = x.get_tags();
    }

    inline void from_json(const json & j, TopLevelChild& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_children(j.at("children").get<std::vector<PurpleChild>>());
        if (j.find("comment") != j.end() && j.at("comment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comment(get_stack_optional<IndecentComment>(j, "comment"));
        x.set_flags(j.at("flags").get<PurpleFlags>());
        x.set_groups(j.at("groups").get<std::vector<Group>>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_kind_string(j.at("kindString").get<TentacledKindString>());
        x.set_name(j.at("name").get<std::string>());
        x.set_original_name(j.at("originalName").get<std::string>());
        x.set_sources(j.at("sources").get<std::vector<Source>>());
    }

    inline void to_json(json & j, const TopLevelChild & x) {
        j = json::object();
        j["children"] = x.get_children();
        j["comment"] = x.get_comment();
        j["flags"] = x.get_flags();
        j["groups"] = x.get_groups();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["kindString"] = x.get_kind_string();
        j["name"] = x.get_name();
        j["originalName"] = x.get_original_name();
        j["sources"] = x.get_sources();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_children(j.at("children").get<std::vector<TopLevelChild>>());
        x.set_flags(j.at("flags").get<GetSignatureFlags>());
        x.set_groups(j.at("groups").get<std::vector<Group>>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        if (j.find("kind") != j.end() && !j.at("kind").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_kind(j.at("kind").get<int64_t>());
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["children"] = x.get_children();
        j["flags"] = x.get_flags();
        j["groups"] = x.get_groups();
        j["id"] = x.get_id();
        j["kind"] = x.get_kind();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, PurpleKindString & x) {
        if (j == "Variable") x = PurpleKindString::VARIABLE;
        else if (j == "Function") x = PurpleKindString::FUNCTION;
        else if (j == "Property") x = PurpleKindString::PROPERTY;
        else if (j == "Method") x = PurpleKindString::METHOD;
        else if (j == "Constructor") x = PurpleKindString::CONSTRUCTOR;
        else if (j == "Accessor") x = PurpleKindString::ACCESSOR;
        else if (j == "Enumeration member") x = PurpleKindString::ENUMERATION_MEMBER;
        else if (j == "Module") x = PurpleKindString::MODULE;
        else if (j == "Object literal") x = PurpleKindString::OBJECT_LITERAL;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"PurpleKindString\""); }
    }

    inline void to_json(json & j, const PurpleKindString & x) {
        switch (x) {
            case PurpleKindString::VARIABLE: j = "Variable"; break;
            case PurpleKindString::FUNCTION: j = "Function"; break;
            case PurpleKindString::PROPERTY: j = "Property"; break;
            case PurpleKindString::METHOD: j = "Method"; break;
            case PurpleKindString::CONSTRUCTOR: j = "Constructor"; break;
            case PurpleKindString::ACCESSOR: j = "Accessor"; break;
            case PurpleKindString::ENUMERATION_MEMBER: j = "Enumeration member"; break;
            case PurpleKindString::MODULE: j = "Module"; break;
            case PurpleKindString::OBJECT_LITERAL: j = "Object literal"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"PurpleKindString\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, SignatureKindString & x) {
        if (j == "Call signature") x = SignatureKindString::CALL_SIGNATURE;
        else if (j == "Constructor signature") x = SignatureKindString::CONSTRUCTOR_SIGNATURE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"SignatureKindString\""); }
    }

    inline void to_json(json & j, const SignatureKindString & x) {
        switch (x) {
            case SignatureKindString::CALL_SIGNATURE: j = "Call signature"; break;
            case SignatureKindString::CONSTRUCTOR_SIGNATURE: j = "Constructor signature"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"SignatureKindString\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Name & x) {
        if (j == "string") x = Name::STRING;
        else if (j == "number") x = Name::NUMBER;
        else if (j == "void") x = Name::VOID;
        else if (j == "T") x = Name::T;
        else if (j == "boolean") x = Name::BOOLEAN;
        else if (j == "BaseClass") x = Name::BASE_CLASS;
        else if (j == "any") x = Name::ANY;
        else if (j == "Array") x = Name::ARRAY;
        else if (j == "MyNumber") x = Name::MY_NUMBER;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Name\""); }
    }

    inline void to_json(json & j, const Name & x) {
        switch (x) {
            case Name::STRING: j = "string"; break;
            case Name::NUMBER: j = "number"; break;
            case Name::VOID: j = "void"; break;
            case Name::T: j = "T"; break;
            case Name::BOOLEAN: j = "boolean"; break;
            case Name::BASE_CLASS: j = "BaseClass"; break;
            case Name::ANY: j = "any"; break;
            case Name::ARRAY: j = "Array"; break;
            case Name::MY_NUMBER: j = "MyNumber"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Name\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, TypeEnum & x) {
        if (j == "intrinsic") x = TypeEnum::INTRINSIC;
        else if (j == "reflection") x = TypeEnum::REFLECTION;
        else if (j == "array") x = TypeEnum::ARRAY;
        else if (j == "reference") x = TypeEnum::REFERENCE;
        else if (j == "typeParameter") x = TypeEnum::TYPE_PARAMETER;
        else if (j == "tuple") x = TypeEnum::TUPLE;
        else if (j == "union") x = TypeEnum::UNION;
        else if (j == "stringLiteral") x = TypeEnum::STRING_LITERAL;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"TypeEnum\""); }
    }

    inline void to_json(json & j, const TypeEnum & x) {
        switch (x) {
            case TypeEnum::INTRINSIC: j = "intrinsic"; break;
            case TypeEnum::REFLECTION: j = "reflection"; break;
            case TypeEnum::ARRAY: j = "array"; break;
            case TypeEnum::REFERENCE: j = "reference"; break;
            case TypeEnum::TYPE_PARAMETER: j = "typeParameter"; break;
            case TypeEnum::TUPLE: j = "tuple"; break;
            case TypeEnum::UNION: j = "union"; break;
            case TypeEnum::STRING_LITERAL: j = "stringLiteral"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"TypeEnum\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, FileName & x) {
        if (j == "modules.ts") x = FileName::MODULES_TS;
        else if (j == "classes.ts") x = FileName::CLASSES_TS;
        else if (j == "flattened.ts") x = FileName::FLATTENED_TS;
        else if (j == "access.ts") x = FileName::ACCESS_TS;
        else if (j == "default-export.ts") x = FileName::DEFAULT_EXPORT_TS;
        else if (j == "enumerations.ts") x = FileName::ENUMERATIONS_TS;
        else if (j == "functions.ts") x = FileName::FUNCTIONS_TS;
        else if (j == "generics.ts") x = FileName::GENERICS_TS;
        else if (j == "single-export.ts") x = FileName::SINGLE_EXPORT_TS;
        else if (j == "typescript-1.3.ts") x = FileName::TYPESCRIPT_13_TS;
        else if (j == "typescript-1.4.ts") x = FileName::TYPESCRIPT_14_TS;
        else if (j == "typescript-1.5.ts") x = FileName::TYPESCRIPT_15_TS;
        else if (j == "variables.ts") x = FileName::VARIABLES_TS;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"FileName\""); }
    }

    inline void to_json(json & j, const FileName & x) {
        switch (x) {
            case FileName::MODULES_TS: j = "modules.ts"; break;
            case FileName::CLASSES_TS: j = "classes.ts"; break;
            case FileName::FLATTENED_TS: j = "flattened.ts"; break;
            case FileName::ACCESS_TS: j = "access.ts"; break;
            case FileName::DEFAULT_EXPORT_TS: j = "default-export.ts"; break;
            case FileName::ENUMERATIONS_TS: j = "enumerations.ts"; break;
            case FileName::FUNCTIONS_TS: j = "functions.ts"; break;
            case FileName::GENERICS_TS: j = "generics.ts"; break;
            case FileName::SINGLE_EXPORT_TS: j = "single-export.ts"; break;
            case FileName::TYPESCRIPT_13_TS: j = "typescript-1.3.ts"; break;
            case FileName::TYPESCRIPT_14_TS: j = "typescript-1.4.ts"; break;
            case FileName::TYPESCRIPT_15_TS: j = "typescript-1.5.ts"; break;
            case FileName::VARIABLES_TS: j = "variables.ts"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"FileName\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, ParameterKindString & x) {
        if (j == "Parameter") x = ParameterKindString::PARAMETER;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ParameterKindString\""); }
    }

    inline void to_json(json & j, const ParameterKindString & x) {
        switch (x) {
            case ParameterKindString::PARAMETER: j = "Parameter"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ParameterKindString\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, FluffyKindString & x) {
        if (j == "Module") x = FluffyKindString::MODULE;
        else if (j == "Class") x = FluffyKindString::CLASS;
        else if (j == "Variable") x = FluffyKindString::VARIABLE;
        else if (j == "Function") x = FluffyKindString::FUNCTION;
        else if (j == "Interface") x = FluffyKindString::INTERFACE;
        else if (j == "Enumeration") x = FluffyKindString::ENUMERATION;
        else if (j == "Object literal") x = FluffyKindString::OBJECT_LITERAL;
        else if (j == "Type alias") x = FluffyKindString::TYPE_ALIAS;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"FluffyKindString\""); }
    }

    inline void to_json(json & j, const FluffyKindString & x) {
        switch (x) {
            case FluffyKindString::MODULE: j = "Module"; break;
            case FluffyKindString::CLASS: j = "Class"; break;
            case FluffyKindString::VARIABLE: j = "Variable"; break;
            case FluffyKindString::FUNCTION: j = "Function"; break;
            case FluffyKindString::INTERFACE: j = "Interface"; break;
            case FluffyKindString::ENUMERATION: j = "Enumeration"; break;
            case FluffyKindString::OBJECT_LITERAL: j = "Object literal"; break;
            case FluffyKindString::TYPE_ALIAS: j = "Type alias"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"FluffyKindString\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, TentacledKindString & x) {
        if (j == "External module") x = TentacledKindString::EXTERNAL_MODULE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"TentacledKindString\""); }
    }

    inline void to_json(json & j, const TentacledKindString & x) {
        switch (x) {
            case TentacledKindString::EXTERNAL_MODULE: j = "External module"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"TentacledKindString\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
