package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum MediaType {
    TEXT_PLAIN, TEXT_HTML;

    @JsonValue
    public String toValue() {
        switch (this) {
            case TEXT_PLAIN: return "text/plain";
            case TEXT_HTML: return "text/html";
        }
        return null;
    }

    @JsonCreator
    public static MediaType forValue(String value) throws IOException {
        if (value.equals("text/plain")) return TEXT_PLAIN;
        if (value.equals("text/html")) return TEXT_HTML;
        throw new IOException("Cannot deserialize MediaType");
    }
}
