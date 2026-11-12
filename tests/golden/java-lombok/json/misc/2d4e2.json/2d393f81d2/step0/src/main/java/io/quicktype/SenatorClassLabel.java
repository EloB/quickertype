package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SenatorClassLabel {
    CLASS_2, CLASS_1, CLASS_3;

    @JsonValue
    public String toValue() {
        switch (this) {
            case CLASS_2: return "Class 2";
            case CLASS_1: return "Class 1";
            case CLASS_3: return "Class 3";
        }
        return null;
    }

    @JsonCreator
    public static SenatorClassLabel forValue(String value) throws IOException {
        if (value.equals("Class 2")) return CLASS_2;
        if (value.equals("Class 1")) return CLASS_1;
        if (value.equals("Class 3")) return CLASS_3;
        throw new IOException("Cannot deserialize SenatorClassLabel");
    }
}
