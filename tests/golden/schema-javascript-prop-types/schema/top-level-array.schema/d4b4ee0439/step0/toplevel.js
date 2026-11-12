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
    "label": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "score": PropTypes.oneOfType([PropTypes.number]).isRequired,
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
