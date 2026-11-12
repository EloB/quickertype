package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Status {
    CURRENT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case CURRENT: return "CURRENT";
        }
        return null;
    }

    @JsonCreator
    public static Status forValue(String value) throws IOException {
        if (value.equals("CURRENT")) return CURRENT;
        throw new IOException("Cannot deserialize Status");
    }
}
