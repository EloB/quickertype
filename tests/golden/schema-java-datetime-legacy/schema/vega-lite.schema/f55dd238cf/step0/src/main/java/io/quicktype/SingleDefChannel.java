package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SingleDefChannel {
    X, Y, X2, Y2, ROW, COLUMN, SIZE, SHAPE, COLOR, OPACITY, TEXT, TOOLTIP, HREF;

    @JsonValue
    public String toValue() {
        switch (this) {
            case X: return "x";
            case Y: return "y";
            case X2: return "x2";
            case Y2: return "y2";
            case ROW: return "row";
            case COLUMN: return "column";
            case SIZE: return "size";
            case SHAPE: return "shape";
            case COLOR: return "color";
            case OPACITY: return "opacity";
            case TEXT: return "text";
            case TOOLTIP: return "tooltip";
            case HREF: return "href";
        }
        return null;
    }

    @JsonCreator
    public static SingleDefChannel forValue(String value) throws IOException {
        if (value.equals("x")) return X;
        if (value.equals("y")) return Y;
        if (value.equals("x2")) return X2;
        if (value.equals("y2")) return Y2;
        if (value.equals("row")) return ROW;
        if (value.equals("column")) return COLUMN;
        if (value.equals("size")) return SIZE;
        if (value.equals("shape")) return SHAPE;
        if (value.equals("color")) return COLOR;
        if (value.equals("opacity")) return OPACITY;
        if (value.equals("text")) return TEXT;
        if (value.equals("tooltip")) return TOOLTIP;
        if (value.equals("href")) return HREF;
        throw new IOException("Cannot deserialize SingleDefChannel");
    }
}
