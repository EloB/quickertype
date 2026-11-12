package io.quicktype;

import com.fasterxml.jackson.annotation.*;

@lombok.Data
public class Noncontributing {
    @lombok.Getter(onMethod_ = {@JsonProperty("estevin")})
    @lombok.Setter(onMethod_ = {@JsonProperty("estevin")})
    private String estevin;
    @lombok.Getter(onMethod_ = {@JsonProperty("jolterhead")})
    @lombok.Setter(onMethod_ = {@JsonProperty("jolterhead")})
    private double jolterhead;
    @lombok.Getter(onMethod_ = {@JsonProperty("sauternes")})
    @lombok.Setter(onMethod_ = {@JsonProperty("sauternes")})
    private long sauternes;
    @lombok.Getter(onMethod_ = {@JsonProperty("sparsely")})
    @lombok.Setter(onMethod_ = {@JsonProperty("sparsely")})
    private boolean sparsely;
    @lombok.Getter(onMethod_ = {@JsonProperty("unrequested")})
    @lombok.Setter(onMethod_ = {@JsonProperty("unrequested")})
    private Object unrequested;
}
