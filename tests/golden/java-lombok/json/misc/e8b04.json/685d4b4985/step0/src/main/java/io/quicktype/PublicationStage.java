package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum PublicationStage {
    PUBLISHED;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PUBLISHED: return "published";
        }
        return null;
    }

    @JsonCreator
    public static PublicationStage forValue(String value) throws IOException {
        if (value.equals("published")) return PUBLISHED;
        throw new IOException("Cannot deserialize PublicationStage");
    }
}
