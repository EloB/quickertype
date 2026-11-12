package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Language {
    MARKDOWN;

    @JsonValue
    public String toValue() {
        switch (this) {
            case MARKDOWN: return "Markdown";
        }
        return null;
    }

    @JsonCreator
    public static Language forValue(String value) throws IOException {
        if (value.equals("Markdown")) return MARKDOWN;
        throw new IOException("Cannot deserialize Language");
    }
}
