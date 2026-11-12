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
let _LightParams;
_LightParams = PropTypes.shape({
    "app_id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "outlet_id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "rgba": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "LightParams": _LightParams,
});

export const TopLevel = _TopLevel;
