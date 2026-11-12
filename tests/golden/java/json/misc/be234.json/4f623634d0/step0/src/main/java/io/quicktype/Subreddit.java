package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Subreddit {
    FUNNY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case FUNNY: return "funny";
        }
        return null;
    }

    @JsonCreator
    public static Subreddit forValue(String value) throws IOException {
        if (value.equals("funny")) return FUNNY;
        throw new IOException("Cannot deserialize Subreddit");
    }
}
