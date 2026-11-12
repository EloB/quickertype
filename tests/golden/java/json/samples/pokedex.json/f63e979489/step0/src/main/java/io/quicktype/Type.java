package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Type {
    FIRE, ICE, FLYING, PSYCHIC, WATER, GROUND, ROCK, ELECTRIC, GRASS, FIGHTING, POISON, BUG, FAIRY, GHOST, DARK, STEEL, DRAGON, NORMAL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case FIRE: return "Fire";
            case ICE: return "Ice";
            case FLYING: return "Flying";
            case PSYCHIC: return "Psychic";
            case WATER: return "Water";
            case GROUND: return "Ground";
            case ROCK: return "Rock";
            case ELECTRIC: return "Electric";
            case GRASS: return "Grass";
            case FIGHTING: return "Fighting";
            case POISON: return "Poison";
            case BUG: return "Bug";
            case FAIRY: return "Fairy";
            case GHOST: return "Ghost";
            case DARK: return "Dark";
            case STEEL: return "Steel";
            case DRAGON: return "Dragon";
            case NORMAL: return "Normal";
        }
        return null;
    }

    @JsonCreator
    public static Type forValue(String value) throws IOException {
        if (value.equals("Fire")) return FIRE;
        if (value.equals("Ice")) return ICE;
        if (value.equals("Flying")) return FLYING;
        if (value.equals("Psychic")) return PSYCHIC;
        if (value.equals("Water")) return WATER;
        if (value.equals("Ground")) return GROUND;
        if (value.equals("Rock")) return ROCK;
        if (value.equals("Electric")) return ELECTRIC;
        if (value.equals("Grass")) return GRASS;
        if (value.equals("Fighting")) return FIGHTING;
        if (value.equals("Poison")) return POISON;
        if (value.equals("Bug")) return BUG;
        if (value.equals("Fairy")) return FAIRY;
        if (value.equals("Ghost")) return GHOST;
        if (value.equals("Dark")) return DARK;
        if (value.equals("Steel")) return STEEL;
        if (value.equals("Dragon")) return DRAGON;
        if (value.equals("Normal")) return NORMAL;
        throw new IOException("Cannot deserialize Type");
    }
}
