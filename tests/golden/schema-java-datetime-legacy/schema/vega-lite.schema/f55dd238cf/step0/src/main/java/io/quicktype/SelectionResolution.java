package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * With layered and multi-view displays, a strategy that determines how
 * selections' data queries are resolved when applied in a filter transform,
 * conditional encoding rule, or scale domain.
 */
public enum SelectionResolution {
    GLOBAL, UNION, INTERSECT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case GLOBAL: return "global";
            case UNION: return "union";
            case INTERSECT: return "intersect";
        }
        return null;
    }

    @JsonCreator
    public static SelectionResolution forValue(String value) throws IOException {
        if (value.equals("global")) return GLOBAL;
        if (value.equals("union")) return UNION;
        if (value.equals("intersect")) return INTERSECT;
        throw new IOException("Cannot deserialize SelectionResolution");
    }
}
