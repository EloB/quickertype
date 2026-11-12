package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Watermark {
    WHITE, RED, BLACK, GREEN, BLUE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case WHITE: return "White";
            case RED: return "Red";
            case BLACK: return "Black";
            case GREEN: return "Green";
            case BLUE: return "Blue";
        }
        return null;
    }

    @JsonCreator
    public static Watermark forValue(String value) throws IOException {
        if (value.equals("White")) return WHITE;
        if (value.equals("Red")) return RED;
        if (value.equals("Black")) return BLACK;
        if (value.equals("Green")) return GREEN;
        if (value.equals("Blue")) return BLUE;
        throw new IOException("Cannot deserialize Watermark");
    }
}
