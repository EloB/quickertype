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
const _UnionWithEnumEnum = PropTypes.oneOf(['foo']);
_TopLevel = PropTypes.shape({
    "arrNullable": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.oneOf([null]), (props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")])), PropTypes.oneOf([null])]),
    "arrOne": PropTypes.oneOfType([PropTypes.arrayOf((props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")), PropTypes.oneOf([null])]),
    "nullable": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), (props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")])])(props, name, ...args),
    "one": PropTypes.oneOfType([(props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")]).isRequired,
    "optional": PropTypes.oneOfType([PropTypes.oneOf([null]), (props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")]),
    "unionWithEnum": PropTypes.oneOfType([PropTypes.oneOfType([_UnionWithEnumEnum, (props, name) => props[name] == null || /^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(props[name]) ? null : new Error("Expected UUID")])]).isRequired,
});

export const TopLevel = _TopLevel;
