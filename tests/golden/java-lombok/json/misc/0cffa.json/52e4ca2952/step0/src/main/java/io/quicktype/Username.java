package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Username {
    CHEEZBURGER, EMPTY, NATGEOWILD, NOWTHIS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case CHEEZBURGER: return "cheezburger";
            case EMPTY: return "";
            case NATGEOWILD: return "natgeowild";
            case NOWTHIS: return "nowthis";
        }
        return null;
    }

    @JsonCreator
    public static Username forValue(String value) throws IOException {
        if (value.equals("cheezburger")) return CHEEZBURGER;
        if (value.equals("")) return EMPTY;
        if (value.equals("natgeowild")) return NATGEOWILD;
        if (value.equals("nowthis")) return NOWTHIS;
        throw new IOException("Cannot deserialize Username");
    }
}
