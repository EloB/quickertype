package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Kind {
    T3;

    @JsonValue
    public String toValue() {
        switch (this) {
            case T3: return "t3";
        }
        return null;
    }

    @JsonCreator
    public static Kind forValue(String value) throws IOException {
        if (value.equals("t3")) return T3;
        throw new IOException("Cannot deserialize Kind");
    }
}
