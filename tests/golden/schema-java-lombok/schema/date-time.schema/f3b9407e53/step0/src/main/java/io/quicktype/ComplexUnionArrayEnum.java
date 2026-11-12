package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ComplexUnionArrayEnum {
    FOO, BAR;

    @JsonValue
    public String toValue() {
        switch (this) {
            case FOO: return "foo";
            case BAR: return "bar";
        }
        return null;
    }

    @JsonCreator
    public static ComplexUnionArrayEnum forValue(String value) throws IOException {
        if (value.equals("foo")) return FOO;
        if (value.equals("bar")) return BAR;
        throw new IOException("Cannot deserialize ComplexUnionArrayEnum");
    }
}
