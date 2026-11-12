package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Priority {
    LOW, MEDIUM, HIGH;

    @JsonValue
    public String toValue() {
        switch (this) {
            case LOW: return "low";
            case MEDIUM: return "medium";
            case HIGH: return "high";
        }
        return null;
    }

    @JsonCreator
    public static Priority forValue(String value) throws IOException {
        if (value.equals("low")) return LOW;
        if (value.equals("medium")) return MEDIUM;
        if (value.equals("high")) return HIGH;
        throw new IOException("Cannot deserialize Priority");
    }
}
