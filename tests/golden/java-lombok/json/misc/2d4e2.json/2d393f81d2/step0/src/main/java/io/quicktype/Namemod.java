package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Namemod {
    EMPTY, III, JR;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case III: return "III";
            case JR: return "Jr.";
        }
        return null;
    }

    @JsonCreator
    public static Namemod forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("III")) return III;
        if (value.equals("Jr.")) return JR;
        throw new IOException("Cannot deserialize Namemod");
    }
}
