package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Scheme {
    DEP5, SPDX, TROVE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case DEP5: return "DEP5";
            case SPDX: return "SPDX";
            case TROVE: return "Trove";
        }
        return null;
    }

    @JsonCreator
    public static Scheme forValue(String value) throws IOException {
        if (value.equals("DEP5")) return DEP5;
        if (value.equals("SPDX")) return SPDX;
        if (value.equals("Trove")) return TROVE;
        throw new IOException("Cannot deserialize Scheme");
    }
}
