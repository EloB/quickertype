package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SelectionDefType {
    SINGLE, MULTI, INTERVAL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SINGLE: return "single";
            case MULTI: return "multi";
            case INTERVAL: return "interval";
        }
        return null;
    }

    @JsonCreator
    public static SelectionDefType forValue(String value) throws IOException {
        if (value.equals("single")) return SINGLE;
        if (value.equals("multi")) return MULTI;
        if (value.equals("interval")) return INTERVAL;
        throw new IOException("Cannot deserialize SelectionDefType");
    }
}
