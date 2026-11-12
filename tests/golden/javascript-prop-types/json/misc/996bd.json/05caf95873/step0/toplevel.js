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
let _Text;
const _Scheme = PropTypes.oneOf(['DEP5', 'SPDX', 'Trove']);
const _Keyword = PropTypes.oneOf(['osi-approved', 'popular', 'copyleft', 'international']);
const _MediaType = PropTypes.oneOf(['text/plain', 'text/html']);
const _Title = PropTypes.oneOf(['Plain Text', 'HTML']);
_Identifier = PropTypes.shape({
    "identifier": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "scheme": _Scheme,
});
_Link = PropTypes.shape({
    "note": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Text = PropTypes.shape({
    "media_type": _MediaType,
    "title": _Title,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "identifiers": PropTypes.oneOfType([PropTypes.arrayOf(_Identifier)]).isRequired,
    "keywords": PropTypes.oneOfType([PropTypes.arrayOf(_Keyword)]).isRequired,
    "links": PropTypes.oneOfType([PropTypes.arrayOf(_Link)]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "other_names": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
    "superseded_by": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "text": PropTypes.oneOfType([PropTypes.arrayOf(_Text)]).isRequired,
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
