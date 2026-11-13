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
#include "helper.hpp"

namespace quicktype {
    class DifferentThingClass;
}

namespace quicktype {
    using nlohmann::json;

    using DifferentThingElement = std::variant<DifferentThingClass, int64_t, std::string>;
}
