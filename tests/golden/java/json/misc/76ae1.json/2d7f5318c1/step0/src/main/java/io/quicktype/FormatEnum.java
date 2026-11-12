package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum FormatEnum {
    STRING;

    @JsonValue
    public String toValue() {
        switch (this) {
            case STRING: return "string";
        }
        return null;
    }

    @JsonCreator
    public static FormatEnum forValue(String value) throws IOException {
        if (value.equals("string")) return STRING;
        throw new IOException("Cannot deserialize FormatEnum");
    }
}
