package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum CustomIncomeType {
    PUBLIC, OTHER;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PUBLIC: return "public";
            case OTHER: return "other";
        }
        return null;
    }

    @JsonCreator
    public static CustomIncomeType forValue(String value) throws IOException {
        if (value.equals("public")) return PUBLIC;
        if (value.equals("other")) return OTHER;
        throw new IOException("Cannot deserialize CustomIncomeType");
    }
}
