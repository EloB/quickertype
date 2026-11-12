package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Rarity {
    UNCOMMON, RARE, COMMON, BASIC_LAND;

    @JsonValue
    public String toValue() {
        switch (this) {
            case UNCOMMON: return "Uncommon";
            case RARE: return "Rare";
            case COMMON: return "Common";
            case BASIC_LAND: return "Basic Land";
        }
        return null;
    }

    @JsonCreator
    public static Rarity forValue(String value) throws IOException {
        if (value.equals("Uncommon")) return UNCOMMON;
        if (value.equals("Rare")) return RARE;
        if (value.equals("Common")) return COMMON;
        if (value.equals("Basic Land")) return BASIC_LAND;
        throw new IOException("Cannot deserialize Rarity");
    }
}
