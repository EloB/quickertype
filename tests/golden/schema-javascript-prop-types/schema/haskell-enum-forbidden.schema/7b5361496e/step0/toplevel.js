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
const _Health = PropTypes.oneOf(['ok', 'error']);
_TopLevel = PropTypes.shape({
    "health": _Health,
});

export const TopLevel = _TopLevel;
