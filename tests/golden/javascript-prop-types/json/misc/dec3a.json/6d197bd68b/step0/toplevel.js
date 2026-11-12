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
let _Metadata;
let _ResponseInfo;
let _Resultset;
let _Result;
let _HiringOrg;
let _Location;
_ResponseInfo = PropTypes.shape({
    "developerMessage": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "status": PropTypes.oneOfType([Integer]).isRequired,
});
_Resultset = PropTypes.shape({
    "count": PropTypes.oneOfType([Integer]).isRequired,
    "page": PropTypes.oneOfType([Integer]).isRequired,
    "pagesize": PropTypes.oneOfType([Integer]).isRequired,
});
_Metadata = PropTypes.shape({
    "executionTime": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "responseInfo": _ResponseInfo,
    "resultset": _Resultset,
});
_HiringOrg = PropTypes.shape({
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "uuid": PropTypes.oneOfType([(props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")]).isRequired,
});
_Location = PropTypes.shape({
    "administrative_area": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "country": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "fax_number": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "locality": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "mobile_number": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "phone_number": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "phone_number_extension": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "postal_code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sub_premise": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "thoroughfare": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Result = PropTypes.shape({
    "about_office": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "application_process": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "body": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "changed": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "created": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "deadline": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "hiring_office": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "hiring_org": _HiringOrg,
    "job_id": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "language": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "location": _Location,
    "num_positions": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "position": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "practice_area": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "qualifications": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "relocation_expenses": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "salary": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "travel": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "uuid": PropTypes.oneOfType([(props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")]).isRequired,
    "vuuid": PropTypes.oneOfType([(props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")]).isRequired,
});
_TopLevel = PropTypes.shape({
    "metadata": _Metadata,
    "results": PropTypes.oneOfType([PropTypes.arrayOf(_Result)]).isRequired,
});

export const TopLevel = _TopLevel;
