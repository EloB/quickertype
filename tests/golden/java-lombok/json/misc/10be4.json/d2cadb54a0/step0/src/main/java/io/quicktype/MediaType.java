package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum MediaType {
    TEXT_HTML, TEXT_PLAIN, APPLICATION_PDF;

    @JsonValue
    public String toValue() {
        switch (this) {
            case TEXT_HTML: return "text/html";
            case TEXT_PLAIN: return "text/plain";
            case APPLICATION_PDF: return "application/pdf";
        }
        return null;
    }

    @JsonCreator
    public static MediaType forValue(String value) throws IOException {
        if (value.equals("text/html")) return TEXT_HTML;
        if (value.equals("text/plain")) return TEXT_PLAIN;
        if (value.equals("application/pdf")) return APPLICATION_PDF;
        throw new IOException("Cannot deserialize MediaType");
    }
}
