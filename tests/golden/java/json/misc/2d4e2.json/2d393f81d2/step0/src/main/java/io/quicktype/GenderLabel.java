package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum GenderLabel {
    MALE, FEMALE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case MALE: return "Male";
            case FEMALE: return "Female";
        }
        return null;
    }

    @JsonCreator
    public static GenderLabel forValue(String value) throws IOException {
        if (value.equals("Male")) return MALE;
        if (value.equals("Female")) return FEMALE;
        throw new IOException("Cannot deserialize GenderLabel");
    }
}
