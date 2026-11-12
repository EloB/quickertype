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
let _Intersection;
_Intersection = PropTypes.shape({
    "foo": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "bar": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_TopLevel = PropTypes.shape({
    "intersection": PropTypes.oneOfType([_Intersection, PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
