package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditNamePrefixed {
    R_ANNOUNCEMENTS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case R_ANNOUNCEMENTS: return "r/announcements";
        }
        return null;
    }

    @JsonCreator
    public static SubredditNamePrefixed forValue(String value) throws IOException {
        if (value.equals("r/announcements")) return R_ANNOUNCEMENTS;
        throw new IOException("Cannot deserialize SubredditNamePrefixed");
    }
}
