//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include "json.hpp"

#include <optional>
#include <stdexcept>
#include <regex>

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

    class TopLevelBla {
        public:
        TopLevelBla() = default;
        virtual ~TopLevelBla() = default;

        private:
        int64_t bar;

        public:
        const int64_t & get_bar() const { return bar; }
        int64_t & get_mutable_bar() { return bar; }
        void set_bar(const int64_t & value) { this->bar = value; }
    };

    class Empty {
        public:
        Empty() = default;
        virtual ~Empty() = default;

        private:
        int64_t x;

        public:
        const int64_t & get_x() const { return x; }
        int64_t & get_mutable_x() { return x; }
        void set_x(const int64_t & value) { this->x = value; }
    };

    class FooBla {
        public:
        FooBla() = default;
        virtual ~FooBla() = default;

        private:

        public:
    };

    class Foo {
        public:
        Foo() = default;
        virtual ~Foo() = default;

        private:
        FooBla bla;
        int64_t empty;
        int64_t foo;

        public:
        const FooBla & get_bla() const { return bla; }
        FooBla & get_mutable_bla() { return bla; }
        void set_bla(const FooBla & value) { this->bla = value; }

        const int64_t & get_empty() const { return empty; }
        int64_t & get_mutable_empty() { return empty; }
        void set_empty(const int64_t & value) { this->empty = value; }

        const int64_t & get_foo() const { return foo; }
        int64_t & get_mutable_foo() { return foo; }
        void set_foo(const int64_t & value) { this->foo = value; }
    };

    class ThisIsAToughOne {
        public:
        ThisIsAToughOne() = default;
        virtual ~ThisIsAToughOne() = default;

        private:
        int64_t empty;
        int64_t this_is_a_tough_one;

        public:
        const int64_t & get_empty() const { return empty; }
        int64_t & get_mutable_empty() { return empty; }
        void set_empty(const int64_t & value) { this->empty = value; }

        const int64_t & get_this_is_a_tough_one() const { return this_is_a_tough_one; }
        int64_t & get_mutable_this_is_a_tough_one() { return this_is_a_tough_one; }
        void set_this_is_a_tough_one(const int64_t & value) { this->this_is_a_tough_one = value; }
    };

    class EmptyClass {
        public:
        EmptyClass() = default;
        virtual ~EmptyClass() = default;

        private:
        int64_t y;

        public:
        const int64_t & get_y() const { return y; }
        int64_t & get_mutable_y() { return y; }
        void set_y(const int64_t & value) { this->y = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        TopLevelBla bla;
        Empty empty;
        Foo foo;
        ThisIsAToughOne this_is_a_tough_one;
        int64_t top_level;
        EmptyClass top_level_empty;

        public:
        const TopLevelBla & get_bla() const { return bla; }
        TopLevelBla & get_mutable_bla() { return bla; }
        void set_bla(const TopLevelBla & value) { this->bla = value; }

        const Empty & get_empty() const { return empty; }
        Empty & get_mutable_empty() { return empty; }
        void set_empty(const Empty & value) { this->empty = value; }

        const Foo & get_foo() const { return foo; }
        Foo & get_mutable_foo() { return foo; }
        void set_foo(const Foo & value) { this->foo = value; }

        const ThisIsAToughOne & get_this_is_a_tough_one() const { return this_is_a_tough_one; }
        ThisIsAToughOne & get_mutable_this_is_a_tough_one() { return this_is_a_tough_one; }
        void set_this_is_a_tough_one(const ThisIsAToughOne & value) { this->this_is_a_tough_one = value; }

        const int64_t & get_top_level() const { return top_level; }
        int64_t & get_mutable_top_level() { return top_level; }
        void set_top_level(const int64_t & value) { this->top_level = value; }

        const EmptyClass & get_top_level_empty() const { return top_level_empty; }
        EmptyClass & get_mutable_top_level_empty() { return top_level_empty; }
        void set_top_level_empty(const EmptyClass & value) { this->top_level_empty = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevelBla & x);
    void to_json(json & j, const TopLevelBla & x);

    void from_json(const json & j, Empty & x);
    void to_json(json & j, const Empty & x);

    void from_json(const json & j, FooBla & x);
    void to_json(json & j, const FooBla & x);

    void from_json(const json & j, Foo & x);
    void to_json(json & j, const Foo & x);

    void from_json(const json & j, ThisIsAToughOne & x);
    void to_json(json & j, const ThisIsAToughOne & x);

    void from_json(const json & j, EmptyClass & x);
    void to_json(json & j, const EmptyClass & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevelBla& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bar") != j.end() && !j.at("bar").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_bar(j.at("bar").get<int64_t>());
    }

    inline void to_json(json & j, const TopLevelBla & x) {
        j = json::object();
        j["bar"] = x.get_bar();
    }

    inline void from_json(const json & j, Empty& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("x") != j.end() && !j.at("x").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_x(j.at("x").get<int64_t>());
    }

    inline void to_json(json & j, const Empty & x) {
        j = json::object();
        j["x"] = x.get_x();
    }

    inline void from_json(const json & j, FooBla& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const FooBla & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Foo& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_bla(j.at("bla").get<FooBla>());
        if (j.find("_") != j.end() && !j.at("_").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_empty(j.at("_").get<int64_t>());
        if (j.find("__") != j.end() && !j.at("__").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_foo(j.at("__").get<int64_t>());
    }

    inline void to_json(json & j, const Foo & x) {
        j = json::object();
        j["bla"] = x.get_bla();
        j["_"] = x.get_empty();
        j["__"] = x.get_foo();
    }

    inline void from_json(const json & j, ThisIsAToughOne& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("\n\n\n") != j.end() && !j.at("\n\n\n").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_empty(j.at("\n\n\n").get<int64_t>());
        if (j.find("\"") != j.end() && !j.at("\"").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_this_is_a_tough_one(j.at("\"").get<int64_t>());
    }

    inline void to_json(json & j, const ThisIsAToughOne & x) {
        j = json::object();
        j["\n\n\n"] = x.get_empty();
        j["\""] = x.get_this_is_a_tough_one();
    }

    inline void from_json(const json & j, EmptyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("y") != j.end() && !j.at("y").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_y(j.at("y").get<int64_t>());
    }

    inline void to_json(json & j, const EmptyClass & x) {
        j = json::object();
        j["y"] = x.get_y();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_bla(j.at("bla").get<TopLevelBla>());
        x.set_empty(j.at("").get<Empty>());
        x.set_foo(j.at("foo").get<Foo>());
        x.set_this_is_a_tough_one(j.at("ThisIsA\U0001f61cTough\"\n\nOne").get<ThisIsAToughOne>());
        if (j.find("!") != j.end() && !j.at("!").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_top_level(j.at("!").get<int64_t>());
        x.set_top_level_empty(j.at("Empty").get<EmptyClass>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["bla"] = x.get_bla();
        j[""] = x.get_empty();
        j["foo"] = x.get_foo();
        j["ThisIsA\U0001f61cTough\"\n\nOne"] = x.get_this_is_a_tough_one();
        j["!"] = x.get_top_level();
        j["Empty"] = x.get_top_level_empty();
    }
}
