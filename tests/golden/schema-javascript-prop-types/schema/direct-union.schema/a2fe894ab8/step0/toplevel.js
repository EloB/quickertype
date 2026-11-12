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
let _ArrayNode;
let _BooleanNode;
let _DoubleNode;
let _IntNode;
let _LongNode;
let _NullNode;
let _ObjectNode;
let _Thing;
let _TextNode;
_ArrayNode = PropTypes.shape({
});
_BooleanNode = PropTypes.shape({
});
_DoubleNode = PropTypes.shape({
});
_IntNode = PropTypes.shape({
});
_LongNode = PropTypes.shape({
});
_NullNode = PropTypes.shape({
});
_ObjectNode = PropTypes.shape({
});
_Thing = PropTypes.shape({
    "optional": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any), PropTypes.bool, PropTypes.number, Integer, PropTypes.objectOf(PropTypes.any), PropTypes.oneOf([null]), PropTypes.string]),
    "required": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any), PropTypes.bool, PropTypes.number, Integer, PropTypes.objectOf(PropTypes.any), PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
});
_TextNode = PropTypes.shape({
});
_TopLevel = PropTypes.shape({
    "arrayNode": PropTypes.oneOfType([_ArrayNode, PropTypes.oneOf([null])]),
    "booleanNode": PropTypes.oneOfType([_BooleanNode, PropTypes.oneOf([null])]),
    "doubleNode": PropTypes.oneOfType([_DoubleNode, PropTypes.oneOf([null])]),
    "intNode": PropTypes.oneOfType([_IntNode, PropTypes.oneOf([null])]),
    "longNode": PropTypes.oneOfType([_LongNode, PropTypes.oneOf([null])]),
    "nullNode": PropTypes.oneOfType([_NullNode, PropTypes.oneOf([null])]),
    "objectNode": PropTypes.oneOfType([_ObjectNode, PropTypes.oneOf([null])]),
    "stuff": PropTypes.oneOfType([PropTypes.objectOf(_Thing)]).isRequired,
    "textNode": PropTypes.oneOfType([_TextNode, PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
