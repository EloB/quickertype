package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Party {
    REPUBLICAN, DEMOCRAT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case REPUBLICAN: return "Republican";
            case DEMOCRAT: return "Democrat";
        }
        return null;
    }

    @JsonCreator
    public static Party forValue(String value) throws IOException {
        if (value.equals("Republican")) return REPUBLICAN;
        if (value.equals("Democrat")) return DEMOCRAT;
        throw new IOException("Cannot deserialize Party");
    }
}
