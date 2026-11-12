package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Note {
    TL_DR_LEGAL, WIKIPEDIA_PAGE, OSI_PAGE, NOTE_WIKIPEDIA_PAGE, MOZILLA_PAGE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case TL_DR_LEGAL: return "tl;dr legal";
            case WIKIPEDIA_PAGE: return "Wikipedia page";
            case OSI_PAGE: return "OSI Page";
            case NOTE_WIKIPEDIA_PAGE: return "Wikipedia Page";
            case MOZILLA_PAGE: return "Mozilla Page";
        }
        return null;
    }

    @JsonCreator
    public static Note forValue(String value) throws IOException {
        if (value.equals("tl;dr legal")) return TL_DR_LEGAL;
        if (value.equals("Wikipedia page")) return WIKIPEDIA_PAGE;
        if (value.equals("OSI Page")) return OSI_PAGE;
        if (value.equals("Wikipedia Page")) return NOTE_WIKIPEDIA_PAGE;
        if (value.equals("Mozilla Page")) return MOZILLA_PAGE;
        throw new IOException("Cannot deserialize Note");
    }
}
