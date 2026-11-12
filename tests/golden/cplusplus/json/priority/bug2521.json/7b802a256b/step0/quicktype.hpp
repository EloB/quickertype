//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);
//
//  You can get std::wstring data back out using
//
//     std::wcout << wdump((nlohmann::json) TopLevel);

#pragma once

#include <optional>
#include "json.hpp"

#include <optional>
#include <stdexcept>
#include <regex>
#include <codecvt>
#include <locale>

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

    template<typename T>
    struct tag {};

    template<typename fromType, typename toType>
    class Utf16_Utf8 {
        private:
        template<typename TF, typename TT>
        static toType convert(tag<std::shared_ptr<TF> >, tag<std::shared_ptr<TT> >, fromType ptr) {
            if (ptr == nullptr) return std::unique_ptr<TT>(); else return std::unique_ptr<TT>(new TT(Utf16_Utf8<TF,TT>::convert(*ptr)));
        }

        template<typename TF, typename TT>
        static toType convert(tag<std::optional<TF> >, tag<std::optional<TT> >, fromType opt) {
            if (!opt) return toType(); else return toType(Utf16_Utf8<TF,TT>::convert(*opt));
        }

        template<typename TF, typename TT>
        static toType convert(tag<std::vector<TF> >, tag<std::vector<TT> >, fromType v) {
            auto it = v.begin();
            auto newVector = std::vector<TT>();
            while (it != v.end()) {
                newVector.push_back(Utf16_Utf8<TF,TT>::convert(*it));
                it++;
            }
            return newVector;
        }

        template<typename KF, typename VF, typename KT, typename VT>
        static toType convert(tag<std::map<KF,VF> >, tag<std::map<KT,VT> >, fromType m) {
            auto it = m.begin();
            auto newMap = std::map<KT, VT>();
            while (it != m.end()) {
                newMap.insert(std::pair<KT, VT>(Utf16_Utf8<KF, KT>::convert(it->first), Utf16_Utf8<VF, VT>::convert(it->second)));
                it++;
            }
            return newMap;
        }

        template<typename TF, typename TT>
        static fromType convert(tag<TF>, tag<TT>, fromType from) {
            return from;
        }

        static std::wstring convert(tag<std::string>, tag<std::wstring>, std::string str) {
            return std::wstring_convert<std::codecvt_utf8_utf16<wchar_t, 0x10ffff, std::little_endian>, wchar_t>{}.from_bytes(str.data());
        }

        static std::string convert(tag<std::wstring>, tag<std::string>, std::wstring str) {
            return std::wstring_convert<std::codecvt_utf8_utf16<wchar_t, 0x10ffff, std::little_endian>, wchar_t>{}.to_bytes(str.data());
        }

        public:
        static toType convert(fromType in) {
            return convert(tag<fromType>(), tag<toType>(), in);
        }
    };

    template<typename T>
    std::wstring wdump(const T& j) {
        std::ostringstream s;
        s << j;
        return Utf16_Utf8<std::string, std::wstring>::convert(s.str()); 
    }

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

    class Option {
        public:
        Option() = default;
        virtual ~Option() = default;

        private:
        std::optional<std::wstring> foo;
        std::wstring name;

        public:
        const std::optional<std::wstring> & get_foo() const { return foo; }
        std::optional<std::wstring> & get_mutable_foo() { return foo; }
        void set_foo(const std::optional<std::wstring> & value) { this->foo = value; }

        const std::wstring & get_name() const { return name; }
        std::wstring & get_mutable_name() { return name; }
        void set_name(const std::wstring & value) { this->name = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Option> options;

        public:
        const std::vector<Option> & get_options() const { return options; }
        std::vector<Option> & get_mutable_options() { return options; }
        void set_options(const std::vector<Option> & value) { this->options = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Option & x);
    void to_json(json & j, const Option & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Option& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("foo") != j.end() && j.at("foo").is_null()) throw std::runtime_error("Unexpected null");
        x.set_foo(Utf16_Utf8<std::optional<std::string>, std::optional<std::wstring>>::convert(get_stack_optional<std::string>(j, Utf16_Utf8<std::wstring, std::string>::convert(L"foo"))));
        x.set_name(Utf16_Utf8<std::string, std::wstring>::convert(j.at(Utf16_Utf8<std::wstring, std::string>::convert(L"name")).get<std::string>()));
    }

    inline void to_json(json & j, const Option & x) {
        j = json::object();
        j[Utf16_Utf8<std::wstring, std::string>::convert(L"foo")] = Utf16_Utf8<std::optional<std::wstring>, std::optional<std::string>>::convert(x.get_foo());
        j[Utf16_Utf8<std::wstring, std::string>::convert(L"name")] = Utf16_Utf8<std::wstring, std::string>::convert(x.get_name());
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_options(j.at(Utf16_Utf8<std::wstring, std::string>::convert(L"options")).get<std::vector<Option>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j[Utf16_Utf8<std::wstring, std::string>::convert(L"options")] = x.get_options();
    }
}
