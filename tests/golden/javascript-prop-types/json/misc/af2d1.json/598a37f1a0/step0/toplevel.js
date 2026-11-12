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
const _GeometryType = PropTypes.oneOf(['MultiPolygon']);
const _GeometryName = PropTypes.oneOf(['geom']);
const _AddImprov = PropTypes.oneOf(['f', 'F', 't']);
const _FundingBa = PropTypes.oneOf(['Non GCCC', 'Capex', 'Initial', 'Contribute']);
const _LevelAccu = PropTypes.oneOf(['GPS Corrected 1.0M', 'APPROX', 'GPS COrrected 1.0M']);
const _Material = PropTypes.oneOf(['Gravel', 'Concrete', 'Bitumen', 'Interlock Conc Block', 'Other', 'Earth']);
const _MiSymbolo = PropTypes.oneOf(['Pen (2, 2, 65535) Brush (1, 0, 16777215)']);
const _Status = PropTypes.oneOf(['CURRENT']);
const _PropertiesType = PropTypes.oneOf(['Boat Ramp']);
const _FeatureType = PropTypes.oneOf(['Feature']);
_CRSProperties = PropTypes.shape({
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_CRS = PropTypes.shape({
    "properties": _CRSProperties,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Geometry = PropTypes.shape({
    "coordinates": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.number))))]).isRequired,
    "type": _GeometryType,
});
_FeatureProperties = PropTypes.shape({
    "add_improv": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_AddImprov, PropTypes.oneOf([null])])])(props, name, ...args),
    "area_": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "asset_numb": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "comments": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "condition": PropTypes.oneOfType([Integer]).isRequired,
    "constructi": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "createdate": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "createuser": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "disposal_d": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "documents": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "drawing_nu": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "file_numbe": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "folder_num": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "funding_ba": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_FundingBa, PropTypes.oneOf([null])])])(props, name, ...args),
    "historic_c": PropTypes.oneOfType([Integer]).isRequired,
    "inspection": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "inspectors": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "last_updat": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "level_accu": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_LevelAccu, PropTypes.oneOf([null])])])(props, name, ...args),
    "material": _Material,
    "mi_prinx": PropTypes.oneOfType([Integer]).isRequired,
    "mi_symbolo": _MiSymbolo,
    "number_lan": PropTypes.oneOfType([Integer]).isRequired,
    "owner": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "positional": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_LevelAccu, PropTypes.oneOf([null])])])(props, name, ...args),
    "project_nu": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "rec_id": PropTypes.oneOfType([Integer]).isRequired,
    "record_cre": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "shape_area": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "shape_leng": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "status": _Status,
    "survey_num": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "toe_rl": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "top_rl": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "type": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_PropertiesType, PropTypes.oneOf([null])])])(props, name, ...args),
    "update_dat": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "updatedate": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "updateuser": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
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
