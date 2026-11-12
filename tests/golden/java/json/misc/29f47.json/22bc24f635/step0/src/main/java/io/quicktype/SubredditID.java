package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubredditID {
    T5_2_R0_IJ;

    @JsonValue
    public String toValue() {
        switch (this) {
            case T5_2_R0_IJ: return "t5_2r0ij";
        }
        return null;
    }

    @JsonCreator
    public static SubredditID forValue(String value) throws IOException {
        if (value.equals("t5_2r0ij")) return T5_2_R0_IJ;
        throw new IOException("Cannot deserialize SubredditID");
    }
}
