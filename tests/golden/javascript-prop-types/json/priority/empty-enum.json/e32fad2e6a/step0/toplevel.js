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
let _Foo;
_Foo = PropTypes.shape({
    "bar": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_TopLevel = PropTypes.shape({
    "foo": PropTypes.oneOfType([PropTypes.arrayOf(_Foo)]).isRequired,
});

export const TopLevel = _TopLevel;
