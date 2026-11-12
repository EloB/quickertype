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
let _Othermatch;
let _Team;
let _Pbp;
let _Scorer;
let _Time;
let _Tm;
let _Lds;
let _SBlocks;
let _Pl;
let _Comp;
let _Shot;
let _Totallds;
const _LeaddatumEnum = PropTypes.oneOf(['', 'P1', 'P2', 'P3', 'P4']);
const _PerType = PropTypes.oneOf(['REGULAR']);
const _ActionType = PropTypes.oneOf(['game', 'period', '3pt', '2pt', 'rebound', 'timeout', 'foulon', 'foul', 'assist', 'substitution', 'freethrow', 'steal', 'turnover', 'block', 'jumpball']);
const _FamilyNameInitial = PropTypes.oneOf(['R', 'M', 's', 'C', 'O', 'W', 'A', 'P', 'V', 'I', 'J', 'S', 'H', 'B']);
const _FirstNameInitial = PropTypes.oneOf(['D', 'J', 'T', 'C', 'O', 'H', 'L', 'A', 'K', 'R', 'B', 'N']);
const _ScoreboardName = PropTypes.oneOf(['', 'T. s', 'R. Ihata', 'D. Jones', 'B. Valentine']);
const _SubType = PropTypes.oneOf(['jumpshot', 'layup', 'dunk']);
_Team = PropTypes.shape({
    "teamCode": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "teamCodeInternational": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "teamName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "teamNameInternational": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Othermatch = PropTypes.shape({
    "clock": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "competitionName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "period": PropTypes.oneOfType([Integer]).isRequired,
    "periodType": _PerType,
    "team1": _Team,
    "team1Name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "team1Score": PropTypes.oneOfType([Integer]).isRequired,
    "team2": _Team,
    "team2Name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "team2Score": PropTypes.oneOfType([Integer]).isRequired,
});
_Pbp = PropTypes.shape({
    "actionType": _ActionType,
    "familyName": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "familyNameInitial": PropTypes.oneOfType([_FamilyNameInitial, PropTypes.oneOf([null])]),
    "firstName": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "firstNameInitial": PropTypes.oneOfType([_FirstNameInitial, PropTypes.oneOf([null])]),
    "gt": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "internationalFamilyName": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "internationalFamilyNameInitial": PropTypes.oneOfType([_FamilyNameInitial, PropTypes.oneOf([null])]),
    "internationalFirstName": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "internationalFirstNameInitial": PropTypes.oneOfType([_FirstNameInitial, PropTypes.oneOf([null])]),
    "lead": PropTypes.oneOfType([Integer]).isRequired,
    "period": PropTypes.oneOfType([Integer]).isRequired,
    "periodType": _PerType,
    "player": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "pno": PropTypes.oneOfType([Integer]).isRequired,
    "qualifier": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "s1": PropTypes.oneOfType([Integer]).isRequired,
    "s2": PropTypes.oneOfType([Integer]).isRequired,
    "scoreboardName": PropTypes.oneOfType([_ScoreboardName, PropTypes.oneOf([null])]),
    "scoring": PropTypes.oneOfType([Integer]).isRequired,
    "shirtNumber": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "subType": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "success": PropTypes.oneOfType([Integer]).isRequired,
    "tno": PropTypes.oneOfType([Integer]).isRequired,
});
_Time = PropTypes.shape({
    "gt": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "per": PropTypes.oneOfType([Integer]).isRequired,
    "perType": _PerType,
});
_Scorer = PropTypes.shape({
    "familyName": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "familyNameInitial": PropTypes.oneOfType([_FamilyNameInitial, PropTypes.oneOf([null])]),
    "firstName": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "firstNameInitial": PropTypes.oneOfType([_FirstNameInitial, PropTypes.oneOf([null])]),
    "gt": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "internationalFamilyName": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "internationalFamilyNameInitial": PropTypes.oneOfType([_FamilyNameInitial, PropTypes.oneOf([null])]),
    "internationalFirstName": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "internationalFirstNameInitial": PropTypes.oneOfType([_FirstNameInitial, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "per": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "perType": PropTypes.oneOfType([_PerType, PropTypes.oneOf([null])]),
    "player": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "pno": PropTypes.oneOfType([Integer]).isRequired,
    "scoreboardName": PropTypes.oneOfType([_ScoreboardName, PropTypes.oneOf([null])]),
    "shirtNumber": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "summary": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "times": PropTypes.oneOfType([PropTypes.arrayOf(_Time), PropTypes.oneOf([null])]),
    "tno": PropTypes.oneOfType([Integer]).isRequired,
    "tot": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
});
_SBlocks = PropTypes.shape({
    "1": _Scorer,
});
_Lds = PropTypes.shape({
    "sAssists": PropTypes.oneOfType([PropTypes.objectOf(_Scorer)]).isRequired,
    "sBlocks": _SBlocks,
    "sPoints": PropTypes.oneOfType([PropTypes.objectOf(_Scorer)]).isRequired,
    "sReboundsTotal": PropTypes.oneOfType([PropTypes.objectOf(_Scorer)]).isRequired,
    "sSteals": PropTypes.oneOfType([PropTypes.objectOf(_Scorer)]).isRequired,
});
_Comp = PropTypes.shape({
    "sAssistsAverage": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "sMinutesAverage": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sPointsAverage": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "sReboundsTotalAverage": PropTypes.oneOfType([PropTypes.number]).isRequired,
});
_Pl = PropTypes.shape({
    "active": PropTypes.oneOfType([Integer]).isRequired,
    "captain": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "comp": PropTypes.oneOfType([_Comp, PropTypes.oneOf([null])]),
    "eff_1": PropTypes.oneOfType([Integer]).isRequired,
    "eff_2": PropTypes.oneOfType([Integer]).isRequired,
    "eff_3": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "eff_4": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "eff_5": PropTypes.oneOfType([Integer]).isRequired,
    "eff_6": PropTypes.oneOfType([Integer]).isRequired,
    "eff_7": PropTypes.oneOfType([Integer]).isRequired,
    "familyName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "familyNameInitial": _FamilyNameInitial,
    "firstName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "firstNameInitial": _FirstNameInitial,
    "internationalFamilyName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "internationalFamilyNameInitial": _FamilyNameInitial,
    "internationalFirstName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "internationalFirstNameInitial": _FirstNameInitial,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "playingPosition": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sAssists": PropTypes.oneOfType([Integer]).isRequired,
    "sBlocks": PropTypes.oneOfType([Integer]).isRequired,
    "sBlocksReceived": PropTypes.oneOfType([Integer]).isRequired,
    "sFieldGoalsAttempted": PropTypes.oneOfType([Integer]).isRequired,
    "sFieldGoalsMade": PropTypes.oneOfType([Integer]).isRequired,
    "sFieldGoalsPercentage": PropTypes.oneOfType([Integer]).isRequired,
    "sFoulsOn": PropTypes.oneOfType([Integer]).isRequired,
    "sFoulsPersonal": PropTypes.oneOfType([Integer]).isRequired,
    "sFreeThrowsAttempted": PropTypes.oneOfType([Integer]).isRequired,
    "sFreeThrowsMade": PropTypes.oneOfType([Integer]).isRequired,
    "sFreeThrowsPercentage": PropTypes.oneOfType([Integer]).isRequired,
    "sMinutes": PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.string])]).isRequired,
    "sPlusMinusPoints": PropTypes.oneOfType([Integer]).isRequired,
    "sPoints": PropTypes.oneOfType([Integer]).isRequired,
    "sPointsFastBreak": PropTypes.oneOfType([Integer]).isRequired,
    "sPointsInThePaint": PropTypes.oneOfType([Integer]).isRequired,
    "sPointsSecondChance": PropTypes.oneOfType([Integer]).isRequired,
    "sReboundsDefensive": PropTypes.oneOfType([Integer]).isRequired,
    "sReboundsOffensive": PropTypes.oneOfType([Integer]).isRequired,
    "sReboundsTotal": PropTypes.oneOfType([Integer]).isRequired,
    "sSteals": PropTypes.oneOfType([Integer]).isRequired,
    "sThreePointersAttempted": PropTypes.oneOfType([Integer]).isRequired,
    "sThreePointersMade": PropTypes.oneOfType([Integer]).isRequired,
    "sThreePointersPercentage": PropTypes.oneOfType([Integer]).isRequired,
    "sTurnovers": PropTypes.oneOfType([Integer]).isRequired,
    "sTwoPointersAttempted": PropTypes.oneOfType([Integer]).isRequired,
    "sTwoPointersMade": PropTypes.oneOfType([Integer]).isRequired,
    "sTwoPointersPercentage": PropTypes.oneOfType([Integer]).isRequired,
    "shirtNumber": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "starter": PropTypes.oneOfType([Integer]).isRequired,
});
_Shot = PropTypes.shape({
    "actionType": _ActionType,
    "p": PropTypes.oneOfType([Integer]).isRequired,
    "per": PropTypes.oneOfType([Integer]).isRequired,
    "perType": _PerType,
    "player": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "pno": PropTypes.oneOfType([Integer]).isRequired,
    "r": PropTypes.oneOfType([Integer]).isRequired,
    "shirtNumber": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "subType": _SubType,
    "tno": PropTypes.oneOfType([Integer]).isRequired,
    "x": PropTypes.oneOfType([Integer]).isRequired,
    "y": PropTypes.oneOfType([Integer]).isRequired,
});
_Tm = PropTypes.shape({
    "code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "codeInternational": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "fouls": PropTypes.oneOfType([Integer]).isRequired,
    "full_score": PropTypes.oneOfType([Integer]).isRequired,
    "lds": _Lds,
    "logo": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "nameInternational": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "p1_score": PropTypes.oneOfType([Integer]).isRequired,
    "p2_score": PropTypes.oneOfType([Integer]).isRequired,
    "p3_score": PropTypes.oneOfType([Integer]).isRequired,
    "p4_score": PropTypes.oneOfType([Integer]).isRequired,
    "pl": PropTypes.oneOfType([PropTypes.objectOf(_Pl)]).isRequired,
    "score": PropTypes.oneOfType([Integer]).isRequired,
    "scoring": PropTypes.oneOfType([PropTypes.arrayOf(_Scorer)]).isRequired,
    "shortName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "shortNameInternational": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "shot": PropTypes.oneOfType([PropTypes.arrayOf(_Shot)]).isRequired,
    "timeouts": PropTypes.oneOfType([Integer]).isRequired,
    "tot_eff_1": PropTypes.oneOfType([Integer]).isRequired,
    "tot_eff_2": PropTypes.oneOfType([Integer]).isRequired,
    "tot_eff_3": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "tot_eff_4": PropTypes.oneOfType([Integer]).isRequired,
    "tot_eff_5": PropTypes.oneOfType([Integer]).isRequired,
    "tot_eff_6": PropTypes.oneOfType([Integer]).isRequired,
    "tot_eff_7": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sAssists": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sBenchPoints": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sBiggestLead": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sBiggestScoringRun": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sBlocks": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sBlocksReceived": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sFieldGoalsAttempted": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sFieldGoalsMade": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sFieldGoalsPercentage": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sFoulsOn": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sFoulsPersonal": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sFoulsTeam": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sFreeThrowsAttempted": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sFreeThrowsMade": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sFreeThrowsPercentage": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sLeadChanges": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sMinutes": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sPoints": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sPointsFastBreak": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sPointsFromTurnovers": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sPointsInThePaint": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sPointsSecondChance": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sReboundsDefensive": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sReboundsOffensive": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sReboundsTeam": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sReboundsTeamDefensive": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sReboundsTeamOffensive": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sReboundsTotal": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sSteals": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sThreePointersAttempted": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sThreePointersMade": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sThreePointersPercentage": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sTimeLeading": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "tot_sTimesScoresLevel": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sTurnovers": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sTurnoversTeam": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sTwoPointersAttempted": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sTwoPointersMade": PropTypes.oneOfType([Integer]).isRequired,
    "tot_sTwoPointersPercentage": PropTypes.oneOfType([Integer]).isRequired,
});
_Totallds = PropTypes.shape({
    "sAssists": PropTypes.oneOfType([PropTypes.objectOf(_Scorer)]).isRequired,
    "sBlocks": PropTypes.oneOfType([PropTypes.objectOf(_Scorer)]).isRequired,
    "sPoints": PropTypes.oneOfType([PropTypes.objectOf(_Scorer)]).isRequired,
    "sReboundsTotal": PropTypes.oneOfType([PropTypes.objectOf(_Scorer)]).isRequired,
    "sSteals": PropTypes.oneOfType([PropTypes.objectOf(_Scorer)]).isRequired,
});
_TopLevel = PropTypes.shape({
    "attendance": PropTypes.oneOfType([Integer]).isRequired,
    "clock": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "disableMatch": PropTypes.oneOfType([Integer]).isRequired,
    "inOT": PropTypes.oneOfType([Integer]).isRequired,
    "leaddata": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.oneOfType([_LeaddatumEnum, Integer])))]).isRequired,
    "officials_referee1": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "officials_referee2": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "officials_referee3": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "othermatches": PropTypes.oneOfType([PropTypes.arrayOf(_Othermatch)]).isRequired,
    "pbp": PropTypes.oneOfType([PropTypes.arrayOf(_Pbp)]).isRequired,
    "period": PropTypes.oneOfType([Integer]).isRequired,
    "periodLengthOVERTIME": PropTypes.oneOfType([Integer]).isRequired,
    "periodLengthREGULAR": PropTypes.oneOfType([Integer]).isRequired,
    "periodType": _PerType,
    "periodsMax": PropTypes.oneOfType([Integer]).isRequired,
    "scorers": PropTypes.oneOfType([PropTypes.objectOf(PropTypes.arrayOf(_Scorer))]).isRequired,
    "timeline": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
    "tm": PropTypes.oneOfType([PropTypes.objectOf(_Tm)]).isRequired,
    "totalTimeAdded": PropTypes.oneOfType([Integer]).isRequired,
    "totallds": _Totallds,
});

export const TopLevel = _TopLevel;
