import * as z from "zod";


export const RatingSchema = z.enum([
    "g",
    "pg",
    "y",
    "pg-13",
]);
export type Rating = z.infer<typeof RatingSchema>;


export const TypeSchema = z.enum([
    "gif",
]);
export type Type = z.infer<typeof TypeSchema>;

export const DownsizedSchema = z.object({
    "height": z.string().regex(/^-?\d+$/),
    "size": z.string().regex(/^-?\d+$/).optional(),
    "url": z.string(),
    "width": z.string().regex(/^-?\d+$/),
});
export type Downsized = z.infer<typeof DownsizedSchema>;

export const DownsizedSmallSchema = z.object({
    "height": z.string().regex(/^-?\d+$/),
    "mp4": z.string(),
    "mp4_size": z.string().regex(/^-?\d+$/),
    "width": z.string().regex(/^-?\d+$/),
});
export type DownsizedSmall = z.infer<typeof DownsizedSmallSchema>;

export const FixedHeightSchema = z.object({
    "frames": z.string().regex(/^-?\d+$/).optional(),
    "height": z.string().regex(/^-?\d+$/),
    "mp4": z.string().optional(),
    "mp4_size": z.string().regex(/^-?\d+$/).optional(),
    "size": z.string().regex(/^-?\d+$/),
    "url": z.string(),
    "webp": z.string(),
    "webp_size": z.string().regex(/^-?\d+$/),
    "width": z.string().regex(/^-?\d+$/),
});
export type FixedHeight = z.infer<typeof FixedHeightSchema>;

export const LoopingSchema = z.object({
    "mp4": z.string(),
    "mp4_size": z.string().regex(/^-?\d+$/),
});
export type Looping = z.infer<typeof LoopingSchema>;

export const UserSchema = z.object({
    "avatar_url": z.string(),
    "banner_url": z.string(),
    "display_name": z.string(),
    "profile_url": z.string(),
    "twitter": z.string(),
    "username": z.string(),
});
export type User = z.infer<typeof UserSchema>;

export const MetaSchema = z.object({
    "msg": z.string(),
    "response_id": z.string(),
    "status": z.number().int(),
});
export type Meta = z.infer<typeof MetaSchema>;

export const PaginationSchema = z.object({
    "count": z.number().int(),
    "offset": z.number().int(),
    "total_count": z.number().int(),
});
export type Pagination = z.infer<typeof PaginationSchema>;

export const ImagesSchema = z.object({
    "downsized": DownsizedSchema,
    "downsized_large": DownsizedSchema,
    "downsized_medium": DownsizedSchema,
    "downsized_small": DownsizedSmallSchema,
    "downsized_still": DownsizedSchema,
    "fixed_height": FixedHeightSchema,
    "fixed_height_downsampled": FixedHeightSchema,
    "fixed_height_small": FixedHeightSchema,
    "fixed_height_small_still": DownsizedSchema,
    "fixed_height_still": DownsizedSchema,
    "fixed_width": FixedHeightSchema,
    "fixed_width_downsampled": FixedHeightSchema,
    "fixed_width_small": FixedHeightSchema,
    "fixed_width_small_still": DownsizedSchema,
    "fixed_width_still": DownsizedSchema,
    "looping": LoopingSchema,
    "original": FixedHeightSchema,
    "original_mp4": DownsizedSmallSchema,
    "original_still": DownsizedSchema,
    "preview": DownsizedSmallSchema,
    "preview_gif": DownsizedSchema,
    "preview_webp": DownsizedSchema,
});
export type Images = z.infer<typeof ImagesSchema>;

export const DatumSchema = z.object({
    "bitly_gif_url": z.string(),
    "bitly_url": z.string(),
    "content_url": z.string(),
    "embed_url": z.string(),
    "id": z.string(),
    "images": ImagesSchema,
    "import_datetime": z.string(),
    "is_indexable": z.number().int(),
    "rating": RatingSchema,
    "slug": z.string(),
    "source": z.string(),
    "source_post_url": z.string(),
    "source_tld": z.string(),
    "trending_datetime": z.string(),
    "type": TypeSchema,
    "url": z.string(),
    "user": UserSchema.optional(),
    "username": z.string(),
});
export type Datum = z.infer<typeof DatumSchema>;

export const TopLevelSchema = z.object({
    "data": z.array(DatumSchema),
    "meta": MetaSchema,
    "pagination": PaginationSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
