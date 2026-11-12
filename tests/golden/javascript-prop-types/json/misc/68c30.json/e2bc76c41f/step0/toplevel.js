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
let _Tx;
let _Input;
let _Out;
_Out = PropTypes.shape({
    "addr": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "n": PropTypes.oneOfType([Integer]).isRequired,
    "script": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "spent": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "tx_index": PropTypes.oneOfType([Integer]).isRequired,
    "type": PropTypes.oneOfType([Integer]).isRequired,
    "value": PropTypes.oneOfType([Integer]).isRequired,
});
_Input = PropTypes.shape({
    "prev_out": _Out,
    "script": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sequence": PropTypes.oneOfType([Integer]).isRequired,
});
_Tx = PropTypes.shape({
    "double_spend": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "hash": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "inputs": PropTypes.oneOfType([PropTypes.arrayOf(_Input)]).isRequired,
    "lock_time": PropTypes.oneOfType([Integer]).isRequired,
    "out": PropTypes.oneOfType([PropTypes.arrayOf(_Out)]).isRequired,
    "relayed_by": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "size": PropTypes.oneOfType([Integer]).isRequired,
    "time": PropTypes.oneOfType([Integer]).isRequired,
    "tx_index": PropTypes.oneOfType([Integer]).isRequired,
    "ver": PropTypes.oneOfType([Integer]).isRequired,
    "vin_sz": PropTypes.oneOfType([Integer]).isRequired,
    "vout_sz": PropTypes.oneOfType([Integer]).isRequired,
});
_TopLevel = PropTypes.shape({
    "txs": PropTypes.oneOfType([PropTypes.arrayOf(_Tx)]).isRequired,
});

export const TopLevel = _TopLevel;
