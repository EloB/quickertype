package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Subreddit {
    PICS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PICS: return "pics";
        }
        return null;
    }

    @JsonCreator
    public static Subreddit forValue(String value) throws IOException {
        if (value.equals("pics")) return PICS;
        throw new IOException("Cannot deserialize Subreddit");
    }
}
