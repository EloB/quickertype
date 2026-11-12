package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditID {
    T5_2_QH1_I;

    @JsonValue
    public String toValue() {
        switch (this) {
            case T5_2_QH1_I: return "t5_2qh1i";
        }
        return null;
    }

    @JsonCreator
    public static SubredditID forValue(String value) throws IOException {
        if (value.equals("t5_2qh1i")) return T5_2_QH1_I;
        throw new IOException("Cannot deserialize SubredditID");
    }
}
