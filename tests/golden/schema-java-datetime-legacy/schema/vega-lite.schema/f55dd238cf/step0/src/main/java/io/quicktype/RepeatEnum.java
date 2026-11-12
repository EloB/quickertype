package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum RepeatEnum {
    ROW, COLUMN;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ROW: return "row";
            case COLUMN: return "column";
        }
        return null;
    }

    @JsonCreator
    public static RepeatEnum forValue(String value) throws IOException {
        if (value.equals("row")) return ROW;
        if (value.equals("column")) return COLUMN;
        throw new IOException("Cannot deserialize RepeatEnum");
    }
}
