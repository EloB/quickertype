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
let _Geolocation;
const _Fall = PropTypes.oneOf(['Fell', 'Found']);
const _Type = PropTypes.oneOf(['Point']);
const _Nametype = PropTypes.oneOf(['Valid']);
_Geolocation = PropTypes.shape({
    "coordinates": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "type": _Type,
});
_TopLevel = PropTypes.shape({
    ":@computed_region_cbhk_fwbd": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    ":@computed_region_nnqa_25f4": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "fall": _Fall,
    "geolocation": PropTypes.oneOfType([_Geolocation, PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "mass": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "nametype": _Nametype,
    "recclass": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "reclat": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "reclong": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "year": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time"), PropTypes.oneOf([null])]),
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
