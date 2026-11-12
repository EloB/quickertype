package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * The orientation of a non-stacked bar, tick, area, and line charts.
 * The value is either horizontal (default) or vertical.
 * - For bar, rule and tick, this determines whether the size of the bar and tick
 * should be applied to x or y dimension.
 * - For area, this property determines the orient property of the Vega output.
 * - For line, this property determines the sort order of the points in the line
 * if `config.sortLineBy` is not specified.
 * For stacked charts, this is always determined by the orientation of the stack;
 * therefore explicitly specified value will be ignored.
 */
public enum Orient {
    HORIZONTAL, VERTICAL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case HORIZONTAL: return "horizontal";
            case VERTICAL: return "vertical";
        }
        return null;
    }

    @JsonCreator
    public static Orient forValue(String value) throws IOException {
        if (value.equals("horizontal")) return HORIZONTAL;
        if (value.equals("vertical")) return VERTICAL;
        throw new IOException("Cannot deserialize Orient");
    }
}
