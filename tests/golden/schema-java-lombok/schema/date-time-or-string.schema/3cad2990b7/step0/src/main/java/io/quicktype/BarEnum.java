package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum BarEnum {
    QUUX;

    @JsonValue
    public String toValue() {
        switch (this) {
            case QUUX: return "quux";
        }
        return null;
    }

    @JsonCreator
    public static BarEnum forValue(String value) throws IOException {
        if (value.equals("quux")) return QUUX;
        throw new IOException("Cannot deserialize BarEnum");
    }
}
