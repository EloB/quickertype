package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum FireBanR {
    NORTH_CENTRAL, CENTRAL, SOUTH_WEST, WIMMERA, NORTHERN_COUNTRY, EAST_GIPPSLAND, NORTH_EAST, MALLEE, WEST_SOUTH_GIPPSLAND, BALLARAT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case NORTH_CENTRAL: return "North Central";
            case CENTRAL: return "Central";
            case SOUTH_WEST: return "South West";
            case WIMMERA: return "Wimmera";
            case NORTHERN_COUNTRY: return "Northern Country";
            case EAST_GIPPSLAND: return "East Gippsland";
            case NORTH_EAST: return "North East";
            case MALLEE: return "Mallee";
            case WEST_SOUTH_GIPPSLAND: return "West &South Gippsland";
            case BALLARAT: return "Ballarat";
        }
        return null;
    }

    @JsonCreator
    public static FireBanR forValue(String value) throws IOException {
        if (value.equals("North Central")) return NORTH_CENTRAL;
        if (value.equals("Central")) return CENTRAL;
        if (value.equals("South West")) return SOUTH_WEST;
        if (value.equals("Wimmera")) return WIMMERA;
        if (value.equals("Northern Country")) return NORTHERN_COUNTRY;
        if (value.equals("East Gippsland")) return EAST_GIPPSLAND;
        if (value.equals("North East")) return NORTH_EAST;
        if (value.equals("Mallee")) return MALLEE;
        if (value.equals("West &South Gippsland")) return WEST_SOUTH_GIPPSLAND;
        if (value.equals("Ballarat")) return BALLARAT;
        throw new IOException("Cannot deserialize FireBanR");
    }
}
