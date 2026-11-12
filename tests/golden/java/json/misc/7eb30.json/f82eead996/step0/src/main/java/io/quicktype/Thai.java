package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Thai {
    EMPTY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "\u0e40\u0e2d\u0e2a\u0e40\u0e2d\u0e1f";
        }
        return null;
    }

    @JsonCreator
    public static Thai forValue(String value) throws IOException {
        if (value.equals("\u0e40\u0e2d\u0e2a\u0e40\u0e2d\u0e1f")) return EMPTY;
        throw new IOException("Cannot deserialize Thai");
    }
}
