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
    "intersection": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 4 && [...value].length <= 5) ? null : new Error("Expected bounded string"); }]).isRequired,
    "inUnion": PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.number, (props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 3 && [...value].length <= 5) ? null : new Error("Expected bounded string"); }])]).isRequired,
    "maxlength": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length <= 5) ? null : new Error("Expected bounded string"); }]).isRequired,
    "minlength": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 3) ? null : new Error("Expected bounded string"); }]).isRequired,
    "minMaxIntersection": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 3 && [...value].length <= 5) ? null : new Error("Expected bounded string"); }]).isRequired,
    "minmaxlength": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 3 && [...value].length <= 5) ? null : new Error("Expected bounded string"); }]).isRequired,
    "minMaxUnion": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "union": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 3 && [...value].length <= 6) ? null : new Error("Expected bounded string"); }]).isRequired,
});

export const TopLevel = _TopLevel;
