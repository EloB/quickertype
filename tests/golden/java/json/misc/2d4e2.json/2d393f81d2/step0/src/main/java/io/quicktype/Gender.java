package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Gender {
    MALE, FEMALE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case MALE: return "male";
            case FEMALE: return "female";
        }
        return null;
    }

    @JsonCreator
    public static Gender forValue(String value) throws IOException {
        if (value.equals("male")) return MALE;
        if (value.equals("female")) return FEMALE;
        throw new IOException("Cannot deserialize Gender");
    }
}
