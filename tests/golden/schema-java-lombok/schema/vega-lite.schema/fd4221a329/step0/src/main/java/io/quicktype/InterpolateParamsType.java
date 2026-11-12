package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum InterpolateParamsType {
    RGB, CUBEHELIX, CUBEHELIX_LONG;

    @JsonValue
    public String toValue() {
        switch (this) {
            case RGB: return "rgb";
            case CUBEHELIX: return "cubehelix";
            case CUBEHELIX_LONG: return "cubehelix-long";
        }
        return null;
    }

    @JsonCreator
    public static InterpolateParamsType forValue(String value) throws IOException {
        if (value.equals("rgb")) return RGB;
        if (value.equals("cubehelix")) return CUBEHELIX;
        if (value.equals("cubehelix-long")) return CUBEHELIX_LONG;
        throw new IOException("Cannot deserialize InterpolateParamsType");
    }
}
