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
    using nlohmann::json;

    using IntOrString = std::variant<int64_t, std::string>;
}
