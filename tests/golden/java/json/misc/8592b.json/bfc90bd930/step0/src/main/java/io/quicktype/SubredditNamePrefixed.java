package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditNamePrefixed {
    R_SCIENCE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case R_SCIENCE: return "r/science";
        }
        return null;
    }

    @JsonCreator
    public static SubredditNamePrefixed forValue(String value) throws IOException {
        if (value.equals("r/science")) return R_SCIENCE;
        throw new IOException("Cannot deserialize SubredditNamePrefixed");
    }
}
