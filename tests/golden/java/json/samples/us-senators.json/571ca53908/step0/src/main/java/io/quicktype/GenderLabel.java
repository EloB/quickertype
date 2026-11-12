package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum GenderLabel {
    FEMALE, MALE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case FEMALE: return "Female";
            case MALE: return "Male";
        }
        return null;
    }

    @JsonCreator
    public static GenderLabel forValue(String value) throws IOException {
        if (value.equals("Female")) return FEMALE;
        if (value.equals("Male")) return MALE;
        throw new IOException("Cannot deserialize GenderLabel");
    }
}
