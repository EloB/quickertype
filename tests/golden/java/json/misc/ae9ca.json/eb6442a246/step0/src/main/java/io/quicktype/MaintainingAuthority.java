package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum MaintainingAuthority {
    CITY_OF_BALLARAT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case CITY_OF_BALLARAT: return "City of Ballarat";
        }
        return null;
    }

    @JsonCreator
    public static MaintainingAuthority forValue(String value) throws IOException {
        if (value.equals("City of Ballarat")) return CITY_OF_BALLARAT;
        throw new IOException("Cannot deserialize MaintainingAuthority");
    }
}
