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

    class ArrayNode {
        public:
        ArrayNode() = default;
        virtual ~ArrayNode() = default;

        private:

        public:
    };

    class BooleanNode {
        public:
        BooleanNode() = default;
        virtual ~BooleanNode() = default;

        private:

        public:
    };

    class DoubleNode {
        public:
        DoubleNode() = default;
        virtual ~DoubleNode() = default;

        private:

        public:
    };

    class IntNode {
        public:
        IntNode() = default;
        virtual ~IntNode() = default;

        private:

        public:
    };

    class LongNode {
        public:
        LongNode() = default;
        virtual ~LongNode() = default;

        private:

        public:
    };

    class NullNode {
        public:
        NullNode() = default;
        virtual ~NullNode() = default;

        private:

        public:
    };

    class ObjectNode {
        public:
        ObjectNode() = default;
        virtual ~ObjectNode() = default;

        private:

        public:
    };

    using Anything = std::optional<std::variant<std::vector<nlohmann::json>, bool, double, int64_t, std::map<std::string, nlohmann::json>, std::string>>;

    class Thing {
        public:
        Thing() = default;
        virtual ~Thing() = default;

        private:
        Anything optional;
        Anything required;

        public:
        Anything get_optional() const { return optional; }
        void set_optional(Anything value) { this->optional = value; }

        Anything get_required() const { return required; }
        void set_required(Anything value) { this->required = value; }
    };

    class TextNode {
        public:
        TextNode() = default;
        virtual ~TextNode() = default;

        private:

        public:
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<ArrayNode> array_node;
        std::optional<BooleanNode> boolean_node;
        std::optional<DoubleNode> double_node;
        std::optional<IntNode> int_node;
        std::optional<LongNode> long_node;
        std::optional<NullNode> null_node;
        std::optional<ObjectNode> object_node;
        std::map<std::string, Thing> stuff;
        std::optional<TextNode> text_node;

        public:
        const std::optional<ArrayNode> & get_array_node() const { return array_node; }
        std::optional<ArrayNode> & get_mutable_array_node() { return array_node; }
        void set_array_node(const std::optional<ArrayNode> & value) { this->array_node = value; }

        const std::optional<BooleanNode> & get_boolean_node() const { return boolean_node; }
        std::optional<BooleanNode> & get_mutable_boolean_node() { return boolean_node; }
        void set_boolean_node(const std::optional<BooleanNode> & value) { this->boolean_node = value; }

        const std::optional<DoubleNode> & get_double_node() const { return double_node; }
        std::optional<DoubleNode> & get_mutable_double_node() { return double_node; }
        void set_double_node(const std::optional<DoubleNode> & value) { this->double_node = value; }

        const std::optional<IntNode> & get_int_node() const { return int_node; }
        std::optional<IntNode> & get_mutable_int_node() { return int_node; }
        void set_int_node(const std::optional<IntNode> & value) { this->int_node = value; }

        const std::optional<LongNode> & get_long_node() const { return long_node; }
        std::optional<LongNode> & get_mutable_long_node() { return long_node; }
        void set_long_node(const std::optional<LongNode> & value) { this->long_node = value; }

        const std::optional<NullNode> & get_null_node() const { return null_node; }
        std::optional<NullNode> & get_mutable_null_node() { return null_node; }
        void set_null_node(const std::optional<NullNode> & value) { this->null_node = value; }

        const std::optional<ObjectNode> & get_object_node() const { return object_node; }
        std::optional<ObjectNode> & get_mutable_object_node() { return object_node; }
        void set_object_node(const std::optional<ObjectNode> & value) { this->object_node = value; }

        const std::map<std::string, Thing> & get_stuff() const { return stuff; }
        std::map<std::string, Thing> & get_mutable_stuff() { return stuff; }
        void set_stuff(const std::map<std::string, Thing> & value) { this->stuff = value; }

        const std::optional<TextNode> & get_text_node() const { return text_node; }
        std::optional<TextNode> & get_mutable_text_node() { return text_node; }
        void set_text_node(const std::optional<TextNode> & value) { this->text_node = value; }
    };
}

