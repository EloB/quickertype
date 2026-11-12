//  To parse this JSON data, first install
//
//      Boost     http://www.boost.org
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <boost/variant.hpp>
#include "json.hpp"

#include <boost/optional.hpp>
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
    struct adl_serializer<boost::optional<T>> {
        static void to_json(json & j, const boost::optional<T> & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static boost::optional<T> from_json(const json & j) {
            if (j.is_null()) return boost::optional<T>(); else return boost::optional<T>(j.get<T>());
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
    inline boost::optional<T> get_stack_optional(const json & j, const char * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<boost::optional<T>>();
        }
        return boost::optional<T>();
    }

    template <typename T>
    inline boost::optional<T> get_stack_optional(const json & j, std::string property) {
        return get_stack_optional<T>(j, property.data());
    }
    #endif

    using X = boost::optional<boost::variant<int64_t, std::string>>;

    class ZClass {
        public:
        ZClass() = default;
        virtual ~ZClass() = default;

        private:
        bool a;

        public:
        const bool & get_a() const { return a; }
        bool & get_mutable_a() { return a; }
        void set_a(const bool & value) { this->a = value; }
    };

    using ZElement = boost::variant<std::vector<int64_t>, ZClass, int64_t>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<X> x;
        std::vector<boost::optional<int64_t>> y;
        std::vector<ZElement> z;

        public:
        const std::vector<X> & get_x() const { return x; }
        std::vector<X> & get_mutable_x() { return x; }
        void set_x(const std::vector<X> & value) { this->x = value; }

        const std::vector<boost::optional<int64_t>> & get_y() const { return y; }
        std::vector<boost::optional<int64_t>> & get_mutable_y() { return y; }
        void set_y(const std::vector<boost::optional<int64_t>> & value) { this->y = value; }

        const std::vector<ZElement> & get_z() const { return z; }
        std::vector<ZElement> & get_mutable_z() { return z; }
        void set_z(const std::vector<ZElement> & value) { this->z = value; }
    };
}

namespace quicktype {
void from_json(const json & j, ZClass & x);
void to_json(json & j, const ZClass & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<boost::variant<int64_t, std::string>> {
    static void from_json(const json & j, boost::variant<int64_t, std::string> & x);
    static void to_json(json & j, const boost::variant<int64_t, std::string> & x);
};

template <>
struct adl_serializer<boost::variant<std::vector<int64_t>, quicktype::ZClass, int64_t>> {
    static void from_json(const json & j, boost::variant<std::vector<int64_t>, quicktype::ZClass, int64_t> & x);
    static void to_json(json & j, const boost::variant<std::vector<int64_t>, quicktype::ZClass, int64_t> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, ZClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_a(j.at("a").get<bool>());
    }

    inline void to_json(json & j, const ZClass & x) {
        j = json::object();
        j["a"] = x.get_a();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_x(j.at("x").get<std::vector<X>>());
        x.set_y(j.at("y").get<std::vector<boost::optional<int64_t>>>());
        x.set_z(j.at("z").get<std::vector<ZElement>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["x"] = x.get_x();
        j["y"] = x.get_y();
        j["z"] = x.get_z();
    }
}
namespace nlohmann {
    inline void adl_serializer<boost::variant<int64_t, std::string>>::from_json(const json & j, boost::variant<int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<boost::variant<int64_t, std::string>>::to_json(json & j, const boost::variant<int64_t, std::string> & x) {
        switch (x.which()) {
            case 0:
                j = boost::get<int64_t>(x);
                break;
            case 1:
                j = boost::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<boost::variant<std::vector<int64_t>, quicktype::ZClass, int64_t>>::from_json(const json & j, boost::variant<std::vector<int64_t>, quicktype::ZClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::ZClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<boost::variant<std::vector<int64_t>, quicktype::ZClass, int64_t>>::to_json(json & j, const boost::variant<std::vector<int64_t>, quicktype::ZClass, int64_t> & x) {
        switch (x.which()) {
            case 0:
                j = boost::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = boost::get<quicktype::ZClass>(x);
                break;
            case 2:
                j = boost::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
