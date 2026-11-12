package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum PropertiesType {
    EARTHQUAKE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EARTHQUAKE: return "earthquake";
        }
        return null;
    }

    @JsonCreator
    public static PropertiesType forValue(String value) throws IOException {
        if (value.equals("earthquake")) return EARTHQUAKE;
        throw new IOException("Cannot deserialize PropertiesType");
    }
}
