package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Firstname {
    EMPTY, CHI;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case CHI: return "Chi";
        }
        return null;
    }

    @JsonCreator
    public static Firstname forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("Chi")) return CHI;
        throw new IOException("Cannot deserialize Firstname");
    }
}
