package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum X {
    THREE, ONE, TWO;

    @JsonValue
    public String toValue() {
        switch (this) {
            case THREE: return "three";
            case ONE: return "one";
            case TWO: return "two";
        }
        return null;
    }

    @JsonCreator
    public static X forValue(String value) throws IOException {
        if (value.equals("three")) return THREE;
        if (value.equals("one")) return ONE;
        if (value.equals("two")) return TWO;
        throw new IOException("Cannot deserialize X");
    }
}
