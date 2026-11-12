package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum TypeName {
    META_DATA, CALENDAR_DATE, TEXT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case META_DATA: return "meta_data";
            case CALENDAR_DATE: return "calendar_date";
            case TEXT: return "text";
        }
        return null;
    }

    @JsonCreator
    public static TypeName forValue(String value) throws IOException {
        if (value.equals("meta_data")) return META_DATA;
        if (value.equals("calendar_date")) return CALENDAR_DATE;
        if (value.equals("text")) return TEXT;
        throw new IOException("Cannot deserialize TypeName");
    }
}
