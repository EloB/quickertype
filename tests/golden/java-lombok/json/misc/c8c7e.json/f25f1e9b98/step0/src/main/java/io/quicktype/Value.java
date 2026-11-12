package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Value {
    INDIA, GDP_CURRENT_US;

    @JsonValue
    public String toValue() {
        switch (this) {
            case INDIA: return "India";
            case GDP_CURRENT_US: return "GDP (current US$)";
        }
        return null;
    }

    @JsonCreator
    public static Value forValue(String value) throws IOException {
        if (value.equals("India")) return INDIA;
        if (value.equals("GDP (current US$)")) return GDP_CURRENT_US;
        throw new IOException("Cannot deserialize Value");
    }
}
