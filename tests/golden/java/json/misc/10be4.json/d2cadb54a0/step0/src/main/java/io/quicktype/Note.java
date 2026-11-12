package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Note {
    OSI_PAGE, TL_DR_LEGAL, WIKIPEDIA_PAGE, NOTE_WIKIPEDIA_PAGE, MOZILLA_PAGE, OSET_FOUNDATION_PAGE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case OSI_PAGE: return "OSI Page";
            case TL_DR_LEGAL: return "tl;dr legal";
            case WIKIPEDIA_PAGE: return "Wikipedia page";
            case NOTE_WIKIPEDIA_PAGE: return "Wikipedia Page";
            case MOZILLA_PAGE: return "Mozilla Page";
            case OSET_FOUNDATION_PAGE: return "OSET Foundation Page";
        }
        return null;
    }

    @JsonCreator
    public static Note forValue(String value) throws IOException {
        if (value.equals("OSI Page")) return OSI_PAGE;
        if (value.equals("tl;dr legal")) return TL_DR_LEGAL;
        if (value.equals("Wikipedia page")) return WIKIPEDIA_PAGE;
        if (value.equals("Wikipedia Page")) return NOTE_WIKIPEDIA_PAGE;
        if (value.equals("Mozilla Page")) return MOZILLA_PAGE;
        if (value.equals("OSET Foundation Page")) return OSET_FOUNDATION_PAGE;
        throw new IOException("Cannot deserialize Note");
    }
}
