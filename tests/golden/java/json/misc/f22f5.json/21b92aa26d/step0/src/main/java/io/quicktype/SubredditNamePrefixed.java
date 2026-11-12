package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditNamePrefixed {
    R_WORLDNEWS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case R_WORLDNEWS: return "r/worldnews";
        }
        return null;
    }

    @JsonCreator
    public static SubredditNamePrefixed forValue(String value) throws IOException {
        if (value.equals("r/worldnews")) return R_WORLDNEWS;
        throw new IOException("Cannot deserialize SubredditNamePrefixed");
    }
}
