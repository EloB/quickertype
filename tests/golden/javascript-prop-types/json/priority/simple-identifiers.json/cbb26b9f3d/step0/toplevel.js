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
    "": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "continue": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "null": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "undefined": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "x": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "x y": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "x\"": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "x'": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "{}": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
