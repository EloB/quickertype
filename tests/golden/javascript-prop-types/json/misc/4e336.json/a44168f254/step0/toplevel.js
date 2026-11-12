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
let _TotalPopulation;
_TotalPopulation = PropTypes.shape({
    "date": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "population": PropTypes.oneOfType([Integer]).isRequired,
});
_TopLevel = PropTypes.shape({
    "total_population": PropTypes.oneOfType([PropTypes.arrayOf(_TotalPopulation)]).isRequired,
});

export const TopLevel = _TopLevel;
