package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Scheme {
    SPDX, TROVE, DEP5;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SPDX: return "SPDX";
            case TROVE: return "Trove";
            case DEP5: return "DEP5";
        }
        return null;
    }

    @JsonCreator
    public static Scheme forValue(String value) throws IOException {
        if (value.equals("SPDX")) return SPDX;
        if (value.equals("Trove")) return TROVE;
        if (value.equals("DEP5")) return DEP5;
        throw new IOException("Cannot deserialize Scheme");
    }
}
