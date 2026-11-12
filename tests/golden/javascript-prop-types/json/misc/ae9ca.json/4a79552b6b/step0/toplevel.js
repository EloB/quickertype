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
let _Feature;
let _Geometry;
let _Properties;
const _GeometryType = PropTypes.oneOf(['Point']);
const _Class = PropTypes.oneOf(['No Code Allocated', 'OS-District', 'OS-Neighbourhood', 'OS-Regional']);
const _MaintainingAuthority = PropTypes.oneOf(['City of Ballarat']);
const _Ward = PropTypes.oneOf(['South', 'North', 'Central']);
const _FeatureType = PropTypes.oneOf(['Feature']);
_Geometry = PropTypes.shape({
    "coordinates": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number)]).isRequired,
    "type": _GeometryType,
});
_Properties = PropTypes.shape({
    "Area": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Central Asset ID": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Class": _Class,
    "Feature Location": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Maintaining Authority": _MaintainingAuthority,
    "Number": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Site Name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Ward": _Ward,
    "lat": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "long": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Feature = PropTypes.shape({
    "geometry": _Geometry,
    "properties": _Properties,
    "type": _FeatureType,
});
_TopLevel = PropTypes.shape({
    "features": PropTypes.oneOfType([PropTypes.arrayOf(_Feature)]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
