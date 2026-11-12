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

    enum class TopLevel : int { ONE, THREE, TWO };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel & x) {
        if (j == "one") x = TopLevel::ONE;
        else if (j == "three") x = TopLevel::THREE;
        else if (j == "two") x = TopLevel::TWO;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"TopLevel\""); }
    }

    inline void to_json(json & j, const TopLevel & x) {
        switch (x) {
            case TopLevel::ONE: j = "one"; break;
            case TopLevel::THREE: j = "three"; break;
            case TopLevel::TWO: j = "two"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"TopLevel\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
