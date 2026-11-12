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

let _TopLevelElement;
let _Adminregion;
let _PurpleTopLevel;
const _ID = PropTypes.oneOf(['', 'SAS', 'SSA', 'ECA', 'LAC', 'EAP', 'MNA', 'HIC', 'LIC', 'NA', 'LMC', 'UMC', 'LNX', 'IDX', 'IBD', 'IDB', 'LCN', 'SSF', 'ECS', 'MEA', 'EAS', 'NAC']);
const _Value = PropTypes.oneOf(['', 'South Asia', 'Sub-Saharan Africa (excluding high income)', 'Europe & Central Asia (excluding high income)', 'Latin America & Caribbean (excluding high income)', 'East Asia & Pacific (excluding high income)', 'Middle East & North Africa (excluding high income)', 'High income', 'Low income', 'Aggregates', 'Lower middle income', 'Upper middle income', 'Not classified', 'IDA', 'IBRD', 'Blend', 'Latin America & Caribbean ', 'Sub-Saharan Africa ', 'Europe & Central Asia', 'Middle East & North Africa', 'East Asia & Pacific', 'North America']);
_Adminregion = PropTypes.shape({
    "id": _ID,
    "value": _Value,
});
_TopLevelElement = PropTypes.shape({
    "adminregion": _Adminregion,
    "capitalCity": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "incomeLevel": _Adminregion,
    "iso2Code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "latitude": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "lendingType": _Adminregion,
    "longitude": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "region": _Adminregion,
});
_PurpleTopLevel = PropTypes.shape({
    "page": PropTypes.oneOfType([Integer]).isRequired,
    "pages": PropTypes.oneOfType([Integer]).isRequired,
    "per_page": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "total": PropTypes.oneOfType([Integer]).isRequired,
});

export const TopLevel = PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.arrayOf(_TopLevelElement), _PurpleTopLevel])]).isRequired);
