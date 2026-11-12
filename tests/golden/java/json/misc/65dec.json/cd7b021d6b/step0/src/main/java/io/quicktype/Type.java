package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Type {
    CREATURE, ARTIFACT, INSTANT, LAND, ENCHANTMENT, SORCERY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case CREATURE: return "Creature";
            case ARTIFACT: return "Artifact";
            case INSTANT: return "Instant";
            case LAND: return "Land";
            case ENCHANTMENT: return "Enchantment";
            case SORCERY: return "Sorcery";
        }
        return null;
    }

    @JsonCreator
    public static Type forValue(String value) throws IOException {
        if (value.equals("Creature")) return CREATURE;
        if (value.equals("Artifact")) return ARTIFACT;
        if (value.equals("Instant")) return INSTANT;
        if (value.equals("Land")) return LAND;
        if (value.equals("Enchantment")) return ENCHANTMENT;
        if (value.equals("Sorcery")) return SORCERY;
        throw new IOException("Cannot deserialize Type");
    }
}
