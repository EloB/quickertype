package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * The orientation of the legend, which determines how the legend is positioned within the
 * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
 * "none".
 *
 * __Default value:__ `"right"`
 */
public enum LegendOrient {
    LEFT, RIGHT, TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT, NONE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case LEFT: return "left";
            case RIGHT: return "right";
            case TOP_LEFT: return "top-left";
            case TOP_RIGHT: return "top-right";
            case BOTTOM_LEFT: return "bottom-left";
            case BOTTOM_RIGHT: return "bottom-right";
            case NONE: return "none";
        }
        return null;
    }

    @JsonCreator
    public static LegendOrient forValue(String value) throws IOException {
        if (value.equals("left")) return LEFT;
        if (value.equals("right")) return RIGHT;
        if (value.equals("top-left")) return TOP_LEFT;
        if (value.equals("top-right")) return TOP_RIGHT;
        if (value.equals("bottom-left")) return BOTTOM_LEFT;
        if (value.equals("bottom-right")) return BOTTOM_RIGHT;
        if (value.equals("none")) return NONE;
        throw new IOException("Cannot deserialize LegendOrient");
    }
}
