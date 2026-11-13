package main

type DifferentThingElement struct {
	DifferentThingClass *DifferentThingClass
	Integer             *int64
	String              *string
}

func (x *DifferentThingElement) UnmarshalJSON(data []byte) error {
	x.DifferentThingClass = nil
	var c DifferentThingClass
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, &x.String, false, nil, true, &c, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
		x.DifferentThingClass = &c
	}
	return nil
}

func (x *DifferentThingElement) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, x.String, false, nil, x.DifferentThingClass != nil, x.DifferentThingClass, false, nil, false, nil, false)
}
