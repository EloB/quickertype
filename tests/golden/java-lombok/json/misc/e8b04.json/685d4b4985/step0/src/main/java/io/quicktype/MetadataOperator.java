package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum MetadataOperator {
    EQUALS, BLANK;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EQUALS: return "EQUALS";
            case BLANK: return "blank?";
        }
        return null;
    }

    @JsonCreator
    public static MetadataOperator forValue(String value) throws IOException {
        if (value.equals("EQUALS")) return EQUALS;
        if (value.equals("blank?")) return BLANK;
        throw new IOException("Cannot deserialize MetadataOperator");
    }
}
