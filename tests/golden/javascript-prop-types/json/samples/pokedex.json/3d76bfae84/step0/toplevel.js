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
let _Pokemon;
let _Evolution;
const _Egg = PropTypes.oneOf(['2 km', 'Not in Eggs', '5 km', '10 km', 'Omanyte Candy']);
const _Type = PropTypes.oneOf(['Fire', 'Ice', 'Flying', 'Psychic', 'Water', 'Ground', 'Rock', 'Electric', 'Grass', 'Fighting', 'Poison', 'Bug', 'Fairy', 'Ghost', 'Dark', 'Steel', 'Dragon', 'Normal']);
_Evolution = PropTypes.shape({
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "num": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Pokemon = PropTypes.shape({
    "avg_spawns": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "candy": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "candy_count": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "egg": _Egg,
    "height": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "img": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "multipliers": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])])])(props, name, ...args),
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "next_evolution": PropTypes.oneOfType([PropTypes.arrayOf(_Evolution), PropTypes.oneOf([null])]),
    "num": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "prev_evolution": PropTypes.oneOfType([PropTypes.arrayOf(_Evolution), PropTypes.oneOf([null])]),
    "spawn_chance": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "spawn_time": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": PropTypes.oneOfType([PropTypes.arrayOf(_Type)]).isRequired,
    "weaknesses": PropTypes.oneOfType([PropTypes.arrayOf(_Type)]).isRequired,
    "weight": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "pokemon": PropTypes.oneOfType([PropTypes.arrayOf(_Pokemon)]).isRequired,
});

export const TopLevel = _TopLevel;
