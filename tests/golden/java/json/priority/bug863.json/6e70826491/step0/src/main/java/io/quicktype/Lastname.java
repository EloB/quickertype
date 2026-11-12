package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Lastname {
    EMPTY, WASHKO;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case WASHKO: return "Washko";
        }
        return null;
    }

    @JsonCreator
    public static Lastname forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("Washko")) return WASHKO;
        throw new IOException("Cannot deserialize Lastname");
    }
}
