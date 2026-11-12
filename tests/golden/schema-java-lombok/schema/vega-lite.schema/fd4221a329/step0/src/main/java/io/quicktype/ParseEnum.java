package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ParseEnum {
    AUTO;

    @JsonValue
    public String toValue() {
        switch (this) {
            case AUTO: return "auto";
        }
        return null;
    }

    @JsonCreator
    public static ParseEnum forValue(String value) throws IOException {
        if (value.equals("auto")) return AUTO;
        throw new IOException("Cannot deserialize ParseEnum");
    }
}
