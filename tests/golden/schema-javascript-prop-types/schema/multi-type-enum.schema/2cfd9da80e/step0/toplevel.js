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
const _FooEnum = PropTypes.oneOf(['a', 'b', 'c']);
_TopLevel = PropTypes.shape({
    "foo": PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.bool, PropTypes.number, _FooEnum])]).isRequired,
});

export const TopLevel = _TopLevel;
