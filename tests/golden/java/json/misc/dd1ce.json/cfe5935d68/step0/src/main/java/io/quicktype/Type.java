package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Type {
    CREATURE, INSTANT, ENCHANTMENT, ARTIFACT, SORCERY, LAND;

    @JsonValue
    public String toValue() {
        switch (this) {
            case CREATURE: return "Creature";
            case INSTANT: return "Instant";
            case ENCHANTMENT: return "Enchantment";
            case ARTIFACT: return "Artifact";
            case SORCERY: return "Sorcery";
            case LAND: return "Land";
        }
        return null;
    }

    @JsonCreator
    public static Type forValue(String value) throws IOException {
        if (value.equals("Creature")) return CREATURE;
        if (value.equals("Instant")) return INSTANT;
        if (value.equals("Enchantment")) return ENCHANTMENT;
        if (value.equals("Artifact")) return ARTIFACT;
        if (value.equals("Sorcery")) return SORCERY;
        if (value.equals("Land")) return LAND;
        throw new IOException("Cannot deserialize Type");
    }
}
