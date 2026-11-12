package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ChildOperator {
    EQUALS, IS_NOT_BLANK;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EQUALS: return "EQUALS";
            case IS_NOT_BLANK: return "IS_NOT_BLANK";
        }
        return null;
    }

    @JsonCreator
    public static ChildOperator forValue(String value) throws IOException {
        if (value.equals("EQUALS")) return EQUALS;
        if (value.equals("IS_NOT_BLANK")) return IS_NOT_BLANK;
        throw new IOException("Cannot deserialize ChildOperator");
    }
}
