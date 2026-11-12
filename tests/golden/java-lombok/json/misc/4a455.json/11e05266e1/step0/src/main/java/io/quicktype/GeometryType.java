package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum GeometryType {
    MULTI_POINT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case MULTI_POINT: return "MultiPoint";
        }
        return null;
    }

    @JsonCreator
    public static GeometryType forValue(String value) throws IOException {
        if (value.equals("MultiPoint")) return MULTI_POINT;
        throw new IOException("Cannot deserialize GeometryType");
    }
}
