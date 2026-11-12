package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum OrbitClass {
    APOLLO, AMOR, ATEN, COMET, JUPITER_FAMILY_COMET, HALLEY_TYPE_COMET, PARABOLIC_COMET, ORBIT_CLASS_JUPITER_FAMILY_COMET, ENCKE_TYPE_COMET;

    @JsonValue
    public String toValue() {
        switch (this) {
            case APOLLO: return "Apollo";
            case AMOR: return "Amor";
            case ATEN: return "Aten";
            case COMET: return "Comet";
            case JUPITER_FAMILY_COMET: return "Jupiter-family Comet";
            case HALLEY_TYPE_COMET: return "Halley-type Comet*";
            case PARABOLIC_COMET: return "Parabolic Comet";
            case ORBIT_CLASS_JUPITER_FAMILY_COMET: return "Jupiter-family Comet*";
            case ENCKE_TYPE_COMET: return "Encke-type Comet";
        }
        return null;
    }

    @JsonCreator
    public static OrbitClass forValue(String value) throws IOException {
        if (value.equals("Apollo")) return APOLLO;
        if (value.equals("Amor")) return AMOR;
        if (value.equals("Aten")) return ATEN;
        if (value.equals("Comet")) return COMET;
        if (value.equals("Jupiter-family Comet")) return JUPITER_FAMILY_COMET;
        if (value.equals("Halley-type Comet*")) return HALLEY_TYPE_COMET;
        if (value.equals("Parabolic Comet")) return PARABOLIC_COMET;
        if (value.equals("Jupiter-family Comet*")) return ORBIT_CLASS_JUPITER_FAMILY_COMET;
        if (value.equals("Encke-type Comet")) return ENCKE_TYPE_COMET;
        throw new IOException("Cannot deserialize OrbitClass");
    }
}
