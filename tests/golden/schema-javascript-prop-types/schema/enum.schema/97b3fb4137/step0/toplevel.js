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
const _OtherArr = PropTypes.oneOf(['foo', 'bar', 'if']);
const _Gve = PropTypes.oneOf(['good', 'neutral', 'evil']);
const _Lvc = PropTypes.oneOf(['lawful', 'neutral', 'chaotic']);
_TopLevel = PropTypes.shape({
    "arr": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([_OtherArr, Integer])), PropTypes.oneOf([null])]),
    "for": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "gve": _Gve,
    "lvc": PropTypes.oneOfType([_Lvc, PropTypes.oneOf([null])]),
    "otherArr": PropTypes.oneOfType([PropTypes.arrayOf(_OtherArr), PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
