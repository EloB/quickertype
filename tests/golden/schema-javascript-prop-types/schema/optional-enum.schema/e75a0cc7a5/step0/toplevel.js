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
const _Shortcut = PropTypes.oneOf(['hidden', 'visible']);
_TopLevel = PropTypes.shape({
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "shortcut": PropTypes.oneOfType([_Shortcut, PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
