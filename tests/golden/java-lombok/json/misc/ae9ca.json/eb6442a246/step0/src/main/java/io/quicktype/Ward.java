package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Ward {
    SOUTH, NORTH, CENTRAL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SOUTH: return "South";
            case NORTH: return "North";
            case CENTRAL: return "Central";
        }
        return null;
    }

    @JsonCreator
    public static Ward forValue(String value) throws IOException {
        if (value.equals("South")) return SOUTH;
        if (value.equals("North")) return NORTH;
        if (value.equals("Central")) return CENTRAL;
        throw new IOException("Cannot deserialize Ward");
    }
}
