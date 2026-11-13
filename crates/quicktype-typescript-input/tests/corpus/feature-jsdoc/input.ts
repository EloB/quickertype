/**
 * Thing description.
 * Second line with {@link Other}.
 * @minimum 3
 */
export interface Thing {
    /** count @minimum 0 @maximum 10 */
    count: number;
    /**
     * @TJS-format email
     */
    email: string;
    /** @nullable */
    maybe: string;
    /** @format date-time */
    when: string;
    /** @pattern ^[a-z]+$ */
    slug: string;
    /** @default 5 */
    d: number;
    /** @ignore */
    hidden: string;
    /** @examples ["a", "b"] */
    ex: string;
    /** @TJS-type integer */
    i: number;
    /** @asType integer */
    j: number;
}
export interface Other { o: string; }
