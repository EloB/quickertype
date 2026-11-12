package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
 * - If set to `"filter"` (default), all data items with null values are filtered.
 * - If `null`, all data items are included. In this case, invalid values will be
 * interpreted as zeroes.
 */
public enum InvalidValues {
    FILTER;

    @JsonValue
    public String toValue() {
        switch (this) {
            case FILTER: return "filter";
        }
        return null;
    }

    @JsonCreator
    public static InvalidValues forValue(String value) throws IOException {
        if (value.equals("filter")) return FILTER;
        throw new IOException("Cannot deserialize InvalidValues");
    }
}
