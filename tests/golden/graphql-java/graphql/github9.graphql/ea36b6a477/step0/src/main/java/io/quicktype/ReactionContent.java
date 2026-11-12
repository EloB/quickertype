package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ReactionContent {
    THUMBS_UP, THUMBS_DOWN, LAUGH, HOORAY, CONFUSED, HEART;

    @JsonValue
    public String toValue() {
        switch (this) {
            case THUMBS_UP: return "THUMBS_UP";
            case THUMBS_DOWN: return "THUMBS_DOWN";
            case LAUGH: return "LAUGH";
            case HOORAY: return "HOORAY";
            case CONFUSED: return "CONFUSED";
            case HEART: return "HEART";
        }
        return null;
    }

    @JsonCreator
    public static ReactionContent forValue(String value) throws IOException {
        if (value.equals("THUMBS_UP")) return THUMBS_UP;
        if (value.equals("THUMBS_DOWN")) return THUMBS_DOWN;
        if (value.equals("LAUGH")) return LAUGH;
        if (value.equals("HOORAY")) return HOORAY;
        if (value.equals("CONFUSED")) return CONFUSED;
        if (value.equals("HEART")) return HEART;
        throw new IOException("Cannot deserialize ReactionContent");
    }
}
