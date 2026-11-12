package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Gve {
    GOOD, NEUTRAL, EVIL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case GOOD: return "good";
            case NEUTRAL: return "neutral";
            case EVIL: return "evil";
        }
        return null;
    }

    @JsonCreator
    public static Gve forValue(String value) throws IOException {
        if (value.equals("good")) return GOOD;
        if (value.equals("neutral")) return NEUTRAL;
        if (value.equals("evil")) return EVIL;
        throw new IOException("Cannot deserialize Gve");
    }
}
