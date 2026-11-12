package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Kind {
    WIDGET;

    @JsonValue
    public String toValue() {
        switch (this) {
            case WIDGET: return "widget";
        }
        return null;
    }

    @JsonCreator
    public static Kind forValue(String value) throws IOException {
        if (value.equals("widget")) return WIDGET;
        throw new IOException("Cannot deserialize Kind");
    }
}
