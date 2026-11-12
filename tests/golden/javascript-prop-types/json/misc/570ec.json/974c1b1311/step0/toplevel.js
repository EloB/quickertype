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
let _Identifier;
let _Link;
let _OtherName;
let _Text;
const _Scheme = PropTypes.oneOf(['DEP5', 'SPDX', 'Trove']);
_Identifier = PropTypes.shape({
    "identifier": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "scheme": _Scheme,
});
_Link = PropTypes.shape({
    "note": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_OtherName = PropTypes.shape({
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "note": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
});
_Text = PropTypes.shape({
    "media_type": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "identifiers": PropTypes.oneOfType([PropTypes.arrayOf(_Identifier)]).isRequired,
    "keywords": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "links": PropTypes.oneOfType([PropTypes.arrayOf(_Link)]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "other_names": PropTypes.oneOfType([PropTypes.arrayOf(_OtherName)]).isRequired,
    "superseded_by": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "text": PropTypes.oneOfType([PropTypes.arrayOf(_Text)]).isRequired,
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
