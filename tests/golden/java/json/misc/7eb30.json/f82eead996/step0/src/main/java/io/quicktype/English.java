package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum English {
    SF;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SF: return "SF";
        }
        return null;
    }

    @JsonCreator
    public static English forValue(String value) throws IOException {
        if (value.equals("SF")) return SF;
        throw new IOException("Cannot deserialize English");
    }
}
