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
let _Result;
let _Collection;
let _Detail;
let _FavMovie;
let _Image;
let _Video;
let _VoteScore;
const _DetailLanguage = PropTypes.oneOf(['en', 'th']);
const _Type = PropTypes.oneOf(['Poster', 'Backdrop']);
const _ResultLanguage = PropTypes.oneOf(['en', '-']);
_Collection = PropTypes.shape({
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "movies": PropTypes.oneOfType([PropTypes.arrayOf(Integer)]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "slug": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Detail = PropTypes.shape({
    "cast": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "director": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "language": _DetailLanguage,
    "storyline": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "tagline": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_FavMovie = PropTypes.shape({
    "follow": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "star": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "watched": PropTypes.oneOfType([PropTypes.bool]).isRequired,
});
_Image = PropTypes.shape({
    "favs": PropTypes.oneOfType([Integer]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "thumbnail": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": _Type,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Video = PropTypes.shape({
    "kind": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "language": _ResultLanguage,
    "source": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_VoteScore = PropTypes.shape({
    "avg": PropTypes.oneOfType([Integer]).isRequired,
    "score": PropTypes.oneOfType([Integer]).isRequired,
    "total": PropTypes.oneOfType([Integer]).isRequired,
});
_Result = PropTypes.shape({
    "active_screens": PropTypes.oneOfType([Integer]).isRequired,
    "collections": PropTypes.oneOfType([PropTypes.arrayOf(_Collection)]).isRequired,
    "details": PropTypes.oneOfType([PropTypes.arrayOf(_Detail)]).isRequired,
    "duration": PropTypes.oneOfType([Integer]).isRequired,
    "fav_movie": _FavMovie,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "images": PropTypes.oneOfType([PropTypes.arrayOf(_Image)]).isRequired,
    "language": _ResultLanguage,
    "release_date": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "stars": PropTypes.oneOfType([Integer]).isRequired,
    "tags": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any), PropTypes.oneOf([null])])])(props, name, ...args),
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "videos": PropTypes.oneOfType([PropTypes.arrayOf(_Video)]).isRequired,
    "vote_score": _VoteScore,
    "watches": PropTypes.oneOfType([Integer]).isRequired,
});
_TopLevel = PropTypes.shape({
    "count": PropTypes.oneOfType([Integer]).isRequired,
    "next": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "previous": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "results": PropTypes.oneOfType([PropTypes.arrayOf(_Result)]).isRequired,
});

export const TopLevel = _TopLevel;
