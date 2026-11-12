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

    enum class OtherArr : int { FOO, BAR, IF };

    using Arr = std::variant<OtherArr, int64_t>;

    enum class Gve : int { GOOD, NEUTRAL, EVIL };

    enum class Lvc : int { LAWFUL, NEUTRAL, CHAOTIC };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<std::vector<Arr>> arr;
        std::optional<std::string> top_level_for;
        Gve gve;
        std::optional<Lvc> lvc;
        std::optional<std::vector<OtherArr>> other_arr;

        public:
        const std::optional<std::vector<Arr>> & get_arr() const { return arr; }
        std::optional<std::vector<Arr>> & get_mutable_arr() { return arr; }
        void set_arr(const std::optional<std::vector<Arr>> & value) { this->arr = value; }

        const std::optional<std::string> & get_top_level_for() const { return top_level_for; }
        std::optional<std::string> & get_mutable_top_level_for() { return top_level_for; }
        void set_top_level_for(const std::optional<std::string> & value) { this->top_level_for = value; }

        const Gve & get_gve() const { return gve; }
        Gve & get_mutable_gve() { return gve; }
        void set_gve(const Gve & value) { this->gve = value; }

        const std::optional<Lvc> & get_lvc() const { return lvc; }
        std::optional<Lvc> & get_mutable_lvc() { return lvc; }
        void set_lvc(const std::optional<Lvc> & value) { this->lvc = value; }

        const std::optional<std::vector<OtherArr>> & get_other_arr() const { return other_arr; }
        std::optional<std::vector<OtherArr>> & get_mutable_other_arr() { return other_arr; }
        void set_other_arr(const std::optional<std::vector<OtherArr>> & value) { this->other_arr = value; }
    };
}

namespace quicktype {
void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);

void from_json(const json & j, OtherArr & x);
void to_json(json & j, const OtherArr & x);

void from_json(const json & j, Gve & x);
void to_json(json & j, const Gve & x);

void from_json(const json & j, Lvc & x);
void to_json(json & j, const Lvc & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<quicktype::OtherArr, int64_t>> {
    static void from_json(const json & j, std::variant<quicktype::OtherArr, int64_t> & x);
    static void to_json(json & j, const std::variant<quicktype::OtherArr, int64_t> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("arr") != j.end() && j.at("arr").is_null()) throw std::runtime_error("Unexpected null");
        x.set_arr(get_stack_optional<std::vector<Arr>>(j, "arr"));
        if (j.find("for") != j.end() && j.at("for").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_for(get_stack_optional<std::string>(j, "for"));
        x.set_gve(j.at("gve").get<Gve>());
        if (j.find("lvc") != j.end() && j.at("lvc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_lvc(get_stack_optional<Lvc>(j, "lvc"));
        if (j.find("otherArr") != j.end() && j.at("otherArr").is_null()) throw std::runtime_error("Unexpected null");
        x.set_other_arr(get_stack_optional<std::vector<OtherArr>>(j, "otherArr"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["arr"] = x.get_arr();
        j["for"] = x.get_top_level_for();
        j["gve"] = x.get_gve();
        j["lvc"] = x.get_lvc();
        j["otherArr"] = x.get_other_arr();
    }

    inline void from_json(const json & j, OtherArr & x) {
        if (j == "foo") x = OtherArr::FOO;
        else if (j == "bar") x = OtherArr::BAR;
        else if (j == "if") x = OtherArr::IF;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"OtherArr\""); }
    }

    inline void to_json(json & j, const OtherArr & x) {
        switch (x) {
            case OtherArr::FOO: j = "foo"; break;
            case OtherArr::BAR: j = "bar"; break;
            case OtherArr::IF: j = "if"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"OtherArr\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Gve & x) {
        if (j == "good") x = Gve::GOOD;
        else if (j == "neutral") x = Gve::NEUTRAL;
        else if (j == "evil") x = Gve::EVIL;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Gve\""); }
    }

    inline void to_json(json & j, const Gve & x) {
        switch (x) {
            case Gve::GOOD: j = "good"; break;
            case Gve::NEUTRAL: j = "neutral"; break;
            case Gve::EVIL: j = "evil"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Gve\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Lvc & x) {
        if (j == "lawful") x = Lvc::LAWFUL;
        else if (j == "neutral") x = Lvc::NEUTRAL;
        else if (j == "chaotic") x = Lvc::CHAOTIC;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Lvc\""); }
    }

    inline void to_json(json & j, const Lvc & x) {
        switch (x) {
            case Lvc::LAWFUL: j = "lawful"; break;
            case Lvc::NEUTRAL: j = "neutral"; break;
            case Lvc::CHAOTIC: j = "chaotic"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Lvc\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<quicktype::OtherArr, int64_t>>::from_json(const json & j, std::variant<quicktype::OtherArr, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<quicktype::OtherArr>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::OtherArr, int64_t>>::to_json(json & j, const std::variant<quicktype::OtherArr, int64_t> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::OtherArr>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
