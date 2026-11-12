package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum PostHint {
    RICH_VIDEO, LINK;

    @JsonValue
    public String toValue() {
        switch (this) {
            case RICH_VIDEO: return "rich:video";
            case LINK: return "link";
        }
        return null;
    }

    @JsonCreator
    public static PostHint forValue(String value) throws IOException {
        if (value.equals("rich:video")) return RICH_VIDEO;
        if (value.equals("link")) return LINK;
        throw new IOException("Cannot deserialize PostHint");
    }
}
