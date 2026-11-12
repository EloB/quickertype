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
let _Feature;
let _Geometry;
let _Properties;
let _Metadata;
const _GeometryType = PropTypes.oneOf(['Point']);
const _MagType = PropTypes.oneOf(['md', 'ml', 'mb']);
const _Status = PropTypes.oneOf(['automatic', 'reviewed']);
const _PropertiesType = PropTypes.oneOf(['earthquake']);
const _FeatureType = PropTypes.oneOf(['Feature']);
_Geometry = PropTypes.shape({
    "coordinates": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "type": _GeometryType,
});
_Properties = PropTypes.shape({
    "alert": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "cdi": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "detail": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "dmin": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])])])(props, name, ...args),
    "felt": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "gap": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "ids": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "mag": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "magType": _MagType,
    "mmi": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "net": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "nst": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "place": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "rms": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "sig": PropTypes.oneOfType([Integer]).isRequired,
    "sources": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "status": _Status,
    "time": PropTypes.oneOfType([Integer]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "tsunami": PropTypes.oneOfType([Integer]).isRequired,
    "type": _PropertiesType,
    "types": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "tz": PropTypes.oneOfType([Integer]).isRequired,
    "updated": PropTypes.oneOfType([Integer]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Feature = PropTypes.shape({
    "geometry": _Geometry,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "properties": _Properties,
    "type": _FeatureType,
});
_Metadata = PropTypes.shape({
    "api": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "count": PropTypes.oneOfType([Integer]).isRequired,
    "generated": PropTypes.oneOfType([Integer]).isRequired,
    "status": PropTypes.oneOfType([Integer]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "bbox": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "features": PropTypes.oneOfType([PropTypes.arrayOf(_Feature)]).isRequired,
    "metadata": _Metadata,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
