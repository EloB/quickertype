package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ID {
    EMPTY, SAS, SSA, ECA, LAC, EAP, MNA, HIC, LIC, NA, LMC, UMC, LNX, IDX, IBD, IDB, LCN, SSF, ECS, MEA, EAS, NAC;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case SAS: return "SAS";
            case SSA: return "SSA";
            case ECA: return "ECA";
            case LAC: return "LAC";
            case EAP: return "EAP";
            case MNA: return "MNA";
            case HIC: return "HIC";
            case LIC: return "LIC";
            case NA: return "NA";
            case LMC: return "LMC";
            case UMC: return "UMC";
            case LNX: return "LNX";
            case IDX: return "IDX";
            case IBD: return "IBD";
            case IDB: return "IDB";
            case LCN: return "LCN";
            case SSF: return "SSF";
            case ECS: return "ECS";
            case MEA: return "MEA";
            case EAS: return "EAS";
            case NAC: return "NAC";
        }
        return null;
    }

    @JsonCreator
    public static ID forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("SAS")) return SAS;
        if (value.equals("SSA")) return SSA;
        if (value.equals("ECA")) return ECA;
        if (value.equals("LAC")) return LAC;
        if (value.equals("EAP")) return EAP;
        if (value.equals("MNA")) return MNA;
        if (value.equals("HIC")) return HIC;
        if (value.equals("LIC")) return LIC;
        if (value.equals("NA")) return NA;
        if (value.equals("LMC")) return LMC;
        if (value.equals("UMC")) return UMC;
        if (value.equals("LNX")) return LNX;
        if (value.equals("IDX")) return IDX;
        if (value.equals("IBD")) return IBD;
        if (value.equals("IDB")) return IDB;
        if (value.equals("LCN")) return LCN;
        if (value.equals("SSF")) return SSF;
        if (value.equals("ECS")) return ECS;
        if (value.equals("MEA")) return MEA;
        if (value.equals("EAS")) return EAS;
        if (value.equals("NAC")) return NAC;
        throw new IOException("Cannot deserialize ID");
    }
}
