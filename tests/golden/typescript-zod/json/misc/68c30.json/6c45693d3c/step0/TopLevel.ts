import * as z from "zod";


export const OutSchema = z.object({
    "addr": z.string(),
    "n": z.number().int(),
    "script": z.string(),
    "spent": z.boolean(),
    "tx_index": z.number().int(),
    "type": z.number().int(),
    "value": z.number().int(),
});
export type Out = z.infer<typeof OutSchema>;

export const InputSchema = z.object({
    "prev_out": OutSchema,
    "script": z.string(),
    "sequence": z.number().int(),
});
export type Input = z.infer<typeof InputSchema>;

export const TxSchema = z.object({
    "double_spend": z.boolean(),
    "hash": z.string(),
    "inputs": z.array(InputSchema),
    "lock_time": z.number().int(),
    "out": z.array(OutSchema),
    "relayed_by": z.string(),
    "size": z.number().int(),
    "time": z.number().int(),
    "tx_index": z.number().int(),
    "ver": z.number().int(),
    "vin_sz": z.number().int(),
    "vout_sz": z.number().int(),
});
export type Tx = z.infer<typeof TxSchema>;

export const TopLevelSchema = z.object({
    "txs": z.array(TxSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
