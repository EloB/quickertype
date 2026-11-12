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
let _Coordinate;
_Coordinate = PropTypes.shape({
    "latitude": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "longitude": PropTypes.oneOfType([PropTypes.number]).isRequired,
});
_TopLevel = PropTypes.shape({
    "coordinates": PropTypes.oneOfType([PropTypes.arrayOf(_Coordinate), PropTypes.oneOf([null])]),
    "count": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= 1 && value <= 100) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "label": PropTypes.oneOfType([PropTypes.oneOf([null]), (props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 2 && [...value].length <= 16) ? null : new Error("Expected bounded string"); }]),
    "requiredCoordinates": PropTypes.oneOfType([PropTypes.arrayOf(_Coordinate)]).isRequired,
    "requiredCount": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (Number.isInteger(value) && value >= 1 && value <= 100) ? null : new Error("Expected bounded number"); }]).isRequired,
    "requiredLabel": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 2 && [...value].length <= 16) ? null : new Error("Expected bounded string"); }]).isRequired,
    "weight": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0.5 && value <= 99.5) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
