package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Value {
    CHINA, GDP_CURRENT_US;

    @JsonValue
    public String toValue() {
        switch (this) {
            case CHINA: return "China";
            case GDP_CURRENT_US: return "GDP (current US$)";
        }
        return null;
    }

    @JsonCreator
    public static Value forValue(String value) throws IOException {
        if (value.equals("China")) return CHINA;
        if (value.equals("GDP (current US$)")) return GDP_CURRENT_US;
        throw new IOException("Cannot deserialize Value");
    }
}
