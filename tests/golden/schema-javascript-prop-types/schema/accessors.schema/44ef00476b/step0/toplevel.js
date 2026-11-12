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
const _Enum = PropTypes.oneOf(['red', 'green', 'blue']);
_TopLevel = PropTypes.shape({
    "bar": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "enum": _Enum,
    "foo": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "union": PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.bool, PropTypes.number])]).isRequired,
});

export const TopLevel = _TopLevel;
