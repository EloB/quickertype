package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditNamePrefixed {
    R_ASK_REDDIT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case R_ASK_REDDIT: return "r/AskReddit";
        }
        return null;
    }

    @JsonCreator
    public static SubredditNamePrefixed forValue(String value) throws IOException {
        if (value.equals("r/AskReddit")) return R_ASK_REDDIT;
        throw new IOException("Cannot deserialize SubredditNamePrefixed");
    }
}
