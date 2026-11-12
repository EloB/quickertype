package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Color {
    BLUE, BLACK, WHITE, GREEN, RED;

    @JsonValue
    public String toValue() {
        switch (this) {
            case BLUE: return "Blue";
            case BLACK: return "Black";
            case WHITE: return "White";
            case GREEN: return "Green";
            case RED: return "Red";
        }
        return null;
    }

    @JsonCreator
    public static Color forValue(String value) throws IOException {
        if (value.equals("Blue")) return BLUE;
        if (value.equals("Black")) return BLACK;
        if (value.equals("White")) return WHITE;
        if (value.equals("Green")) return GREEN;
        if (value.equals("Red")) return RED;
        throw new IOException("Cannot deserialize Color");
    }
}
