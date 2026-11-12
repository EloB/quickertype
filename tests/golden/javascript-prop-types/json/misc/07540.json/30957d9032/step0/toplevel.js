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
let _Cookies;
_Cookies = PropTypes.shape({
});
_TopLevel = PropTypes.shape({
    "cookies": _Cookies,
});

export const TopLevel = _TopLevel;
