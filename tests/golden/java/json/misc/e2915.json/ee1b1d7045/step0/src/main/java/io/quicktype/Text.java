package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Text {
    SUNNY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SUNNY: return "Sunny";
        }
        return null;
    }

    @JsonCreator
    public static Text forValue(String value) throws IOException {
        if (value.equals("Sunny")) return SUNNY;
        throw new IOException("Cannot deserialize Text");
    }
}
