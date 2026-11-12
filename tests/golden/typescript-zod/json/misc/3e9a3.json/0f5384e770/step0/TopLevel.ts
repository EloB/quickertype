import * as z from "zod";


export const FootnoteSchema = z.object({
    "code": z.string().optional(),
    "text": z.string().optional(),
});
export type Footnote = z.infer<typeof FootnoteSchema>;

export const DatumSchema = z.object({
    "footnotes": z.array(FootnoteSchema),
    "period": z.string(),
    "periodName": z.string(),
    "value": z.string(),
    "year": z.string().regex(/^-?\d+$/),
});
export type Datum = z.infer<typeof DatumSchema>;

export const SeriesSchema = z.object({
    "data": z.array(DatumSchema),
    "seriesID": z.string(),
});
export type Series = z.infer<typeof SeriesSchema>;

export const ResultsSchema = z.object({
    "series": z.array(SeriesSchema),
});
export type Results = z.infer<typeof ResultsSchema>;

export const TopLevelSchema = z.object({
    "message": z.array(z.any()),
    "responseTime": z.number().int(),
    "Results": ResultsSchema,
    "status": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
