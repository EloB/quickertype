package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum GrantType {
    VIEWER;

    @JsonValue
    public String toValue() {
        switch (this) {
            case VIEWER: return "viewer";
        }
        return null;
    }

    @JsonCreator
    public static GrantType forValue(String value) throws IOException {
        if (value.equals("viewer")) return VIEWER;
        throw new IOException("Cannot deserialize GrantType");
    }
}
