package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * Default title orientation ("top", "bottom", "left", or "right")
 *
 * The orientation of the title relative to the chart. One of `"top"` (the default),
 * `"bottom"`, `"left"`, or `"right"`.
 *
 * The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
 * orientation can be used to further specialize the axis type (e.g., a y axis oriented for
 * the right edge of the chart).
 *
 * __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
 */
public enum TitleOrient {
    TOP, BOTTOM, LEFT, RIGHT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case TOP: return "top";
            case BOTTOM: return "bottom";
            case LEFT: return "left";
            case RIGHT: return "right";
        }
        return null;
    }

    @JsonCreator
    public static TitleOrient forValue(String value) throws IOException {
        if (value.equals("top")) return TOP;
        if (value.equals("bottom")) return BOTTOM;
        if (value.equals("left")) return LEFT;
        if (value.equals("right")) return RIGHT;
        throw new IOException("Cannot deserialize TitleOrient");
    }
}
