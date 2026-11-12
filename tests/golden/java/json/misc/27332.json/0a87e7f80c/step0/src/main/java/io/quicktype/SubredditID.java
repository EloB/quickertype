package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditID {
    T5_2_QH0_U;

    @JsonValue
    public String toValue() {
        switch (this) {
            case T5_2_QH0_U: return "t5_2qh0u";
        }
        return null;
    }

    @JsonCreator
    public static SubredditID forValue(String value) throws IOException {
        if (value.equals("t5_2qh0u")) return T5_2_QH0_U;
        throw new IOException("Cannot deserialize SubredditID");
    }
}
