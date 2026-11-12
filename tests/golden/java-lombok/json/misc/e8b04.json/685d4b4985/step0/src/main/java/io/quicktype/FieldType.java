package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum FieldType {
    COLUMN_LABEL, COLUMN_DATA;

    @JsonValue
    public String toValue() {
        switch (this) {
            case COLUMN_LABEL: return "columnLabel";
            case COLUMN_DATA: return "columnData";
        }
        return null;
    }

    @JsonCreator
    public static FieldType forValue(String value) throws IOException {
        if (value.equals("columnLabel")) return COLUMN_LABEL;
        if (value.equals("columnData")) return COLUMN_DATA;
        throw new IOException("Cannot deserialize FieldType");
    }
}
