package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Region {
    EASTERN, NORTHERN_METRO, WESTERN, SOUTHERN_METRO;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EASTERN: return "Eastern";
            case NORTHERN_METRO: return "Northern Metro";
            case WESTERN: return "Western";
            case SOUTHERN_METRO: return "Southern Metro";
        }
        return null;
    }

    @JsonCreator
    public static Region forValue(String value) throws IOException {
        if (value.equals("Eastern")) return EASTERN;
        if (value.equals("Northern Metro")) return NORTHERN_METRO;
        if (value.equals("Western")) return WESTERN;
        if (value.equals("Southern Metro")) return SOUTHERN_METRO;
        throw new IOException("Cannot deserialize Region");
    }
}
