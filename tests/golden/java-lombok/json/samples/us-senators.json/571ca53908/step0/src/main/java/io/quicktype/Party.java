package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Party {
    DEMOCRAT, REPUBLICAN, INDEPENDENT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case DEMOCRAT: return "Democrat";
            case REPUBLICAN: return "Republican";
            case INDEPENDENT: return "Independent";
        }
        return null;
    }

    @JsonCreator
    public static Party forValue(String value) throws IOException {
        if (value.equals("Democrat")) return DEMOCRAT;
        if (value.equals("Republican")) return REPUBLICAN;
        if (value.equals("Independent")) return INDEPENDENT;
        throw new IOException("Cannot deserialize Party");
    }
}
