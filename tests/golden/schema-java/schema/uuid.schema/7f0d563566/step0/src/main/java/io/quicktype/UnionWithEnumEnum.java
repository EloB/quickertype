package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum UnionWithEnumEnum {
    FOO;

    @JsonValue
    public String toValue() {
        switch (this) {
            case FOO: return "foo";
        }
        return null;
    }

    @JsonCreator
    public static UnionWithEnumEnum forValue(String value) throws IOException {
        if (value.equals("foo")) return FOO;
        throw new IOException("Cannot deserialize UnionWithEnumEnum");
    }
}
