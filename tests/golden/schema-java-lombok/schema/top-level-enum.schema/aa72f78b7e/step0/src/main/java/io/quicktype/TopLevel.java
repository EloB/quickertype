package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum TopLevel {
    ONE, THREE, TWO;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ONE: return "one";
            case THREE: return "three";
            case TWO: return "two";
        }
        return null;
    }

    @JsonCreator
    public static TopLevel forValue(String value) throws IOException {
        if (value.equals("one")) return ONE;
        if (value.equals("three")) return THREE;
        if (value.equals("two")) return TWO;
        throw new IOException("Cannot deserialize TopLevel");
    }
}
