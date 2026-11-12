package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Country {
    UNITED_STATES;

    @JsonValue
    public String toValue() {
        switch (this) {
            case UNITED_STATES: return "United States";
        }
        return null;
    }

    @JsonCreator
    public static Country forValue(String value) throws IOException {
        if (value.equals("United States")) return UNITED_STATES;
        throw new IOException("Cannot deserialize Country");
    }
}
