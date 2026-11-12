package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ColorIdentity {
    W, R, B, G, U;

    @JsonValue
    public String toValue() {
        switch (this) {
            case W: return "W";
            case R: return "R";
            case B: return "B";
            case G: return "G";
            case U: return "U";
        }
        return null;
    }

    @JsonCreator
    public static ColorIdentity forValue(String value) throws IOException {
        if (value.equals("W")) return W;
        if (value.equals("R")) return R;
        if (value.equals("B")) return B;
        if (value.equals("G")) return G;
        if (value.equals("U")) return U;
        throw new IOException("Cannot deserialize ColorIdentity");
    }
}
