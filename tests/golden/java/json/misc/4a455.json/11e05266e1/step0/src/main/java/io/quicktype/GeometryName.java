package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum GeometryName {
    GEOM;

    @JsonValue
    public String toValue() {
        switch (this) {
            case GEOM: return "geom";
        }
        return null;
    }

    @JsonCreator
    public static GeometryName forValue(String value) throws IOException {
        if (value.equals("geom")) return GEOM;
        throw new IOException("Cannot deserialize GeometryName");
    }
}
