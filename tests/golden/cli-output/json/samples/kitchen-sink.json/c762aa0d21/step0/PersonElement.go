package main

type PersonElement struct {
	Name          string       `json:"name"`
	IntOrString   *IntOrString `json:"intOrString"`
	OptionalValue *bool        `json:"optionalValue,omitempty"`
}
