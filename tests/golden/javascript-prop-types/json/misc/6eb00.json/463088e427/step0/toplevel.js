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
    "DirectorateID": PropTypes.oneOfType([Integer]).isRequired,
    "Id": PropTypes.oneOfType([Integer]).isRequired,
    "Name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
