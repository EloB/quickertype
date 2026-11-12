package io.quicktype;

import com.fasterxml.jackson.annotation.*;

@lombok.Data
public class QuebrachineClass {
    @lombok.Getter(onMethod_ = {@JsonProperty("catharticalness")})
    @lombok.Setter(onMethod_ = {@JsonProperty("catharticalness")})
    private double catharticalness;
    @lombok.Getter(onMethod_ = {@JsonProperty("Chirotherium")})
    @lombok.Setter(onMethod_ = {@JsonProperty("Chirotherium")})
    private long chirotherium;
    @lombok.Getter(onMethod_ = {@JsonProperty("disdiapason")})
    @lombok.Setter(onMethod_ = {@JsonProperty("disdiapason")})
    private String disdiapason;
    @lombok.Getter(onMethod_ = {@JsonProperty("homocerc")})
    @lombok.Setter(onMethod_ = {@JsonProperty("homocerc")})
    private boolean homocerc;
    @lombok.Getter(onMethod_ = {@JsonProperty("nonbookish")})
    @lombok.Setter(onMethod_ = {@JsonProperty("nonbookish")})
    private Object nonbookish;
}
