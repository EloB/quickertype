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

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::shared_ptr<TopLevel> also;
        bool bar;
        int64_t foo;
        double moo;
        std::string quux;

        public:
        const std::shared_ptr<TopLevel> & get_also() const { return also; }
        std::shared_ptr<TopLevel> & get_mutable_also() { return also; }
        void set_also(const std::shared_ptr<TopLevel> & value) { this->also = value; }

        const bool & get_bar() const { return bar; }
        bool & get_mutable_bar() { return bar; }
        void set_bar(const bool & value) { this->bar = value; }

        const int64_t & get_foo() const { return foo; }
        int64_t & get_mutable_foo() { return foo; }
        void set_foo(const int64_t & value) { this->foo = value; }

        const double & get_moo() const { return moo; }
        double & get_mutable_moo() { return moo; }
        void set_moo(const double & value) { this->moo = value; }

        const std::string & get_quux() const { return quux; }
        std::string & get_mutable_quux() { return quux; }
        void set_quux(const std::string & value) { this->quux = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("also") != j.end() && j.at("also").is_null()) throw std::runtime_error("Unexpected null");
        x.set_also(get_heap_optional<TopLevel>(j, "also"));
        x.set_bar(j.at("bar").get<bool>());
        if (j.find("foo") != j.end() && !j.at("foo").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_foo(j.at("foo").get<int64_t>());
        x.set_moo(j.at("moo").get<double>());
        x.set_quux(j.at("quux").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["also"] = x.get_also();
        j["bar"] = x.get_bar();
        j["foo"] = x.get_foo();
        j["moo"] = x.get_moo();
        j["quux"] = x.get_quux();
    }
}
