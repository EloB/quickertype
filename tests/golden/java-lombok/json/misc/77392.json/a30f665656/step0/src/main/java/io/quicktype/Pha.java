package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Pha {
    Y, N, N_A;

    @JsonValue
    public String toValue() {
        switch (this) {
            case Y: return "Y";
            case N: return "N";
            case N_A: return "n/a";
        }
        return null;
    }

    @JsonCreator
    public static Pha forValue(String value) throws IOException {
        if (value.equals("Y")) return Y;
        if (value.equals("N")) return N;
        if (value.equals("n/a")) return N_A;
        throw new IOException("Cannot deserialize Pha");
    }
}
