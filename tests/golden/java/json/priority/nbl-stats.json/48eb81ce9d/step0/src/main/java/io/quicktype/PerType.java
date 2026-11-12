package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum PerType {
    REGULAR;

    @JsonValue
    public String toValue() {
        switch (this) {
            case REGULAR: return "REGULAR";
        }
        return null;
    }

    @JsonCreator
    public static PerType forValue(String value) throws IOException {
        if (value.equals("REGULAR")) return REGULAR;
        throw new IOException("Cannot deserialize PerType");
    }
}
