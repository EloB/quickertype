package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Text {
    SHOWERS, MOSTLY_SUNNY, PARTLY_CLOUDY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SHOWERS: return "Showers";
            case MOSTLY_SUNNY: return "Mostly Sunny";
            case PARTLY_CLOUDY: return "Partly Cloudy";
        }
        return null;
    }

    @JsonCreator
    public static Text forValue(String value) throws IOException {
        if (value.equals("Showers")) return SHOWERS;
        if (value.equals("Mostly Sunny")) return MOSTLY_SUNNY;
        if (value.equals("Partly Cloudy")) return PARTLY_CLOUDY;
        throw new IOException("Cannot deserialize Text");
    }
}
