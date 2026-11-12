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
let _File;
const _Language = PropTypes.oneOf(['Markdown']);
const _Type = PropTypes.oneOf(['text/plain']);
_File = PropTypes.shape({
    "filename": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "language": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_Language, PropTypes.oneOf([null])])])(props, name, ...args),
    "raw_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "size": PropTypes.oneOfType([Integer]).isRequired,
    "type": _Type,
});
_TopLevel = PropTypes.shape({
    "comments": PropTypes.oneOfType([Integer]).isRequired,
    "comments_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "commits_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "created_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "description": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "files": PropTypes.oneOfType([PropTypes.objectOf(_File)]).isRequired,
    "forks_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "git_pull_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "git_push_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "html_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "public": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "truncated": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "updated_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "user": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
