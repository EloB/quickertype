package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Username {
    EMPTY, THEDAILYSHOW, STUDIOSORIGINALS, DISNEYZOOTOPIA;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case THEDAILYSHOW: return "thedailyshow";
            case STUDIOSORIGINALS: return "studiosoriginals";
            case DISNEYZOOTOPIA: return "disneyzootopia";
        }
        return null;
    }

    @JsonCreator
    public static Username forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("thedailyshow")) return THEDAILYSHOW;
        if (value.equals("studiosoriginals")) return STUDIOSORIGINALS;
        if (value.equals("disneyzootopia")) return DISNEYZOOTOPIA;
        throw new IOException("Cannot deserialize Username");
    }
}
