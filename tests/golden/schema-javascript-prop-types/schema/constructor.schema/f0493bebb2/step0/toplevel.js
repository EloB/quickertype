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
let _Constructor;
_Constructor = PropTypes.shape({
});
_TopLevel = PropTypes.shape({
    "constructor": (props, name, ...args) => Object.prototype.hasOwnProperty.call(props, name) ? PropTypes.oneOfType([_Constructor, PropTypes.number, PropTypes.oneOf([null])])(props, name, ...args) : null,
});

export const TopLevel = _TopLevel;
