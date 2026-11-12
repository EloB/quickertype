package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Namemod {
    EMPTY, JR, II, III, IV;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case JR: return "Jr.";
            case II: return "II";
            case III: return "III";
            case IV: return "IV";
        }
        return null;
    }

    @JsonCreator
    public static Namemod forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("Jr.")) return JR;
        if (value.equals("II")) return II;
        if (value.equals("III")) return III;
        if (value.equals("IV")) return IV;
        throw new IOException("Cannot deserialize Namemod");
    }
}
