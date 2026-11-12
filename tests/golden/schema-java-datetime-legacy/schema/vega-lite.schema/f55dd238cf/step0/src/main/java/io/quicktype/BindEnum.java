package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * Establishes a two-way binding between the interval selection and the scales
 * used within the same view. This allows a user to interactively pan and
 * zoom the view.
 */
public enum BindEnum {
    SCALES;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SCALES: return "scales";
        }
        return null;
    }

    @JsonCreator
    public static BindEnum forValue(String value) throws IOException {
        if (value.equals("scales")) return SCALES;
        throw new IOException("Cannot deserialize BindEnum");
    }
}
