package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Title {
    HTML, PLAIN_TEXT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case HTML: return "HTML";
            case PLAIN_TEXT: return "Plain Text";
        }
        return null;
    }

    @JsonCreator
    public static Title forValue(String value) throws IOException {
        if (value.equals("HTML")) return HTML;
        if (value.equals("Plain Text")) return PLAIN_TEXT;
        throw new IOException("Cannot deserialize Title");
    }
}
