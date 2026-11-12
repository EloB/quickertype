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
let _CRS;
let _CRSProperties;
let _Feature;
let _Geometry;
let _FeatureProperties;
const _GeometryType = PropTypes.oneOf(['Point']);
const _GeometryName = PropTypes.oneOf(['geom']);
const _FireBanR = PropTypes.oneOf(['North Central', 'Central', 'South West', 'Wimmera', 'Northern Country', 'East Gippsland', 'North East', 'Mallee', 'West &South Gippsland', 'Ballarat']);
const _Region = PropTypes.oneOf(['Eastern', 'Northern Metro', 'Western', 'Southern Metro']);
const _PropertiesType = PropTypes.oneOf(['STREET', 'AVENUE', 'ROAD', 'HIGHWAY', 'BOULEVARD', 'COURT', 'WAY', 'DRIVE', 'SOUTH', 'HILL', 'LANE', 'CLOSE', 'PARADE', 'Road', 'PLACE', 'RD']);
const _FeatureType = PropTypes.oneOf(['Feature']);
_CRSProperties = PropTypes.shape({
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_CRS = PropTypes.shape({
    "properties": _CRSProperties,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Geometry = PropTypes.shape({
    "coordinates": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "type": _GeometryType,
});
_FeatureProperties = PropTypes.shape({
    "division": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "fax": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "fire_ban_r": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_FireBanR, PropTypes.oneOf([null])])])(props, name, ...args),
    "latitude": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "local_govt": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "longitude": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "no": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "phone": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "postcode": PropTypes.oneOfType([Integer]).isRequired,
    "psa": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "region": _Region,
    "station": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "street": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "suburb": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_PropertiesType, PropTypes.oneOf([null])])])(props, name, ...args),
});
_Feature = PropTypes.shape({
    "geometry": _Geometry,
    "geometry_name": _GeometryName,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "properties": _FeatureProperties,
    "type": _FeatureType,
});
_TopLevel = PropTypes.shape({
    "crs": _CRS,
    "features": PropTypes.oneOfType([PropTypes.arrayOf(_Feature)]).isRequired,
    "totalFeatures": PropTypes.oneOfType([Integer]).isRequired,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
