package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Title {
    PLAIN_TEXT, HTML;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PLAIN_TEXT: return "Plain Text";
            case HTML: return "HTML";
        }
        return null;
    }

    @JsonCreator
    public static Title forValue(String value) throws IOException {
        if (value.equals("Plain Text")) return PLAIN_TEXT;
        if (value.equals("HTML")) return HTML;
        throw new IOException("Cannot deserialize Title");
    }
}
