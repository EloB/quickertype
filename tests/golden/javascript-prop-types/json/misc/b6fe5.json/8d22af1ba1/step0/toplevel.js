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
    "group": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "movie": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "movie-image": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "theater": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
