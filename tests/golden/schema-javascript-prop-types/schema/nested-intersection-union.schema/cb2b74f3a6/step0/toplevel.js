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
let _Item;
_Item = PropTypes.shape({
    "content": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "id": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "output": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "summary": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_TopLevel = PropTypes.shape({
    "input": PropTypes.oneOfType([PropTypes.arrayOf(_Item)]).isRequired,
});

export const TopLevel = _TopLevel;
