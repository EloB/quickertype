package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Namemod {
    EMPTY, JR, III;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case JR: return "Jr.";
            case III: return "III";
        }
        return null;
    }

    @JsonCreator
    public static Namemod forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("Jr.")) return JR;
        if (value.equals("III")) return III;
        throw new IOException("Cannot deserialize Namemod");
    }
}
