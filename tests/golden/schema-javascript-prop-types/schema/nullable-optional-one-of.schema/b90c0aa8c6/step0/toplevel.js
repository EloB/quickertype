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
const _Kind = PropTypes.oneOf(['one', 'two']);
_TopLevel = PropTypes.shape({
    "b": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "kind": _Kind,
});

export const TopLevel = _TopLevel;
