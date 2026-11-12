package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * The font style (e.g., `"italic"`).
 */
public enum FontStyle {
    NORMAL, ITALIC;

    @JsonValue
    public String toValue() {
        switch (this) {
            case NORMAL: return "normal";
            case ITALIC: return "italic";
        }
        return null;
    }

    @JsonCreator
    public static FontStyle forValue(String value) throws IOException {
        if (value.equals("normal")) return NORMAL;
        if (value.equals("italic")) return ITALIC;
        throw new IOException("Cannot deserialize FontStyle");
    }
}
