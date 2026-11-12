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

let _TopLevelClass;
let _XClass;
_XClass = PropTypes.shape({
    "x": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any), PropTypes.bool, _XClass, PropTypes.number, PropTypes.oneOf([null]), PropTypes.string])), PropTypes.bool, PropTypes.number, PropTypes.objectOf(PropTypes.any), PropTypes.oneOf([null]), PropTypes.string]),
});
_TopLevelClass = PropTypes.shape({
    "x": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any), PropTypes.bool, _XClass, PropTypes.number, PropTypes.oneOf([null]), PropTypes.string])), PropTypes.bool, PropTypes.number, PropTypes.objectOf(PropTypes.any), PropTypes.oneOf([null]), PropTypes.string]),
});

export const TopLevel = (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any), PropTypes.bool, _TopLevelClass, PropTypes.number, PropTypes.oneOf([null]), PropTypes.string])), PropTypes.bool, PropTypes.number, Integer, PropTypes.objectOf(PropTypes.any), PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args);
