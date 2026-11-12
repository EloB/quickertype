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
    "free": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "intersection": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 4 && value <= 5) ? null : new Error("Expected bounded number"); }]).isRequired,
    "max": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value <= 5) ? null : new Error("Expected bounded number"); }]).isRequired,
    "min": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 3) ? null : new Error("Expected bounded number"); }]).isRequired,
    "minmax": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 3 && value <= 5) ? null : new Error("Expected bounded number"); }]).isRequired,
    "minMaxIntersection": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 3 && value <= 5) ? null : new Error("Expected bounded number"); }]).isRequired,
    "minMaxUnion": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "union": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 3 && value <= 6) ? null : new Error("Expected bounded number"); }]).isRequired,
});

export const TopLevel = _TopLevel;
