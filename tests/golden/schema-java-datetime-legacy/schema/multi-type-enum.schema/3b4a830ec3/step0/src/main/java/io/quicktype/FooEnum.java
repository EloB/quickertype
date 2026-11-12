package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum FooEnum {
    A, B, C;

    @JsonValue
    public String toValue() {
        switch (this) {
            case A: return "a";
            case B: return "b";
            case C: return "c";
        }
        return null;
    }

    @JsonCreator
    public static FooEnum forValue(String value) throws IOException {
        if (value.equals("a")) return A;
        if (value.equals("b")) return B;
        if (value.equals("c")) return C;
        throw new IOException("Cannot deserialize FooEnum");
    }
}
