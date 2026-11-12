package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
 * `"nominal"`).
 * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
 * [geographic projection](projection.html) is applied.
 *
 * Constants and utilities for data type
 * Data type based on level of measurement
 */
public enum Type {
    QUANTITATIVE, ORDINAL, TEMPORAL, NOMINAL, LATITUDE, LONGITUDE, GEOJSON;

    @JsonValue
    public String toValue() {
        switch (this) {
            case QUANTITATIVE: return "quantitative";
            case ORDINAL: return "ordinal";
            case TEMPORAL: return "temporal";
            case NOMINAL: return "nominal";
            case LATITUDE: return "latitude";
            case LONGITUDE: return "longitude";
            case GEOJSON: return "geojson";
        }
        return null;
    }

    @JsonCreator
    public static Type forValue(String value) throws IOException {
        if (value.equals("quantitative")) return QUANTITATIVE;
        if (value.equals("ordinal")) return ORDINAL;
        if (value.equals("temporal")) return TEMPORAL;
        if (value.equals("nominal")) return NOMINAL;
        if (value.equals("latitude")) return LATITUDE;
        if (value.equals("longitude")) return LONGITUDE;
        if (value.equals("geojson")) return GEOJSON;
        throw new IOException("Cannot deserialize Type");
    }
}
