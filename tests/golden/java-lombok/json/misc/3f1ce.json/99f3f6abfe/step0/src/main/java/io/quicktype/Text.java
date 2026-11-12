package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Text {
    THUNDERSTORMS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case THUNDERSTORMS: return "Thunderstorms";
        }
        return null;
    }

    @JsonCreator
    public static Text forValue(String value) throws IOException {
        if (value.equals("Thunderstorms")) return THUNDERSTORMS;
        throw new IOException("Cannot deserialize Text");
    }
}
