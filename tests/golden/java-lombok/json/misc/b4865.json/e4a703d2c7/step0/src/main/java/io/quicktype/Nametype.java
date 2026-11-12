package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Nametype {
    VALID;

    @JsonValue
    public String toValue() {
        switch (this) {
            case VALID: return "Valid";
        }
        return null;
    }

    @JsonCreator
    public static Nametype forValue(String value) throws IOException {
        if (value.equals("Valid")) return VALID;
        throw new IOException("Cannot deserialize Nametype");
    }
}
