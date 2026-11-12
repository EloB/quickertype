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
let _RegExp;
_RegExp = PropTypes.shape({
    "pattern3": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && new RegExp("d[.]*").test(value)) ? null : new Error("Expected bounded string"); }]).isRequired,
});
_TopLevel = PropTypes.shape({
    "pattern1": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && new RegExp("a[.]*").test(value)) ? null : new Error("Expected bounded string"); }]).isRequired,
    "pattern2": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && new RegExp("b[.]*").test(value)) ? null : new Error("Expected bounded string"); }]).isRequired,
    "RegExp": PropTypes.oneOfType([_RegExp, PropTypes.oneOf([null])]),
    "union": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && new RegExp("(b[.]*)|(c[.]*)").test(value)) ? null : new Error("Expected bounded string"); }]).isRequired,
});

export const TopLevel = _TopLevel;
