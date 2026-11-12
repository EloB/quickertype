package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditID {
    T5_2_QH13;

    @JsonValue
    public String toValue() {
        switch (this) {
            case T5_2_QH13: return "t5_2qh13";
        }
        return null;
    }

    @JsonCreator
    public static SubredditID forValue(String value) throws IOException {
        if (value.equals("t5_2qh13")) return T5_2_QH13;
        throw new IOException("Cannot deserialize SubredditID");
    }
}
