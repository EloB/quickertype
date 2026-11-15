/** A person: what the TypeScript input reads from type definitions. */
export interface Person {
    /** The full name. */
    name: string;
    age?: number;
    /** When the person joined. */
    joined: Date;
    tags: ReadonlyArray<string>;
    role: "admin" | "member";
    contact: Email | Phone;
    scores: { [subject: string]: number };
    friends: Person[];
}

export interface Email {
    kind: "email";
    address: string;
}

export interface Phone {
    kind: "phone";
    number: string;
}
