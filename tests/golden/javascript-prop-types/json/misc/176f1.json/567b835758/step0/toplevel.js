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
let _Results;
let _Series;
let _Datum;
let _Footnote;
_Footnote = PropTypes.shape({
    "code": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "text": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_Datum = PropTypes.shape({
    "footnotes": PropTypes.oneOfType([PropTypes.arrayOf(_Footnote)]).isRequired,
    "period": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "periodName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "value": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "year": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Series = PropTypes.shape({
    "data": PropTypes.oneOfType([PropTypes.arrayOf(_Datum)]).isRequired,
    "seriesID": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Results = PropTypes.shape({
    "series": PropTypes.oneOfType([PropTypes.arrayOf(_Series)]).isRequired,
});
_TopLevel = PropTypes.shape({
    "Results": _Results,
    "message": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
    "responseTime": PropTypes.oneOfType([Integer]).isRequired,
    "status": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
