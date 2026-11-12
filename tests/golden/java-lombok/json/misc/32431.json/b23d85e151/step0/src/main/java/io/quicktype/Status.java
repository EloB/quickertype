package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Status {
    AUTOMATIC, REVIEWED;

    @JsonValue
    public String toValue() {
        switch (this) {
            case AUTOMATIC: return "automatic";
            case REVIEWED: return "reviewed";
        }
        return null;
    }

    @JsonCreator
    public static Status forValue(String value) throws IOException {
        if (value.equals("automatic")) return AUTOMATIC;
        if (value.equals("reviewed")) return REVIEWED;
        throw new IOException("Cannot deserialize Status");
    }
}
