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
let _Prize;
let _Laureate;
const _Category = PropTypes.oneOf(['physics', 'chemistry', 'medicine', 'literature', 'peace', 'economics']);
_Laureate = PropTypes.shape({
    "firstname": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "motivation": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "share": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "surname": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Prize = PropTypes.shape({
    "category": _Category,
    "laureates": PropTypes.oneOfType([PropTypes.arrayOf(_Laureate)]).isRequired,
    "overallMotivation": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "year": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "prizes": PropTypes.oneOfType([PropTypes.arrayOf(_Prize)]).isRequired,
});

export const TopLevel = _TopLevel;
