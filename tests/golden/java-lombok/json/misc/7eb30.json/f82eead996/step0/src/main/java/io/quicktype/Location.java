package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Location {
    EMPTY, THE_5_TH_FL_EMPORIUM;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case THE_5_TH_FL_EMPORIUM: return "5th Fl. Emporium";
        }
        return null;
    }

    @JsonCreator
    public static Location forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("5th Fl. Emporium")) return THE_5_TH_FL_EMPORIUM;
        throw new IOException("Cannot deserialize Location");
    }
}
