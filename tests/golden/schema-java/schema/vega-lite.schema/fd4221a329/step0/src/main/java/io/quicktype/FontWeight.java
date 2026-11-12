package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum FontWeight {
    NORMAL, BOLD;

    @JsonValue
    public String toValue() {
        switch (this) {
            case NORMAL: return "normal";
            case BOLD: return "bold";
        }
        return null;
    }

    @JsonCreator
    public static FontWeight forValue(String value) throws IOException {
        if (value.equals("normal")) return NORMAL;
        if (value.equals("bold")) return BOLD;
        throw new IOException("Cannot deserialize FontWeight");
    }
}
