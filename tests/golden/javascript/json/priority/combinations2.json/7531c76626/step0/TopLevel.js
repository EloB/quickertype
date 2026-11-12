// To parse this data:
//
//   const Convert = require("./TopLevel");
//
//   const topLevel = Convert.toTopLevel(json);

// Converts JSON strings to/from your types
function toTopLevel(json) {
    return JSON.parse(json);
}

function topLevelToJson(value) {
    return JSON.stringify(value);
}

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
