package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Username {
    EMPTY, DISNEYPIXAR;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case DISNEYPIXAR: return "disneypixar";
        }
        return null;
    }

    @JsonCreator
    public static Username forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("disneypixar")) return DISNEYPIXAR;
        throw new IOException("Cannot deserialize Username");
    }
}
