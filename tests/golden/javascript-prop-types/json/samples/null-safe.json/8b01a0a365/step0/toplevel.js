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
let _Item;
let _Address;
_Address = PropTypes.shape({
    "city": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "country": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "street": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Item = PropTypes.shape({
    "address": PropTypes.oneOfType([_Address, PropTypes.oneOf([null])]),
    "created_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time"), PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sex": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
});
_TopLevel = PropTypes.shape({
    "item": PropTypes.oneOfType([PropTypes.arrayOf(_Item)]).isRequired,
});

export const TopLevel = _TopLevel;
