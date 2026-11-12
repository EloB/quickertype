package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Status {
    ACTIVE, INACTIVE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ACTIVE: return "active";
            case INACTIVE: return "inactive";
        }
        return null;
    }

    @JsonCreator
    public static Status forValue(String value) throws IOException {
        if (value.equals("active")) return ACTIVE;
        if (value.equals("inactive")) return INACTIVE;
        throw new IOException("Cannot deserialize Status");
    }
}
