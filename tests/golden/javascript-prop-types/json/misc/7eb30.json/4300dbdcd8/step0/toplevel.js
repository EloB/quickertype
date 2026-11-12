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
let _Group;
const _Code = PropTypes.oneOf(['sf']);
const _English = PropTypes.oneOf(['SF']);
const _Thai = PropTypes.oneOf(['เอสเอฟ']);
const _Location = PropTypes.oneOf(['', '5th Fl. Emporium']);
const _Tel = PropTypes.oneOf(['', '02-268-8899']);
_Group = PropTypes.shape({
    "code": _Code,
    "english": _English,
    "thai": _Thai,
    "website": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Result = PropTypes.shape({
    "code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "english": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "fav": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "group": _Group,
    "location": _Location,
    "min_screens": PropTypes.oneOfType([Integer]).isRequired,
    "num_views": PropTypes.oneOfType([Integer]).isRequired,
    "showtimes": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "stars": PropTypes.oneOfType([Integer]).isRequired,
    "tel": _Tel,
    "thai": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "today_screens": PropTypes.oneOfType([Integer]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "website": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "count": PropTypes.oneOfType([Integer]).isRequired,
    "next": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "previous": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "results": PropTypes.oneOfType([PropTypes.arrayOf(_Result)]).isRequired,
});

export const TopLevel = _TopLevel;
