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
let _MissionSpec;
let _Objective;
let _Reward;
_Reward = PropTypes.shape({
});
_Objective = PropTypes.shape({
    "rewards": PropTypes.oneOfType([PropTypes.objectOf(_Reward)]).isRequired,
});
_MissionSpec = PropTypes.shape({
    "objectives": PropTypes.oneOfType([PropTypes.objectOf(_Objective)]).isRequired,
});
_TopLevel = PropTypes.shape({
    "mission_specs": PropTypes.oneOfType([PropTypes.objectOf(_MissionSpec)]).isRequired,
});

export const TopLevel = _TopLevel;
