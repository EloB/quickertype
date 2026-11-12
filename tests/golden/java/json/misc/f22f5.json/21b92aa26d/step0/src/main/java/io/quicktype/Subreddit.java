package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Subreddit {
    WORLDNEWS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case WORLDNEWS: return "worldnews";
        }
        return null;
    }

    @JsonCreator
    public static Subreddit forValue(String value) throws IOException {
        if (value.equals("worldnews")) return WORLDNEWS;
        throw new IOException("Cannot deserialize Subreddit");
    }
}
