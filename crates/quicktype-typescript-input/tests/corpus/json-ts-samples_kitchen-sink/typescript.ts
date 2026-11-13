export interface TopLevel {
    booleanValue:       boolean;
    dateValue:          string;
    differentThings:    Array<DifferentThingClass | number | string>;
    doubleValue:        number;
    intValue:           number;
    mapValue:           { [key: string]: number | null };
    "name with spaces": null;
    nullValue:          null;
    nullableMapValue:   { [key: string]: number | null };
    people:             PersonElement[];
    person:             PurplePerson;
    stringValue:        string;
    tuples:             Array<Array<number | string>>;
    uuidValue:          string;
}

export interface DifferentThingClass {
    name: string;
}

export interface PersonElement {
    intOrString:    number | string;
    name:           string;
    optionalValue?: boolean;
}

export interface PurplePerson {
    intOrString: number;
    name:        string;
}
