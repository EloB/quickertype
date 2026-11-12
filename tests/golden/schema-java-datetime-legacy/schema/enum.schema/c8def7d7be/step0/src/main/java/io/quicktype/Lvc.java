package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Lvc {
    LAWFUL, NEUTRAL, CHAOTIC;

    @JsonValue
    public String toValue() {
        switch (this) {
            case LAWFUL: return "lawful";
            case NEUTRAL: return "neutral";
            case CHAOTIC: return "chaotic";
        }
        return null;
    }

    @JsonCreator
    public static Lvc forValue(String value) throws IOException {
        if (value.equals("lawful")) return LAWFUL;
        if (value.equals("neutral")) return NEUTRAL;
        if (value.equals("chaotic")) return CHAOTIC;
        throw new IOException("Cannot deserialize Lvc");
    }
}
