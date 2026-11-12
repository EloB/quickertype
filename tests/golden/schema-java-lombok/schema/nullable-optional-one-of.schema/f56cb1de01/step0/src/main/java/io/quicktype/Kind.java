package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Kind {
    ONE, TWO;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ONE: return "one";
            case TWO: return "two";
        }
        return null;
    }

    @JsonCreator
    public static Kind forValue(String value) throws IOException {
        if (value.equals("one")) return ONE;
        if (value.equals("two")) return TWO;
        throw new IOException("Cannot deserialize Kind");
    }
}
