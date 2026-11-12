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
const _OrbitClass = PropTypes.oneOf(['Apollo', 'Amor', 'Aten', 'Comet', 'Jupiter-family Comet', 'Halley-type Comet*', 'Parabolic Comet', 'Jupiter-family Comet*', 'Encke-type Comet']);
const _Pha = PropTypes.oneOf(['Y', 'N', 'n/a']);
_TopLevel = PropTypes.shape({
    "designation": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "discovery_date": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "h_mag": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "i_deg": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "moid_au": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "orbit_class": _OrbitClass,
    "period_yr": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "pha": _Pha,
    "q_au_1": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "q_au_2": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
