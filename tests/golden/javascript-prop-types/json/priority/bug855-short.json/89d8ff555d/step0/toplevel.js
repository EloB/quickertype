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
    "channel_id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "channel_name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "emoticon_set": PropTypes.oneOfType([Integer]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
});

export const TopLevel = PropTypes.oneOfType([PropTypes.objectOf(_TopLevel)]).isRequired;
