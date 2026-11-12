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
_TopLevel = PropTypes.shape({
    "git": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "github_services_sha": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "hooks": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "importer": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "pages": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "verifiable_password_authentication": PropTypes.oneOfType([PropTypes.bool]).isRequired,
});

export const TopLevel = _TopLevel;
