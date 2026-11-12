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

    struct X;
    struct XElement;

    class XClass;

    struct X : std::shared_ptr<std::variant<std::vector<XElement>, bool, double, int64_t, std::map<std::string, nlohmann::json>, std::string>> {
        using base = std::shared_ptr<std::variant<std::vector<XElement>, bool, double, int64_t, std::map<std::string, nlohmann::json>, std::string>>;
        using base::base;
        using base::operator=;
    };

    struct XElement : std::optional<std::variant<std::vector<nlohmann::json>, bool, std::shared_ptr<XClass>, double, int64_t, std::string>> {
        using base = std::optional<std::variant<std::vector<nlohmann::json>, bool, std::shared_ptr<XClass>, double, int64_t, std::string>>;
        using base::base;
        using base::operator=;
    };

    class XClass {
        public:
        XClass() = default;
        virtual ~XClass() = default;

        private:
        X x;

        public:
        X get_x() const { return x; }
        void set_x(X value) { this->x = value; }
    };

    class TopLevelClass {
        public:
        TopLevelClass() = default;
        virtual ~TopLevelClass() = default;

        private:
        X x;

        public:
        X get_x() const { return x; }
        void set_x(X value) { this->x = value; }
    };

    using TopLevelElement = std::optional<std::variant<std::vector<nlohmann::json>, bool, TopLevelClass, double, int64_t, std::string>>;

    using TopLevel = std::optional<std::variant<std::vector<TopLevelElement>, bool, double, int64_t, std::map<std::string, nlohmann::json>, std::string>>;
}

namespace quicktype {
void from_json(const json & j, XClass & x);
void to_json(json & j, const XClass & x);

void from_json(const json & j, TopLevelClass & x);
void to_json(json & j, const TopLevelClass & x);

void from_json(const json & j, X & x);
void to_json(json & j, const X & x);

void from_json(const json & j, XElement & x);
void to_json(json & j, const XElement & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::vector<quicktype::XElement>, bool, double, int64_t, std::map<std::string, json>, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::XElement>, bool, double, int64_t, std::map<std::string, json>, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::XElement>, bool, double, int64_t, std::map<std::string, json>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, std::shared_ptr<quicktype::XClass>, double, int64_t, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<json>, bool, std::shared_ptr<quicktype::XClass>, double, int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, bool, std::shared_ptr<quicktype::XClass>, double, int64_t, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, quicktype::TopLevelClass, double, int64_t, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<json>, bool, quicktype::TopLevelClass, double, int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, bool, quicktype::TopLevelClass, double, int64_t, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<quicktype::TopLevelElement>, bool, double, int64_t, std::map<std::string, json>, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::TopLevelElement>, bool, double, int64_t, std::map<std::string, json>, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::TopLevelElement>, bool, double, int64_t, std::map<std::string, json>, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, XClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_x(j.find("x") != j.end() ? j.at("x").get<X>() : X());
    }

    inline void to_json(json & j, const XClass & x) {
        j = json::object();
        j["x"] = x.get_x();
    }

    inline void from_json(const json & j, TopLevelClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_x(j.find("x") != j.end() ? j.at("x").get<X>() : X());
    }

    inline void to_json(json & j, const TopLevelClass & x) {
        j = json::object();
        j["x"] = x.get_x();
    }

    inline void from_json(const json & j, X & x) {
        x = j.get<X::base>();
    }

    inline void to_json(json & j, const X & x) {
        j = static_cast<const X::base &>(x);
    }

    inline void from_json(const json & j, XElement & x) {
        x = j.get<XElement::base>();
    }

    inline void to_json(json & j, const XElement & x) {
        j = static_cast<const XElement::base &>(x);
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::vector<quicktype::XElement>, bool, double, int64_t, std::map<std::string, json>, std::string>>::from_json(const json & j, std::variant<std::vector<quicktype::XElement>, bool, double, int64_t, std::map<std::string, json>, std::string> & x) {
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
            x = j.get<std::vector<quicktype::XElement>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::XElement>, bool, double, int64_t, std::map<std::string, json>, std::string>>::to_json(json & j, const std::variant<std::vector<quicktype::XElement>, bool, double, int64_t, std::map<std::string, json>, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::XElement>>(x);
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

    inline void adl_serializer<std::variant<std::vector<json>, bool, std::shared_ptr<quicktype::XClass>, double, int64_t, std::string>>::from_json(const json & j, std::variant<std::vector<json>, bool, std::shared_ptr<quicktype::XClass>, double, int64_t, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::shared_ptr<quicktype::XClass>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, std::shared_ptr<quicktype::XClass>, double, int64_t, std::string>>::to_json(json & j, const std::variant<std::vector<json>, bool, std::shared_ptr<quicktype::XClass>, double, int64_t, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<std::shared_ptr<quicktype::XClass>>(x);
                break;
            case 3:
                j = std::get<double>(x);
                break;
            case 4:
                j = std::get<int64_t>(x);
                break;
            case 5:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, quicktype::TopLevelClass, double, int64_t, std::string>>::from_json(const json & j, std::variant<std::vector<json>, bool, quicktype::TopLevelClass, double, int64_t, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::TopLevelClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, quicktype::TopLevelClass, double, int64_t, std::string>>::to_json(json & j, const std::variant<std::vector<json>, bool, quicktype::TopLevelClass, double, int64_t, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<quicktype::TopLevelClass>(x);
                break;
            case 3:
                j = std::get<double>(x);
                break;
            case 4:
                j = std::get<int64_t>(x);
                break;
            case 5:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::TopLevelElement>, bool, double, int64_t, std::map<std::string, json>, std::string>>::from_json(const json & j, std::variant<std::vector<quicktype::TopLevelElement>, bool, double, int64_t, std::map<std::string, json>, std::string> & x) {
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
            x = j.get<std::vector<quicktype::TopLevelElement>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::TopLevelElement>, bool, double, int64_t, std::map<std::string, json>, std::string>>::to_json(json & j, const std::variant<std::vector<quicktype::TopLevelElement>, bool, double, int64_t, std::map<std::string, json>, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::TopLevelElement>>(x);
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
