// To parse this data:
//
//   const Convert = require("./TopLevel");
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
function toTopLevel(json) {
    return cast(JSON.parse(json), r("TopLevel"));
}

function topLevelToJson(value) {
    return JSON.stringify(uncast(value, r("TopLevel")), null, 2);
}

function invalidValue(typ, val, key, parent = '') {
    const prettyTyp = prettyTypeName(typ);
    const parentText = parent ? ` on ${parent}` : '';
    const keyText = key ? ` for key "${key}"` : '';
    throw Error(`Invalid value${keyText}${parentText}. Expected ${prettyTyp} but got ${JSON.stringify(val)}`);
}

function prettyTypeName(typ) {
    if (Array.isArray(typ)) {
        if (typ.length === 2 && typ[0] === undefined) {
            return `an optional ${prettyTypeName(typ[1])}`;
        } else {
            return `one of [${typ.map(a => { return prettyTypeName(a); }).join(", ")}]`;
        }
    } else if (typeof typ === "object" && typ.literal !== undefined) {
        return typ.literal;
    } else {
        return typeof typ;
    }
}

function jsonToJSProps(typ) {
    if (typ.jsonToJS === undefined) {
        const map = {};
        typ.props.forEach((p) => map[p.json] = { key: p.js, typ: p.typ });
        typ.jsonToJS = map;
    }
    return typ.jsonToJS;
}

function jsToJSONProps(typ) {
    if (typ.jsToJSON === undefined) {
        const map = {};
        typ.props.forEach((p) => map[p.js] = { key: p.json, typ: p.typ });
        typ.jsToJSON = map;
    }
    return typ.jsToJSON;
}

