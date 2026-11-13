import { B } from './b';
export interface A { a: 1 }
export interface T { u: B | A; v: A[] | B; }
