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
let _Rate;
let _Period;
let _Rates;
const _EffectiveFromEnum = PropTypes.oneOf(['0000-01-01']);
_Rates = PropTypes.shape({
    "parking": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "reduced": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "reduced1": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "reduced2": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "standard": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "super_reduced": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_Period = PropTypes.shape({
    "effective_from": PropTypes.oneOfType([PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time"), _EffectiveFromEnum])]).isRequired,
    "rates": _Rates,
});
_Rate = PropTypes.shape({
    "code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "country_code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "periods": PropTypes.oneOfType([PropTypes.arrayOf(_Period)]).isRequired,
});
_TopLevel = PropTypes.shape({
    "details": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "rates": PropTypes.oneOfType([PropTypes.arrayOf(_Rate)]).isRequired,
    "version": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
});

export const TopLevel = _TopLevel;
