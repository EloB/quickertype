package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditNamePrefixed {
    R_PICS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case R_PICS: return "r/pics";
        }
        return null;
    }

    @JsonCreator
    public static SubredditNamePrefixed forValue(String value) throws IOException {
        if (value.equals("r/pics")) return R_PICS;
        throw new IOException("Cannot deserialize SubredditNamePrefixed");
    }
}
