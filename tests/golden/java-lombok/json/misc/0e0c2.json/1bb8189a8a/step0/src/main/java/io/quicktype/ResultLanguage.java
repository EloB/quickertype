package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ResultLanguage {
    EN, EMPTY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EN: return "en";
            case EMPTY: return "-";
        }
        return null;
    }

    @JsonCreator
    public static ResultLanguage forValue(String value) throws IOException {
        if (value.equals("en")) return EN;
        if (value.equals("-")) return EMPTY;
        throw new IOException("Cannot deserialize ResultLanguage");
    }
}
