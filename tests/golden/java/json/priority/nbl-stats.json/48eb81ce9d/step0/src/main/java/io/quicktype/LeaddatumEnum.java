package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum LeaddatumEnum {
    EMPTY, P1, P2, P3, P4;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case P1: return "P1";
            case P2: return "P2";
            case P3: return "P3";
            case P4: return "P4";
        }
        return null;
    }

    @JsonCreator
    public static LeaddatumEnum forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("P1")) return P1;
        if (value.equals("P2")) return P2;
        if (value.equals("P3")) return P3;
        if (value.equals("P4")) return P4;
        throw new IOException("Cannot deserialize LeaddatumEnum");
    }
}
