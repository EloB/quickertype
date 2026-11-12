package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SortEnum {
    ASCENDING, DESCENDING;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ASCENDING: return "ascending";
            case DESCENDING: return "descending";
        }
        return null;
    }

    @JsonCreator
    public static SortEnum forValue(String value) throws IOException {
        if (value.equals("ascending")) return ASCENDING;
        if (value.equals("descending")) return DESCENDING;
        throw new IOException("Cannot deserialize SortEnum");
    }
}
