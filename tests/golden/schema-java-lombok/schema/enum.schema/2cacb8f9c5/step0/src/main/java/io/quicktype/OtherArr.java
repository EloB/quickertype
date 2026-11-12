package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum OtherArr {
    FOO, BAR, IF;

    @JsonValue
    public String toValue() {
        switch (this) {
            case FOO: return "foo";
            case BAR: return "bar";
            case IF: return "if";
        }
        return null;
    }

    @JsonCreator
    public static OtherArr forValue(String value) throws IOException {
        if (value.equals("foo")) return FOO;
        if (value.equals("bar")) return BAR;
        if (value.equals("if")) return IF;
        throw new IOException("Cannot deserialize OtherArr");
    }
}
