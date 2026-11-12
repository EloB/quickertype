package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum PostHint {
    LINK, IMAGE, RICH_VIDEO;

    @JsonValue
    public String toValue() {
        switch (this) {
            case LINK: return "link";
            case IMAGE: return "image";
            case RICH_VIDEO: return "rich:video";
        }
        return null;
    }

    @JsonCreator
    public static PostHint forValue(String value) throws IOException {
        if (value.equals("link")) return LINK;
        if (value.equals("image")) return IMAGE;
        if (value.equals("rich:video")) return RICH_VIDEO;
        throw new IOException("Cannot deserialize PostHint");
    }
}
