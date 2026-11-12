package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditID {
    T5_2_QQJC;

    @JsonValue
    public String toValue() {
        switch (this) {
            case T5_2_QQJC: return "t5_2qqjc";
        }
        return null;
    }

    @JsonCreator
    public static SubredditID forValue(String value) throws IOException {
        if (value.equals("t5_2qqjc")) return T5_2_QQJC;
        throw new IOException("Cannot deserialize SubredditID");
    }
}
