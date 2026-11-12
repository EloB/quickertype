package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
 *
 * __Default value:__ `"middle"`
 *
 * Vertical text baseline for title text.
 */
public enum VerticalAlign {
    TOP, MIDDLE, BOTTOM;

    @JsonValue
    public String toValue() {
        switch (this) {
            case TOP: return "top";
            case MIDDLE: return "middle";
            case BOTTOM: return "bottom";
        }
        return null;
    }

    @JsonCreator
    public static VerticalAlign forValue(String value) throws IOException {
        if (value.equals("top")) return TOP;
        if (value.equals("middle")) return MIDDLE;
        if (value.equals("bottom")) return BOTTOM;
        throw new IOException("Cannot deserialize VerticalAlign");
    }
}
