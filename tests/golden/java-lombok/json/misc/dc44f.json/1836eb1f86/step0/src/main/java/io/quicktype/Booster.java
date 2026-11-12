package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Booster {
    RARE, UNCOMMON, COMMON;

    @JsonValue
    public String toValue() {
        switch (this) {
            case RARE: return "rare";
            case UNCOMMON: return "uncommon";
            case COMMON: return "common";
        }
        return null;
    }

    @JsonCreator
    public static Booster forValue(String value) throws IOException {
        if (value.equals("rare")) return RARE;
        if (value.equals("uncommon")) return UNCOMMON;
        if (value.equals("common")) return COMMON;
        throw new IOException("Cannot deserialize Booster");
    }
}
