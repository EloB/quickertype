package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditType {
    RESTRICTED;

    @JsonValue
    public String toValue() {
        switch (this) {
            case RESTRICTED: return "restricted";
        }
        return null;
    }

    @JsonCreator
    public static SubredditType forValue(String value) throws IOException {
        if (value.equals("restricted")) return RESTRICTED;
        throw new IOException("Cannot deserialize SubredditType");
    }
}
