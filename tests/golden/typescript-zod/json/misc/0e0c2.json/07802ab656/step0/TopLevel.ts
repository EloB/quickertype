import * as z from "zod";


export const DetailLanguageSchema = z.enum([
    "en",
    "th",
]);
export type DetailLanguage = z.infer<typeof DetailLanguageSchema>;


export const TypeSchema = z.enum([
    "Poster",
    "Backdrop",
]);
export type Type = z.infer<typeof TypeSchema>;


export const ResultLanguageSchema = z.enum([
    "en",
    "-",
]);
export type ResultLanguage = z.infer<typeof ResultLanguageSchema>;

export const CollectionSchema = z.object({
    "id": z.number().int(),
    "movies": z.array(z.number().int()),
    "name": z.string(),
    "slug": z.string(),
});
export type Collection = z.infer<typeof CollectionSchema>;

export const DetailSchema = z.object({
    "cast": z.string(),
    "director": z.string(),
    "id": z.number().int(),
    "language": DetailLanguageSchema,
    "storyline": z.string(),
    "tagline": z.string(),
    "title": z.string(),
});
export type Detail = z.infer<typeof DetailSchema>;

export const FavMovieSchema = z.object({
    "follow": z.boolean(),
    "star": z.boolean(),
    "watched": z.boolean(),
});
export type FavMovie = z.infer<typeof FavMovieSchema>;

export const ImageSchema = z.object({
    "favs": z.number().int(),
    "id": z.number().int(),
    "thumbnail": z.string(),
    "type": TypeSchema,
    "url": z.string(),
});
export type Image = z.infer<typeof ImageSchema>;

export const VideoSchema = z.object({
    "kind": z.string(),
    "language": ResultLanguageSchema,
    "source": z.string(),
    "url": z.string(),
});
export type Video = z.infer<typeof VideoSchema>;

export const VoteScoreSchema = z.object({
    "avg": z.number().int(),
    "score": z.number().int(),
    "total": z.number().int(),
});
export type VoteScore = z.infer<typeof VoteScoreSchema>;

export const ResultSchema = z.object({
    "active_screens": z.number().int(),
    "collections": z.array(CollectionSchema),
    "details": z.array(DetailSchema),
    "duration": z.number().int(),
    "fav_movie": FavMovieSchema,
    "id": z.number().int(),
    "images": z.array(ImageSchema),
    "language": ResultLanguageSchema,
    "release_date": z.string(),
    "stars": z.number().int(),
    "tags": z.union([z.null(), z.array(z.any())]),
    "title": z.string(),
    "videos": z.array(VideoSchema),
    "vote_score": VoteScoreSchema,
    "watches": z.number().int(),
});
export type Result = z.infer<typeof ResultSchema>;

export const TopLevelSchema = z.object({
    "count": z.number().int(),
    "next": z.string(),
    "previous": z.null(),
    "results": z.array(ResultSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
