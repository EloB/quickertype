package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Gender {
    FEMALE, MALE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case FEMALE: return "female";
            case MALE: return "male";
        }
        return null;
    }

    @JsonCreator
    public static Gender forValue(String value) throws IOException {
        if (value.equals("female")) return FEMALE;
        if (value.equals("male")) return MALE;
        throw new IOException("Cannot deserialize Gender");
    }
}
