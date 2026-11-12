package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum PostHint {
    LINK;

    @JsonValue
    public String toValue() {
        switch (this) {
            case LINK: return "link";
        }
        return null;
    }

    @JsonCreator
    public static PostHint forValue(String value) throws IOException {
        if (value.equals("link")) return LINK;
        throw new IOException("Cannot deserialize PostHint");
    }
}
