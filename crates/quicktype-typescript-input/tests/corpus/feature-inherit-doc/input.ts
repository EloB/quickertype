export interface A { /** Doc from A */ shared: string; /** a doc */ a: number; }
export interface B extends A { shared: string; b: boolean; }