namespace quicktype {
void from_json(const json & j, ArrayNode & x);
void to_json(json & j, const ArrayNode & x);

void from_json(const json & j, BooleanNode & x);
void to_json(json & j, const BooleanNode & x);

void from_json(const json & j, DoubleNode & x);
void to_json(json & j, const DoubleNode & x);

void from_json(const json & j, IntNode & x);
void to_json(json & j, const IntNode & x);

void from_json(const json & j, LongNode & x);
void to_json(json & j, const LongNode & x);

void from_json(const json & j, NullNode & x);
void to_json(json & j, const NullNode & x);

void from_json(const json & j, ObjectNode & x);
void to_json(json & j, const ObjectNode & x);

void from_json(const json & j, Thing & x);
void to_json(json & j, const Thing & x);

void from_json(const json & j, TextNode & x);
void to_json(json & j, const TextNode & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::vector<json>, bool, double, int64_t, std::map<std::string, json>, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<json>, bool, double, int64_t, std::map<std::string, json>, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, bool, double, int64_t, std::map<std::string, json>, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, ArrayNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ArrayNode & x) {
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

    inline void from_json(const json & j, DoubleNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const DoubleNode & x) {
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

    inline void from_json(const json & j, LongNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const LongNode & x) {
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

    inline void from_json(const json & j, ObjectNode& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ObjectNode & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Thing& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_optional(get_stack_optional<std::variant<std::vector<nlohmann::json>, bool, double, int64_t, std::map<std::string, nlohmann::json>, std::string>>(j, "optional"));
        j.at("required");
        x.set_required(get_stack_optional<std::variant<std::vector<nlohmann::json>, bool, double, int64_t, std::map<std::string, nlohmann::json>, std::string>>(j, "required"));
    }

    inline void to_json(json & j, const Thing & x) {
        j = json::object();
        j["optional"] = x.get_optional();
        j["required"] = x.get_required();
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

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("arrayNode") != j.end() && j.at("arrayNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_array_node(get_stack_optional<ArrayNode>(j, "arrayNode"));
        if (j.find("booleanNode") != j.end() && j.at("booleanNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_boolean_node(get_stack_optional<BooleanNode>(j, "booleanNode"));
        if (j.find("doubleNode") != j.end() && j.at("doubleNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_double_node(get_stack_optional<DoubleNode>(j, "doubleNode"));
        if (j.find("intNode") != j.end() && j.at("intNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_int_node(get_stack_optional<IntNode>(j, "intNode"));
        if (j.find("longNode") != j.end() && j.at("longNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_long_node(get_stack_optional<LongNode>(j, "longNode"));
        if (j.find("nullNode") != j.end() && j.at("nullNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_null_node(get_stack_optional<NullNode>(j, "nullNode"));
        if (j.find("objectNode") != j.end() && j.at("objectNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_object_node(get_stack_optional<ObjectNode>(j, "objectNode"));
        x.set_stuff(j.at("stuff").get<std::map<std::string, Thing>>());
        if (j.find("textNode") != j.end() && j.at("textNode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text_node(get_stack_optional<TextNode>(j, "textNode"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["arrayNode"] = x.get_array_node();
        j["booleanNode"] = x.get_boolean_node();
        j["doubleNode"] = x.get_double_node();
        j["intNode"] = x.get_int_node();
        j["longNode"] = x.get_long_node();
        j["nullNode"] = x.get_null_node();
        j["objectNode"] = x.get_object_node();
        j["stuff"] = x.get_stuff();
        j["textNode"] = x.get_text_node();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::vector<json>, bool, double, int64_t, std::map<std::string, json>, std::string>>::from_json(const json & j, std::variant<std::vector<json>, bool, double, int64_t, std::map<std::string, json>, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, json>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, double, int64_t, std::map<std::string, json>, std::string>>::to_json(json & j, const std::variant<std::vector<json>, bool, double, int64_t, std::map<std::string, json>, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<double>(x);
                break;
            case 3:
                j = std::get<int64_t>(x);
                break;
            case 4:
                j = std::get<std::map<std::string, json>>(x);
                break;
            case 5:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
