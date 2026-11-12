package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Username {
    EMPTY, PRODUCTHUNT, MEETAIKO, CHEEZBURGER;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case PRODUCTHUNT: return "producthunt";
            case MEETAIKO: return "meetaiko";
            case CHEEZBURGER: return "cheezburger";
        }
        return null;
    }

    @JsonCreator
    public static Username forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("producthunt")) return PRODUCTHUNT;
        if (value.equals("meetaiko")) return MEETAIKO;
        if (value.equals("cheezburger")) return CHEEZBURGER;
        throw new IOException("Cannot deserialize Username");
    }
}
