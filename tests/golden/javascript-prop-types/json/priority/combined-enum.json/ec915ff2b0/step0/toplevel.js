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
let _Bar;
const _X = PropTypes.oneOf(['three', 'one', 'two']);
_Bar = PropTypes.shape({
    "x": _X,
});
_TopLevel = PropTypes.shape({
    "bar": PropTypes.oneOfType([PropTypes.arrayOf(_Bar)]).isRequired,
    "foo": PropTypes.oneOfType([PropTypes.arrayOf(_Bar)]).isRequired,
});

export const TopLevel = _TopLevel;
