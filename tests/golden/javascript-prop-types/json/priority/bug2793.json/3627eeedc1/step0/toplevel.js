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
let _Hints;
let _Labels;
_Hints = PropTypes.shape({
});
_Labels = PropTypes.shape({
    "AccountNumber": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Title": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "Hints": _Hints,
    "Labels": _Labels,
});

export const TopLevel = _TopLevel;
