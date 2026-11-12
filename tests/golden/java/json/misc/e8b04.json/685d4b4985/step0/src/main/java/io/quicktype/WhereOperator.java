package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum WhereOperator {
    EQUALS, AND;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EQUALS: return "EQUALS";
            case AND: return "AND";
        }
        return null;
    }

    @JsonCreator
    public static WhereOperator forValue(String value) throws IOException {
        if (value.equals("EQUALS")) return EQUALS;
        if (value.equals("AND")) return AND;
        throw new IOException("Cannot deserialize WhereOperator");
    }
}
