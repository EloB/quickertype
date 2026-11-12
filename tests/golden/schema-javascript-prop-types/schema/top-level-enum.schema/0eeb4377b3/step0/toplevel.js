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

const _TopLevel = PropTypes.oneOf(['one', 'three', 'two']);

export const TopLevel = _TopLevel;
