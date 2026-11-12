package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
 * continuous color gradient.
 *
 * __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
 * `"symbol"` otherwise.
 */
public enum LegendType {
    SYMBOL, GRADIENT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SYMBOL: return "symbol";
            case GRADIENT: return "gradient";
        }
        return null;
    }

    @JsonCreator
    public static LegendType forValue(String value) throws IOException {
        if (value.equals("symbol")) return SYMBOL;
        if (value.equals("gradient")) return GRADIENT;
        throw new IOException("Cannot deserialize LegendType");
    }
}
