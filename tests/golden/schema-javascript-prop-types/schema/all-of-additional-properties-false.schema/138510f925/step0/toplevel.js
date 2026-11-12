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
const _Frequency = PropTypes.oneOf(['Weekly', 'Monthly', 'Annually']);
const _Type = PropTypes.oneOf(['GrossSalaryAmount', 'Overtime']);
_TopLevel = PropTypes.shape({
    "amount": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "frequency": _Frequency,
    "description": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "type": _Type,
});

export const TopLevel = _TopLevel;
