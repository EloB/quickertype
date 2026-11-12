package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Status {
    INACTIVE, ACTIVE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case INACTIVE: return "inactive";
            case ACTIVE: return "active";
        }
        return null;
    }

    @JsonCreator
    public static Status forValue(String value) throws IOException {
        if (value.equals("inactive")) return INACTIVE;
        if (value.equals("active")) return ACTIVE;
        throw new IOException("Cannot deserialize Status");
    }
}
