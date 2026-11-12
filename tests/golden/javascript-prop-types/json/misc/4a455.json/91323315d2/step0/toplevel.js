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
const _GeometryType = PropTypes.oneOf(['MultiPoint']);
const _GeometryName = PropTypes.oneOf(['geom']);
const _FeatureType = PropTypes.oneOf(['Feature']);
_CRSProperties = PropTypes.shape({
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_CRS = PropTypes.shape({
    "properties": _CRSProperties,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Geometry = PropTypes.shape({
    "coordinates": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.number))]).isRequired,
    "type": _GeometryType,
});
_FeatureProperties = PropTypes.shape({
    "facebookaccount": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "frequencyfinderurl": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "siteurl": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "streetaddress": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "twitteraccount": PropTypes.oneOfType([PropTypes.string]).isRequired,
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
