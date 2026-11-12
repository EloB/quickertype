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
let _Facets;
let _Result;
let _CustomIncome;
const _Status = PropTypes.oneOf(['active', 'inactive']);
const _CustomIncomeType = PropTypes.oneOf(['public', 'other']);
const _ResultType = PropTypes.oneOf(['FinancialDataNGO', 'FinancialDataLawyer', 'FinancialDataTradeAssociation']);
_Facets = PropTypes.shape({
});
_CustomIncome = PropTypes.shape({
    "amount": PropTypes.oneOfType([Integer]).isRequired,
    "created_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "status": _Status,
    "type": _CustomIncomeType,
    "updated_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "uri": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Result = PropTypes.shape({
    "cost_absolute": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "cost_max": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "cost_min": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "created_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "customIncomes": PropTypes.oneOfType([PropTypes.arrayOf(_CustomIncome)]).isRequired,
    "direct_rep_costs_max": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "direct_rep_costs_min": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "end_date": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "eur_sources_grants": PropTypes.oneOfType([Integer]).isRequired,
    "eur_sources_grants_src": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "eur_sources_procurement": PropTypes.oneOfType([Integer]).isRequired,
    "eur_sources_procurement_src": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "new_organisation": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "no_clients": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "other_financial_information": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "other_sources_contributions": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "other_sources_donation": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "other_sources_total": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "public_financing_infranational": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "public_financing_national": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "public_financing_total": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "representative": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "start_date": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "status": _Status,
    "total_budget": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "turnover_absolute": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "turnover_max": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "turnover_min": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "type": _ResultType,
    "updated_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "uri": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "count": PropTypes.oneOfType([Integer]).isRequired,
    "facets": _Facets,
    "limit": PropTypes.oneOfType([Integer]).isRequired,
    "next": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "offset": PropTypes.oneOfType([Integer]).isRequired,
    "previous": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "results": PropTypes.oneOfType([PropTypes.arrayOf(_Result)]).isRequired,
});

export const TopLevel = _TopLevel;
