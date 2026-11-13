export namespace NS { export interface A { a: 1 } export interface B { b: 1 } export interface T { u: B | A; } }
export interface Top { t: NS.T; u: NS.A | NS.B[] }
