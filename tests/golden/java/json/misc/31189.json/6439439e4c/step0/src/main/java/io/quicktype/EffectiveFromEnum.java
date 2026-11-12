package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum EffectiveFromEnum {
    THE_00000101;

    @JsonValue
    public String toValue() {
        switch (this) {
            case THE_00000101: return "0000-01-01";
        }
        return null;
    }

    @JsonCreator
    public static EffectiveFromEnum forValue(String value) throws IOException {
        if (value.equals("0000-01-01")) return THE_00000101;
        throw new IOException("Cannot deserialize EffectiveFromEnum");
    }
}
