package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Note {
    OSI_PAGE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case OSI_PAGE: return "OSI Page";
        }
        return null;
    }

    @JsonCreator
    public static Note forValue(String value) throws IOException {
        if (value.equals("OSI Page")) return OSI_PAGE;
        throw new IOException("Cannot deserialize Note");
    }
}
