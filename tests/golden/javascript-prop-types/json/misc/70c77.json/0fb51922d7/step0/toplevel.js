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
_TopLevel = PropTypes.shape({
    "base": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "date": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "rates": PropTypes.oneOfType([PropTypes.objectOf(PropTypes.number)]).isRequired,
});

export const TopLevel = _TopLevel;
