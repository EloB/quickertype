package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ColorIdentity {
    U, B, W, G, R;

    @JsonValue
    public String toValue() {
        switch (this) {
            case U: return "U";
            case B: return "B";
            case W: return "W";
            case G: return "G";
            case R: return "R";
        }
        return null;
    }

    @JsonCreator
    public static ColorIdentity forValue(String value) throws IOException {
        if (value.equals("U")) return U;
        if (value.equals("B")) return B;
        if (value.equals("W")) return W;
        if (value.equals("G")) return G;
        if (value.equals("R")) return R;
        throw new IOException("Cannot deserialize ColorIdentity");
    }
}
