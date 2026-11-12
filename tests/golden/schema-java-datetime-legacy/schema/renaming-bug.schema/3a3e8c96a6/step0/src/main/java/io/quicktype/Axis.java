package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Axis {
    X, Y, Z, XY, YZ, ZX;

    @JsonValue
    public String toValue() {
        switch (this) {
            case X: return "X";
            case Y: return "Y";
            case Z: return "Z";
            case XY: return "XY";
            case YZ: return "YZ";
            case ZX: return "ZX";
        }
        return null;
    }

    @JsonCreator
    public static Axis forValue(String value) throws IOException {
        if (value.equals("X")) return X;
        if (value.equals("Y")) return Y;
        if (value.equals("Z")) return Z;
        if (value.equals("XY")) return XY;
        if (value.equals("YZ")) return YZ;
        if (value.equals("ZX")) return ZX;
        throw new IOException("Cannot deserialize Axis");
    }
}
