package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
 * type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
 * descriptions of each.
 *
 * __Default value__: `"pad"`
 */
public enum AutosizeType {
    PAD, FIT, NONE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PAD: return "pad";
            case FIT: return "fit";
            case NONE: return "none";
        }
        return null;
    }

    @JsonCreator
    public static AutosizeType forValue(String value) throws IOException {
        if (value.equals("pad")) return PAD;
        if (value.equals("fit")) return FIT;
        if (value.equals("none")) return NONE;
        throw new IOException("Cannot deserialize AutosizeType");
    }
}
