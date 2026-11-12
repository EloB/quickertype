package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SchemaType {
    ARRAY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ARRAY: return "array";
        }
        return null;
    }

    @JsonCreator
    public static SchemaType forValue(String value) throws IOException {
        if (value.equals("array")) return ARRAY;
        throw new IOException("Cannot deserialize SchemaType");
    }
}
