import * as z from "zod";


export type Format = {
    "formats": FormatsClass;
};
export const FormatSchema: z.ZodType<Format> = z.lazy(() =>
    z.object({
        "formats": FormatsClassSchema,
    })
);

export type FormatsClass = {
    "formats"?: Array<Format>;
    "height": number;
    "url": string;
    "width": number;
};
export const FormatsClassSchema: z.ZodType<FormatsClass> = z.lazy(() =>
    z.object({
        "formats": z.array(FormatSchema).optional(),
        "height": z.number().int(),
        "url": z.string(),
        "width": z.number().int(),
    })
);

export const LinkLinkSchema = z.object({
    "type": z.string(),
    "url": z.string(),
});
export type LinkLink = z.infer<typeof LinkLinkSchema>;

export const CategoryThumbnailSchema = z.object({
    "url": z.string(),
});
export type CategoryThumbnail = z.infer<typeof CategoryThumbnailSchema>;

export const EonandyearSchema = z.object({
    "lowestsetbit": z.number().int(),
});
export type Eonandyear = z.infer<typeof EonandyearSchema>;

export const XmlschematypeSchema = z.object({
    "localpart": z.string(),
    "namespaceuri": z.string(),
    "prefix": z.string(),
});
export type Xmlschematype = z.infer<typeof XmlschematypeSchema>;

export const CurrencySchema = z.object({
    "abbreviation": z.string(),
});
export type Currency = z.infer<typeof CurrencySchema>;

export const LinkElementSchema = z.object({
    "link": LinkLinkSchema,
});
export type LinkElement = z.infer<typeof LinkElementSchema>;

export const DateClassSchema = z.object({
    "day": z.number().int(),
    "eonandyear": EonandyearSchema,
    "hour": z.number().int(),
    "millisecond": z.number().int(),
    "minute": z.number().int(),
    "month": z.number().int(),
    "second": z.number().int(),
    "timezone": z.number().int(),
    "valid": z.boolean(),
    "xmlschematype": XmlschematypeSchema,
    "year": z.number().int(),
});
export type DateClass = z.infer<typeof DateClassSchema>;

export const UseraverageratingSchema = z.object({
    "links": z.array(LinkElementSchema),
    "numcomments": z.number().int(),
    "rating": z.string(),
});
export type Useraveragerating = z.infer<typeof UseraverageratingSchema>;

export const SpecificationSchema = z.object({
    "links": z.array(LinkElementSchema),
});
export type Specification = z.infer<typeof SpecificationSchema>;

export const CategorySchema = z.object({
    "concatenatecategoryname": z.boolean(),
    "hasoffer": z.boolean(),
    "id": z.number().int(),
    "isfinal": z.boolean(),
    "links": z.array(LinkElementSchema),
    "name": z.string(),
    "parentcategoryid": z.number().int(),
    "thumbnail": CategoryThumbnailSchema,
});
export type Category = z.infer<typeof CategorySchema>;

export const DetailsSchema = z.object({
    "applicationid": z.string(),
    "applicationversion": z.string(),
    "code": z.number().int(),
    "date": DateClassSchema,
    "elapsedtime": z.number().int(),
    "message": z.string(),
    "status": z.string(),
});
export type Details = z.infer<typeof DetailsSchema>;

export const RatingSchema = z.object({
    "useraveragerating": UseraverageratingSchema,
});
export type Rating = z.infer<typeof RatingSchema>;

export const ProductProductSchema = z.object({
    "categoryid": z.number().int(),
    "currency": CurrencySchema,
    "eco": z.boolean(),
    "fulldescription": z.boolean(),
    "hasmetasearch": z.boolean(),
    "id": z.number().int(),
    "links": z.array(LinkElementSchema),
    "numoffers": z.number().int(),
    "pricemax": z.string(),
    "pricemin": z.string(),
    "productname": z.string(),
    "quantity": z.number().int(),
    "rating": RatingSchema,
    "specification": SpecificationSchema,
    "thumbnail": FormatsClassSchema,
    "totalsellers": z.number().int(),
});
export type ProductProduct = z.infer<typeof ProductProductSchema>;

export const ProductElementSchema = z.object({
    "product": ProductProductSchema,
});
export type ProductElement = z.infer<typeof ProductElementSchema>;

export const TopLevelSchema = z.object({
    "category": CategorySchema,
    "details": DetailsSchema,
    "match": z.string(),
    "page": z.number().int(),
    "product": z.array(ProductElementSchema),
    "schk": z.boolean(),
    "totallooseoffers": z.number().int(),
    "totalpages": z.number().int(),
    "totalresultsavailable": z.number().int(),
    "totalresultsreturned": z.number().int(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
