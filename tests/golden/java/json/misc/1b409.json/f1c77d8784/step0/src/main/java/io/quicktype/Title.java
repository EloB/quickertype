package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Title {
    REP, COMMISH;

    @JsonValue
    public String toValue() {
        switch (this) {
            case REP: return "Rep.";
            case COMMISH: return "Commish.";
        }
        return null;
    }

    @JsonCreator
    public static Title forValue(String value) throws IOException {
        if (value.equals("Rep.")) return REP;
        if (value.equals("Commish.")) return COMMISH;
        throw new IOException("Cannot deserialize Title");
    }
}
