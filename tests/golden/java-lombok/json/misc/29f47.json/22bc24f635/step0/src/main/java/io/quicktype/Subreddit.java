package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Subreddit {
    ANNOUNCEMENTS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ANNOUNCEMENTS: return "announcements";
        }
        return null;
    }

    @JsonCreator
    public static Subreddit forValue(String value) throws IOException {
        if (value.equals("announcements")) return ANNOUNCEMENTS;
        throw new IOException("Cannot deserialize Subreddit");
    }
}
