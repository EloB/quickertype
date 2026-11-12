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
    "map": PropTypes.oneOfType([PropTypes.objectOf(PropTypes.oneOfType([PropTypes.bool, PropTypes.number])), PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
