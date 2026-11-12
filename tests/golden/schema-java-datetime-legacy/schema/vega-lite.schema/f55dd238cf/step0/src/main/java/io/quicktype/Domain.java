package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Domain {
    UNAGGREGATED;

    @JsonValue
    public String toValue() {
        switch (this) {
            case UNAGGREGATED: return "unaggregated";
        }
        return null;
    }

    @JsonCreator
    public static Domain forValue(String value) throws IOException {
        if (value.equals("unaggregated")) return UNAGGREGATED;
        throw new IOException("Cannot deserialize Domain");
    }
}
