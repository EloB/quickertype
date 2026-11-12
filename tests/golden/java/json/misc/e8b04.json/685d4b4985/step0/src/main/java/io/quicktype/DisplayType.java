package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum DisplayType {
    TABLE, DATA_LENS, FATROW, PAGE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case TABLE: return "table";
            case DATA_LENS: return "data_lens";
            case FATROW: return "fatrow";
            case PAGE: return "page";
        }
        return null;
    }

    @JsonCreator
    public static DisplayType forValue(String value) throws IOException {
        if (value.equals("table")) return TABLE;
        if (value.equals("data_lens")) return DATA_LENS;
        if (value.equals("fatrow")) return FATROW;
        if (value.equals("page")) return PAGE;
        throw new IOException("Cannot deserialize DisplayType");
    }
}
