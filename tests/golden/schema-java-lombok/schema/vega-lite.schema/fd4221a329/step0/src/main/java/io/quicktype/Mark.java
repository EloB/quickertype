package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * All types of primitive marks.
 *
 * The mark type.
 * One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
 * `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
 */
public enum Mark {
    AREA, BAR, LINE, POINT, TEXT, TICK, RECT, RULE, CIRCLE, SQUARE, GEOSHAPE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case AREA: return "area";
            case BAR: return "bar";
            case LINE: return "line";
            case POINT: return "point";
            case TEXT: return "text";
            case TICK: return "tick";
            case RECT: return "rect";
            case RULE: return "rule";
            case CIRCLE: return "circle";
            case SQUARE: return "square";
            case GEOSHAPE: return "geoshape";
        }
        return null;
    }

    @JsonCreator
    public static Mark forValue(String value) throws IOException {
        if (value.equals("area")) return AREA;
        if (value.equals("bar")) return BAR;
        if (value.equals("line")) return LINE;
        if (value.equals("point")) return POINT;
        if (value.equals("text")) return TEXT;
        if (value.equals("tick")) return TICK;
        if (value.equals("rect")) return RECT;
        if (value.equals("rule")) return RULE;
        if (value.equals("circle")) return CIRCLE;
        if (value.equals("square")) return SQUARE;
        if (value.equals("geoshape")) return GEOSHAPE;
        throw new IOException("Cannot deserialize Mark");
    }
}
