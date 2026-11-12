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
let _DifferentThingClass;
let _PersonElement;
let _PurplePerson;
_DifferentThingClass = PropTypes.shape({
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_PersonElement = PropTypes.shape({
    "intOrString": PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.string])]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "optionalValue": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
});
_PurplePerson = PropTypes.shape({
    "intOrString": PropTypes.oneOfType([Integer]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "booleanValue": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "dateValue": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "differentThings": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([_DifferentThingClass, Integer, PropTypes.string]))]).isRequired,
    "doubleValue": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "intValue": PropTypes.oneOfType([Integer]).isRequired,
    "mapValue": PropTypes.oneOfType([PropTypes.objectOf(PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]))]).isRequired,
    "name with spaces": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "nullValue": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "nullableMapValue": PropTypes.oneOfType([PropTypes.objectOf(PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]))]).isRequired,
    "people": PropTypes.oneOfType([PropTypes.arrayOf(_PersonElement)]).isRequired,
    "person": _PurplePerson,
    "stringValue": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "tuples": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.oneOfType([Integer, PropTypes.string])))]).isRequired,
    "uuidValue": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