function transform(val, typ, getProps, key = '', parent = '') {
    function transformPrimitive(typ, val) {
        if (typeof typ === typeof val) return val;
        return invalidValue(typ, val, key, parent);
    }

    function transformUnion(typs, val) {
        // val must validate against one typ in typs
        const l = typs.length;
        for (let i = 0; i < l; i++) {
            const typ = typs[i];
            try {
                return transform(val, typ, getProps);
            } catch (_) {}
        }
        return invalidValue(typs, val, key, parent);
    }

    function transformEnum(cases, val) {
        if (cases.indexOf(val) !== -1) return val;
        return invalidValue(cases.map(a => { return l(a); }), val, key, parent);
    }

    function transformArray(typ, val) {
        // val must be an array with no invalid elements
        if (!Array.isArray(val)) return invalidValue(l("array"), val, key, parent);

        return val.map(el => transform(el, typ, getProps));
    }

    function transformDate(val) {
        if (val === null) {
            return null;
        }
        const d = new Date(val);
        if (isNaN(d.valueOf())) {
            return invalidValue(l("Date"), val, key, parent);
        }
        return d;
    }

    function transformObject(props, additional, val) {
        if (val === null || typeof val !== "object" || Array.isArray(val)) {
            return invalidValue(l(ref || "object"), val, key, parent);
        }
        const result = {};
        Object.getOwnPropertyNames(props).forEach(key => {
            const prop = props[key];
            const v = Object.prototype.hasOwnProperty.call(val, key) ? val[key] : undefined;
            result[prop.key] = transform(v, prop.typ, getProps, key, ref);
        });
        Object.getOwnPropertyNames(val).forEach(key => {
            if (!Object.prototype.hasOwnProperty.call(props, key)) {
                result[key] = transform(val[key], additional, getProps, key, ref);
            }
        });
        return result;
    }

    if (typ === "any") return val;
    if (typ === null) {
        if (val === null) return val;
        return invalidValue(typ, val, key, parent);
    }
    if (typ === false) return invalidValue(typ, val, key, parent);
    let ref = undefined;
    while (typeof typ === "object" && typ.ref !== undefined) {
        ref = typ.ref;
        typ = typeMap[typ.ref];
    }
    if (Array.isArray(typ)) return transformEnum(typ, val);
    if (typeof typ === "object") {
        return typ.hasOwnProperty("pattern")      ? typeof val === "string" && new RegExp(typ.pattern).test(val) ? val : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("string")       ? typeof val === "string" && (typ.min === undefined || Array.from(val).length >= typ.min) && (typ.max === undefined || Array.from(val).length <= typ.max) ? transform(val, typ.string, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("number")       ? typeof val === "number" && (typ.min === undefined || val >= typ.min) && (typ.max === undefined || val <= typ.max) ? transform(val, typ.number, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("integer")      ? typeof val === "number" && val % 1 === 0 ? val : invalidValue(l("integer"), val, key, parent)
            : typ.hasOwnProperty("unionMembers") ? transformUnion(typ.unionMembers, val)
            : typ.hasOwnProperty("arrayItems")    ? transformArray(typ.arrayItems, val)
            : typ.hasOwnProperty("props")         ? transformObject(getProps(typ), typ.additional, val)
            : invalidValue(typ, val, key, parent);
    }
    // Numbers can be parsed by Date but shouldn't be.
    if (typ === Date && (typeof val === "string" || val instanceof Date)) return transformDate(val);
    return transformPrimitive(typ, val);
}

function cast(val, typ) {
    return transform(val, typ, jsonToJSProps);
}

function uncast(val, typ) {
    return transform(val, typ, jsToJSONProps);
}

function l(typ) {
    return { literal: typ };
}

function a(typ) {
    return { arrayItems: typ };
}

function i(typ) {
    return { integer: typ };
}

function p(pattern) {
    return { pattern };
}

function s(typ, min, max) {
    return { string: typ, min, max };
}

function n(typ, min, max) {
    return { number: typ, min, max };
}

function u(...typs) {
    return { unionMembers: typs };
}

function o(props, additional) {
    return { props, additional };
}

function m(additional) {
    const props = [];
    return { props, additional };
}

function r(name) {
    return { ref: name };
}

const typeMap = {
    "TopLevel": o([
        { json: "attendance", js: "attendance", typ: i(0) },
        { json: "clock", js: "clock", typ: "" },
        { json: "disableMatch", js: "disableMatch", typ: i(0) },
        { json: "inOT", js: "inOT", typ: i(0) },
        { json: "leaddata", js: "leaddata", typ: a(a(u(r("LeaddatumEnum"), i(0)))) },
        { json: "officials_referee1", js: "officials_referee1", typ: "" },
        { json: "officials_referee2", js: "officials_referee2", typ: "" },
        { json: "officials_referee3", js: "officials_referee3", typ: "" },
        { json: "othermatches", js: "othermatches", typ: a(r("Othermatch")) },
        { json: "pbp", js: "pbp", typ: a(r("Pbp")) },
        { json: "period", js: "period", typ: i(0) },
        { json: "periodLengthOVERTIME", js: "periodLengthOVERTIME", typ: i(0) },
        { json: "periodLengthREGULAR", js: "periodLengthREGULAR", typ: i(0) },
        { json: "periodType", js: "periodType", typ: r("PerType") },
        { json: "periodsMax", js: "periodsMax", typ: i(0) },
        { json: "scorers", js: "scorers", typ: m(a(r("Scorer"))) },
        { json: "timeline", js: "timeline", typ: a("any") },
        { json: "tm", js: "tm", typ: m(r("Tm")) },
        { json: "totalTimeAdded", js: "totalTimeAdded", typ: i(0) },
        { json: "totallds", js: "totallds", typ: r("Totallds") },
    ], false),
    "Othermatch": o([
        { json: "clock", js: "clock", typ: "" },
        { json: "competitionName", js: "competitionName", typ: "" },
        { json: "id", js: "id", typ: "" },
        { json: "period", js: "period", typ: i(0) },
        { json: "periodType", js: "periodType", typ: r("PerType") },
        { json: "team1", js: "team1", typ: r("Team") },
        { json: "team1Name", js: "team1Name", typ: "" },
        { json: "team1Score", js: "team1Score", typ: i(0) },
        { json: "team2", js: "team2", typ: r("Team") },
        { json: "team2Name", js: "team2Name", typ: "" },
        { json: "team2Score", js: "team2Score", typ: i(0) },
    ], false),
    "Team": o([
        { json: "teamCode", js: "teamCode", typ: "" },
        { json: "teamCodeInternational", js: "teamCodeInternational", typ: "" },
        { json: "teamName", js: "teamName", typ: "" },
        { json: "teamNameInternational", js: "teamNameInternational", typ: "" },
    ], false),
    "Pbp": o([
        { json: "actionType", js: "actionType", typ: r("ActionType") },
        { json: "familyName", js: "familyName", typ: u(undefined, "") },
        { json: "familyNameInitial", js: "familyNameInitial", typ: u(undefined, r("FamilyNameInitial")) },
        { json: "firstName", js: "firstName", typ: u(undefined, "") },
        { json: "firstNameInitial", js: "firstNameInitial", typ: u(undefined, r("FirstNameInitial")) },
        { json: "gt", js: "gt", typ: "" },
        { json: "internationalFamilyName", js: "internationalFamilyName", typ: u(undefined, "") },
        { json: "internationalFamilyNameInitial", js: "internationalFamilyNameInitial", typ: u(undefined, r("FamilyNameInitial")) },
        { json: "internationalFirstName", js: "internationalFirstName", typ: u(undefined, "") },
        { json: "internationalFirstNameInitial", js: "internationalFirstNameInitial", typ: u(undefined, r("FirstNameInitial")) },
        { json: "lead", js: "lead", typ: i(0) },
        { json: "period", js: "period", typ: i(0) },
        { json: "periodType", js: "periodType", typ: r("PerType") },
        { json: "player", js: "player", typ: "" },
        { json: "pno", js: "pno", typ: i(0) },
        { json: "qualifier", js: "qualifier", typ: "" },
        { json: "s1", js: "s1", typ: i(0) },
        { json: "s2", js: "s2", typ: i(0) },
        { json: "scoreboardName", js: "scoreboardName", typ: u(undefined, r("ScoreboardName")) },
        { json: "scoring", js: "scoring", typ: i(0) },
        { json: "shirtNumber", js: "shirtNumber", typ: "" },
        { json: "subType", js: "subType", typ: "" },
        { json: "success", js: "success", typ: i(0) },
        { json: "tno", js: "tno", typ: i(0) },
    ], false),
    "Scorer": o([
        { json: "familyName", js: "familyName", typ: u(undefined, "") },
        { json: "familyNameInitial", js: "familyNameInitial", typ: u(undefined, r("FamilyNameInitial")) },
        { json: "firstName", js: "firstName", typ: u(undefined, "") },
        { json: "firstNameInitial", js: "firstNameInitial", typ: u(undefined, r("FirstNameInitial")) },
        { json: "gt", js: "gt", typ: u(undefined, "") },
        { json: "internationalFamilyName", js: "internationalFamilyName", typ: u(undefined, "") },
        { json: "internationalFamilyNameInitial", js: "internationalFamilyNameInitial", typ: u(undefined, r("FamilyNameInitial")) },
        { json: "internationalFirstName", js: "internationalFirstName", typ: u(undefined, "") },
        { json: "internationalFirstNameInitial", js: "internationalFirstNameInitial", typ: u(undefined, r("FirstNameInitial")) },
        { json: "name", js: "name", typ: u(undefined, "") },
        { json: "per", js: "per", typ: u(undefined, i(0)) },
        { json: "perType", js: "perType", typ: u(undefined, r("PerType")) },
        { json: "player", js: "player", typ: u(undefined, "") },
        { json: "pno", js: "pno", typ: i(0) },
        { json: "scoreboardName", js: "scoreboardName", typ: u(undefined, r("ScoreboardName")) },
        { json: "shirtNumber", js: "shirtNumber", typ: "" },
        { json: "summary", js: "summary", typ: u(undefined, "") },
        { json: "times", js: "times", typ: u(undefined, a(r("Time"))) },
        { json: "tno", js: "tno", typ: i(0) },
        { json: "tot", js: "tot", typ: u(undefined, i(0)) },
    ], false),
    "Time": o([
        { json: "gt", js: "gt", typ: "" },
        { json: "per", js: "per", typ: i(0) },
        { json: "perType", js: "perType", typ: r("PerType") },
    ], false),
    "Tm": o([
        { json: "code", js: "code", typ: "" },
        { json: "codeInternational", js: "codeInternational", typ: "" },
        { json: "fouls", js: "fouls", typ: i(0) },
        { json: "full_score", js: "full_score", typ: i(0) },
        { json: "lds", js: "lds", typ: r("Lds") },
        { json: "logo", js: "logo", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "nameInternational", js: "nameInternational", typ: "" },
        { json: "p1_score", js: "p1_score", typ: i(0) },
        { json: "p2_score", js: "p2_score", typ: i(0) },
        { json: "p3_score", js: "p3_score", typ: i(0) },
        { json: "p4_score", js: "p4_score", typ: i(0) },
        { json: "pl", js: "pl", typ: m(r("Pl")) },
        { json: "score", js: "score", typ: i(0) },
        { json: "scoring", js: "scoring", typ: a(r("Scorer")) },
        { json: "shortName", js: "shortName", typ: "" },
        { json: "shortNameInternational", js: "shortNameInternational", typ: "" },
        { json: "shot", js: "shot", typ: a(r("Shot")) },
        { json: "timeouts", js: "timeouts", typ: i(0) },
        { json: "tot_eff_1", js: "tot_eff_1", typ: i(0) },
        { json: "tot_eff_2", js: "tot_eff_2", typ: i(0) },
        { json: "tot_eff_3", js: "tot_eff_3", typ: 3.14 },
        { json: "tot_eff_4", js: "tot_eff_4", typ: i(0) },
        { json: "tot_eff_5", js: "tot_eff_5", typ: i(0) },
        { json: "tot_eff_6", js: "tot_eff_6", typ: i(0) },
        { json: "tot_eff_7", js: "tot_eff_7", typ: i(0) },
        { json: "tot_sAssists", js: "tot_sAssists", typ: i(0) },
        { json: "tot_sBenchPoints", js: "tot_sBenchPoints", typ: i(0) },
        { json: "tot_sBiggestLead", js: "tot_sBiggestLead", typ: i(0) },
        { json: "tot_sBiggestScoringRun", js: "tot_sBiggestScoringRun", typ: i(0) },
        { json: "tot_sBlocks", js: "tot_sBlocks", typ: i(0) },
        { json: "tot_sBlocksReceived", js: "tot_sBlocksReceived", typ: i(0) },
        { json: "tot_sFieldGoalsAttempted", js: "tot_sFieldGoalsAttempted", typ: i(0) },
        { json: "tot_sFieldGoalsMade", js: "tot_sFieldGoalsMade", typ: i(0) },
        { json: "tot_sFieldGoalsPercentage", js: "tot_sFieldGoalsPercentage", typ: i(0) },
        { json: "tot_sFoulsOn", js: "tot_sFoulsOn", typ: i(0) },
        { json: "tot_sFoulsPersonal", js: "tot_sFoulsPersonal", typ: i(0) },
        { json: "tot_sFoulsTeam", js: "tot_sFoulsTeam", typ: i(0) },
        { json: "tot_sFreeThrowsAttempted", js: "tot_sFreeThrowsAttempted", typ: i(0) },
        { json: "tot_sFreeThrowsMade", js: "tot_sFreeThrowsMade", typ: i(0) },
        { json: "tot_sFreeThrowsPercentage", js: "tot_sFreeThrowsPercentage", typ: i(0) },
        { json: "tot_sLeadChanges", js: "tot_sLeadChanges", typ: i(0) },
        { json: "tot_sMinutes", js: "tot_sMinutes", typ: i(0) },
        { json: "tot_sPoints", js: "tot_sPoints", typ: i(0) },
        { json: "tot_sPointsFastBreak", js: "tot_sPointsFastBreak", typ: i(0) },
        { json: "tot_sPointsFromTurnovers", js: "tot_sPointsFromTurnovers", typ: i(0) },
        { json: "tot_sPointsInThePaint", js: "tot_sPointsInThePaint", typ: i(0) },
        { json: "tot_sPointsSecondChance", js: "tot_sPointsSecondChance", typ: i(0) },
        { json: "tot_sReboundsDefensive", js: "tot_sReboundsDefensive", typ: i(0) },
        { json: "tot_sReboundsOffensive", js: "tot_sReboundsOffensive", typ: i(0) },
        { json: "tot_sReboundsTeam", js: "tot_sReboundsTeam", typ: i(0) },
        { json: "tot_sReboundsTeamDefensive", js: "tot_sReboundsTeamDefensive", typ: i(0) },
        { json: "tot_sReboundsTeamOffensive", js: "tot_sReboundsTeamOffensive", typ: i(0) },
        { json: "tot_sReboundsTotal", js: "tot_sReboundsTotal", typ: i(0) },
        { json: "tot_sSteals", js: "tot_sSteals", typ: i(0) },
        { json: "tot_sThreePointersAttempted", js: "tot_sThreePointersAttempted", typ: i(0) },
        { json: "tot_sThreePointersMade", js: "tot_sThreePointersMade", typ: i(0) },
        { json: "tot_sThreePointersPercentage", js: "tot_sThreePointersPercentage", typ: i(0) },
        { json: "tot_sTimeLeading", js: "tot_sTimeLeading", typ: 3.14 },
        { json: "tot_sTimesScoresLevel", js: "tot_sTimesScoresLevel", typ: i(0) },
        { json: "tot_sTurnovers", js: "tot_sTurnovers", typ: i(0) },
        { json: "tot_sTurnoversTeam", js: "tot_sTurnoversTeam", typ: i(0) },
        { json: "tot_sTwoPointersAttempted", js: "tot_sTwoPointersAttempted", typ: i(0) },
        { json: "tot_sTwoPointersMade", js: "tot_sTwoPointersMade", typ: i(0) },
        { json: "tot_sTwoPointersPercentage", js: "tot_sTwoPointersPercentage", typ: i(0) },
    ], false),
    "Lds": o([
        { json: "sAssists", js: "sAssists", typ: m(r("Scorer")) },
        { json: "sBlocks", js: "sBlocks", typ: r("SBlocks") },
        { json: "sPoints", js: "sPoints", typ: m(r("Scorer")) },
        { json: "sReboundsTotal", js: "sReboundsTotal", typ: m(r("Scorer")) },
        { json: "sSteals", js: "sSteals", typ: m(r("Scorer")) },
    ], false),
    "SBlocks": o([
        { json: "1", js: "1", typ: r("Scorer") },
    ], false),
    "Pl": o([
        { json: "active", js: "active", typ: i(0) },
        { json: "captain", js: "captain", typ: u(undefined, i(0)) },
        { json: "comp", js: "comp", typ: u(undefined, r("Comp")) },
        { json: "eff_1", js: "eff_1", typ: i(0) },
        { json: "eff_2", js: "eff_2", typ: i(0) },
        { json: "eff_3", js: "eff_3", typ: 3.14 },
        { json: "eff_4", js: "eff_4", typ: 3.14 },
        { json: "eff_5", js: "eff_5", typ: i(0) },
        { json: "eff_6", js: "eff_6", typ: i(0) },
        { json: "eff_7", js: "eff_7", typ: i(0) },
        { json: "familyName", js: "familyName", typ: "" },
        { json: "familyNameInitial", js: "familyNameInitial", typ: r("FamilyNameInitial") },
        { json: "firstName", js: "firstName", typ: "" },
        { json: "firstNameInitial", js: "firstNameInitial", typ: r("FirstNameInitial") },
        { json: "internationalFamilyName", js: "internationalFamilyName", typ: "" },
        { json: "internationalFamilyNameInitial", js: "internationalFamilyNameInitial", typ: r("FamilyNameInitial") },
        { json: "internationalFirstName", js: "internationalFirstName", typ: "" },
        { json: "internationalFirstNameInitial", js: "internationalFirstNameInitial", typ: r("FirstNameInitial") },
        { json: "name", js: "name", typ: "" },
        { json: "playingPosition", js: "playingPosition", typ: "" },
        { json: "sAssists", js: "sAssists", typ: i(0) },
        { json: "sBlocks", js: "sBlocks", typ: i(0) },
        { json: "sBlocksReceived", js: "sBlocksReceived", typ: i(0) },
        { json: "sFieldGoalsAttempted", js: "sFieldGoalsAttempted", typ: i(0) },
        { json: "sFieldGoalsMade", js: "sFieldGoalsMade", typ: i(0) },
        { json: "sFieldGoalsPercentage", js: "sFieldGoalsPercentage", typ: i(0) },
        { json: "sFoulsOn", js: "sFoulsOn", typ: i(0) },
        { json: "sFoulsPersonal", js: "sFoulsPersonal", typ: i(0) },
        { json: "sFreeThrowsAttempted", js: "sFreeThrowsAttempted", typ: i(0) },
        { json: "sFreeThrowsMade", js: "sFreeThrowsMade", typ: i(0) },
        { json: "sFreeThrowsPercentage", js: "sFreeThrowsPercentage", typ: i(0) },
        { json: "sMinutes", js: "sMinutes", typ: u(i(0), "") },
        { json: "sPlusMinusPoints", js: "sPlusMinusPoints", typ: i(0) },
        { json: "sPoints", js: "sPoints", typ: i(0) },
        { json: "sPointsFastBreak", js: "sPointsFastBreak", typ: i(0) },
        { json: "sPointsInThePaint", js: "sPointsInThePaint", typ: i(0) },
        { json: "sPointsSecondChance", js: "sPointsSecondChance", typ: i(0) },
        { json: "sReboundsDefensive", js: "sReboundsDefensive", typ: i(0) },
        { json: "sReboundsOffensive", js: "sReboundsOffensive", typ: i(0) },
        { json: "sReboundsTotal", js: "sReboundsTotal", typ: i(0) },
        { json: "sSteals", js: "sSteals", typ: i(0) },
        { json: "sThreePointersAttempted", js: "sThreePointersAttempted", typ: i(0) },
        { json: "sThreePointersMade", js: "sThreePointersMade", typ: i(0) },
        { json: "sThreePointersPercentage", js: "sThreePointersPercentage", typ: i(0) },
        { json: "sTurnovers", js: "sTurnovers", typ: i(0) },
        { json: "sTwoPointersAttempted", js: "sTwoPointersAttempted", typ: i(0) },
        { json: "sTwoPointersMade", js: "sTwoPointersMade", typ: i(0) },
        { json: "sTwoPointersPercentage", js: "sTwoPointersPercentage", typ: i(0) },
        { json: "shirtNumber", js: "shirtNumber", typ: "" },
        { json: "starter", js: "starter", typ: i(0) },
    ], false),
    "Comp": o([
        { json: "sAssistsAverage", js: "sAssistsAverage", typ: 3.14 },
        { json: "sMinutesAverage", js: "sMinutesAverage", typ: "" },
        { json: "sPointsAverage", js: "sPointsAverage", typ: 3.14 },
        { json: "sReboundsTotalAverage", js: "sReboundsTotalAverage", typ: 3.14 },
    ], false),
    "Shot": o([
        { json: "actionType", js: "actionType", typ: r("ActionType") },
        { json: "p", js: "p", typ: i(0) },
        { json: "per", js: "per", typ: i(0) },
        { json: "perType", js: "perType", typ: r("PerType") },
        { json: "player", js: "player", typ: "" },
        { json: "pno", js: "pno", typ: i(0) },
        { json: "r", js: "r", typ: i(0) },
        { json: "shirtNumber", js: "shirtNumber", typ: "" },
        { json: "subType", js: "subType", typ: r("SubType") },
        { json: "tno", js: "tno", typ: i(0) },
        { json: "x", js: "x", typ: i(0) },
        { json: "y", js: "y", typ: i(0) },
    ], false),
    "Totallds": o([
        { json: "sAssists", js: "sAssists", typ: m(r("Scorer")) },
        { json: "sBlocks", js: "sBlocks", typ: m(r("Scorer")) },
        { json: "sPoints", js: "sPoints", typ: m(r("Scorer")) },
        { json: "sReboundsTotal", js: "sReboundsTotal", typ: m(r("Scorer")) },
        { json: "sSteals", js: "sSteals", typ: m(r("Scorer")) },
    ], false),
    "LeaddatumEnum": [
        "",
        "P1",
        "P2",
        "P3",
        "P4",
    ],
    "PerType": [
        "REGULAR",
    ],
    "ActionType": [
        "game",
        "period",
        "3pt",
        "2pt",
        "rebound",
        "timeout",
        "foulon",
        "foul",
        "assist",
        "substitution",
        "freethrow",
        "steal",
        "turnover",
        "block",
        "jumpball",
    ],
    "FamilyNameInitial": [
        "R",
        "M",
        "s",
        "C",
        "O",
        "W",
        "A",
        "P",
        "V",
        "I",
        "J",
        "S",
        "H",
        "B",
    ],
    "FirstNameInitial": [
        "D",
        "J",
        "T",
        "C",
        "O",
        "H",
        "L",
        "A",
        "K",
        "R",
        "B",
        "N",
    ],
    "ScoreboardName": [
        "",
        "T. s",
        "R. Ihata",
        "D. Jones",
        "B. Valentine",
    ],
    "SubType": [
        "jumpshot",
        "layup",
        "dunk",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
