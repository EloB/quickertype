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
let _Fruit;
let _Berry;
let _Color;
let _Shape;
let _Geometry;
let _CircularShape;
let _RectShape;
let _Part;
let _History;
let _Vehicle;
let _Speed;
let _Limit;
let _VehicleType;
const _Axis = PropTypes.oneOf(['X', 'Y', 'Z', 'XY', 'YZ', 'ZX']);
const _Name = PropTypes.oneOf(['truck', 'bus', 'car', 'van', 'train', 'Bike', 'Aeroplane', 'Jeep', 'Trolley']);
_Color = PropTypes.shape({
    "rgb": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_CircularShape = PropTypes.shape({
    "shapeName": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_Part = PropTypes.shape({
    "depth": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "length": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "width": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_RectShape = PropTypes.shape({
    "parts": PropTypes.oneOfType([PropTypes.arrayOf(_Part), PropTypes.oneOf([null])]),
});
_Geometry = PropTypes.shape({
    "rectShape": PropTypes.oneOfType([_RectShape, PropTypes.oneOf([null])]),
    "circularShape": PropTypes.oneOfType([PropTypes.arrayOf(_CircularShape), PropTypes.oneOf([null])]),
});
_History = PropTypes.shape({
    "class": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_Shape = PropTypes.shape({
    "geometry": PropTypes.oneOfType([_Geometry, PropTypes.oneOf([null])]),
    "history": PropTypes.oneOfType([_History, PropTypes.oneOf([null])]),
});
_Berry = PropTypes.shape({
    "color": PropTypes.oneOfType([_Color, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.oneOf([null]), (props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 1) ? null : new Error("Expected bounded string"); }]),
    "shapes": PropTypes.oneOfType([PropTypes.arrayOf(_Shape), PropTypes.oneOf([null])]),
});
_Fruit = PropTypes.shape({
    "apple": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "berries": PropTypes.oneOfType([PropTypes.arrayOf(_Berry), PropTypes.oneOf([null])]),
    "orange": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
});
_Limit = PropTypes.shape({
    "maximum": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "minimum": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_Speed = PropTypes.shape({
    "velocity": PropTypes.oneOfType([_Limit, PropTypes.oneOf([null])]),
});
_VehicleType = PropTypes.shape({
    "name": PropTypes.oneOfType([_Name, PropTypes.oneOf([null])]),
    "width": PropTypes.oneOfType([_Axis, PropTypes.oneOf([null])]),
    "length": PropTypes.oneOfType([_Axis, PropTypes.oneOf([null])]),
});
_Vehicle = PropTypes.shape({
    "brand": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "id": PropTypes.oneOfType([PropTypes.oneOf([null]), (props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && [...value].length >= 1) ? null : new Error("Expected bounded string"); }]),
    "speed": PropTypes.oneOfType([_Speed, PropTypes.oneOf([null])]),
    "subModule": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_VehicleType, PropTypes.oneOf([null])]),
    "year": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_TopLevel = PropTypes.shape({
    "version": PropTypes.oneOfType([PropTypes.oneOf([null]), (props, name) => { const value = props[name]; return value == null || (typeof value === 'string' && new RegExp("^\\d{1,5}.{1}\\d{1,5}.{1}\\d{1,5}$").test(value)) ? null : new Error("Expected bounded string"); }]),
    "fruits": PropTypes.oneOfType([PropTypes.arrayOf(_Fruit), PropTypes.oneOf([null])]),
    "vehicles": PropTypes.oneOfType([PropTypes.arrayOf(_Vehicle), PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
