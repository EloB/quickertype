package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditNamePrefixed {
    R_TODAYILEARNED;

    @JsonValue
    public String toValue() {
        switch (this) {
            case R_TODAYILEARNED: return "r/todayilearned";
        }
        return null;
    }

    @JsonCreator
    public static SubredditNamePrefixed forValue(String value) throws IOException {
        if (value.equals("r/todayilearned")) return R_TODAYILEARNED;
        throw new IOException("Cannot deserialize SubredditNamePrefixed");
    }
}
