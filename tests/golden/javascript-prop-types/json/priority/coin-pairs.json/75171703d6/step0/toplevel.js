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
let _Pair;
_Pair = PropTypes.shape({
    "decimal_places": PropTypes.oneOfType([Integer]).isRequired,
    "fee": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "hidden": PropTypes.oneOfType([Integer]).isRequired,
    "max_amount": PropTypes.oneOfType([Integer]).isRequired,
    "max_price": PropTypes.oneOfType([Integer]).isRequired,
    "min_amount": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "min_price": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "min_total": PropTypes.oneOfType([PropTypes.number]).isRequired,
});
_TopLevel = PropTypes.shape({
    "pairs": PropTypes.oneOfType([PropTypes.objectOf(_Pair)]).isRequired,
    "server_time": PropTypes.oneOfType([Integer]).isRequired,
});

export const TopLevel = _TopLevel;
