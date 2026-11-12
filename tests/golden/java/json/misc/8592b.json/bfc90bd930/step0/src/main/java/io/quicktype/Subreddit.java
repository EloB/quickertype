package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Subreddit {
    SCIENCE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SCIENCE: return "science";
        }
        return null;
    }

    @JsonCreator
    public static Subreddit forValue(String value) throws IOException {
        if (value.equals("science")) return SCIENCE;
        throw new IOException("Cannot deserialize Subreddit");
    }
}
