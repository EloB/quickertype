package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Callsign {
    ALPHA, BRAVO, CHARLIE, DELTA, ECHO, FOXTROT, GOLF, HOTEL, INDIA, JULIETT, KILO, LIMA, MIKE, NOVEMBER, OSCAR, PAPA, QUEBEC, ROMEO, SIERRA, TANGO;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ALPHA: return "alpha";
            case BRAVO: return "bravo";
            case CHARLIE: return "charlie";
            case DELTA: return "delta";
            case ECHO: return "echo";
            case FOXTROT: return "foxtrot";
            case GOLF: return "golf";
            case HOTEL: return "hotel";
            case INDIA: return "india";
            case JULIETT: return "juliett";
            case KILO: return "kilo";
            case LIMA: return "lima";
            case MIKE: return "mike";
            case NOVEMBER: return "november";
            case OSCAR: return "oscar";
            case PAPA: return "papa";
            case QUEBEC: return "quebec";
            case ROMEO: return "romeo";
            case SIERRA: return "sierra";
            case TANGO: return "tango";
        }
        return null;
    }

    @JsonCreator
    public static Callsign forValue(String value) throws IOException {
        if (value.equals("alpha")) return ALPHA;
        if (value.equals("bravo")) return BRAVO;
        if (value.equals("charlie")) return CHARLIE;
        if (value.equals("delta")) return DELTA;
        if (value.equals("echo")) return ECHO;
        if (value.equals("foxtrot")) return FOXTROT;
        if (value.equals("golf")) return GOLF;
        if (value.equals("hotel")) return HOTEL;
        if (value.equals("india")) return INDIA;
        if (value.equals("juliett")) return JULIETT;
        if (value.equals("kilo")) return KILO;
        if (value.equals("lima")) return LIMA;
        if (value.equals("mike")) return MIKE;
        if (value.equals("november")) return NOVEMBER;
        if (value.equals("oscar")) return OSCAR;
        if (value.equals("papa")) return PAPA;
        if (value.equals("quebec")) return QUEBEC;
        if (value.equals("romeo")) return ROMEO;
        if (value.equals("sierra")) return SIERRA;
        if (value.equals("tango")) return TANGO;
        throw new IOException("Cannot deserialize Callsign");
    }
}
