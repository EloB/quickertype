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
let _Config;
let _ClosedClass;
let _Item;
_ClosedClass = PropTypes.shape({
});
_Item = PropTypes.shape({
    "key": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "value": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Config = PropTypes.shape({
    "closed": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any), PropTypes.bool, _ClosedClass, PropTypes.number, Integer, PropTypes.oneOf([null]), PropTypes.string]),
    "name": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "settings": PropTypes.oneOfType([PropTypes.objectOf(PropTypes.arrayOf(_Item)), PropTypes.oneOf([null])]),
});
_TopLevel = PropTypes.shape({
    "config": PropTypes.oneOfType([_Config, PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
