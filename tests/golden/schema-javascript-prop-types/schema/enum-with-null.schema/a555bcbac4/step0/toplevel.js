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
const _Enum = PropTypes.oneOf(['foo', 'bar']);
_TopLevel = PropTypes.shape({
    "enum": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_Enum, PropTypes.oneOf([null])])])(props, name, ...args),
});

export const TopLevel = _TopLevel;
