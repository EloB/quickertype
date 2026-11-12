package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SenatorClass {
    CLASS2, CLASS1, CLASS3;

    @JsonValue
    public String toValue() {
        switch (this) {
            case CLASS2: return "class2";
            case CLASS1: return "class1";
            case CLASS3: return "class3";
        }
        return null;
    }

    @JsonCreator
    public static SenatorClass forValue(String value) throws IOException {
        if (value.equals("class2")) return CLASS2;
        if (value.equals("class1")) return CLASS1;
        if (value.equals("class3")) return CLASS3;
        throw new IOException("Cannot deserialize SenatorClass");
    }
}
