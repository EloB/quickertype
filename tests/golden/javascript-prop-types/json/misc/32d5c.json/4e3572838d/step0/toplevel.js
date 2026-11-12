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
_TopLevel = PropTypes.shape({
    "BirthDate": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time"), PropTypes.oneOf([null])])])(props, name, ...args),
    "BirthDateIsProtected": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "GenderTypeID": PropTypes.oneOfType([Integer]).isRequired,
    "Notes": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "ParliamentaryName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "PersonID": PropTypes.oneOfType([Integer]).isRequired,
    "PhotoURL": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "PreferredName": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
