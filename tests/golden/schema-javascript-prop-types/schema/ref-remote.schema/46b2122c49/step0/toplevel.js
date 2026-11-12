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
    "next": PropTypes.oneOfType([(...args) => _TopLevel(...args), PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
