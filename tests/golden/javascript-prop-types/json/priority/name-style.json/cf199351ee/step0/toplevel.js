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
    "   spaces are separators  too  ": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "JSONString": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "PrettyEasyToo": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "ZSR_HH_DEMO3_DELMATNR": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "anEasyOne": PropTypes.oneOfType([Integer]).isRequired,
    "isMNISTLetter": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "should_know_that_id_is_an_initialism": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
