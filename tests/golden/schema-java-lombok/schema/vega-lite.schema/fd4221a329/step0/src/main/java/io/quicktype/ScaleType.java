package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * The type of scale.  Vega-Lite supports the following categories of scale types:
 *
 * 1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
 * continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
 * [`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
 * [`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
 *
 * 2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
 * ([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
 * [`"point"`](scale.html#point)) output ranges.
 *
 * 3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
 * discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
 * [`"bin-ordinal"`](scale.html#bin-ordinal)).
 *
 * __Default value:__ please see the [scale type table](scale.html#type).
 */
public enum ScaleType {
    LINEAR, BIN_LINEAR, LOG, POW, SQRT, TIME, UTC, SEQUENTIAL, ORDINAL, BIN_ORDINAL, POINT, BAND;

    @JsonValue
    public String toValue() {
        switch (this) {
            case LINEAR: return "linear";
            case BIN_LINEAR: return "bin-linear";
            case LOG: return "log";
            case POW: return "pow";
            case SQRT: return "sqrt";
            case TIME: return "time";
            case UTC: return "utc";
            case SEQUENTIAL: return "sequential";
            case ORDINAL: return "ordinal";
            case BIN_ORDINAL: return "bin-ordinal";
            case POINT: return "point";
            case BAND: return "band";
        }
        return null;
    }

    @JsonCreator
    public static ScaleType forValue(String value) throws IOException {
        if (value.equals("linear")) return LINEAR;
        if (value.equals("bin-linear")) return BIN_LINEAR;
        if (value.equals("log")) return LOG;
        if (value.equals("pow")) return POW;
        if (value.equals("sqrt")) return SQRT;
        if (value.equals("time")) return TIME;
        if (value.equals("utc")) return UTC;
        if (value.equals("sequential")) return SEQUENTIAL;
        if (value.equals("ordinal")) return ORDINAL;
        if (value.equals("bin-ordinal")) return BIN_ORDINAL;
        if (value.equals("point")) return POINT;
        if (value.equals("band")) return BAND;
        throw new IOException("Cannot deserialize ScaleType");
    }
}
