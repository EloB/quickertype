package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Value {
    UNITED_STATES, GDP_CURRENT_US;

    @JsonValue
    public String toValue() {
        switch (this) {
            case UNITED_STATES: return "United States";
            case GDP_CURRENT_US: return "GDP (current US$)";
        }
        return null;
    }

    @JsonCreator
    public static Value forValue(String value) throws IOException {
        if (value.equals("United States")) return UNITED_STATES;
        if (value.equals("GDP (current US$)")) return GDP_CURRENT_US;
        throw new IOException("Cannot deserialize Value");
    }
}
