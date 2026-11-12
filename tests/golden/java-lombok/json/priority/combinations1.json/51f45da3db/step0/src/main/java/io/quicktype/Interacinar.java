package io.quicktype;

import com.fasterxml.jackson.annotation.*;

@lombok.Data
public class Interacinar {
    @lombok.Getter(onMethod_ = {@JsonProperty("assapan")})
    @lombok.Setter(onMethod_ = {@JsonProperty("assapan")})
    private double assapan;
    @lombok.Getter(onMethod_ = {@JsonProperty("benefactorship")})
    @lombok.Setter(onMethod_ = {@JsonProperty("benefactorship")})
    private boolean benefactorship;
    @lombok.Getter(onMethod_ = {@JsonProperty("triseriatim")})
    @lombok.Setter(onMethod_ = {@JsonProperty("triseriatim")})
    private String triseriatim;
    @lombok.Getter(onMethod_ = {@JsonProperty("tubbing")})
    @lombok.Setter(onMethod_ = {@JsonProperty("tubbing")})
    private long tubbing;
    @lombok.Getter(onMethod_ = {@JsonProperty("untrimmed")})
    @lombok.Setter(onMethod_ = {@JsonProperty("untrimmed")})
    private Object untrimmed;
}
