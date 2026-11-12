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
let _TopLevelChild;
let _PurpleChild;
let _FluffyChild;
let _TentacledChild;
let _PurpleComment;
let _PurpleFlags;
let _PurpleSignature;
let _GetSignatureFlags;
let _GetSignatureType;
let _IndexSignatureElement;
let _PurpleType;
let _GetSignatureChild;
let _GetSignature;
let _ElementType;
let _FluffyComment;
let _FluffyFlags;
let _Source;
let _GetSignatureComment;
let _Group;
let _GetSignatureParameter;
let _TentacledComment;
let _TentacledFlags;
let _FluffyType;
let _TentacledType;
let _PurpleDeclaration;
let _TypeElement;
let _StickyComment;
let _Tag;
let _StickyFlags;
let _ExtendedBy;
let _FluffySignature;
let _IndigoFlags;
let _PurpleParameter;
let _StickyType;
let _IndigoType;
let _FluffyDeclaration;
let _StickyChild;
let _IndecentType;
let _IndexSignature;
let _HilariousType;
let _TentacledSignature;
let _IndigoComment;
let _FluffyParameter;
let _PurpleTypeArgument;
let _IndecentFlags;
let _StickySignature;
let _TentacledParameter;
let _AmbitiousType;
let _TentacledDeclaration;
let _IndigoChild;
let _CunningType;
let _MagentaType;
let _StickyDeclaration;
let _IndecentChild;
let _FriskyType;
let _IndigoDeclaration;
let _FluffyTypeArgument;
let _TypeParameter;
let _MischievousType;
let _IndecentComment;
const _PurpleKindString = PropTypes.oneOf(['Variable', 'Function', 'Property', 'Method', 'Constructor', 'Accessor', 'Enumeration member', 'Module', 'Object literal']);
const _SignatureKindString = PropTypes.oneOf(['Call signature', 'Constructor signature']);
const _Name = PropTypes.oneOf(['string', 'number', 'void', 'T', 'boolean', 'BaseClass', 'any', 'Array', 'MyNumber']);
const _TypeEnum = PropTypes.oneOf(['intrinsic', 'reflection', 'array', 'reference', 'typeParameter', 'tuple', 'union', 'stringLiteral']);
const _FileName = PropTypes.oneOf(['modules.ts', 'classes.ts', 'flattened.ts', 'access.ts', 'default-export.ts', 'enumerations.ts', 'functions.ts', 'generics.ts', 'single-export.ts', 'typescript-1.3.ts', 'typescript-1.4.ts', 'typescript-1.5.ts', 'variables.ts']);
const _ParameterKindString = PropTypes.oneOf(['Parameter']);
const _FluffyKindString = PropTypes.oneOf(['Module', 'Class', 'Variable', 'Function', 'Interface', 'Enumeration', 'Object literal', 'Type alias']);
const _TentacledKindString = PropTypes.oneOf(['External module']);
_PurpleComment = PropTypes.shape({
    "shortText": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_PurpleFlags = PropTypes.shape({
    "isExported": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
});
_GetSignatureFlags = PropTypes.shape({
});
_PurpleType = PropTypes.shape({
    "declaration": PropTypes.oneOfType([(...args) => _GetSignature(...args), PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([_Name, PropTypes.oneOf([null])]),
    "type": _TypeEnum,
});
_IndexSignatureElement = PropTypes.shape({
    "flags": _GetSignatureFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "parameters": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _GetSignature(...args)), PropTypes.oneOf([null])]),
    "type": _PurpleType,
});
_ElementType = PropTypes.shape({
    "name": _Name,
    "type": _TypeEnum,
});
_GetSignatureType = PropTypes.shape({
    "declaration": PropTypes.oneOfType([(...args) => _GetSignature(...args), PropTypes.oneOf([null])]),
    "elementType": PropTypes.oneOfType([_ElementType, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([_Name, PropTypes.oneOf([null])]),
    "type": _TypeEnum,
});
_FluffyComment = PropTypes.shape({
    "text": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_FluffyFlags = PropTypes.shape({
    "isOptional": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
});
_Source = PropTypes.shape({
    "character": PropTypes.oneOfType([Integer]).isRequired,
    "fileName": _FileName,
    "line": PropTypes.oneOfType([Integer]).isRequired,
});
_GetSignatureChild = PropTypes.shape({
    "comment": PropTypes.oneOfType([_FluffyComment, PropTypes.oneOf([null])]),
    "flags": _FluffyFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _PurpleKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
    "type": _PurpleType,
});
_GetSignatureComment = PropTypes.shape({
    "returns": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "shortText": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "text": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_Group = PropTypes.shape({
    "children": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TentacledComment = PropTypes.shape({
    "shortText": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "text": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_TentacledFlags = PropTypes.shape({
    "isOptional": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isRest": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
});
_FluffyType = PropTypes.shape({
    "elementType": PropTypes.oneOfType([_ElementType, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([_Name, PropTypes.oneOf([null])]),
    "type": _TypeEnum,
    "typeArguments": PropTypes.oneOfType([PropTypes.arrayOf(_ElementType), PropTypes.oneOf([null])]),
});
_GetSignatureParameter = PropTypes.shape({
    "comment": PropTypes.oneOfType([_TentacledComment, PropTypes.oneOf([null])]),
    "flags": _TentacledFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _ParameterKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": _FluffyType,
});
_GetSignature = PropTypes.shape({
    "children": PropTypes.oneOfType([PropTypes.arrayOf(_GetSignatureChild), PropTypes.oneOf([null])]),
    "comment": PropTypes.oneOfType([_GetSignatureComment, PropTypes.oneOf([null])]),
    "defaultValue": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "flags": _GetSignatureFlags,
    "groups": PropTypes.oneOfType([PropTypes.arrayOf(_Group), PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "parameters": PropTypes.oneOfType([PropTypes.arrayOf(_GetSignatureParameter), PropTypes.oneOf([null])]),
    "signatures": PropTypes.oneOfType([PropTypes.arrayOf(_IndexSignatureElement), PropTypes.oneOf([null])]),
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source), PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_GetSignatureType, PropTypes.oneOf([null])]),
    "typeParameter": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _GetSignature(...args)), PropTypes.oneOf([null])]),
});
_PurpleDeclaration = PropTypes.shape({
    "children": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _GetSignature(...args))]).isRequired,
    "flags": _GetSignatureFlags,
    "groups": PropTypes.oneOfType([PropTypes.arrayOf(_Group)]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TentacledType = PropTypes.shape({
    "declaration": PropTypes.oneOfType([_PurpleDeclaration, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([_Name, PropTypes.oneOf([null])]),
    "type": _TypeEnum,
});
_PurpleSignature = PropTypes.shape({
    "comment": PropTypes.oneOfType([_PurpleComment, PropTypes.oneOf([null])]),
    "flags": _GetSignatureFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _SignatureKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "parameters": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _GetSignature(...args))]).isRequired,
    "type": _TentacledType,
});
_TypeElement = PropTypes.shape({
    "declaration": PropTypes.oneOfType([(...args) => _GetSignature(...args), PropTypes.oneOf([null])]),
    "elementType": PropTypes.oneOfType([_ElementType, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([_Name, PropTypes.oneOf([null])]),
    "type": _TypeEnum,
    "typeArguments": PropTypes.oneOfType([PropTypes.arrayOf(_ElementType), PropTypes.oneOf([null])]),
});
_TentacledChild = PropTypes.shape({
    "comment": PropTypes.oneOfType([_PurpleComment, PropTypes.oneOf([null])]),
    "defaultValue": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "flags": _PurpleFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _PurpleKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "signatures": PropTypes.oneOfType([PropTypes.arrayOf(_PurpleSignature), PropTypes.oneOf([null])]),
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
    "type": PropTypes.oneOfType([_TypeElement, PropTypes.oneOf([null])]),
});
_Tag = PropTypes.shape({
    "tag": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "text": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_StickyComment = PropTypes.shape({
    "returns": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "shortText": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "tags": PropTypes.oneOfType([PropTypes.arrayOf(_Tag), PropTypes.oneOf([null])]),
    "text": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_StickyFlags = PropTypes.shape({
    "isAbstract": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isConstructorProperty": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isExported": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isPrivate": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isProtected": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isPublic": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isStatic": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
});
_ExtendedBy = PropTypes.shape({
    "constraint": PropTypes.oneOfType([(...args) => _ExtendedBy(...args), PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": _TypeEnum,
    "typeArguments": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _ExtendedBy(...args)), PropTypes.oneOf([null])]),
});
_IndigoFlags = PropTypes.shape({
    "isPrivate": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isProtected": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
});
_StickyType = PropTypes.shape({
    "constraint": PropTypes.oneOfType([(...args) => _ExtendedBy(...args), PropTypes.oneOf([null])]),
    "declaration": PropTypes.oneOfType([(...args) => _GetSignature(...args), PropTypes.oneOf([null])]),
    "elementType": PropTypes.oneOfType([_ElementType, PropTypes.oneOf([null])]),
    "elements": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _ExtendedBy(...args)), PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "type": _TypeEnum,
    "typeArguments": PropTypes.oneOfType([PropTypes.arrayOf(_ElementType), PropTypes.oneOf([null])]),
});
_PurpleParameter = PropTypes.shape({
    "comment": PropTypes.oneOfType([_TentacledComment, PropTypes.oneOf([null])]),
    "flags": _GetSignatureFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _ParameterKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": _StickyType,
});
_FluffySignature = PropTypes.shape({
    "comment": PropTypes.oneOfType([_StickyComment, PropTypes.oneOf([null])]),
    "flags": _IndigoFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "implementationOf": PropTypes.oneOfType([(...args) => _ExtendedBy(...args), PropTypes.oneOf([null])]),
    "inheritedFrom": PropTypes.oneOfType([(...args) => _ExtendedBy(...args), PropTypes.oneOf([null])]),
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _SignatureKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "overwrites": PropTypes.oneOfType([(...args) => _ExtendedBy(...args), PropTypes.oneOf([null])]),
    "parameters": PropTypes.oneOfType([PropTypes.arrayOf(_PurpleParameter), PropTypes.oneOf([null])]),
    "type": (...args) => _ExtendedBy(...args),
    "typeParameter": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _GetSignature(...args)), PropTypes.oneOf([null])]),
});
_IndecentType = PropTypes.shape({
    "declaration": PropTypes.oneOfType([(...args) => _GetSignature(...args), PropTypes.oneOf([null])]),
    "elements": PropTypes.oneOfType([PropTypes.arrayOf(_ElementType), PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([_Name, PropTypes.oneOf([null])]),
    "type": _TypeEnum,
});
_StickyChild = PropTypes.shape({
    "comment": PropTypes.oneOfType([_FluffyComment, PropTypes.oneOf([null])]),
    "flags": _FluffyFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _PurpleKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
    "type": _IndecentType,
});
_HilariousType = PropTypes.shape({
    "declaration": (...args) => _GetSignature(...args),
    "type": _TypeEnum,
});
_IndexSignature = PropTypes.shape({
    "flags": _GetSignatureFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "parameters": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _GetSignature(...args))]).isRequired,
    "type": _HilariousType,
});
_IndigoComment = PropTypes.shape({
    "returns": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "shortText": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_FluffyParameter = PropTypes.shape({
    "comment": PropTypes.oneOfType([_FluffyComment, PropTypes.oneOf([null])]),
    "flags": _FluffyFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source), PropTypes.oneOf([null])]),
    "type": _ElementType,
});
_TentacledSignature = PropTypes.shape({
    "comment": PropTypes.oneOfType([_IndigoComment, PropTypes.oneOf([null])]),
    "flags": _GetSignatureFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _SignatureKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "parameters": PropTypes.oneOfType([PropTypes.arrayOf(_FluffyParameter), PropTypes.oneOf([null])]),
    "type": (...args) => _ExtendedBy(...args),
});
_FluffyDeclaration = PropTypes.shape({
    "children": PropTypes.oneOfType([PropTypes.arrayOf(_StickyChild), PropTypes.oneOf([null])]),
    "flags": _GetSignatureFlags,
    "groups": PropTypes.oneOfType([PropTypes.arrayOf(_Group), PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "indexSignature": PropTypes.oneOfType([_IndexSignature, PropTypes.oneOf([null])]),
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "signatures": PropTypes.oneOfType([PropTypes.arrayOf(_TentacledSignature), PropTypes.oneOf([null])]),
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
});
_PurpleTypeArgument = PropTypes.shape({
    "operator": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "target": _ElementType,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_IndigoType = PropTypes.shape({
    "constraint": PropTypes.oneOfType([(...args) => _ExtendedBy(...args), PropTypes.oneOf([null])]),
    "declaration": PropTypes.oneOfType([_FluffyDeclaration, PropTypes.oneOf([null])]),
    "elementType": PropTypes.oneOfType([(...args) => _ExtendedBy(...args), PropTypes.oneOf([null])]),
    "elements": PropTypes.oneOfType([PropTypes.arrayOf(_ElementType), PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "type": _TypeEnum,
    "typeArguments": PropTypes.oneOfType([PropTypes.arrayOf(_PurpleTypeArgument), PropTypes.oneOf([null])]),
    "types": PropTypes.oneOfType([PropTypes.arrayOf(_TypeElement), PropTypes.oneOf([null])]),
});
_FluffyChild = PropTypes.shape({
    "children": PropTypes.oneOfType([PropTypes.arrayOf(_TentacledChild), PropTypes.oneOf([null])]),
    "comment": PropTypes.oneOfType([_StickyComment, PropTypes.oneOf([null])]),
    "defaultValue": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "flags": _StickyFlags,
    "getSignature": PropTypes.oneOfType([(...args) => _GetSignature(...args), PropTypes.oneOf([null])]),
    "groups": PropTypes.oneOfType([PropTypes.arrayOf(_Group), PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "implementationOf": PropTypes.oneOfType([(...args) => _ExtendedBy(...args), PropTypes.oneOf([null])]),
    "inheritedFrom": PropTypes.oneOfType([(...args) => _ExtendedBy(...args), PropTypes.oneOf([null])]),
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _PurpleKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "overwrites": PropTypes.oneOfType([(...args) => _ExtendedBy(...args), PropTypes.oneOf([null])]),
    "setSignature": PropTypes.oneOfType([(...args) => _GetSignature(...args), PropTypes.oneOf([null])]),
    "signatures": PropTypes.oneOfType([PropTypes.arrayOf(_FluffySignature), PropTypes.oneOf([null])]),
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
    "type": PropTypes.oneOfType([_IndigoType, PropTypes.oneOf([null])]),
});
_IndecentFlags = PropTypes.shape({
    "hasExportAssignment": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isAbstract": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isConst": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isExported": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isLet": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isPrivate": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "isProtected": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
});
_IndigoChild = PropTypes.shape({
    "comment": _FluffyComment,
    "defaultValue": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "flags": _FluffyFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _PurpleKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
    "type": _IndecentType,
});
_TentacledDeclaration = PropTypes.shape({
    "children": PropTypes.oneOfType([PropTypes.arrayOf(_IndigoChild), PropTypes.oneOf([null])]),
    "flags": _GetSignatureFlags,
    "groups": PropTypes.oneOfType([PropTypes.arrayOf(_Group), PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "indexSignature": PropTypes.oneOfType([_IndexSignatureElement, PropTypes.oneOf([null])]),
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "signatures": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _GetSignature(...args)), PropTypes.oneOf([null])]),
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
});
_AmbitiousType = PropTypes.shape({
    "declaration": PropTypes.oneOfType([_TentacledDeclaration, PropTypes.oneOf([null])]),
    "elementType": PropTypes.oneOfType([_ElementType, PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "type": _TypeEnum,
    "typeArguments": PropTypes.oneOfType([PropTypes.arrayOf(_ElementType), PropTypes.oneOf([null])]),
});
_TentacledParameter = PropTypes.shape({
    "comment": PropTypes.oneOfType([_TentacledComment, PropTypes.oneOf([null])]),
    "defaultValue": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "flags": _TentacledFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _ParameterKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "originalName": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "type": _AmbitiousType,
});
_CunningType = PropTypes.shape({
    "declaration": PropTypes.oneOfType([_PurpleDeclaration, PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([_Name, PropTypes.oneOf([null])]),
    "type": _TypeEnum,
    "typeArguments": PropTypes.oneOfType([PropTypes.arrayOf(_ElementType), PropTypes.oneOf([null])]),
});
_StickySignature = PropTypes.shape({
    "comment": _StickyComment,
    "flags": _IndigoFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _SignatureKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "parameters": PropTypes.oneOfType([PropTypes.arrayOf(_TentacledParameter), PropTypes.oneOf([null])]),
    "type": _CunningType,
    "typeParameter": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _GetSignature(...args)), PropTypes.oneOf([null])]),
});
_IndigoDeclaration = PropTypes.shape({
    "children": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _GetSignature(...args)), PropTypes.oneOf([null])]),
    "flags": _GetSignatureFlags,
    "groups": PropTypes.oneOfType([PropTypes.arrayOf(_Group), PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "signatures": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _GetSignature(...args)), PropTypes.oneOf([null])]),
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
});
_FriskyType = PropTypes.shape({
    "declaration": PropTypes.oneOfType([_IndigoDeclaration, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([_Name, PropTypes.oneOf([null])]),
    "type": _TypeEnum,
});
_IndecentChild = PropTypes.shape({
    "flags": _FluffyFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _PurpleKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
    "type": _FriskyType,
});
_StickyDeclaration = PropTypes.shape({
    "children": PropTypes.oneOfType([PropTypes.arrayOf(_IndecentChild), PropTypes.oneOf([null])]),
    "flags": _GetSignatureFlags,
    "groups": PropTypes.oneOfType([PropTypes.arrayOf(_Group), PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "signatures": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _GetSignature(...args))]).isRequired,
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
});
_FluffyTypeArgument = PropTypes.shape({
    "type": _TypeEnum,
    "types": PropTypes.oneOfType([PropTypes.arrayOf(_ElementType)]).isRequired,
});
_MagentaType = PropTypes.shape({
    "declaration": PropTypes.oneOfType([_StickyDeclaration, PropTypes.oneOf([null])]),
    "elementType": PropTypes.oneOfType([_ElementType, PropTypes.oneOf([null])]),
    "elements": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _ExtendedBy(...args)), PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "type": _TypeEnum,
    "typeArguments": PropTypes.oneOfType([PropTypes.arrayOf(_FluffyTypeArgument), PropTypes.oneOf([null])]),
    "types": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _ExtendedBy(...args)), PropTypes.oneOf([null])]),
    "value": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_MischievousType = PropTypes.shape({
    "id": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([_Name, PropTypes.oneOf([null])]),
    "operator": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "target": PropTypes.oneOfType([_ElementType, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TypeParameter = PropTypes.shape({
    "comment": PropTypes.oneOfType([_PurpleComment, PropTypes.oneOf([null])]),
    "flags": _GetSignatureFlags,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": PropTypes.oneOfType([_MischievousType, PropTypes.oneOf([null])]),
});
_PurpleChild = PropTypes.shape({
    "children": PropTypes.oneOfType([PropTypes.arrayOf(_FluffyChild), PropTypes.oneOf([null])]),
    "comment": PropTypes.oneOfType([_StickyComment, PropTypes.oneOf([null])]),
    "defaultValue": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "extendedBy": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _ExtendedBy(...args)), PropTypes.oneOf([null])]),
    "extendedTypes": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _ExtendedBy(...args)), PropTypes.oneOf([null])]),
    "flags": _IndecentFlags,
    "groups": PropTypes.oneOfType([PropTypes.arrayOf(_Group), PropTypes.oneOf([null])]),
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "implementedBy": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _ExtendedBy(...args)), PropTypes.oneOf([null])]),
    "implementedTypes": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _ExtendedBy(...args)), PropTypes.oneOf([null])]),
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _FluffyKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "signatures": PropTypes.oneOfType([PropTypes.arrayOf(_StickySignature), PropTypes.oneOf([null])]),
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
    "type": PropTypes.oneOfType([_MagentaType, PropTypes.oneOf([null])]),
    "typeParameter": PropTypes.oneOfType([PropTypes.arrayOf(_TypeParameter), PropTypes.oneOf([null])]),
});
_IndecentComment = PropTypes.shape({
    "shortText": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "tags": PropTypes.oneOfType([PropTypes.arrayOf(_Tag), PropTypes.oneOf([null])]),
});
_TopLevelChild = PropTypes.shape({
    "children": PropTypes.oneOfType([PropTypes.arrayOf(_PurpleChild)]).isRequired,
    "comment": PropTypes.oneOfType([_IndecentComment, PropTypes.oneOf([null])]),
    "flags": _PurpleFlags,
    "groups": PropTypes.oneOfType([PropTypes.arrayOf(_Group)]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "kindString": _TentacledKindString,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "originalName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sources": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
});
_TopLevel = PropTypes.shape({
    "children": PropTypes.oneOfType([PropTypes.arrayOf(_TopLevelChild)]).isRequired,
    "flags": _GetSignatureFlags,
    "groups": PropTypes.oneOfType([PropTypes.arrayOf(_Group)]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "kind": PropTypes.oneOfType([Integer]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
