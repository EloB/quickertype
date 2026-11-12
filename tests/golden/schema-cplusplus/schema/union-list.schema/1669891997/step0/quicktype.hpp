//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

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

    struct UnionList;

    class UnionListClass;

    struct UnionList : std::variant<std::shared_ptr<UnionListClass>, double> {
        using base = std::variant<std::shared_ptr<UnionListClass>, double>;
        using base::base;
        using base::operator=;
    };

    class UnionListClass {
        public:
        UnionListClass() = default;
        virtual ~UnionListClass() = default;

        private:
        UnionList next;

        public:
        const UnionList & get_next() const { return next; }
        UnionList & get_mutable_next() { return next; }
        void set_next(const UnionList & value) { this->next = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        UnionList list;

        public:
        const UnionList & get_list() const { return list; }
        UnionList & get_mutable_list() { return list; }
        void set_list(const UnionList & value) { this->list = value; }
    };
}

namespace quicktype {
void from_json(const json & j, UnionListClass & x);
void to_json(json & j, const UnionListClass & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);

void from_json(const json & j, UnionList & x);
void to_json(json & j, const UnionList & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::shared_ptr<quicktype::UnionListClass>, double>> {
    static void from_json(const json & j, std::variant<std::shared_ptr<quicktype::UnionListClass>, double> & x);
    static void to_json(json & j, const std::variant<std::shared_ptr<quicktype::UnionListClass>, double> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, UnionListClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_next(j.at("next").get<UnionList>());
    }

    inline void to_json(json & j, const UnionListClass & x) {
        j = json::object();
        j["next"] = x.get_next();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_list(j.at("list").get<UnionList>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["list"] = x.get_list();
    }

    inline void from_json(const json & j, UnionList & x) {
        x = j.get<UnionList::base>();
    }

    inline void to_json(json & j, const UnionList & x) {
        j = static_cast<const UnionList::base &>(x);
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::shared_ptr<quicktype::UnionListClass>, double>>::from_json(const json & j, std::variant<std::shared_ptr<quicktype::UnionListClass>, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<std::shared_ptr<quicktype::UnionListClass>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::shared_ptr<quicktype::UnionListClass>, double>>::to_json(json & j, const std::variant<std::shared_ptr<quicktype::UnionListClass>, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::shared_ptr<quicktype::UnionListClass>>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
