package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Tel {
    EMPTY, THE_022688899;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case THE_022688899: return "02-268-8899";
        }
        return null;
    }

    @JsonCreator
    public static Tel forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("02-268-8899")) return THE_022688899;
        throw new IOException("Cannot deserialize Tel");
    }
}
