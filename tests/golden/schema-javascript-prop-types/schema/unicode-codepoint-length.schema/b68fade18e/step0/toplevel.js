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

let _TopLevel;
_TopLevel = PropTypes.shape({
    "exact": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 2 && [...value].length <= 2 && new RegExp("^[^!]+$").test(value)) ? null : new Error("Expected bounded string"); }]).isRequired,
    "maximum": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length <= 1) ? null : new Error("Expected bounded string"); }]).isRequired,
    "minimum": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 2) ? null : new Error("Expected bounded string"); }]).isRequired,
});

export const TopLevel = _TopLevel;
