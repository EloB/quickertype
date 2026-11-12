package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * Default stack offset for stackable mark.
 */
public enum StackOffset {
    ZERO, CENTER, NORMALIZE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ZERO: return "zero";
            case CENTER: return "center";
            case NORMALIZE: return "normalize";
        }
        return null;
    }

    @JsonCreator
    public static StackOffset forValue(String value) throws IOException {
        if (value.equals("zero")) return ZERO;
        if (value.equals("center")) return CENTER;
        if (value.equals("normalize")) return NORMALIZE;
        throw new IOException("Cannot deserialize StackOffset");
    }
}
