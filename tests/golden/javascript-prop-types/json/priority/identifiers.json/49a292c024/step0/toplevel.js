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
const Integer = (props, name) => props[name] == null || Number.isInteger(props[name]) ? null : new Error("Expected integer");

let _TopLevel;
let _Empty;
let _EmptyClass;
let _ThisIsAToughOne;
let _TopLevelBla;
let _Foo;
let _FooBla;
_Empty = PropTypes.shape({
    "x": PropTypes.oneOfType([Integer]).isRequired,
});
_EmptyClass = PropTypes.shape({
    "y": PropTypes.oneOfType([Integer]).isRequired,
});
_ThisIsAToughOne = PropTypes.shape({
    "\n\n\n": PropTypes.oneOfType([Integer]).isRequired,
    "\"": PropTypes.oneOfType([Integer]).isRequired,
});
_TopLevelBla = PropTypes.shape({
    "bar": PropTypes.oneOfType([Integer]).isRequired,
});
_FooBla = PropTypes.shape({
});
_Foo = PropTypes.shape({
    "_": PropTypes.oneOfType([Integer]).isRequired,
    "__": PropTypes.oneOfType([Integer]).isRequired,
    "bla": _FooBla,
});
_TopLevel = PropTypes.shape({
    "": _Empty,
    "!": PropTypes.oneOfType([Integer]).isRequired,
    "Empty": _EmptyClass,
    "ThisIsA\ud83d\ude1cTough\"\n\nOne": _ThisIsAToughOne,
    "bla": _TopLevelBla,
    "foo": _Foo,
});

export const TopLevel = _TopLevel;
