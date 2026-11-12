package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum PropertiesType {
    STREET, AVENUE, ROAD, HIGHWAY, BOULEVARD, COURT, WAY, DRIVE, SOUTH, HILL, LANE, CLOSE, PARADE, TYPE_ROAD, PLACE, RD;

    @JsonValue
    public String toValue() {
        switch (this) {
            case STREET: return "STREET";
            case AVENUE: return "AVENUE";
            case ROAD: return "ROAD";
            case HIGHWAY: return "HIGHWAY";
            case BOULEVARD: return "BOULEVARD";
            case COURT: return "COURT";
            case WAY: return "WAY";
            case DRIVE: return "DRIVE";
            case SOUTH: return "SOUTH";
            case HILL: return "HILL";
            case LANE: return "LANE";
            case CLOSE: return "CLOSE";
            case PARADE: return "PARADE";
            case TYPE_ROAD: return "Road";
            case PLACE: return "PLACE";
            case RD: return "RD";
        }
        return null;
    }

    @JsonCreator
    public static PropertiesType forValue(String value) throws IOException {
        if (value.equals("STREET")) return STREET;
        if (value.equals("AVENUE")) return AVENUE;
        if (value.equals("ROAD")) return ROAD;
        if (value.equals("HIGHWAY")) return HIGHWAY;
        if (value.equals("BOULEVARD")) return BOULEVARD;
        if (value.equals("COURT")) return COURT;
        if (value.equals("WAY")) return WAY;
        if (value.equals("DRIVE")) return DRIVE;
        if (value.equals("SOUTH")) return SOUTH;
        if (value.equals("HILL")) return HILL;
        if (value.equals("LANE")) return LANE;
        if (value.equals("CLOSE")) return CLOSE;
        if (value.equals("PARADE")) return PARADE;
        if (value.equals("Road")) return TYPE_ROAD;
        if (value.equals("PLACE")) return PLACE;
        if (value.equals("RD")) return RD;
        throw new IOException("Cannot deserialize PropertiesType");
    }
}
