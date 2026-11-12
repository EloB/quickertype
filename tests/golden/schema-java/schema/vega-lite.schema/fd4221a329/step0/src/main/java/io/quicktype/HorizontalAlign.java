package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
 */
public enum HorizontalAlign {
    LEFT, RIGHT, CENTER;

    @JsonValue
    public String toValue() {
        switch (this) {
            case LEFT: return "left";
            case RIGHT: return "right";
            case CENTER: return "center";
        }
        return null;
    }

    @JsonCreator
    public static HorizontalAlign forValue(String value) throws IOException {
        if (value.equals("left")) return LEFT;
        if (value.equals("right")) return RIGHT;
        if (value.equals("center")) return CENTER;
        throw new IOException("Cannot deserialize HorizontalAlign");
    }
}
