package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Text {
    MOSTLY_CLOUDY, RAIN, PARTLY_CLOUDY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case MOSTLY_CLOUDY: return "Mostly Cloudy";
            case RAIN: return "Rain";
            case PARTLY_CLOUDY: return "Partly Cloudy";
        }
        return null;
    }

    @JsonCreator
    public static Text forValue(String value) throws IOException {
        if (value.equals("Mostly Cloudy")) return MOSTLY_CLOUDY;
        if (value.equals("Rain")) return RAIN;
        if (value.equals("Partly Cloudy")) return PARTLY_CLOUDY;
        throw new IOException("Cannot deserialize Text");
    }
}
