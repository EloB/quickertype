package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Subreddit {
    ASK_REDDIT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ASK_REDDIT: return "AskReddit";
        }
        return null;
    }

    @JsonCreator
    public static Subreddit forValue(String value) throws IOException {
        if (value.equals("AskReddit")) return ASK_REDDIT;
        throw new IOException("Cannot deserialize Subreddit");
    }
}
