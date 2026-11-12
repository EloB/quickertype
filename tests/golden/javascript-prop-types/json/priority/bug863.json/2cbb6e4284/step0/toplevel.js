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
let _PurpleTopLevel;
const _Breed = PropTypes.oneOf(['Atrox', 'Solitus', 'Opifex', 'Nano']);
const _Firstname = PropTypes.oneOf(['', 'Chi']);
const _Lastname = PropTypes.oneOf(['', 'Washko']);
const _Pvptitle = PropTypes.oneOf(['Freshman']);
const _RankTitle = PropTypes.oneOf(['President', 'Advisor', 'Veteran', 'Applicant']);
const _Sex = PropTypes.oneOf(['Neuter', 'Male', 'Female']);
_TopLevelElement = PropTypes.shape({
    "ALIENLEVEL": PropTypes.oneOfType([Integer]).isRequired,
    "BREED": _Breed,
    "CHAR_DIMENSION": PropTypes.oneOfType([Integer]).isRequired,
    "CHAR_INSTANCE": PropTypes.oneOfType([Integer]).isRequired,
    "DEFENDER_RANK_TITLE": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "FIRSTNAME": _Firstname,
    "HEADID": PropTypes.oneOfType([Integer]).isRequired,
    "LASTNAME": _Lastname,
    "LEVELX": PropTypes.oneOfType([Integer]).isRequired,
    "NAME": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "PROF": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "PROF_TITLE": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "PVPRATING": PropTypes.oneOfType([Integer]).isRequired,
    "PVPTITLE": _Pvptitle,
    "RANK": PropTypes.oneOfType([Integer]).isRequired,
    "RANK_TITLE": _RankTitle,
    "SEX": _Sex,
});
_PurpleTopLevel = PropTypes.shape({
    "ADVENTURERCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "AGENTCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "ATROXCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "AVGLVL": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "BTCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "DESCRIPTION": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "DOCTORCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "ENFCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "ENGINEEERCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "FEMALECOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "FIXERCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "GOVERNINGNAME": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "HISTORY": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "KEEPERCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "MACOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "MALECOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "MAXLVL": PropTypes.oneOfType([Integer]).isRequired,
    "METACOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "MINLVL": PropTypes.oneOfType([Integer]).isRequired,
    "MONSTERCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "NAME": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "NANOCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "NANORACECOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "NEUTERCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "NUMMEMBERS": PropTypes.oneOfType([Integer]).isRequired,
    "OBJECTIVE": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "OPIFEXCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "ORG_DIMENSION": PropTypes.oneOfType([Integer]).isRequired,
    "ORG_INSTANCE": PropTypes.oneOfType([Integer]).isRequired,
    "SHADECOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "SIDE": PropTypes.oneOfType([Integer]).isRequired,
    "SIDE_NAME": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "SOLIDERCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "SOLITUSCOUNT": PropTypes.oneOfType([Integer]).isRequired,
    "TRADERCOUNT": PropTypes.oneOfType([Integer]).isRequired,
});

export const TopLevel = PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.arrayOf(_TopLevelElement), _PurpleTopLevel, PropTypes.string])]).isRequired);
