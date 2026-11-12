package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum RowsUpdatedBy {
    PJXG_VE4_M, THE_54_A3_QYUN, THE_9_E3_M_2843, VVCA_FR6_G;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PJXG_VE4_M: return "pjxg-ve4m";
            case THE_54_A3_QYUN: return "54a3-qyun";
            case THE_9_E3_M_2843: return "9e3m-2843";
            case VVCA_FR6_G: return "vvca-fr6g";
        }
        return null;
    }

    @JsonCreator
    public static RowsUpdatedBy forValue(String value) throws IOException {
        if (value.equals("pjxg-ve4m")) return PJXG_VE4_M;
        if (value.equals("54a3-qyun")) return THE_54_A3_QYUN;
        if (value.equals("9e3m-2843")) return THE_9_E3_M_2843;
        if (value.equals("vvca-fr6g")) return VVCA_FR6_G;
        throw new IOException("Cannot deserialize RowsUpdatedBy");
    }
}
