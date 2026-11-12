package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum LevelAccu {
    GPS_CORRECTED_10_M, APPROX, GPS_C_ORRECTED_10_M;

    @JsonValue
    public String toValue() {
        switch (this) {
            case GPS_CORRECTED_10_M: return "GPS Corrected 1.0M";
            case APPROX: return "APPROX";
            case GPS_C_ORRECTED_10_M: return "GPS COrrected 1.0M";
        }
        return null;
    }

    @JsonCreator
    public static LevelAccu forValue(String value) throws IOException {
        if (value.equals("GPS Corrected 1.0M")) return GPS_CORRECTED_10_M;
        if (value.equals("APPROX")) return APPROX;
        if (value.equals("GPS COrrected 1.0M")) return GPS_C_ORRECTED_10_M;
        throw new IOException("Cannot deserialize LevelAccu");
    }
}
