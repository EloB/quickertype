package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Shortcut {
    HIDDEN, VISIBLE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case HIDDEN: return "hidden";
            case VISIBLE: return "visible";
        }
        return null;
    }

    @JsonCreator
    public static Shortcut forValue(String value) throws IOException {
        if (value.equals("hidden")) return HIDDEN;
        if (value.equals("visible")) return VISIBLE;
        throw new IOException("Cannot deserialize Shortcut");
    }
}
