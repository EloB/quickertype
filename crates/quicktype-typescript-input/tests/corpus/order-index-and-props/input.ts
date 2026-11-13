export interface R { a: X | Y; [k: string]: Y | X | Z[] | undefined; }
export interface X { x: 1 }
export interface Y { y: 1 }
export interface Z { z: 1 }
