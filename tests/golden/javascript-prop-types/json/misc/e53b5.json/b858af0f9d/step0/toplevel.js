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

let _TopLevelElement;
let _Country;
let _PurpleTopLevel;
const _ID = PropTypes.oneOf(['IN', 'SP.POP.TOTL']);
const _Value = PropTypes.oneOf(['India', 'Population, total']);
_Country = PropTypes.shape({
    "id": _ID,
    "value": _Value,
});
_TopLevelElement = PropTypes.shape({
    "country": _Country,
    "date": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "decimal": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "indicator": _Country,
    "value": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_PurpleTopLevel = PropTypes.shape({
    "page": PropTypes.oneOfType([Integer]).isRequired,
    "pages": PropTypes.oneOfType([Integer]).isRequired,
    "per_page": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "total": PropTypes.oneOfType([Integer]).isRequired,
});

export const TopLevel = PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.arrayOf(_TopLevelElement), _PurpleTopLevel])]).isRequired);
