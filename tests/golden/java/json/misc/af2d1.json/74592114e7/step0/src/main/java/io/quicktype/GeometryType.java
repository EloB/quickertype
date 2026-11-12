package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum GeometryType {
    MULTI_POLYGON;

    @JsonValue
    public String toValue() {
        switch (this) {
            case MULTI_POLYGON: return "MultiPolygon";
        }
        return null;
    }

    @JsonCreator
    public static GeometryType forValue(String value) throws IOException {
        if (value.equals("MultiPolygon")) return MULTI_POLYGON;
        throw new IOException("Cannot deserialize GeometryType");
    }
}
