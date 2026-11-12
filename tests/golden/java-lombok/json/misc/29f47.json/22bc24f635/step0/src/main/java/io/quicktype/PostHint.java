package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum PostHint {
    SELF, IMAGE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SELF: return "self";
            case IMAGE: return "image";
        }
        return null;
    }

    @JsonCreator
    public static PostHint forValue(String value) throws IOException {
        if (value.equals("self")) return SELF;
        if (value.equals("image")) return IMAGE;
        throw new IOException("Cannot deserialize PostHint");
    }
}
