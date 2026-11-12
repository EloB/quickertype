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
_TopLevel = PropTypes.shape({
    "booleanValue": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "doubleValue": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "intValue": PropTypes.oneOfType([Integer]).isRequired,
    "stringValue": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "uuidValue": PropTypes.oneOfType([(props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")]).isRequired,
    "uuidValues": PropTypes.oneOfType([PropTypes.arrayOf((props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID"))]).isRequired,
});

export const TopLevel = _TopLevel;
