// Types from imported files (and a triple-slash reference), which the
// compiler resolves while it builds the program.
/// <reference path="./ref.d.ts" />
import { X, Y, Mode, Kind } from "./other";
import type { Renamed } from "./reexport";
import * as o from "./other";

export interface Main {
  x: X;
  xs: X[];
  maybe: X | null;
  y: Y;
  mode: Mode;
  kind: Kind;
  ox: o.X;
  renamed: Renamed;
  global: GlobalThing;
  inline: { x: o.Y; k?: Kind };
}
