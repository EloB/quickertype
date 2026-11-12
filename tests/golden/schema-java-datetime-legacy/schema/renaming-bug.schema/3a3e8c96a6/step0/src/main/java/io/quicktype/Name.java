package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Name {
    TRUCK, BUS, CAR, VAN, TRAIN, BIKE, AEROPLANE, JEEP, TROLLEY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case TRUCK: return "truck";
            case BUS: return "bus";
            case CAR: return "car";
            case VAN: return "van";
            case TRAIN: return "train";
            case BIKE: return "Bike";
            case AEROPLANE: return "Aeroplane";
            case JEEP: return "Jeep";
            case TROLLEY: return "Trolley";
        }
        return null;
    }

    @JsonCreator
    public static Name forValue(String value) throws IOException {
        if (value.equals("truck")) return TRUCK;
        if (value.equals("bus")) return BUS;
        if (value.equals("car")) return CAR;
        if (value.equals("van")) return VAN;
        if (value.equals("train")) return TRAIN;
        if (value.equals("Bike")) return BIKE;
        if (value.equals("Aeroplane")) return AEROPLANE;
        if (value.equals("Jeep")) return JEEP;
        if (value.equals("Trolley")) return TROLLEY;
        throw new IOException("Cannot deserialize Name");
    }
}
