package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Enum {
    FIRE, GRASS, BLUE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case FIRE: return "red";
            case GRASS: return "green";
            case BLUE: return "blue";
        }
        return null;
    }

    @JsonCreator
    public static Enum forValue(String value) throws IOException {
        if (value.equals("red")) return FIRE;
        if (value.equals("green")) return GRASS;
        if (value.equals("blue")) return BLUE;
        throw new IOException("Cannot deserialize Enum");
    }
}
