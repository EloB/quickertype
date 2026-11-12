package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum GeometryType {
    POINT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case POINT: return "Point";
        }
        return null;
    }

    @JsonCreator
    public static GeometryType forValue(String value) throws IOException {
        if (value.equals("Point")) return POINT;
        throw new IOException("Cannot deserialize GeometryType");
    }
}
