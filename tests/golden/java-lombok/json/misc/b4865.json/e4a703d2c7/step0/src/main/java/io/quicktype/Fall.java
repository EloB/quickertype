package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Fall {
    FELL, FOUND;

    @JsonValue
    public String toValue() {
        switch (this) {
            case FELL: return "Fell";
            case FOUND: return "Found";
        }
        return null;
    }

    @JsonCreator
    public static Fall forValue(String value) throws IOException {
        if (value.equals("Fell")) return FELL;
        if (value.equals("Found")) return FOUND;
        throw new IOException("Cannot deserialize Fall");
    }
}
