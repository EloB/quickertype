package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum MediaType {
    TEXT_HTML, TEXT_PLAIN;

    @JsonValue
    public String toValue() {
        switch (this) {
            case TEXT_HTML: return "text/html";
            case TEXT_PLAIN: return "text/plain";
        }
        return null;
    }

    @JsonCreator
    public static MediaType forValue(String value) throws IOException {
        if (value.equals("text/html")) return TEXT_HTML;
        if (value.equals("text/plain")) return TEXT_PLAIN;
        throw new IOException("Cannot deserialize MediaType");
    }
}
