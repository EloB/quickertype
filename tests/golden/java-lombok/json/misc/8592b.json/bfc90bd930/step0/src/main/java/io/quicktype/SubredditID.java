package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditID {
    T5_MOUW;

    @JsonValue
    public String toValue() {
        switch (this) {
            case T5_MOUW: return "t5_mouw";
        }
        return null;
    }

    @JsonCreator
    public static SubredditID forValue(String value) throws IOException {
        if (value.equals("t5_mouw")) return T5_MOUW;
        throw new IOException("Cannot deserialize SubredditID");
    }
}
