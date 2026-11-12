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
_TopLevel = PropTypes.shape({
    "children_data": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _TopLevel(...args))]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "is_active": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "level": PropTypes.oneOfType([Integer]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "parent_id": PropTypes.oneOfType([Integer]).isRequired,
    "position": PropTypes.oneOfType([Integer]).isRequired,
    "product_count": PropTypes.oneOfType([Integer]).isRequired,
});

export const TopLevel = _TopLevel;
