package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Category {
    EMPTY, CATEGORY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return " ";
            case CATEGORY: return "";
        }
        return null;
    }

    @JsonCreator
    public static Category forValue(String value) throws IOException {
        if (value.equals(" ")) return EMPTY;
        if (value.equals("")) return CATEGORY;
        throw new IOException("Cannot deserialize Category");
    }
}
