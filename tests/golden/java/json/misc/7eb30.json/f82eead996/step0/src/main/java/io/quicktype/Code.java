package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Code {
    SF;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SF: return "sf";
        }
        return null;
    }

    @JsonCreator
    public static Code forValue(String value) throws IOException {
        if (value.equals("sf")) return SF;
        throw new IOException("Cannot deserialize Code");
    }
}
