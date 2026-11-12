package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum PropertiesType {
    BOAT_RAMP;

    @JsonValue
    public String toValue() {
        switch (this) {
            case BOAT_RAMP: return "Boat Ramp";
        }
        return null;
    }

    @JsonCreator
    public static PropertiesType forValue(String value) throws IOException {
        if (value.equals("Boat Ramp")) return BOAT_RAMP;
        throw new IOException("Cannot deserialize PropertiesType");
    }
}
