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
let _Meta;
let _Object;
let _Extra;
let _Person;
const _Party = PropTypes.oneOf(['Democrat', 'Republican', 'Independent']);
const _Gender = PropTypes.oneOf(['female', 'male']);
const _GenderLabel = PropTypes.oneOf(['Female', 'Male']);
const _Namemod = PropTypes.oneOf(['', 'Jr.', 'III']);
const _RoleType = PropTypes.oneOf(['senator']);
const _RoleTypeLabel = PropTypes.oneOf(['Senator']);
const _SenatorClass = PropTypes.oneOf(['class1', 'class2', 'class3']);
const _SenatorClassLabel = PropTypes.oneOf(['Class 1', 'Class 2', 'Class 3']);
const _SenatorRank = PropTypes.oneOf(['junior', 'senior']);
const _SenatorRankLabel = PropTypes.oneOf(['Junior', 'Senior']);
const _Title = PropTypes.oneOf(['Sen.']);
_Meta = PropTypes.shape({
    "limit": PropTypes.oneOfType([Integer]).isRequired,
    "offset": PropTypes.oneOfType([Integer]).isRequired,
    "total_count": PropTypes.oneOfType([Integer]).isRequired,
});
_Extra = PropTypes.shape({
    "address": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "contact_form": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "fax": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "office": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "rss_url": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_Person = PropTypes.shape({
    "bioguideid": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "birthday": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "cspanid": PropTypes.oneOfType([Integer]).isRequired,
    "firstname": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "gender": _Gender,
    "gender_label": _GenderLabel,
    "lastname": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "link": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "middlename": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "namemod": _Namemod,
    "nickname": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "osid": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "pvsid": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sortname": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "twitterid": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "youtubeid": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
});
_Object = PropTypes.shape({
    "caucus": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_Party, PropTypes.oneOf([null])])])(props, name, ...args),
    "congress_numbers": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
    "current": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "district": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "enddate": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "extra": _Extra,
    "leadership_title": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "party": _Party,
    "person": _Person,
    "phone": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "role_type": _RoleType,
    "role_type_label": _RoleTypeLabel,
    "senator_class": _SenatorClass,
    "senator_class_label": _SenatorClassLabel,
    "senator_rank": _SenatorRank,
    "senator_rank_label": _SenatorRankLabel,
    "startdate": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "state": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": _Title,
    "title_long": _RoleTypeLabel,
    "website": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "meta": _Meta,
    "objects": PropTypes.oneOfType([PropTypes.arrayOf(_Object)]).isRequired,
});

export const TopLevel = _TopLevel;
