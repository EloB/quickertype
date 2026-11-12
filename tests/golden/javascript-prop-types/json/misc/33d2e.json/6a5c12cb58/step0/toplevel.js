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
let _Laureate;
let _Prize;
let _AffiliationClass;
const _BornEnum = PropTypes.oneOf(['0000-00-00', '1898-00-00', '1943-00-00']);
const _Gender = PropTypes.oneOf(['male', 'female', 'org']);
const _Category = PropTypes.oneOf(['physics', 'chemistry', 'peace', 'medicine', 'literature', 'economics']);
_AffiliationClass = PropTypes.shape({
    "city": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "country": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "name": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_Prize = PropTypes.shape({
    "affiliations": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any), _AffiliationClass]))]).isRequired,
    "category": PropTypes.oneOfType([_Category, PropTypes.oneOf([null])]),
    "motivation": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "overallMotivation": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "share": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "year": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_Laureate = PropTypes.shape({
    "born": PropTypes.oneOfType([PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time"), _BornEnum])]).isRequired,
    "bornCity": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "bornCountry": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "bornCountryCode": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "died": PropTypes.oneOfType([PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time"), _BornEnum])]).isRequired,
    "diedCity": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "diedCountry": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "diedCountryCode": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "firstname": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "gender": _Gender,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "prizes": PropTypes.oneOfType([PropTypes.arrayOf(_Prize)]).isRequired,
    "surname": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_TopLevel = PropTypes.shape({
    "laureates": PropTypes.oneOfType([PropTypes.arrayOf(_Laureate)]).isRequired,
});

export const TopLevel = _TopLevel;
