package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum RoleName {
    ADMINISTRATOR, PUBLISHER;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ADMINISTRATOR: return "administrator";
            case PUBLISHER: return "publisher";
        }
        return null;
    }

    @JsonCreator
    public static RoleName forValue(String value) throws IOException {
        if (value.equals("administrator")) return ADMINISTRATOR;
        if (value.equals("publisher")) return PUBLISHER;
        throw new IOException("Cannot deserialize RoleName");
    }
}
