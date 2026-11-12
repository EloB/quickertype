package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum DetailLanguage {
    EN, TH;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EN: return "en";
            case TH: return "th";
        }
        return null;
    }

    @JsonCreator
    public static DetailLanguage forValue(String value) throws IOException {
        if (value.equals("en")) return EN;
        if (value.equals("th")) return TH;
        throw new IOException("Cannot deserialize DetailLanguage");
    }
}
