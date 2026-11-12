// Example usage:
//
// import { MyShape } from ./myShape.js;
//
// class MyComponent extends React.Component {
//   //
// }
//
// MyComponent.propTypes = {
//   input: MyShape
// };

import PropTypes from "prop-types";
const Integer = (props, name) => props[name] == null || Number.isInteger(props[name]) ? null : new Error("Expected integer");

let _TopLevel;
let _Facets;
let _Result;
const _Status = PropTypes.oneOf(['active', 'inactive']);
_Facets = PropTypes.shape({
});
_Result = PropTypes.shape({
    "acronym": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "activity_consult_committees": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "activity_eu_legislative": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "activity_expert_groups": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "activity_high_level_groups": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "activity_industry_forums": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "activity_inter_groups": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "activity_other": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "activity_relevant_comm": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "be_office_country": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "be_office_lat": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "be_office_lon": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "be_office_phone": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "be_office_post_code": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "be_office_postbox": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "be_office_street": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "be_office_town": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "code_of_conduct": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "contact_country": PropTypes.oneOfType([Integer]).isRequired,
    "created_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "entity": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "goals": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "head": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "head_office_country": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "head_office_lat": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])])])(props, name, ...args),
    "head_office_lon": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])])])(props, name, ...args),
    "head_office_phone": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "head_office_post_code": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "head_office_postbox": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "head_office_street": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "head_office_town": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "identification_code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "info_members": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "last_update_date": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "legal": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "legal_status": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "main_category": PropTypes.oneOfType([Integer]).isRequired,
    "main_category_title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "members": PropTypes.oneOfType([Integer]).isRequired,
    "members_100": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "members_25": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "members_50": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "members_75": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "members_fte": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "native_name": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "networking": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "number_of_natural_persons": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "other_code_of_conduct": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "registration_date": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "status": _Status,
    "structure_members": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sub_category": PropTypes.oneOfType([Integer]).isRequired,
    "sub_category_title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "updated_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "uri": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "web_site_url": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
});
_TopLevel = PropTypes.shape({
    "count": PropTypes.oneOfType([Integer]).isRequired,
    "facets": _Facets,
    "limit": PropTypes.oneOfType([Integer]).isRequired,
    "next": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "offset": PropTypes.oneOfType([Integer]).isRequired,
    "previous": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "results": PropTypes.oneOfType([PropTypes.arrayOf(_Result)]).isRequired,
});

export const TopLevel = _TopLevel;
