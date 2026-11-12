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
let _Component;
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
_Component = PropTypes.shape({
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "uuid": PropTypes.oneOfType([(props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")]).isRequired,
});
_Result = PropTypes.shape({
    "attachment": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
    "body": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "changed": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "component": PropTypes.oneOfType([PropTypes.arrayOf(_Component)]).isRequired,
    "created": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "date": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "image": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
    "number": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "teaser": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "topic": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "uuid": PropTypes.oneOfType([(props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")]).isRequired,
    "vuuid": PropTypes.oneOfType([(props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")]).isRequired,
});
_TopLevel = PropTypes.shape({
    "metadata": _Metadata,
    "results": PropTypes.oneOfType([PropTypes.arrayOf(_Result)]).isRequired,
});

export const TopLevel = _TopLevel;
