package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Subreddit {
    TODAYILEARNED;

    @JsonValue
    public String toValue() {
        switch (this) {
            case TODAYILEARNED: return "todayilearned";
        }
        return null;
    }

    @JsonCreator
    public static Subreddit forValue(String value) throws IOException {
        if (value.equals("todayilearned")) return TODAYILEARNED;
        throw new IOException("Cannot deserialize Subreddit");
    }
}
