package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Type {
    USER, ORGANIZATION;

    @JsonValue
    public String toValue() {
        switch (this) {
            case USER: return "User";
            case ORGANIZATION: return "Organization";
        }
        return null;
    }

    @JsonCreator
    public static Type forValue(String value) throws IOException {
        if (value.equals("User")) return USER;
        if (value.equals("Organization")) return ORGANIZATION;
        throw new IOException("Cannot deserialize Type");
    }
}
