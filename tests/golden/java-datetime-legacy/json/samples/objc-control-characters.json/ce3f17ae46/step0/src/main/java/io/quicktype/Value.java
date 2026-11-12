package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Value {
    C0, C1;

    @JsonValue
    public String toValue() {
        switch (this) {
            case C0: return "c0";
            case C1: return "c1\u0080\u0085\u009f";
        }
        return null;
    }

    @JsonCreator
    public static Value forValue(String value) throws IOException {
        if (value.equals("c0")) return C0;
        if (value.equals("c1\u0080\u0085\u009f")) return C1;
        throw new IOException("Cannot deserialize Value");
    }
}
