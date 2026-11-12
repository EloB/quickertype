package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditNamePrefixed {
    R_FUNNY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case R_FUNNY: return "r/funny";
        }
        return null;
    }

    @JsonCreator
    public static SubredditNamePrefixed forValue(String value) throws IOException {
        if (value.equals("r/funny")) return R_FUNNY;
        throw new IOException("Cannot deserialize SubredditNamePrefixed");
    }
}
