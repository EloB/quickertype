#import "QTTopLevel.h"

#define λ(decl, expr) (^(decl) { return (expr); })

static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

@interface QTTopLevel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAutoSizeParams (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMarkConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAxisConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVGAxisConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBarConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLegendConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPaddingClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTProjectionConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVGScheme (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTScaleConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSelectionConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIntervalSelectionConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBrushConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMultiSelectionConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSingleSelectionConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVGBinding (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVGMarkConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTextConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTickConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVGTitleConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTViewConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTData (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDataFormat (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTEncodingWithFacet (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMarkPropDefWithCondition (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBinParams (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConditionalValueDef (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSelection (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPredicate (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDateTime (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConditionalPredicateMarkPropFieldDefClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRepeatRef (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLegend (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTScale (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDomainClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTInterpolateParams (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNiceClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSchemeParams (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSortField (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFacetFieldDef (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTHeader (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFieldDef (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDefWithCondition (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConditionalPredicateFieldDefClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOrderFieldDef (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTextDefWithCondition (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConditionalPredicateTextFieldDefClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTXClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAxis (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTX2Class (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFacetMapping (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSpec (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTEncoding (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLayerSpec (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMarkDef (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTProjection (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTResolve (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAxisResolveMap (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLegendResolveMap (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTScaleResolveMap (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSelectionDef (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTitleParams (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTransform (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAggregatedFieldDef (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLookupData (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRepeat (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTContains
+ (NSDictionary<NSString *, QTContains *> *)values
{
    static NSDictionary<NSString *, QTContains *> *values;
    return values = values ? values : @{
        @"content": [[QTContains alloc] initWithValue:@"content"],
        @"padding": [[QTContains alloc] initWithValue:@"padding"],
    };
}

+ (QTContains *)content { return QTContains.values[@"content"]; }
+ (QTContains *)padding { return QTContains.values[@"padding"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTContains.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTAutosizeType
+ (NSDictionary<NSString *, QTAutosizeType *> *)values
{
    static NSDictionary<NSString *, QTAutosizeType *> *values;
    return values = values ? values : @{
        @"pad": [[QTAutosizeType alloc] initWithValue:@"pad"],
        @"fit": [[QTAutosizeType alloc] initWithValue:@"fit"],
        @"none": [[QTAutosizeType alloc] initWithValue:@"none"],
    };
}

+ (QTAutosizeType *)pad { return QTAutosizeType.values[@"pad"]; }
+ (QTAutosizeType *)fit { return QTAutosizeType.values[@"fit"]; }
+ (QTAutosizeType *)none { return QTAutosizeType.values[@"none"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTAutosizeType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTHorizontalAlign
+ (NSDictionary<NSString *, QTHorizontalAlign *> *)values
{
    static NSDictionary<NSString *, QTHorizontalAlign *> *values;
    return values = values ? values : @{
        @"left": [[QTHorizontalAlign alloc] initWithValue:@"left"],
        @"right": [[QTHorizontalAlign alloc] initWithValue:@"right"],
        @"center": [[QTHorizontalAlign alloc] initWithValue:@"center"],
    };
}

+ (QTHorizontalAlign *)left { return QTHorizontalAlign.values[@"left"]; }
+ (QTHorizontalAlign *)right { return QTHorizontalAlign.values[@"right"]; }
+ (QTHorizontalAlign *)center { return QTHorizontalAlign.values[@"center"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTHorizontalAlign.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTVerticalAlign
+ (NSDictionary<NSString *, QTVerticalAlign *> *)values
{
    static NSDictionary<NSString *, QTVerticalAlign *> *values;
    return values = values ? values : @{
        @"top": [[QTVerticalAlign alloc] initWithValue:@"top"],
        @"middle": [[QTVerticalAlign alloc] initWithValue:@"middle"],
        @"bottom": [[QTVerticalAlign alloc] initWithValue:@"bottom"],
    };
}

+ (QTVerticalAlign *)top { return QTVerticalAlign.values[@"top"]; }
+ (QTVerticalAlign *)middle { return QTVerticalAlign.values[@"middle"]; }
+ (QTVerticalAlign *)bottom { return QTVerticalAlign.values[@"bottom"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTVerticalAlign.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTCursor
+ (NSDictionary<NSString *, QTCursor *> *)values
{
    static NSDictionary<NSString *, QTCursor *> *values;
    return values = values ? values : @{
        @"auto": [[QTCursor alloc] initWithValue:@"auto"],
        @"default": [[QTCursor alloc] initWithValue:@"default"],
        @"none": [[QTCursor alloc] initWithValue:@"none"],
        @"context-menu": [[QTCursor alloc] initWithValue:@"context-menu"],
        @"help": [[QTCursor alloc] initWithValue:@"help"],
        @"pointer": [[QTCursor alloc] initWithValue:@"pointer"],
        @"progress": [[QTCursor alloc] initWithValue:@"progress"],
        @"wait": [[QTCursor alloc] initWithValue:@"wait"],
        @"cell": [[QTCursor alloc] initWithValue:@"cell"],
        @"crosshair": [[QTCursor alloc] initWithValue:@"crosshair"],
        @"text": [[QTCursor alloc] initWithValue:@"text"],
        @"vertical-text": [[QTCursor alloc] initWithValue:@"vertical-text"],
        @"alias": [[QTCursor alloc] initWithValue:@"alias"],
        @"copy": [[QTCursor alloc] initWithValue:@"copy"],
        @"move": [[QTCursor alloc] initWithValue:@"move"],
        @"no-drop": [[QTCursor alloc] initWithValue:@"no-drop"],
        @"not-allowed": [[QTCursor alloc] initWithValue:@"not-allowed"],
        @"e-resize": [[QTCursor alloc] initWithValue:@"e-resize"],
        @"n-resize": [[QTCursor alloc] initWithValue:@"n-resize"],
        @"ne-resize": [[QTCursor alloc] initWithValue:@"ne-resize"],
        @"nw-resize": [[QTCursor alloc] initWithValue:@"nw-resize"],
        @"s-resize": [[QTCursor alloc] initWithValue:@"s-resize"],
        @"se-resize": [[QTCursor alloc] initWithValue:@"se-resize"],
        @"sw-resize": [[QTCursor alloc] initWithValue:@"sw-resize"],
        @"w-resize": [[QTCursor alloc] initWithValue:@"w-resize"],
        @"ew-resize": [[QTCursor alloc] initWithValue:@"ew-resize"],
        @"ns-resize": [[QTCursor alloc] initWithValue:@"ns-resize"],
        @"nesw-resize": [[QTCursor alloc] initWithValue:@"nesw-resize"],
        @"nwse-resize": [[QTCursor alloc] initWithValue:@"nwse-resize"],
        @"col-resize": [[QTCursor alloc] initWithValue:@"col-resize"],
        @"row-resize": [[QTCursor alloc] initWithValue:@"row-resize"],
        @"all-scroll": [[QTCursor alloc] initWithValue:@"all-scroll"],
        @"zoom-in": [[QTCursor alloc] initWithValue:@"zoom-in"],
        @"zoom-out": [[QTCursor alloc] initWithValue:@"zoom-out"],
        @"grab": [[QTCursor alloc] initWithValue:@"grab"],
        @"grabbing": [[QTCursor alloc] initWithValue:@"grabbing"],
    };
}

+ (QTCursor *)cursorAuto { return QTCursor.values[@"auto"]; }
+ (QTCursor *)cursorDefault { return QTCursor.values[@"default"]; }
+ (QTCursor *)none { return QTCursor.values[@"none"]; }
+ (QTCursor *)contextMenu { return QTCursor.values[@"context-menu"]; }
+ (QTCursor *)help { return QTCursor.values[@"help"]; }
+ (QTCursor *)pointer { return QTCursor.values[@"pointer"]; }
+ (QTCursor *)progress { return QTCursor.values[@"progress"]; }
+ (QTCursor *)wait { return QTCursor.values[@"wait"]; }
+ (QTCursor *)cell { return QTCursor.values[@"cell"]; }
+ (QTCursor *)crosshair { return QTCursor.values[@"crosshair"]; }
+ (QTCursor *)text { return QTCursor.values[@"text"]; }
+ (QTCursor *)verticalText { return QTCursor.values[@"vertical-text"]; }
+ (QTCursor *)alias { return QTCursor.values[@"alias"]; }
+ (QTCursor *)theCopy { return QTCursor.values[@"copy"]; }
+ (QTCursor *)move { return QTCursor.values[@"move"]; }
+ (QTCursor *)noDrop { return QTCursor.values[@"no-drop"]; }
+ (QTCursor *)notAllowed { return QTCursor.values[@"not-allowed"]; }
+ (QTCursor *)eResize { return QTCursor.values[@"e-resize"]; }
+ (QTCursor *)nResize { return QTCursor.values[@"n-resize"]; }
+ (QTCursor *)neResize { return QTCursor.values[@"ne-resize"]; }
+ (QTCursor *)nwResize { return QTCursor.values[@"nw-resize"]; }
+ (QTCursor *)sResize { return QTCursor.values[@"s-resize"]; }
+ (QTCursor *)seResize { return QTCursor.values[@"se-resize"]; }
+ (QTCursor *)swResize { return QTCursor.values[@"sw-resize"]; }
+ (QTCursor *)wResize { return QTCursor.values[@"w-resize"]; }
+ (QTCursor *)ewResize { return QTCursor.values[@"ew-resize"]; }
+ (QTCursor *)nsResize { return QTCursor.values[@"ns-resize"]; }
+ (QTCursor *)neswResize { return QTCursor.values[@"nesw-resize"]; }
+ (QTCursor *)nwseResize { return QTCursor.values[@"nwse-resize"]; }
+ (QTCursor *)colResize { return QTCursor.values[@"col-resize"]; }
+ (QTCursor *)rowResize { return QTCursor.values[@"row-resize"]; }
+ (QTCursor *)allScroll { return QTCursor.values[@"all-scroll"]; }
+ (QTCursor *)zoomIn { return QTCursor.values[@"zoom-in"]; }
+ (QTCursor *)zoomOut { return QTCursor.values[@"zoom-out"]; }
+ (QTCursor *)grab { return QTCursor.values[@"grab"]; }
+ (QTCursor *)grabbing { return QTCursor.values[@"grabbing"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTCursor.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTFontStyle
+ (NSDictionary<NSString *, QTFontStyle *> *)values
{
    static NSDictionary<NSString *, QTFontStyle *> *values;
    return values = values ? values : @{
        @"normal": [[QTFontStyle alloc] initWithValue:@"normal"],
        @"italic": [[QTFontStyle alloc] initWithValue:@"italic"],
    };
}

+ (QTFontStyle *)normal { return QTFontStyle.values[@"normal"]; }
+ (QTFontStyle *)italic { return QTFontStyle.values[@"italic"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFontStyle.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTFontWeight
+ (NSDictionary<NSString *, QTFontWeight *> *)values
{
    static NSDictionary<NSString *, QTFontWeight *> *values;
    return values = values ? values : @{
        @"normal": [[QTFontWeight alloc] initWithValue:@"normal"],
        @"bold": [[QTFontWeight alloc] initWithValue:@"bold"],
    };
}

+ (QTFontWeight *)normal { return QTFontWeight.values[@"normal"]; }
+ (QTFontWeight *)bold { return QTFontWeight.values[@"bold"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFontWeight.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTInterpolate
+ (NSDictionary<NSString *, QTInterpolate *> *)values
{
    static NSDictionary<NSString *, QTInterpolate *> *values;
    return values = values ? values : @{
        @"linear": [[QTInterpolate alloc] initWithValue:@"linear"],
        @"linear-closed": [[QTInterpolate alloc] initWithValue:@"linear-closed"],
        @"step": [[QTInterpolate alloc] initWithValue:@"step"],
        @"step-before": [[QTInterpolate alloc] initWithValue:@"step-before"],
        @"step-after": [[QTInterpolate alloc] initWithValue:@"step-after"],
        @"basis": [[QTInterpolate alloc] initWithValue:@"basis"],
        @"basis-open": [[QTInterpolate alloc] initWithValue:@"basis-open"],
        @"basis-closed": [[QTInterpolate alloc] initWithValue:@"basis-closed"],
        @"cardinal": [[QTInterpolate alloc] initWithValue:@"cardinal"],
        @"cardinal-open": [[QTInterpolate alloc] initWithValue:@"cardinal-open"],
        @"cardinal-closed": [[QTInterpolate alloc] initWithValue:@"cardinal-closed"],
        @"bundle": [[QTInterpolate alloc] initWithValue:@"bundle"],
        @"monotone": [[QTInterpolate alloc] initWithValue:@"monotone"],
    };
}

+ (QTInterpolate *)linear { return QTInterpolate.values[@"linear"]; }
+ (QTInterpolate *)linearClosed { return QTInterpolate.values[@"linear-closed"]; }
+ (QTInterpolate *)step { return QTInterpolate.values[@"step"]; }
+ (QTInterpolate *)stepBefore { return QTInterpolate.values[@"step-before"]; }
+ (QTInterpolate *)stepAfter { return QTInterpolate.values[@"step-after"]; }
+ (QTInterpolate *)basis { return QTInterpolate.values[@"basis"]; }
+ (QTInterpolate *)basisOpen { return QTInterpolate.values[@"basis-open"]; }
+ (QTInterpolate *)basisClosed { return QTInterpolate.values[@"basis-closed"]; }
+ (QTInterpolate *)cardinal { return QTInterpolate.values[@"cardinal"]; }
+ (QTInterpolate *)cardinalOpen { return QTInterpolate.values[@"cardinal-open"]; }
+ (QTInterpolate *)cardinalClosed { return QTInterpolate.values[@"cardinal-closed"]; }
+ (QTInterpolate *)bundle { return QTInterpolate.values[@"bundle"]; }
+ (QTInterpolate *)monotone { return QTInterpolate.values[@"monotone"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTInterpolate.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTOrient
+ (NSDictionary<NSString *, QTOrient *> *)values
{
    static NSDictionary<NSString *, QTOrient *> *values;
    return values = values ? values : @{
        @"horizontal": [[QTOrient alloc] initWithValue:@"horizontal"],
        @"vertical": [[QTOrient alloc] initWithValue:@"vertical"],
    };
}

+ (QTOrient *)horizontal { return QTOrient.values[@"horizontal"]; }
+ (QTOrient *)vertical { return QTOrient.values[@"vertical"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTOrient.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTLabelOverlapEnum
+ (NSDictionary<NSString *, QTLabelOverlapEnum *> *)values
{
    static NSDictionary<NSString *, QTLabelOverlapEnum *> *values;
    return values = values ? values : @{
        @"parity": [[QTLabelOverlapEnum alloc] initWithValue:@"parity"],
        @"greedy": [[QTLabelOverlapEnum alloc] initWithValue:@"greedy"],
    };
}

+ (QTLabelOverlapEnum *)parity { return QTLabelOverlapEnum.values[@"parity"]; }
+ (QTLabelOverlapEnum *)greedy { return QTLabelOverlapEnum.values[@"greedy"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTLabelOverlapEnum.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTFieldTitle
+ (NSDictionary<NSString *, QTFieldTitle *> *)values
{
    static NSDictionary<NSString *, QTFieldTitle *> *values;
    return values = values ? values : @{
        @"verbal": [[QTFieldTitle alloc] initWithValue:@"verbal"],
        @"functional": [[QTFieldTitle alloc] initWithValue:@"functional"],
        @"plain": [[QTFieldTitle alloc] initWithValue:@"plain"],
    };
}

+ (QTFieldTitle *)verbal { return QTFieldTitle.values[@"verbal"]; }
+ (QTFieldTitle *)functional { return QTFieldTitle.values[@"functional"]; }
+ (QTFieldTitle *)plain { return QTFieldTitle.values[@"plain"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFieldTitle.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTInvalidValues
+ (NSDictionary<NSString *, QTInvalidValues *> *)values
{
    static NSDictionary<NSString *, QTInvalidValues *> *values;
    return values = values ? values : @{
        @"filter": [[QTInvalidValues alloc] initWithValue:@"filter"],
    };
}

+ (QTInvalidValues *)filter { return QTInvalidValues.values[@"filter"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTInvalidValues.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTLegendOrient
+ (NSDictionary<NSString *, QTLegendOrient *> *)values
{
    static NSDictionary<NSString *, QTLegendOrient *> *values;
    return values = values ? values : @{
        @"left": [[QTLegendOrient alloc] initWithValue:@"left"],
        @"right": [[QTLegendOrient alloc] initWithValue:@"right"],
        @"top-left": [[QTLegendOrient alloc] initWithValue:@"top-left"],
        @"top-right": [[QTLegendOrient alloc] initWithValue:@"top-right"],
        @"bottom-left": [[QTLegendOrient alloc] initWithValue:@"bottom-left"],
        @"bottom-right": [[QTLegendOrient alloc] initWithValue:@"bottom-right"],
        @"none": [[QTLegendOrient alloc] initWithValue:@"none"],
    };
}

+ (QTLegendOrient *)left { return QTLegendOrient.values[@"left"]; }
+ (QTLegendOrient *)right { return QTLegendOrient.values[@"right"]; }
+ (QTLegendOrient *)topLeft { return QTLegendOrient.values[@"top-left"]; }
+ (QTLegendOrient *)topRight { return QTLegendOrient.values[@"top-right"]; }
+ (QTLegendOrient *)bottomLeft { return QTLegendOrient.values[@"bottom-left"]; }
+ (QTLegendOrient *)bottomRight { return QTLegendOrient.values[@"bottom-right"]; }
+ (QTLegendOrient *)none { return QTLegendOrient.values[@"none"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTLegendOrient.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTVGProjectionType
+ (NSDictionary<NSString *, QTVGProjectionType *> *)values
{
    static NSDictionary<NSString *, QTVGProjectionType *> *values;
    return values = values ? values : @{
        @"albers": [[QTVGProjectionType alloc] initWithValue:@"albers"],
        @"albersUsa": [[QTVGProjectionType alloc] initWithValue:@"albersUsa"],
        @"azimuthalEqualArea": [[QTVGProjectionType alloc] initWithValue:@"azimuthalEqualArea"],
        @"azimuthalEquidistant": [[QTVGProjectionType alloc] initWithValue:@"azimuthalEquidistant"],
        @"conicConformal": [[QTVGProjectionType alloc] initWithValue:@"conicConformal"],
        @"conicEqualArea": [[QTVGProjectionType alloc] initWithValue:@"conicEqualArea"],
        @"conicEquidistant": [[QTVGProjectionType alloc] initWithValue:@"conicEquidistant"],
        @"equirectangular": [[QTVGProjectionType alloc] initWithValue:@"equirectangular"],
        @"gnomonic": [[QTVGProjectionType alloc] initWithValue:@"gnomonic"],
        @"mercator": [[QTVGProjectionType alloc] initWithValue:@"mercator"],
        @"orthographic": [[QTVGProjectionType alloc] initWithValue:@"orthographic"],
        @"stereographic": [[QTVGProjectionType alloc] initWithValue:@"stereographic"],
        @"transverseMercator": [[QTVGProjectionType alloc] initWithValue:@"transverseMercator"],
    };
}

+ (QTVGProjectionType *)albers { return QTVGProjectionType.values[@"albers"]; }
+ (QTVGProjectionType *)albersUsa { return QTVGProjectionType.values[@"albersUsa"]; }
+ (QTVGProjectionType *)azimuthalEqualArea { return QTVGProjectionType.values[@"azimuthalEqualArea"]; }
+ (QTVGProjectionType *)azimuthalEquidistant { return QTVGProjectionType.values[@"azimuthalEquidistant"]; }
+ (QTVGProjectionType *)conicConformal { return QTVGProjectionType.values[@"conicConformal"]; }
+ (QTVGProjectionType *)conicEqualArea { return QTVGProjectionType.values[@"conicEqualArea"]; }
+ (QTVGProjectionType *)conicEquidistant { return QTVGProjectionType.values[@"conicEquidistant"]; }
+ (QTVGProjectionType *)equirectangular { return QTVGProjectionType.values[@"equirectangular"]; }
+ (QTVGProjectionType *)gnomonic { return QTVGProjectionType.values[@"gnomonic"]; }
+ (QTVGProjectionType *)mercator { return QTVGProjectionType.values[@"mercator"]; }
+ (QTVGProjectionType *)orthographic { return QTVGProjectionType.values[@"orthographic"]; }
+ (QTVGProjectionType *)stereographic { return QTVGProjectionType.values[@"stereographic"]; }
+ (QTVGProjectionType *)transverseMercator { return QTVGProjectionType.values[@"transverseMercator"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTVGProjectionType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTBindEnum
+ (NSDictionary<NSString *, QTBindEnum *> *)values
{
    static NSDictionary<NSString *, QTBindEnum *> *values;
    return values = values ? values : @{
        @"scales": [[QTBindEnum alloc] initWithValue:@"scales"],
    };
}

+ (QTBindEnum *)scales { return QTBindEnum.values[@"scales"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTBindEnum.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTEmpty
+ (NSDictionary<NSString *, QTEmpty *> *)values
{
    static NSDictionary<NSString *, QTEmpty *> *values;
    return values = values ? values : @{
        @"all": [[QTEmpty alloc] initWithValue:@"all"],
        @"none": [[QTEmpty alloc] initWithValue:@"none"],
    };
}

+ (QTEmpty *)all { return QTEmpty.values[@"all"]; }
+ (QTEmpty *)none { return QTEmpty.values[@"none"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTEmpty.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSingleDefChannel
+ (NSDictionary<NSString *, QTSingleDefChannel *> *)values
{
    static NSDictionary<NSString *, QTSingleDefChannel *> *values;
    return values = values ? values : @{
        @"x": [[QTSingleDefChannel alloc] initWithValue:@"x"],
        @"y": [[QTSingleDefChannel alloc] initWithValue:@"y"],
        @"x2": [[QTSingleDefChannel alloc] initWithValue:@"x2"],
        @"y2": [[QTSingleDefChannel alloc] initWithValue:@"y2"],
        @"row": [[QTSingleDefChannel alloc] initWithValue:@"row"],
        @"column": [[QTSingleDefChannel alloc] initWithValue:@"column"],
        @"size": [[QTSingleDefChannel alloc] initWithValue:@"size"],
        @"shape": [[QTSingleDefChannel alloc] initWithValue:@"shape"],
        @"color": [[QTSingleDefChannel alloc] initWithValue:@"color"],
        @"opacity": [[QTSingleDefChannel alloc] initWithValue:@"opacity"],
        @"text": [[QTSingleDefChannel alloc] initWithValue:@"text"],
        @"tooltip": [[QTSingleDefChannel alloc] initWithValue:@"tooltip"],
        @"href": [[QTSingleDefChannel alloc] initWithValue:@"href"],
    };
}

+ (QTSingleDefChannel *)x { return QTSingleDefChannel.values[@"x"]; }
+ (QTSingleDefChannel *)y { return QTSingleDefChannel.values[@"y"]; }
+ (QTSingleDefChannel *)x2 { return QTSingleDefChannel.values[@"x2"]; }
+ (QTSingleDefChannel *)y2 { return QTSingleDefChannel.values[@"y2"]; }
+ (QTSingleDefChannel *)row { return QTSingleDefChannel.values[@"row"]; }
+ (QTSingleDefChannel *)column { return QTSingleDefChannel.values[@"column"]; }
+ (QTSingleDefChannel *)size { return QTSingleDefChannel.values[@"size"]; }
+ (QTSingleDefChannel *)shape { return QTSingleDefChannel.values[@"shape"]; }
+ (QTSingleDefChannel *)color { return QTSingleDefChannel.values[@"color"]; }
+ (QTSingleDefChannel *)opacity { return QTSingleDefChannel.values[@"opacity"]; }
+ (QTSingleDefChannel *)text { return QTSingleDefChannel.values[@"text"]; }
+ (QTSingleDefChannel *)tooltip { return QTSingleDefChannel.values[@"tooltip"]; }
+ (QTSingleDefChannel *)href { return QTSingleDefChannel.values[@"href"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSingleDefChannel.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSelectionResolution
+ (NSDictionary<NSString *, QTSelectionResolution *> *)values
{
    static NSDictionary<NSString *, QTSelectionResolution *> *values;
    return values = values ? values : @{
        @"global": [[QTSelectionResolution alloc] initWithValue:@"global"],
        @"union": [[QTSelectionResolution alloc] initWithValue:@"union"],
        @"intersect": [[QTSelectionResolution alloc] initWithValue:@"intersect"],
    };
}

+ (QTSelectionResolution *)global { return QTSelectionResolution.values[@"global"]; }
+ (QTSelectionResolution *)selectionResolutionUnion { return QTSelectionResolution.values[@"union"]; }
+ (QTSelectionResolution *)intersect { return QTSelectionResolution.values[@"intersect"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSelectionResolution.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTStackOffset
+ (NSDictionary<NSString *, QTStackOffset *> *)values
{
    static NSDictionary<NSString *, QTStackOffset *> *values;
    return values = values ? values : @{
        @"zero": [[QTStackOffset alloc] initWithValue:@"zero"],
        @"center": [[QTStackOffset alloc] initWithValue:@"center"],
        @"normalize": [[QTStackOffset alloc] initWithValue:@"normalize"],
    };
}

+ (QTStackOffset *)zero { return QTStackOffset.values[@"zero"]; }
+ (QTStackOffset *)center { return QTStackOffset.values[@"center"]; }
+ (QTStackOffset *)normalize { return QTStackOffset.values[@"normalize"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTStackOffset.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTAnchor
+ (NSDictionary<NSString *, QTAnchor *> *)values
{
    static NSDictionary<NSString *, QTAnchor *> *values;
    return values = values ? values : @{
        @"start": [[QTAnchor alloc] initWithValue:@"start"],
        @"middle": [[QTAnchor alloc] initWithValue:@"middle"],
        @"end": [[QTAnchor alloc] initWithValue:@"end"],
    };
}

+ (QTAnchor *)start { return QTAnchor.values[@"start"]; }
+ (QTAnchor *)middle { return QTAnchor.values[@"middle"]; }
+ (QTAnchor *)end { return QTAnchor.values[@"end"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTAnchor.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTTitleOrient
+ (NSDictionary<NSString *, QTTitleOrient *> *)values
{
    static NSDictionary<NSString *, QTTitleOrient *> *values;
    return values = values ? values : @{
        @"top": [[QTTitleOrient alloc] initWithValue:@"top"],
        @"bottom": [[QTTitleOrient alloc] initWithValue:@"bottom"],
        @"left": [[QTTitleOrient alloc] initWithValue:@"left"],
        @"right": [[QTTitleOrient alloc] initWithValue:@"right"],
    };
}

+ (QTTitleOrient *)top { return QTTitleOrient.values[@"top"]; }
+ (QTTitleOrient *)bottom { return QTTitleOrient.values[@"bottom"]; }
+ (QTTitleOrient *)left { return QTTitleOrient.values[@"left"]; }
+ (QTTitleOrient *)right { return QTTitleOrient.values[@"right"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTTitleOrient.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTParseEnum
+ (NSDictionary<NSString *, QTParseEnum *> *)values
{
    static NSDictionary<NSString *, QTParseEnum *> *values;
    return values = values ? values : @{
        @"auto": [[QTParseEnum alloc] initWithValue:@"auto"],
    };
}

+ (QTParseEnum *)parseAuto { return QTParseEnum.values[@"auto"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTParseEnum.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTDataFormatType
+ (NSDictionary<NSString *, QTDataFormatType *> *)values
{
    static NSDictionary<NSString *, QTDataFormatType *> *values;
    return values = values ? values : @{
        @"csv": [[QTDataFormatType alloc] initWithValue:@"csv"],
        @"tsv": [[QTDataFormatType alloc] initWithValue:@"tsv"],
        @"json": [[QTDataFormatType alloc] initWithValue:@"json"],
        @"topojson": [[QTDataFormatType alloc] initWithValue:@"topojson"],
    };
}

+ (QTDataFormatType *)csv { return QTDataFormatType.values[@"csv"]; }
+ (QTDataFormatType *)tsv { return QTDataFormatType.values[@"tsv"]; }
+ (QTDataFormatType *)json { return QTDataFormatType.values[@"json"]; }
+ (QTDataFormatType *)topojson { return QTDataFormatType.values[@"topojson"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTDataFormatType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTAggregateOp
+ (NSDictionary<NSString *, QTAggregateOp *> *)values
{
    static NSDictionary<NSString *, QTAggregateOp *> *values;
    return values = values ? values : @{
        @"argmax": [[QTAggregateOp alloc] initWithValue:@"argmax"],
        @"argmin": [[QTAggregateOp alloc] initWithValue:@"argmin"],
        @"average": [[QTAggregateOp alloc] initWithValue:@"average"],
        @"count": [[QTAggregateOp alloc] initWithValue:@"count"],
        @"distinct": [[QTAggregateOp alloc] initWithValue:@"distinct"],
        @"max": [[QTAggregateOp alloc] initWithValue:@"max"],
        @"mean": [[QTAggregateOp alloc] initWithValue:@"mean"],
        @"median": [[QTAggregateOp alloc] initWithValue:@"median"],
        @"min": [[QTAggregateOp alloc] initWithValue:@"min"],
        @"missing": [[QTAggregateOp alloc] initWithValue:@"missing"],
        @"q1": [[QTAggregateOp alloc] initWithValue:@"q1"],
        @"q3": [[QTAggregateOp alloc] initWithValue:@"q3"],
        @"ci0": [[QTAggregateOp alloc] initWithValue:@"ci0"],
        @"ci1": [[QTAggregateOp alloc] initWithValue:@"ci1"],
        @"stdev": [[QTAggregateOp alloc] initWithValue:@"stdev"],
        @"stdevp": [[QTAggregateOp alloc] initWithValue:@"stdevp"],
        @"sum": [[QTAggregateOp alloc] initWithValue:@"sum"],
        @"valid": [[QTAggregateOp alloc] initWithValue:@"valid"],
        @"values": [[QTAggregateOp alloc] initWithValue:@"values"],
        @"variance": [[QTAggregateOp alloc] initWithValue:@"variance"],
        @"variancep": [[QTAggregateOp alloc] initWithValue:@"variancep"],
    };
}

+ (QTAggregateOp *)argmax { return QTAggregateOp.values[@"argmax"]; }
+ (QTAggregateOp *)argmin { return QTAggregateOp.values[@"argmin"]; }
+ (QTAggregateOp *)average { return QTAggregateOp.values[@"average"]; }
+ (QTAggregateOp *)count { return QTAggregateOp.values[@"count"]; }
+ (QTAggregateOp *)distinct { return QTAggregateOp.values[@"distinct"]; }
+ (QTAggregateOp *)max { return QTAggregateOp.values[@"max"]; }
+ (QTAggregateOp *)mean { return QTAggregateOp.values[@"mean"]; }
+ (QTAggregateOp *)median { return QTAggregateOp.values[@"median"]; }
+ (QTAggregateOp *)min { return QTAggregateOp.values[@"min"]; }
+ (QTAggregateOp *)missing { return QTAggregateOp.values[@"missing"]; }
+ (QTAggregateOp *)q1 { return QTAggregateOp.values[@"q1"]; }
+ (QTAggregateOp *)q3 { return QTAggregateOp.values[@"q3"]; }
+ (QTAggregateOp *)ci0 { return QTAggregateOp.values[@"ci0"]; }
+ (QTAggregateOp *)ci1 { return QTAggregateOp.values[@"ci1"]; }
+ (QTAggregateOp *)stdev { return QTAggregateOp.values[@"stdev"]; }
+ (QTAggregateOp *)stdevp { return QTAggregateOp.values[@"stdevp"]; }
+ (QTAggregateOp *)sum { return QTAggregateOp.values[@"sum"]; }
+ (QTAggregateOp *)valid { return QTAggregateOp.values[@"valid"]; }
+ (QTAggregateOp *)aggregateOpValues { return QTAggregateOp.values[@"values"]; }
+ (QTAggregateOp *)variance { return QTAggregateOp.values[@"variance"]; }
+ (QTAggregateOp *)variancep { return QTAggregateOp.values[@"variancep"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTAggregateOp.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTTimeUnit
+ (NSDictionary<NSString *, QTTimeUnit *> *)values
{
    static NSDictionary<NSString *, QTTimeUnit *> *values;
    return values = values ? values : @{
        @"year": [[QTTimeUnit alloc] initWithValue:@"year"],
        @"quarter": [[QTTimeUnit alloc] initWithValue:@"quarter"],
        @"month": [[QTTimeUnit alloc] initWithValue:@"month"],
        @"day": [[QTTimeUnit alloc] initWithValue:@"day"],
        @"date": [[QTTimeUnit alloc] initWithValue:@"date"],
        @"hours": [[QTTimeUnit alloc] initWithValue:@"hours"],
        @"minutes": [[QTTimeUnit alloc] initWithValue:@"minutes"],
        @"seconds": [[QTTimeUnit alloc] initWithValue:@"seconds"],
        @"milliseconds": [[QTTimeUnit alloc] initWithValue:@"milliseconds"],
        @"utcyear": [[QTTimeUnit alloc] initWithValue:@"utcyear"],
        @"utcquarter": [[QTTimeUnit alloc] initWithValue:@"utcquarter"],
        @"utcmonth": [[QTTimeUnit alloc] initWithValue:@"utcmonth"],
        @"utcday": [[QTTimeUnit alloc] initWithValue:@"utcday"],
        @"utcdate": [[QTTimeUnit alloc] initWithValue:@"utcdate"],
        @"utchours": [[QTTimeUnit alloc] initWithValue:@"utchours"],
        @"utcminutes": [[QTTimeUnit alloc] initWithValue:@"utcminutes"],
        @"utcseconds": [[QTTimeUnit alloc] initWithValue:@"utcseconds"],
        @"utcmilliseconds": [[QTTimeUnit alloc] initWithValue:@"utcmilliseconds"],
        @"yearquarter": [[QTTimeUnit alloc] initWithValue:@"yearquarter"],
        @"yearquartermonth": [[QTTimeUnit alloc] initWithValue:@"yearquartermonth"],
        @"yearmonth": [[QTTimeUnit alloc] initWithValue:@"yearmonth"],
        @"yearmonthdate": [[QTTimeUnit alloc] initWithValue:@"yearmonthdate"],
        @"yearmonthdatehours": [[QTTimeUnit alloc] initWithValue:@"yearmonthdatehours"],
        @"yearmonthdatehoursminutes": [[QTTimeUnit alloc] initWithValue:@"yearmonthdatehoursminutes"],
        @"yearmonthdatehoursminutesseconds": [[QTTimeUnit alloc] initWithValue:@"yearmonthdatehoursminutesseconds"],
        @"quartermonth": [[QTTimeUnit alloc] initWithValue:@"quartermonth"],
        @"monthdate": [[QTTimeUnit alloc] initWithValue:@"monthdate"],
        @"hoursminutes": [[QTTimeUnit alloc] initWithValue:@"hoursminutes"],
        @"hoursminutesseconds": [[QTTimeUnit alloc] initWithValue:@"hoursminutesseconds"],
        @"minutesseconds": [[QTTimeUnit alloc] initWithValue:@"minutesseconds"],
        @"secondsmilliseconds": [[QTTimeUnit alloc] initWithValue:@"secondsmilliseconds"],
        @"utcyearquarter": [[QTTimeUnit alloc] initWithValue:@"utcyearquarter"],
        @"utcyearquartermonth": [[QTTimeUnit alloc] initWithValue:@"utcyearquartermonth"],
        @"utcyearmonth": [[QTTimeUnit alloc] initWithValue:@"utcyearmonth"],
        @"utcyearmonthdate": [[QTTimeUnit alloc] initWithValue:@"utcyearmonthdate"],
        @"utcyearmonthdatehours": [[QTTimeUnit alloc] initWithValue:@"utcyearmonthdatehours"],
        @"utcyearmonthdatehoursminutes": [[QTTimeUnit alloc] initWithValue:@"utcyearmonthdatehoursminutes"],
        @"utcyearmonthdatehoursminutesseconds": [[QTTimeUnit alloc] initWithValue:@"utcyearmonthdatehoursminutesseconds"],
        @"utcquartermonth": [[QTTimeUnit alloc] initWithValue:@"utcquartermonth"],
        @"utcmonthdate": [[QTTimeUnit alloc] initWithValue:@"utcmonthdate"],
        @"utchoursminutes": [[QTTimeUnit alloc] initWithValue:@"utchoursminutes"],
        @"utchoursminutesseconds": [[QTTimeUnit alloc] initWithValue:@"utchoursminutesseconds"],
        @"utcminutesseconds": [[QTTimeUnit alloc] initWithValue:@"utcminutesseconds"],
        @"utcsecondsmilliseconds": [[QTTimeUnit alloc] initWithValue:@"utcsecondsmilliseconds"],
    };
}

+ (QTTimeUnit *)year { return QTTimeUnit.values[@"year"]; }
+ (QTTimeUnit *)quarter { return QTTimeUnit.values[@"quarter"]; }
+ (QTTimeUnit *)month { return QTTimeUnit.values[@"month"]; }
+ (QTTimeUnit *)day { return QTTimeUnit.values[@"day"]; }
+ (QTTimeUnit *)date { return QTTimeUnit.values[@"date"]; }
+ (QTTimeUnit *)hours { return QTTimeUnit.values[@"hours"]; }
+ (QTTimeUnit *)minutes { return QTTimeUnit.values[@"minutes"]; }
+ (QTTimeUnit *)seconds { return QTTimeUnit.values[@"seconds"]; }
+ (QTTimeUnit *)milliseconds { return QTTimeUnit.values[@"milliseconds"]; }
+ (QTTimeUnit *)utcyear { return QTTimeUnit.values[@"utcyear"]; }
+ (QTTimeUnit *)utcquarter { return QTTimeUnit.values[@"utcquarter"]; }
+ (QTTimeUnit *)utcmonth { return QTTimeUnit.values[@"utcmonth"]; }
+ (QTTimeUnit *)utcday { return QTTimeUnit.values[@"utcday"]; }
+ (QTTimeUnit *)utcdate { return QTTimeUnit.values[@"utcdate"]; }
+ (QTTimeUnit *)utchours { return QTTimeUnit.values[@"utchours"]; }
+ (QTTimeUnit *)utcminutes { return QTTimeUnit.values[@"utcminutes"]; }
+ (QTTimeUnit *)utcseconds { return QTTimeUnit.values[@"utcseconds"]; }
+ (QTTimeUnit *)utcmilliseconds { return QTTimeUnit.values[@"utcmilliseconds"]; }
+ (QTTimeUnit *)yearquarter { return QTTimeUnit.values[@"yearquarter"]; }
+ (QTTimeUnit *)yearquartermonth { return QTTimeUnit.values[@"yearquartermonth"]; }
+ (QTTimeUnit *)yearmonth { return QTTimeUnit.values[@"yearmonth"]; }
+ (QTTimeUnit *)yearmonthdate { return QTTimeUnit.values[@"yearmonthdate"]; }
+ (QTTimeUnit *)yearmonthdatehours { return QTTimeUnit.values[@"yearmonthdatehours"]; }
+ (QTTimeUnit *)yearmonthdatehoursminutes { return QTTimeUnit.values[@"yearmonthdatehoursminutes"]; }
+ (QTTimeUnit *)yearmonthdatehoursminutesseconds { return QTTimeUnit.values[@"yearmonthdatehoursminutesseconds"]; }
+ (QTTimeUnit *)quartermonth { return QTTimeUnit.values[@"quartermonth"]; }
+ (QTTimeUnit *)monthdate { return QTTimeUnit.values[@"monthdate"]; }
+ (QTTimeUnit *)hoursminutes { return QTTimeUnit.values[@"hoursminutes"]; }
+ (QTTimeUnit *)hoursminutesseconds { return QTTimeUnit.values[@"hoursminutesseconds"]; }
+ (QTTimeUnit *)minutesseconds { return QTTimeUnit.values[@"minutesseconds"]; }
+ (QTTimeUnit *)secondsmilliseconds { return QTTimeUnit.values[@"secondsmilliseconds"]; }
+ (QTTimeUnit *)utcyearquarter { return QTTimeUnit.values[@"utcyearquarter"]; }
+ (QTTimeUnit *)utcyearquartermonth { return QTTimeUnit.values[@"utcyearquartermonth"]; }
+ (QTTimeUnit *)utcyearmonth { return QTTimeUnit.values[@"utcyearmonth"]; }
+ (QTTimeUnit *)utcyearmonthdate { return QTTimeUnit.values[@"utcyearmonthdate"]; }
+ (QTTimeUnit *)utcyearmonthdatehours { return QTTimeUnit.values[@"utcyearmonthdatehours"]; }
+ (QTTimeUnit *)utcyearmonthdatehoursminutes { return QTTimeUnit.values[@"utcyearmonthdatehoursminutes"]; }
+ (QTTimeUnit *)utcyearmonthdatehoursminutesseconds { return QTTimeUnit.values[@"utcyearmonthdatehoursminutesseconds"]; }
+ (QTTimeUnit *)utcquartermonth { return QTTimeUnit.values[@"utcquartermonth"]; }
+ (QTTimeUnit *)utcmonthdate { return QTTimeUnit.values[@"utcmonthdate"]; }
+ (QTTimeUnit *)utchoursminutes { return QTTimeUnit.values[@"utchoursminutes"]; }
+ (QTTimeUnit *)utchoursminutesseconds { return QTTimeUnit.values[@"utchoursminutesseconds"]; }
+ (QTTimeUnit *)utcminutesseconds { return QTTimeUnit.values[@"utcminutesseconds"]; }
+ (QTTimeUnit *)utcsecondsmilliseconds { return QTTimeUnit.values[@"utcsecondsmilliseconds"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTTimeUnit.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTRepeatEnum
+ (NSDictionary<NSString *, QTRepeatEnum *> *)values
{
    static NSDictionary<NSString *, QTRepeatEnum *> *values;
    return values = values ? values : @{
        @"row": [[QTRepeatEnum alloc] initWithValue:@"row"],
        @"column": [[QTRepeatEnum alloc] initWithValue:@"column"],
    };
}

+ (QTRepeatEnum *)row { return QTRepeatEnum.values[@"row"]; }
+ (QTRepeatEnum *)column { return QTRepeatEnum.values[@"column"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTRepeatEnum.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTLegendType
+ (NSDictionary<NSString *, QTLegendType *> *)values
{
    static NSDictionary<NSString *, QTLegendType *> *values;
    return values = values ? values : @{
        @"symbol": [[QTLegendType alloc] initWithValue:@"symbol"],
        @"gradient": [[QTLegendType alloc] initWithValue:@"gradient"],
    };
}

+ (QTLegendType *)symbol { return QTLegendType.values[@"symbol"]; }
+ (QTLegendType *)gradient { return QTLegendType.values[@"gradient"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTLegendType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTDomain
+ (NSDictionary<NSString *, QTDomain *> *)values
{
    static NSDictionary<NSString *, QTDomain *> *values;
    return values = values ? values : @{
        @"unaggregated": [[QTDomain alloc] initWithValue:@"unaggregated"],
    };
}

+ (QTDomain *)unaggregated { return QTDomain.values[@"unaggregated"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTDomain.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTInterpolateParamsType
+ (NSDictionary<NSString *, QTInterpolateParamsType *> *)values
{
    static NSDictionary<NSString *, QTInterpolateParamsType *> *values;
    return values = values ? values : @{
        @"rgb": [[QTInterpolateParamsType alloc] initWithValue:@"rgb"],
        @"cubehelix": [[QTInterpolateParamsType alloc] initWithValue:@"cubehelix"],
        @"cubehelix-long": [[QTInterpolateParamsType alloc] initWithValue:@"cubehelix-long"],
    };
}

+ (QTInterpolateParamsType *)rgb { return QTInterpolateParamsType.values[@"rgb"]; }
+ (QTInterpolateParamsType *)cubehelix { return QTInterpolateParamsType.values[@"cubehelix"]; }
+ (QTInterpolateParamsType *)cubehelixLong { return QTInterpolateParamsType.values[@"cubehelix-long"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTInterpolateParamsType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTNiceTime
+ (NSDictionary<NSString *, QTNiceTime *> *)values
{
    static NSDictionary<NSString *, QTNiceTime *> *values;
    return values = values ? values : @{
        @"second": [[QTNiceTime alloc] initWithValue:@"second"],
        @"minute": [[QTNiceTime alloc] initWithValue:@"minute"],
        @"hour": [[QTNiceTime alloc] initWithValue:@"hour"],
        @"day": [[QTNiceTime alloc] initWithValue:@"day"],
        @"week": [[QTNiceTime alloc] initWithValue:@"week"],
        @"month": [[QTNiceTime alloc] initWithValue:@"month"],
        @"year": [[QTNiceTime alloc] initWithValue:@"year"],
    };
}

+ (QTNiceTime *)second { return QTNiceTime.values[@"second"]; }
+ (QTNiceTime *)minute { return QTNiceTime.values[@"minute"]; }
+ (QTNiceTime *)hour { return QTNiceTime.values[@"hour"]; }
+ (QTNiceTime *)day { return QTNiceTime.values[@"day"]; }
+ (QTNiceTime *)week { return QTNiceTime.values[@"week"]; }
+ (QTNiceTime *)month { return QTNiceTime.values[@"month"]; }
+ (QTNiceTime *)year { return QTNiceTime.values[@"year"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTNiceTime.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTScaleType
+ (NSDictionary<NSString *, QTScaleType *> *)values
{
    static NSDictionary<NSString *, QTScaleType *> *values;
    return values = values ? values : @{
        @"linear": [[QTScaleType alloc] initWithValue:@"linear"],
        @"bin-linear": [[QTScaleType alloc] initWithValue:@"bin-linear"],
        @"log": [[QTScaleType alloc] initWithValue:@"log"],
        @"pow": [[QTScaleType alloc] initWithValue:@"pow"],
        @"sqrt": [[QTScaleType alloc] initWithValue:@"sqrt"],
        @"time": [[QTScaleType alloc] initWithValue:@"time"],
        @"utc": [[QTScaleType alloc] initWithValue:@"utc"],
        @"sequential": [[QTScaleType alloc] initWithValue:@"sequential"],
        @"ordinal": [[QTScaleType alloc] initWithValue:@"ordinal"],
        @"bin-ordinal": [[QTScaleType alloc] initWithValue:@"bin-ordinal"],
        @"point": [[QTScaleType alloc] initWithValue:@"point"],
        @"band": [[QTScaleType alloc] initWithValue:@"band"],
    };
}

+ (QTScaleType *)linear { return QTScaleType.values[@"linear"]; }
+ (QTScaleType *)binLinear { return QTScaleType.values[@"bin-linear"]; }
+ (QTScaleType *)log { return QTScaleType.values[@"log"]; }
+ (QTScaleType *)pow { return QTScaleType.values[@"pow"]; }
+ (QTScaleType *)sqrt { return QTScaleType.values[@"sqrt"]; }
+ (QTScaleType *)time { return QTScaleType.values[@"time"]; }
+ (QTScaleType *)utc { return QTScaleType.values[@"utc"]; }
+ (QTScaleType *)sequential { return QTScaleType.values[@"sequential"]; }
+ (QTScaleType *)ordinal { return QTScaleType.values[@"ordinal"]; }
+ (QTScaleType *)binOrdinal { return QTScaleType.values[@"bin-ordinal"]; }
+ (QTScaleType *)point { return QTScaleType.values[@"point"]; }
+ (QTScaleType *)band { return QTScaleType.values[@"band"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTScaleType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSortEnum
+ (NSDictionary<NSString *, QTSortEnum *> *)values
{
    static NSDictionary<NSString *, QTSortEnum *> *values;
    return values = values ? values : @{
        @"ascending": [[QTSortEnum alloc] initWithValue:@"ascending"],
        @"descending": [[QTSortEnum alloc] initWithValue:@"descending"],
    };
}

+ (QTSortEnum *)ascending { return QTSortEnum.values[@"ascending"]; }
+ (QTSortEnum *)descending { return QTSortEnum.values[@"descending"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSortEnum.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTType
+ (NSDictionary<NSString *, QTType *> *)values
{
    static NSDictionary<NSString *, QTType *> *values;
    return values = values ? values : @{
        @"quantitative": [[QTType alloc] initWithValue:@"quantitative"],
        @"ordinal": [[QTType alloc] initWithValue:@"ordinal"],
        @"temporal": [[QTType alloc] initWithValue:@"temporal"],
        @"nominal": [[QTType alloc] initWithValue:@"nominal"],
        @"latitude": [[QTType alloc] initWithValue:@"latitude"],
        @"longitude": [[QTType alloc] initWithValue:@"longitude"],
        @"geojson": [[QTType alloc] initWithValue:@"geojson"],
    };
}

+ (QTType *)quantitative { return QTType.values[@"quantitative"]; }
+ (QTType *)ordinal { return QTType.values[@"ordinal"]; }
+ (QTType *)temporal { return QTType.values[@"temporal"]; }
+ (QTType *)nominal { return QTType.values[@"nominal"]; }
+ (QTType *)latitude { return QTType.values[@"latitude"]; }
+ (QTType *)longitude { return QTType.values[@"longitude"]; }
+ (QTType *)geojson { return QTType.values[@"geojson"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTMark
+ (NSDictionary<NSString *, QTMark *> *)values
{
    static NSDictionary<NSString *, QTMark *> *values;
    return values = values ? values : @{
        @"area": [[QTMark alloc] initWithValue:@"area"],
        @"bar": [[QTMark alloc] initWithValue:@"bar"],
        @"line": [[QTMark alloc] initWithValue:@"line"],
        @"point": [[QTMark alloc] initWithValue:@"point"],
        @"text": [[QTMark alloc] initWithValue:@"text"],
        @"tick": [[QTMark alloc] initWithValue:@"tick"],
        @"rect": [[QTMark alloc] initWithValue:@"rect"],
        @"rule": [[QTMark alloc] initWithValue:@"rule"],
        @"circle": [[QTMark alloc] initWithValue:@"circle"],
        @"square": [[QTMark alloc] initWithValue:@"square"],
        @"geoshape": [[QTMark alloc] initWithValue:@"geoshape"],
    };
}

+ (QTMark *)area { return QTMark.values[@"area"]; }
+ (QTMark *)bar { return QTMark.values[@"bar"]; }
+ (QTMark *)line { return QTMark.values[@"line"]; }
+ (QTMark *)point { return QTMark.values[@"point"]; }
+ (QTMark *)text { return QTMark.values[@"text"]; }
+ (QTMark *)tick { return QTMark.values[@"tick"]; }
+ (QTMark *)rect { return QTMark.values[@"rect"]; }
+ (QTMark *)rule { return QTMark.values[@"rule"]; }
+ (QTMark *)circle { return QTMark.values[@"circle"]; }
+ (QTMark *)square { return QTMark.values[@"square"]; }
+ (QTMark *)geoshape { return QTMark.values[@"geoshape"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTMark.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTResolveMode
+ (NSDictionary<NSString *, QTResolveMode *> *)values
{
    static NSDictionary<NSString *, QTResolveMode *> *values;
    return values = values ? values : @{
        @"independent": [[QTResolveMode alloc] initWithValue:@"independent"],
        @"shared": [[QTResolveMode alloc] initWithValue:@"shared"],
    };
}

+ (QTResolveMode *)independent { return QTResolveMode.values[@"independent"]; }
+ (QTResolveMode *)shared { return QTResolveMode.values[@"shared"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTResolveMode.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSelectionDefType
+ (NSDictionary<NSString *, QTSelectionDefType *> *)values
{
    static NSDictionary<NSString *, QTSelectionDefType *> *values;
    return values = values ? values : @{
        @"single": [[QTSelectionDefType alloc] initWithValue:@"single"],
        @"multi": [[QTSelectionDefType alloc] initWithValue:@"multi"],
        @"interval": [[QTSelectionDefType alloc] initWithValue:@"interval"],
    };
}

+ (QTSelectionDefType *)single { return QTSelectionDefType.values[@"single"]; }
+ (QTSelectionDefType *)multi { return QTSelectionDefType.values[@"multi"]; }
+ (QTSelectionDefType *)interval { return QTSelectionDefType.values[@"interval"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSelectionDefType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:NSArray.class]) {
            result = [NSMutableArray arrayWithCapacity:[(NSArray *)collection count]];
            for (id x in collection) [result addObject:NSNullify(f(x))];
    } else if ([collection isKindOfClass:NSDictionary.class]) {
            result = [NSMutableDictionary dictionaryWithCapacity:[(NSDictionary *)collection count]];
            for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

#pragma mark - JSON serialization

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [QTTopLevel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return QTTopLevelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error)
{
    @try {
        id json = [topLevel JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingFragmentsAllowed error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = QTTopLevelToData(topLevel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation QTTopLevel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"$schema": @"schema",
        @"autosize": @"autosize",
        @"background": @"background",
        @"config": @"config",
        @"data": @"data",
        @"description": @"theDescription",
        @"encoding": @"encoding",
        @"height": @"height",
        @"mark": @"mark",
        @"name": @"name",
        @"padding": @"padding",
        @"projection": @"projection",
        @"selection": @"selection",
        @"title": @"title",
        @"transform": @"transform",
        @"width": @"width",
        @"layer": @"layer",
        @"resolve": @"resolve",
        @"facet": @"facet",
        @"spec": @"spec",
        @"repeat": @"repeat",
        @"vconcat": @"vconcat",
        @"hconcat": @"hconcat",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return QTTopLevelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTTopLevelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _config = [QTConfig fromJSONDictionary:(id)_config];
        if (!_config && dict[@"config"] && ![dict[@"config"] isKindOfClass:NSNull.class]) return nil;
        _data = [QTData fromJSONDictionary:(id)_data];
        if (!_data && dict[@"data"] && ![dict[@"data"] isKindOfClass:NSNull.class]) return nil;
        _encoding = [QTEncodingWithFacet fromJSONDictionary:(id)_encoding];
        if (!_encoding && dict[@"encoding"] && ![dict[@"encoding"] isKindOfClass:NSNull.class]) return nil;
        _projection = [QTProjection fromJSONDictionary:(id)_projection];
        if (!_projection && dict[@"projection"] && ![dict[@"projection"] isKindOfClass:NSNull.class]) return nil;
        _selection = map(_selection, λ(id x, [QTSelectionDef fromJSONDictionary:x]));
        _transform = map(_transform, λ(id x, [QTTransform fromJSONDictionary:x]));
        _layer = map(_layer, λ(id x, [QTLayerSpec fromJSONDictionary:x]));
        _resolve = [QTResolve fromJSONDictionary:(id)_resolve];
        if (!_resolve && dict[@"resolve"] && ![dict[@"resolve"] isKindOfClass:NSNull.class]) return nil;
        _facet = [QTFacetMapping fromJSONDictionary:(id)_facet];
        if (!_facet && dict[@"facet"] && ![dict[@"facet"] isKindOfClass:NSNull.class]) return nil;
        _spec = [QTSpec fromJSONDictionary:(id)_spec];
        if (!_spec && dict[@"spec"] && ![dict[@"spec"] isKindOfClass:NSNull.class]) return nil;
        _repeat = [QTRepeat fromJSONDictionary:(id)_repeat];
        if (!_repeat && dict[@"repeat"] && ![dict[@"repeat"] isKindOfClass:NSNull.class]) return nil;
        _vconcat = map(_vconcat, λ(id x, [QTSpec fromJSONDictionary:x]));
        _hconcat = map(_hconcat, λ(id x, [QTSpec fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTopLevel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTopLevel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTopLevel.properties.allValues] mutableCopy];

    for (id jsonName in QTTopLevel.properties) {
        id propertyName = QTTopLevel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"config": NSNullify([_config isKindOfClass:NSNull.class] ? nil : [_config JSONDictionary]),
        @"data": NSNullify([_data isKindOfClass:NSNull.class] ? nil : [_data JSONDictionary]),
        @"encoding": NSNullify([_encoding isKindOfClass:NSNull.class] ? nil : [_encoding JSONDictionary]),
        @"projection": NSNullify([_projection isKindOfClass:NSNull.class] ? nil : [_projection JSONDictionary]),
        @"selection": NSNullify(map(_selection, λ(id x, [x JSONDictionary]))),
        @"transform": NSNullify(map(_transform, λ(id x, [x JSONDictionary]))),
        @"layer": NSNullify(map(_layer, λ(id x, [x JSONDictionary]))),
        @"resolve": NSNullify([_resolve isKindOfClass:NSNull.class] ? nil : [_resolve JSONDictionary]),
        @"facet": NSNullify([_facet isKindOfClass:NSNull.class] ? nil : [_facet JSONDictionary]),
        @"spec": NSNullify([_spec isKindOfClass:NSNull.class] ? nil : [_spec JSONDictionary]),
        @"repeat": NSNullify([_repeat isKindOfClass:NSNull.class] ? nil : [_repeat JSONDictionary]),
        @"vconcat": NSNullify(map(_vconcat, λ(id x, [x JSONDictionary]))),
        @"hconcat": NSNullify(map(_hconcat, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return QTTopLevelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTTopLevelToJSON(self, encoding, error);
}
@end

@implementation QTAutoSizeParams
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"contains": @"contains",
        @"resize": @"resize",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAutoSizeParams alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _contains = [QTContains withValue:(id)_contains];
        if (_contains == nil && dict[@"contains"] && ![dict[@"contains"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTAutosizeType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAutoSizeParams.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAutoSizeParams.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAutoSizeParams.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"contains": NSNullify([_contains value]),
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"area": @"area",
        @"autosize": @"autosize",
        @"axis": @"axis",
        @"axisBand": @"axisBand",
        @"axisBottom": @"axisBottom",
        @"axisLeft": @"axisLeft",
        @"axisRight": @"axisRight",
        @"axisTop": @"axisTop",
        @"axisX": @"axisX",
        @"axisY": @"axisY",
        @"background": @"background",
        @"bar": @"bar",
        @"circle": @"circle",
        @"countTitle": @"countTitle",
        @"fieldTitle": @"fieldTitle",
        @"geoshape": @"geoshape",
        @"invalidValues": @"invalidValues",
        @"legend": @"legend",
        @"line": @"line",
        @"mark": @"mark",
        @"numberFormat": @"numberFormat",
        @"padding": @"padding",
        @"point": @"point",
        @"projection": @"projection",
        @"range": @"range",
        @"rect": @"rect",
        @"rule": @"rule",
        @"scale": @"scale",
        @"selection": @"selection",
        @"square": @"square",
        @"stack": @"stack",
        @"style": @"style",
        @"text": @"text",
        @"tick": @"tick",
        @"timeFormat": @"timeFormat",
        @"title": @"title",
        @"view": @"view",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _area = [QTMarkConfig fromJSONDictionary:(id)_area];
        if (!_area && dict[@"area"] && ![dict[@"area"] isKindOfClass:NSNull.class]) return nil;
        _axis = [QTAxisConfig fromJSONDictionary:(id)_axis];
        if (!_axis && dict[@"axis"] && ![dict[@"axis"] isKindOfClass:NSNull.class]) return nil;
        _axisBand = [QTVGAxisConfig fromJSONDictionary:(id)_axisBand];
        if (!_axisBand && dict[@"axisBand"] && ![dict[@"axisBand"] isKindOfClass:NSNull.class]) return nil;
        _axisBottom = [QTVGAxisConfig fromJSONDictionary:(id)_axisBottom];
        if (!_axisBottom && dict[@"axisBottom"] && ![dict[@"axisBottom"] isKindOfClass:NSNull.class]) return nil;
        _axisLeft = [QTVGAxisConfig fromJSONDictionary:(id)_axisLeft];
        if (!_axisLeft && dict[@"axisLeft"] && ![dict[@"axisLeft"] isKindOfClass:NSNull.class]) return nil;
        _axisRight = [QTVGAxisConfig fromJSONDictionary:(id)_axisRight];
        if (!_axisRight && dict[@"axisRight"] && ![dict[@"axisRight"] isKindOfClass:NSNull.class]) return nil;
        _axisTop = [QTVGAxisConfig fromJSONDictionary:(id)_axisTop];
        if (!_axisTop && dict[@"axisTop"] && ![dict[@"axisTop"] isKindOfClass:NSNull.class]) return nil;
        _axisX = [QTVGAxisConfig fromJSONDictionary:(id)_axisX];
        if (!_axisX && dict[@"axisX"] && ![dict[@"axisX"] isKindOfClass:NSNull.class]) return nil;
        _axisY = [QTVGAxisConfig fromJSONDictionary:(id)_axisY];
        if (!_axisY && dict[@"axisY"] && ![dict[@"axisY"] isKindOfClass:NSNull.class]) return nil;
        _bar = [QTBarConfig fromJSONDictionary:(id)_bar];
        if (!_bar && dict[@"bar"] && ![dict[@"bar"] isKindOfClass:NSNull.class]) return nil;
        _circle = [QTMarkConfig fromJSONDictionary:(id)_circle];
        if (!_circle && dict[@"circle"] && ![dict[@"circle"] isKindOfClass:NSNull.class]) return nil;
        _fieldTitle = [QTFieldTitle withValue:(id)_fieldTitle];
        if (_fieldTitle == nil && dict[@"fieldTitle"] && ![dict[@"fieldTitle"] isKindOfClass:NSNull.class]) return nil;
        _geoshape = [QTMarkConfig fromJSONDictionary:(id)_geoshape];
        if (!_geoshape && dict[@"geoshape"] && ![dict[@"geoshape"] isKindOfClass:NSNull.class]) return nil;
        _invalidValues = [QTInvalidValues withValue:(id)_invalidValues];
        if (_invalidValues == nil && dict[@"invalidValues"] && ![dict[@"invalidValues"] isKindOfClass:NSNull.class]) return nil;
        _legend = [QTLegendConfig fromJSONDictionary:(id)_legend];
        if (!_legend && dict[@"legend"] && ![dict[@"legend"] isKindOfClass:NSNull.class]) return nil;
        _line = [QTMarkConfig fromJSONDictionary:(id)_line];
        if (!_line && dict[@"line"] && ![dict[@"line"] isKindOfClass:NSNull.class]) return nil;
        _mark = [QTMarkConfig fromJSONDictionary:(id)_mark];
        if (!_mark && dict[@"mark"] && ![dict[@"mark"] isKindOfClass:NSNull.class]) return nil;
        _point = [QTMarkConfig fromJSONDictionary:(id)_point];
        if (!_point && dict[@"point"] && ![dict[@"point"] isKindOfClass:NSNull.class]) return nil;
        _projection = [QTProjectionConfig fromJSONDictionary:(id)_projection];
        if (!_projection && dict[@"projection"] && ![dict[@"projection"] isKindOfClass:NSNull.class]) return nil;
        _rect = [QTMarkConfig fromJSONDictionary:(id)_rect];
        if (!_rect && dict[@"rect"] && ![dict[@"rect"] isKindOfClass:NSNull.class]) return nil;
        _rule = [QTMarkConfig fromJSONDictionary:(id)_rule];
        if (!_rule && dict[@"rule"] && ![dict[@"rule"] isKindOfClass:NSNull.class]) return nil;
        _scale = [QTScaleConfig fromJSONDictionary:(id)_scale];
        if (!_scale && dict[@"scale"] && ![dict[@"scale"] isKindOfClass:NSNull.class]) return nil;
        _selection = [QTSelectionConfig fromJSONDictionary:(id)_selection];
        if (!_selection && dict[@"selection"] && ![dict[@"selection"] isKindOfClass:NSNull.class]) return nil;
        _square = [QTMarkConfig fromJSONDictionary:(id)_square];
        if (!_square && dict[@"square"] && ![dict[@"square"] isKindOfClass:NSNull.class]) return nil;
        _stack = [QTStackOffset withValue:(id)_stack];
        if (_stack == nil && dict[@"stack"] && ![dict[@"stack"] isKindOfClass:NSNull.class]) return nil;
        _style = map(_style, λ(id x, [QTVGMarkConfig fromJSONDictionary:x]));
        _text = [QTTextConfig fromJSONDictionary:(id)_text];
        if (!_text && dict[@"text"] && ![dict[@"text"] isKindOfClass:NSNull.class]) return nil;
        _tick = [QTTickConfig fromJSONDictionary:(id)_tick];
        if (!_tick && dict[@"tick"] && ![dict[@"tick"] isKindOfClass:NSNull.class]) return nil;
        _title = [QTVGTitleConfig fromJSONDictionary:(id)_title];
        if (!_title && dict[@"title"] && ![dict[@"title"] isKindOfClass:NSNull.class]) return nil;
        _view = [QTViewConfig fromJSONDictionary:(id)_view];
        if (!_view && dict[@"view"] && ![dict[@"view"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"area": NSNullify([_area isKindOfClass:NSNull.class] ? nil : [_area JSONDictionary]),
        @"axis": NSNullify([_axis isKindOfClass:NSNull.class] ? nil : [_axis JSONDictionary]),
        @"axisBand": NSNullify([_axisBand isKindOfClass:NSNull.class] ? nil : [_axisBand JSONDictionary]),
        @"axisBottom": NSNullify([_axisBottom isKindOfClass:NSNull.class] ? nil : [_axisBottom JSONDictionary]),
        @"axisLeft": NSNullify([_axisLeft isKindOfClass:NSNull.class] ? nil : [_axisLeft JSONDictionary]),
        @"axisRight": NSNullify([_axisRight isKindOfClass:NSNull.class] ? nil : [_axisRight JSONDictionary]),
        @"axisTop": NSNullify([_axisTop isKindOfClass:NSNull.class] ? nil : [_axisTop JSONDictionary]),
        @"axisX": NSNullify([_axisX isKindOfClass:NSNull.class] ? nil : [_axisX JSONDictionary]),
        @"axisY": NSNullify([_axisY isKindOfClass:NSNull.class] ? nil : [_axisY JSONDictionary]),
        @"bar": NSNullify([_bar isKindOfClass:NSNull.class] ? nil : [_bar JSONDictionary]),
        @"circle": NSNullify([_circle isKindOfClass:NSNull.class] ? nil : [_circle JSONDictionary]),
        @"fieldTitle": NSNullify([_fieldTitle value]),
        @"geoshape": NSNullify([_geoshape isKindOfClass:NSNull.class] ? nil : [_geoshape JSONDictionary]),
        @"invalidValues": NSNullify([_invalidValues value]),
        @"legend": NSNullify([_legend isKindOfClass:NSNull.class] ? nil : [_legend JSONDictionary]),
        @"line": NSNullify([_line isKindOfClass:NSNull.class] ? nil : [_line JSONDictionary]),
        @"mark": NSNullify([_mark isKindOfClass:NSNull.class] ? nil : [_mark JSONDictionary]),
        @"point": NSNullify([_point isKindOfClass:NSNull.class] ? nil : [_point JSONDictionary]),
        @"projection": NSNullify([_projection isKindOfClass:NSNull.class] ? nil : [_projection JSONDictionary]),
        @"rect": NSNullify([_rect isKindOfClass:NSNull.class] ? nil : [_rect JSONDictionary]),
        @"rule": NSNullify([_rule isKindOfClass:NSNull.class] ? nil : [_rule JSONDictionary]),
        @"scale": NSNullify([_scale isKindOfClass:NSNull.class] ? nil : [_scale JSONDictionary]),
        @"selection": NSNullify([_selection isKindOfClass:NSNull.class] ? nil : [_selection JSONDictionary]),
        @"square": NSNullify([_square isKindOfClass:NSNull.class] ? nil : [_square JSONDictionary]),
        @"stack": NSNullify([_stack value]),
        @"style": NSNullify(map(_style, λ(id x, [x JSONDictionary]))),
        @"text": NSNullify([_text isKindOfClass:NSNull.class] ? nil : [_text JSONDictionary]),
        @"tick": NSNullify([_tick isKindOfClass:NSNull.class] ? nil : [_tick JSONDictionary]),
        @"title": NSNullify([_title isKindOfClass:NSNull.class] ? nil : [_title JSONDictionary]),
        @"view": NSNullify([_view isKindOfClass:NSNull.class] ? nil : [_view JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTMarkConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"align": @"align",
        @"angle": @"angle",
        @"baseline": @"baseline",
        @"color": @"color",
        @"cursor": @"cursor",
        @"dx": @"dx",
        @"dy": @"dy",
        @"fill": @"fill",
        @"filled": @"filled",
        @"fillOpacity": @"fillOpacity",
        @"font": @"font",
        @"fontSize": @"fontSize",
        @"fontStyle": @"fontStyle",
        @"fontWeight": @"fontWeight",
        @"href": @"href",
        @"interpolate": @"interpolate",
        @"limit": @"limit",
        @"opacity": @"opacity",
        @"orient": @"orient",
        @"radius": @"radius",
        @"shape": @"shape",
        @"size": @"size",
        @"stroke": @"stroke",
        @"strokeDash": @"strokeDash",
        @"strokeDashOffset": @"strokeDashOffset",
        @"strokeOpacity": @"strokeOpacity",
        @"strokeWidth": @"strokeWidth",
        @"tension": @"tension",
        @"text": @"text",
        @"theta": @"theta",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMarkConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"angle"] && [dict[@"angle"] doubleValue] < 0) return nil;
        if (dict[@"angle"] && [dict[@"angle"] doubleValue] > 360) return nil;
        if (dict[@"fillOpacity"] && [dict[@"fillOpacity"] doubleValue] < 0) return nil;
        if (dict[@"fillOpacity"] && [dict[@"fillOpacity"] doubleValue] > 1) return nil;
        if (dict[@"fontSize"] && [dict[@"fontSize"] doubleValue] < 0) return nil;
        if (dict[@"opacity"] && [dict[@"opacity"] doubleValue] < 0) return nil;
        if (dict[@"opacity"] && [dict[@"opacity"] doubleValue] > 1) return nil;
        if (dict[@"radius"] && [dict[@"radius"] doubleValue] < 0) return nil;
        if (dict[@"size"] && [dict[@"size"] doubleValue] < 0) return nil;
        if (dict[@"strokeOpacity"] && [dict[@"strokeOpacity"] doubleValue] < 0) return nil;
        if (dict[@"strokeOpacity"] && [dict[@"strokeOpacity"] doubleValue] > 1) return nil;
        if (dict[@"strokeWidth"] && [dict[@"strokeWidth"] doubleValue] < 0) return nil;
        if (dict[@"tension"] && [dict[@"tension"] doubleValue] < 0) return nil;
        if (dict[@"tension"] && [dict[@"tension"] doubleValue] > 1) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _align = [QTHorizontalAlign withValue:(id)_align];
        if (_align == nil && dict[@"align"] && ![dict[@"align"] isKindOfClass:NSNull.class]) return nil;
        _baseline = [QTVerticalAlign withValue:(id)_baseline];
        if (_baseline == nil && dict[@"baseline"] && ![dict[@"baseline"] isKindOfClass:NSNull.class]) return nil;
        _cursor = [QTCursor withValue:(id)_cursor];
        if (_cursor == nil && dict[@"cursor"] && ![dict[@"cursor"] isKindOfClass:NSNull.class]) return nil;
        _fontStyle = [QTFontStyle withValue:(id)_fontStyle];
        if (_fontStyle == nil && dict[@"fontStyle"] && ![dict[@"fontStyle"] isKindOfClass:NSNull.class]) return nil;
        _interpolate = [QTInterpolate withValue:(id)_interpolate];
        if (_interpolate == nil && dict[@"interpolate"] && ![dict[@"interpolate"] isKindOfClass:NSNull.class]) return nil;
        _orient = [QTOrient withValue:(id)_orient];
        if (_orient == nil && dict[@"orient"] && ![dict[@"orient"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMarkConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMarkConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMarkConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"align": NSNullify([_align value]),
        @"baseline": NSNullify([_baseline value]),
        @"cursor": NSNullify([_cursor value]),
        @"fontStyle": NSNullify([_fontStyle value]),
        @"interpolate": NSNullify([_interpolate value]),
        @"orient": NSNullify([_orient value]),
    }];

    return dict;
}
@end

@implementation QTAxisConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bandPosition": @"bandPosition",
        @"domain": @"domain",
        @"domainColor": @"domainColor",
        @"domainWidth": @"domainWidth",
        @"grid": @"grid",
        @"gridColor": @"gridColor",
        @"gridDash": @"gridDash",
        @"gridOpacity": @"gridOpacity",
        @"gridWidth": @"gridWidth",
        @"labelAngle": @"labelAngle",
        @"labelBound": @"labelBound",
        @"labelColor": @"labelColor",
        @"labelFlush": @"labelFlush",
        @"labelFont": @"labelFont",
        @"labelFontSize": @"labelFontSize",
        @"labelLimit": @"labelLimit",
        @"labelOverlap": @"labelOverlap",
        @"labelPadding": @"labelPadding",
        @"labels": @"labels",
        @"maxExtent": @"maxExtent",
        @"minExtent": @"minExtent",
        @"shortTimeLabels": @"shortTimeLabels",
        @"tickColor": @"tickColor",
        @"tickRound": @"tickRound",
        @"ticks": @"ticks",
        @"tickSize": @"tickSize",
        @"tickWidth": @"tickWidth",
        @"titleAlign": @"titleAlign",
        @"titleAngle": @"titleAngle",
        @"titleBaseline": @"titleBaseline",
        @"titleColor": @"titleColor",
        @"titleFont": @"titleFont",
        @"titleFontSize": @"titleFontSize",
        @"titleFontWeight": @"titleFontWeight",
        @"titleLimit": @"titleLimit",
        @"titleMaxLength": @"titleMaxLength",
        @"titlePadding": @"titlePadding",
        @"titleX": @"titleX",
        @"titleY": @"titleY",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAxisConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"gridOpacity"] && [dict[@"gridOpacity"] doubleValue] < 0) return nil;
        if (dict[@"gridOpacity"] && [dict[@"gridOpacity"] doubleValue] > 1) return nil;
        if (dict[@"gridWidth"] && [dict[@"gridWidth"] doubleValue] < 0) return nil;
        if (dict[@"labelAngle"] && [dict[@"labelAngle"] doubleValue] < -360) return nil;
        if (dict[@"labelAngle"] && [dict[@"labelAngle"] doubleValue] > 360) return nil;
        if (dict[@"labelFontSize"] && [dict[@"labelFontSize"] doubleValue] < 0) return nil;
        if (dict[@"tickSize"] && [dict[@"tickSize"] doubleValue] < 0) return nil;
        if (dict[@"tickWidth"] && [dict[@"tickWidth"] doubleValue] < 0) return nil;
        if (dict[@"titleFontSize"] && [dict[@"titleFontSize"] doubleValue] < 0) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAxisConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAxisConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTAxisConfig.properties.allValues];
}
@end

@implementation QTVGAxisConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bandPosition": @"bandPosition",
        @"domain": @"domain",
        @"domainColor": @"domainColor",
        @"domainWidth": @"domainWidth",
        @"grid": @"grid",
        @"gridColor": @"gridColor",
        @"gridDash": @"gridDash",
        @"gridOpacity": @"gridOpacity",
        @"gridWidth": @"gridWidth",
        @"labelAngle": @"labelAngle",
        @"labelBound": @"labelBound",
        @"labelColor": @"labelColor",
        @"labelFlush": @"labelFlush",
        @"labelFont": @"labelFont",
        @"labelFontSize": @"labelFontSize",
        @"labelLimit": @"labelLimit",
        @"labelOverlap": @"labelOverlap",
        @"labelPadding": @"labelPadding",
        @"labels": @"labels",
        @"maxExtent": @"maxExtent",
        @"minExtent": @"minExtent",
        @"tickColor": @"tickColor",
        @"tickRound": @"tickRound",
        @"ticks": @"ticks",
        @"tickSize": @"tickSize",
        @"tickWidth": @"tickWidth",
        @"titleAlign": @"titleAlign",
        @"titleAngle": @"titleAngle",
        @"titleBaseline": @"titleBaseline",
        @"titleColor": @"titleColor",
        @"titleFont": @"titleFont",
        @"titleFontSize": @"titleFontSize",
        @"titleFontWeight": @"titleFontWeight",
        @"titleLimit": @"titleLimit",
        @"titleMaxLength": @"titleMaxLength",
        @"titlePadding": @"titlePadding",
        @"titleX": @"titleX",
        @"titleY": @"titleY",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVGAxisConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"gridOpacity"] && [dict[@"gridOpacity"] doubleValue] < 0) return nil;
        if (dict[@"gridOpacity"] && [dict[@"gridOpacity"] doubleValue] > 1) return nil;
        if (dict[@"gridWidth"] && [dict[@"gridWidth"] doubleValue] < 0) return nil;
        if (dict[@"labelAngle"] && [dict[@"labelAngle"] doubleValue] < -360) return nil;
        if (dict[@"labelAngle"] && [dict[@"labelAngle"] doubleValue] > 360) return nil;
        if (dict[@"labelFontSize"] && [dict[@"labelFontSize"] doubleValue] < 0) return nil;
        if (dict[@"tickSize"] && [dict[@"tickSize"] doubleValue] < 0) return nil;
        if (dict[@"tickWidth"] && [dict[@"tickWidth"] doubleValue] < 0) return nil;
        if (dict[@"titleFontSize"] && [dict[@"titleFontSize"] doubleValue] < 0) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVGAxisConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVGAxisConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTVGAxisConfig.properties.allValues];
}
@end

@implementation QTBarConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"align": @"align",
        @"angle": @"angle",
        @"baseline": @"baseline",
        @"binSpacing": @"binSpacing",
        @"color": @"color",
        @"continuousBandSize": @"continuousBandSize",
        @"cursor": @"cursor",
        @"discreteBandSize": @"discreteBandSize",
        @"dx": @"dx",
        @"dy": @"dy",
        @"fill": @"fill",
        @"filled": @"filled",
        @"fillOpacity": @"fillOpacity",
        @"font": @"font",
        @"fontSize": @"fontSize",
        @"fontStyle": @"fontStyle",
        @"fontWeight": @"fontWeight",
        @"href": @"href",
        @"interpolate": @"interpolate",
        @"limit": @"limit",
        @"opacity": @"opacity",
        @"orient": @"orient",
        @"radius": @"radius",
        @"shape": @"shape",
        @"size": @"size",
        @"stroke": @"stroke",
        @"strokeDash": @"strokeDash",
        @"strokeDashOffset": @"strokeDashOffset",
        @"strokeOpacity": @"strokeOpacity",
        @"strokeWidth": @"strokeWidth",
        @"tension": @"tension",
        @"text": @"text",
        @"theta": @"theta",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBarConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"angle"] && [dict[@"angle"] doubleValue] < 0) return nil;
        if (dict[@"angle"] && [dict[@"angle"] doubleValue] > 360) return nil;
        if (dict[@"binSpacing"] && [dict[@"binSpacing"] doubleValue] < 0) return nil;
        if (dict[@"continuousBandSize"] && [dict[@"continuousBandSize"] doubleValue] < 0) return nil;
        if (dict[@"discreteBandSize"] && [dict[@"discreteBandSize"] doubleValue] < 0) return nil;
        if (dict[@"fillOpacity"] && [dict[@"fillOpacity"] doubleValue] < 0) return nil;
        if (dict[@"fillOpacity"] && [dict[@"fillOpacity"] doubleValue] > 1) return nil;
        if (dict[@"fontSize"] && [dict[@"fontSize"] doubleValue] < 0) return nil;
        if (dict[@"opacity"] && [dict[@"opacity"] doubleValue] < 0) return nil;
        if (dict[@"opacity"] && [dict[@"opacity"] doubleValue] > 1) return nil;
        if (dict[@"radius"] && [dict[@"radius"] doubleValue] < 0) return nil;
        if (dict[@"size"] && [dict[@"size"] doubleValue] < 0) return nil;
        if (dict[@"strokeOpacity"] && [dict[@"strokeOpacity"] doubleValue] < 0) return nil;
        if (dict[@"strokeOpacity"] && [dict[@"strokeOpacity"] doubleValue] > 1) return nil;
        if (dict[@"strokeWidth"] && [dict[@"strokeWidth"] doubleValue] < 0) return nil;
        if (dict[@"tension"] && [dict[@"tension"] doubleValue] < 0) return nil;
        if (dict[@"tension"] && [dict[@"tension"] doubleValue] > 1) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _align = [QTHorizontalAlign withValue:(id)_align];
        if (_align == nil && dict[@"align"] && ![dict[@"align"] isKindOfClass:NSNull.class]) return nil;
        _baseline = [QTVerticalAlign withValue:(id)_baseline];
        if (_baseline == nil && dict[@"baseline"] && ![dict[@"baseline"] isKindOfClass:NSNull.class]) return nil;
        _cursor = [QTCursor withValue:(id)_cursor];
        if (_cursor == nil && dict[@"cursor"] && ![dict[@"cursor"] isKindOfClass:NSNull.class]) return nil;
        _fontStyle = [QTFontStyle withValue:(id)_fontStyle];
        if (_fontStyle == nil && dict[@"fontStyle"] && ![dict[@"fontStyle"] isKindOfClass:NSNull.class]) return nil;
        _interpolate = [QTInterpolate withValue:(id)_interpolate];
        if (_interpolate == nil && dict[@"interpolate"] && ![dict[@"interpolate"] isKindOfClass:NSNull.class]) return nil;
        _orient = [QTOrient withValue:(id)_orient];
        if (_orient == nil && dict[@"orient"] && ![dict[@"orient"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBarConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBarConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTBarConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"align": NSNullify([_align value]),
        @"baseline": NSNullify([_baseline value]),
        @"cursor": NSNullify([_cursor value]),
        @"fontStyle": NSNullify([_fontStyle value]),
        @"interpolate": NSNullify([_interpolate value]),
        @"orient": NSNullify([_orient value]),
    }];

    return dict;
}
@end

@implementation QTLegendConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"cornerRadius": @"cornerRadius",
        @"entryPadding": @"entryPadding",
        @"fillColor": @"fillColor",
        @"gradientHeight": @"gradientHeight",
        @"gradientLabelBaseline": @"gradientLabelBaseline",
        @"gradientLabelLimit": @"gradientLabelLimit",
        @"gradientLabelOffset": @"gradientLabelOffset",
        @"gradientStrokeColor": @"gradientStrokeColor",
        @"gradientStrokeWidth": @"gradientStrokeWidth",
        @"gradientWidth": @"gradientWidth",
        @"labelAlign": @"labelAlign",
        @"labelBaseline": @"labelBaseline",
        @"labelColor": @"labelColor",
        @"labelFont": @"labelFont",
        @"labelFontSize": @"labelFontSize",
        @"labelLimit": @"labelLimit",
        @"labelOffset": @"labelOffset",
        @"offset": @"offset",
        @"orient": @"orient",
        @"padding": @"padding",
        @"shortTimeLabels": @"shortTimeLabels",
        @"strokeColor": @"strokeColor",
        @"strokeDash": @"strokeDash",
        @"strokeWidth": @"strokeWidth",
        @"symbolColor": @"symbolColor",
        @"symbolSize": @"symbolSize",
        @"symbolStrokeWidth": @"symbolStrokeWidth",
        @"symbolType": @"symbolType",
        @"titleAlign": @"titleAlign",
        @"titleBaseline": @"titleBaseline",
        @"titleColor": @"titleColor",
        @"titleFont": @"titleFont",
        @"titleFontSize": @"titleFontSize",
        @"titleFontWeight": @"titleFontWeight",
        @"titleLimit": @"titleLimit",
        @"titlePadding": @"titlePadding",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLegendConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"gradientHeight"] && [dict[@"gradientHeight"] doubleValue] < 0) return nil;
        if (dict[@"gradientStrokeWidth"] && [dict[@"gradientStrokeWidth"] doubleValue] < 0) return nil;
        if (dict[@"gradientWidth"] && [dict[@"gradientWidth"] doubleValue] < 0) return nil;
        if (dict[@"labelFontSize"] && [dict[@"labelFontSize"] doubleValue] < 0) return nil;
        if (dict[@"labelOffset"] && [dict[@"labelOffset"] doubleValue] < 0) return nil;
        if (dict[@"symbolSize"] && [dict[@"symbolSize"] doubleValue] < 0) return nil;
        if (dict[@"symbolStrokeWidth"] && [dict[@"symbolStrokeWidth"] doubleValue] < 0) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _orient = [QTLegendOrient withValue:(id)_orient];
        if (_orient == nil && dict[@"orient"] && ![dict[@"orient"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLegendConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLegendConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLegendConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"orient": NSNullify([_orient value]),
    }];

    return dict;
}
@end

@implementation QTPaddingClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bottom": @"bottom",
        @"left": @"left",
        @"right": @"right",
        @"top": @"top",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPaddingClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPaddingClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPaddingClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPaddingClass.properties.allValues];
}
@end

@implementation QTProjectionConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"center": @"center",
        @"clipAngle": @"clipAngle",
        @"clipExtent": @"clipExtent",
        @"coefficient": @"coefficient",
        @"distance": @"distance",
        @"fraction": @"fraction",
        @"lobes": @"lobes",
        @"parallel": @"parallel",
        @"precision": @"precision",
        @"radius": @"radius",
        @"ratio": @"ratio",
        @"rotate": @"rotate",
        @"spacing": @"spacing",
        @"tilt": @"tilt",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTProjectionConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _type = [QTVGProjectionType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTProjectionConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTProjectionConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTProjectionConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTVGScheme
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"count": @"count",
        @"extent": @"extent",
        @"scheme": @"scheme",
        @"step": @"step",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVGScheme alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVGScheme.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVGScheme.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTVGScheme.properties.allValues];
}
@end

@implementation QTScaleConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bandPaddingInner": @"bandPaddingInner",
        @"bandPaddingOuter": @"bandPaddingOuter",
        @"clamp": @"clamp",
        @"continuousPadding": @"continuousPadding",
        @"maxBandSize": @"maxBandSize",
        @"maxFontSize": @"maxFontSize",
        @"maxOpacity": @"maxOpacity",
        @"maxSize": @"maxSize",
        @"maxStrokeWidth": @"maxStrokeWidth",
        @"minBandSize": @"minBandSize",
        @"minFontSize": @"minFontSize",
        @"minOpacity": @"minOpacity",
        @"minSize": @"minSize",
        @"minStrokeWidth": @"minStrokeWidth",
        @"pointPadding": @"pointPadding",
        @"rangeStep": @"rangeStep",
        @"round": @"round",
        @"textXRangeStep": @"textXRangeStep",
        @"useUnaggregatedDomain": @"useUnaggregatedDomain",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTScaleConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"bandPaddingInner"] && [dict[@"bandPaddingInner"] doubleValue] < 0) return nil;
        if (dict[@"bandPaddingInner"] && [dict[@"bandPaddingInner"] doubleValue] > 1) return nil;
        if (dict[@"bandPaddingOuter"] && [dict[@"bandPaddingOuter"] doubleValue] < 0) return nil;
        if (dict[@"bandPaddingOuter"] && [dict[@"bandPaddingOuter"] doubleValue] > 1) return nil;
        if (dict[@"continuousPadding"] && [dict[@"continuousPadding"] doubleValue] < 0) return nil;
        if (dict[@"maxBandSize"] && [dict[@"maxBandSize"] doubleValue] < 0) return nil;
        if (dict[@"maxFontSize"] && [dict[@"maxFontSize"] doubleValue] < 0) return nil;
        if (dict[@"maxOpacity"] && [dict[@"maxOpacity"] doubleValue] < 0) return nil;
        if (dict[@"maxOpacity"] && [dict[@"maxOpacity"] doubleValue] > 1) return nil;
        if (dict[@"maxSize"] && [dict[@"maxSize"] doubleValue] < 0) return nil;
        if (dict[@"maxStrokeWidth"] && [dict[@"maxStrokeWidth"] doubleValue] < 0) return nil;
        if (dict[@"minBandSize"] && [dict[@"minBandSize"] doubleValue] < 0) return nil;
        if (dict[@"minFontSize"] && [dict[@"minFontSize"] doubleValue] < 0) return nil;
        if (dict[@"minOpacity"] && [dict[@"minOpacity"] doubleValue] < 0) return nil;
        if (dict[@"minOpacity"] && [dict[@"minOpacity"] doubleValue] > 1) return nil;
        if (dict[@"minSize"] && [dict[@"minSize"] doubleValue] < 0) return nil;
        if (dict[@"minStrokeWidth"] && [dict[@"minStrokeWidth"] doubleValue] < 0) return nil;
        if (dict[@"pointPadding"] && [dict[@"pointPadding"] doubleValue] < 0) return nil;
        if (dict[@"pointPadding"] && [dict[@"pointPadding"] doubleValue] > 1) return nil;
        if (dict[@"textXRangeStep"] && [dict[@"textXRangeStep"] doubleValue] < 0) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTScaleConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTScaleConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTScaleConfig.properties.allValues];
}
@end

@implementation QTSelectionConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"interval": @"interval",
        @"multi": @"multi",
        @"single": @"single",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSelectionConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _interval = [QTIntervalSelectionConfig fromJSONDictionary:(id)_interval];
        if (!_interval && dict[@"interval"] && ![dict[@"interval"] isKindOfClass:NSNull.class]) return nil;
        _multi = [QTMultiSelectionConfig fromJSONDictionary:(id)_multi];
        if (!_multi && dict[@"multi"] && ![dict[@"multi"] isKindOfClass:NSNull.class]) return nil;
        _single = [QTSingleSelectionConfig fromJSONDictionary:(id)_single];
        if (!_single && dict[@"single"] && ![dict[@"single"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSelectionConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSelectionConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSelectionConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"interval": NSNullify([_interval isKindOfClass:NSNull.class] ? nil : [_interval JSONDictionary]),
        @"multi": NSNullify([_multi isKindOfClass:NSNull.class] ? nil : [_multi JSONDictionary]),
        @"single": NSNullify([_single isKindOfClass:NSNull.class] ? nil : [_single JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTIntervalSelectionConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bind": @"bind",
        @"empty": @"empty",
        @"encodings": @"encodings",
        @"fields": @"fields",
        @"mark": @"mark",
        @"on": @"on",
        @"resolve": @"resolve",
        @"translate": @"translate",
        @"zoom": @"zoom",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIntervalSelectionConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _bind = [QTBindEnum withValue:(id)_bind];
        if (_bind == nil && dict[@"bind"] && ![dict[@"bind"] isKindOfClass:NSNull.class]) return nil;
        _empty = [QTEmpty withValue:(id)_empty];
        if (_empty == nil && dict[@"empty"] && ![dict[@"empty"] isKindOfClass:NSNull.class]) return nil;
        _encodings = map(_encodings, λ(id x, [QTSingleDefChannel withValue:x]));
        _mark = [QTBrushConfig fromJSONDictionary:(id)_mark];
        if (!_mark && dict[@"mark"] && ![dict[@"mark"] isKindOfClass:NSNull.class]) return nil;
        _resolve = [QTSelectionResolution withValue:(id)_resolve];
        if (_resolve == nil && dict[@"resolve"] && ![dict[@"resolve"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIntervalSelectionConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIntervalSelectionConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIntervalSelectionConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"bind": NSNullify([_bind value]),
        @"empty": NSNullify([_empty value]),
        @"encodings": NSNullify(map(_encodings, λ(id x, [x value]))),
        @"mark": NSNullify([_mark isKindOfClass:NSNull.class] ? nil : [_mark JSONDictionary]),
        @"resolve": NSNullify([_resolve value]),
    }];

    return dict;
}
@end

@implementation QTBrushConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"fill": @"fill",
        @"fillOpacity": @"fillOpacity",
        @"stroke": @"stroke",
        @"strokeDash": @"strokeDash",
        @"strokeDashOffset": @"strokeDashOffset",
        @"strokeOpacity": @"strokeOpacity",
        @"strokeWidth": @"strokeWidth",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBrushConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBrushConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBrushConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTBrushConfig.properties.allValues];
}
@end

@implementation QTMultiSelectionConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"empty": @"empty",
        @"encodings": @"encodings",
        @"fields": @"fields",
        @"nearest": @"nearest",
        @"on": @"on",
        @"resolve": @"resolve",
        @"toggle": @"toggle",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMultiSelectionConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _empty = [QTEmpty withValue:(id)_empty];
        if (_empty == nil && dict[@"empty"] && ![dict[@"empty"] isKindOfClass:NSNull.class]) return nil;
        _encodings = map(_encodings, λ(id x, [QTSingleDefChannel withValue:x]));
        _resolve = [QTSelectionResolution withValue:(id)_resolve];
        if (_resolve == nil && dict[@"resolve"] && ![dict[@"resolve"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMultiSelectionConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMultiSelectionConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMultiSelectionConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"empty": NSNullify([_empty value]),
        @"encodings": NSNullify(map(_encodings, λ(id x, [x value]))),
        @"resolve": NSNullify([_resolve value]),
    }];

    return dict;
}
@end

@implementation QTSingleSelectionConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bind": @"bind",
        @"empty": @"empty",
        @"encodings": @"encodings",
        @"fields": @"fields",
        @"nearest": @"nearest",
        @"on": @"on",
        @"resolve": @"resolve",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSingleSelectionConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _bind = map(_bind, λ(id x, [QTVGBinding fromJSONDictionary:x]));
        _empty = [QTEmpty withValue:(id)_empty];
        if (_empty == nil && dict[@"empty"] && ![dict[@"empty"] isKindOfClass:NSNull.class]) return nil;
        _encodings = map(_encodings, λ(id x, [QTSingleDefChannel withValue:x]));
        _resolve = [QTSelectionResolution withValue:(id)_resolve];
        if (_resolve == nil && dict[@"resolve"] && ![dict[@"resolve"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSingleSelectionConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSingleSelectionConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSingleSelectionConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"bind": NSNullify(map(_bind, λ(id x, [x JSONDictionary]))),
        @"empty": NSNullify([_empty value]),
        @"encodings": NSNullify(map(_encodings, λ(id x, [x value]))),
        @"resolve": NSNullify([_resolve value]),
    }];

    return dict;
}
@end

@implementation QTVGBinding
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"element": @"element",
        @"input": @"input",
        @"options": @"options",
        @"max": @"max",
        @"min": @"min",
        @"step": @"step",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVGBinding alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"input"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVGBinding.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVGBinding.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTVGBinding.properties.allValues];
}
@end

@implementation QTVGMarkConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"align": @"align",
        @"angle": @"angle",
        @"baseline": @"baseline",
        @"cursor": @"cursor",
        @"dx": @"dx",
        @"dy": @"dy",
        @"fill": @"fill",
        @"fillOpacity": @"fillOpacity",
        @"font": @"font",
        @"fontSize": @"fontSize",
        @"fontStyle": @"fontStyle",
        @"fontWeight": @"fontWeight",
        @"href": @"href",
        @"interpolate": @"interpolate",
        @"limit": @"limit",
        @"opacity": @"opacity",
        @"orient": @"orient",
        @"radius": @"radius",
        @"shape": @"shape",
        @"size": @"size",
        @"stroke": @"stroke",
        @"strokeDash": @"strokeDash",
        @"strokeDashOffset": @"strokeDashOffset",
        @"strokeOpacity": @"strokeOpacity",
        @"strokeWidth": @"strokeWidth",
        @"tension": @"tension",
        @"text": @"text",
        @"theta": @"theta",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVGMarkConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"angle"] && [dict[@"angle"] doubleValue] < 0) return nil;
        if (dict[@"angle"] && [dict[@"angle"] doubleValue] > 360) return nil;
        if (dict[@"fillOpacity"] && [dict[@"fillOpacity"] doubleValue] < 0) return nil;
        if (dict[@"fillOpacity"] && [dict[@"fillOpacity"] doubleValue] > 1) return nil;
        if (dict[@"fontSize"] && [dict[@"fontSize"] doubleValue] < 0) return nil;
        if (dict[@"opacity"] && [dict[@"opacity"] doubleValue] < 0) return nil;
        if (dict[@"opacity"] && [dict[@"opacity"] doubleValue] > 1) return nil;
        if (dict[@"radius"] && [dict[@"radius"] doubleValue] < 0) return nil;
        if (dict[@"size"] && [dict[@"size"] doubleValue] < 0) return nil;
        if (dict[@"strokeOpacity"] && [dict[@"strokeOpacity"] doubleValue] < 0) return nil;
        if (dict[@"strokeOpacity"] && [dict[@"strokeOpacity"] doubleValue] > 1) return nil;
        if (dict[@"strokeWidth"] && [dict[@"strokeWidth"] doubleValue] < 0) return nil;
        if (dict[@"tension"] && [dict[@"tension"] doubleValue] < 0) return nil;
        if (dict[@"tension"] && [dict[@"tension"] doubleValue] > 1) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _align = [QTHorizontalAlign withValue:(id)_align];
        if (_align == nil && dict[@"align"] && ![dict[@"align"] isKindOfClass:NSNull.class]) return nil;
        _baseline = [QTVerticalAlign withValue:(id)_baseline];
        if (_baseline == nil && dict[@"baseline"] && ![dict[@"baseline"] isKindOfClass:NSNull.class]) return nil;
        _cursor = [QTCursor withValue:(id)_cursor];
        if (_cursor == nil && dict[@"cursor"] && ![dict[@"cursor"] isKindOfClass:NSNull.class]) return nil;
        _fontStyle = [QTFontStyle withValue:(id)_fontStyle];
        if (_fontStyle == nil && dict[@"fontStyle"] && ![dict[@"fontStyle"] isKindOfClass:NSNull.class]) return nil;
        _interpolate = [QTInterpolate withValue:(id)_interpolate];
        if (_interpolate == nil && dict[@"interpolate"] && ![dict[@"interpolate"] isKindOfClass:NSNull.class]) return nil;
        _orient = [QTOrient withValue:(id)_orient];
        if (_orient == nil && dict[@"orient"] && ![dict[@"orient"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVGMarkConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVGMarkConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTVGMarkConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"align": NSNullify([_align value]),
        @"baseline": NSNullify([_baseline value]),
        @"cursor": NSNullify([_cursor value]),
        @"fontStyle": NSNullify([_fontStyle value]),
        @"interpolate": NSNullify([_interpolate value]),
        @"orient": NSNullify([_orient value]),
    }];

    return dict;
}
@end

@implementation QTTextConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"align": @"align",
        @"angle": @"angle",
        @"baseline": @"baseline",
        @"color": @"color",
        @"cursor": @"cursor",
        @"dx": @"dx",
        @"dy": @"dy",
        @"fill": @"fill",
        @"filled": @"filled",
        @"fillOpacity": @"fillOpacity",
        @"font": @"font",
        @"fontSize": @"fontSize",
        @"fontStyle": @"fontStyle",
        @"fontWeight": @"fontWeight",
        @"href": @"href",
        @"interpolate": @"interpolate",
        @"limit": @"limit",
        @"opacity": @"opacity",
        @"orient": @"orient",
        @"radius": @"radius",
        @"shape": @"shape",
        @"shortTimeLabels": @"shortTimeLabels",
        @"size": @"size",
        @"stroke": @"stroke",
        @"strokeDash": @"strokeDash",
        @"strokeDashOffset": @"strokeDashOffset",
        @"strokeOpacity": @"strokeOpacity",
        @"strokeWidth": @"strokeWidth",
        @"tension": @"tension",
        @"text": @"text",
        @"theta": @"theta",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTextConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"angle"] && [dict[@"angle"] doubleValue] < 0) return nil;
        if (dict[@"angle"] && [dict[@"angle"] doubleValue] > 360) return nil;
        if (dict[@"fillOpacity"] && [dict[@"fillOpacity"] doubleValue] < 0) return nil;
        if (dict[@"fillOpacity"] && [dict[@"fillOpacity"] doubleValue] > 1) return nil;
        if (dict[@"fontSize"] && [dict[@"fontSize"] doubleValue] < 0) return nil;
        if (dict[@"opacity"] && [dict[@"opacity"] doubleValue] < 0) return nil;
        if (dict[@"opacity"] && [dict[@"opacity"] doubleValue] > 1) return nil;
        if (dict[@"radius"] && [dict[@"radius"] doubleValue] < 0) return nil;
        if (dict[@"size"] && [dict[@"size"] doubleValue] < 0) return nil;
        if (dict[@"strokeOpacity"] && [dict[@"strokeOpacity"] doubleValue] < 0) return nil;
        if (dict[@"strokeOpacity"] && [dict[@"strokeOpacity"] doubleValue] > 1) return nil;
        if (dict[@"strokeWidth"] && [dict[@"strokeWidth"] doubleValue] < 0) return nil;
        if (dict[@"tension"] && [dict[@"tension"] doubleValue] < 0) return nil;
        if (dict[@"tension"] && [dict[@"tension"] doubleValue] > 1) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _align = [QTHorizontalAlign withValue:(id)_align];
        if (_align == nil && dict[@"align"] && ![dict[@"align"] isKindOfClass:NSNull.class]) return nil;
        _baseline = [QTVerticalAlign withValue:(id)_baseline];
        if (_baseline == nil && dict[@"baseline"] && ![dict[@"baseline"] isKindOfClass:NSNull.class]) return nil;
        _cursor = [QTCursor withValue:(id)_cursor];
        if (_cursor == nil && dict[@"cursor"] && ![dict[@"cursor"] isKindOfClass:NSNull.class]) return nil;
        _fontStyle = [QTFontStyle withValue:(id)_fontStyle];
        if (_fontStyle == nil && dict[@"fontStyle"] && ![dict[@"fontStyle"] isKindOfClass:NSNull.class]) return nil;
        _interpolate = [QTInterpolate withValue:(id)_interpolate];
        if (_interpolate == nil && dict[@"interpolate"] && ![dict[@"interpolate"] isKindOfClass:NSNull.class]) return nil;
        _orient = [QTOrient withValue:(id)_orient];
        if (_orient == nil && dict[@"orient"] && ![dict[@"orient"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTextConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTextConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTextConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"align": NSNullify([_align value]),
        @"baseline": NSNullify([_baseline value]),
        @"cursor": NSNullify([_cursor value]),
        @"fontStyle": NSNullify([_fontStyle value]),
        @"interpolate": NSNullify([_interpolate value]),
        @"orient": NSNullify([_orient value]),
    }];

    return dict;
}
@end

@implementation QTTickConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"align": @"align",
        @"angle": @"angle",
        @"bandSize": @"bandSize",
        @"baseline": @"baseline",
        @"color": @"color",
        @"cursor": @"cursor",
        @"dx": @"dx",
        @"dy": @"dy",
        @"fill": @"fill",
        @"filled": @"filled",
        @"fillOpacity": @"fillOpacity",
        @"font": @"font",
        @"fontSize": @"fontSize",
        @"fontStyle": @"fontStyle",
        @"fontWeight": @"fontWeight",
        @"href": @"href",
        @"interpolate": @"interpolate",
        @"limit": @"limit",
        @"opacity": @"opacity",
        @"orient": @"orient",
        @"radius": @"radius",
        @"shape": @"shape",
        @"size": @"size",
        @"stroke": @"stroke",
        @"strokeDash": @"strokeDash",
        @"strokeDashOffset": @"strokeDashOffset",
        @"strokeOpacity": @"strokeOpacity",
        @"strokeWidth": @"strokeWidth",
        @"tension": @"tension",
        @"text": @"text",
        @"theta": @"theta",
        @"thickness": @"thickness",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTickConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"angle"] && [dict[@"angle"] doubleValue] < 0) return nil;
        if (dict[@"angle"] && [dict[@"angle"] doubleValue] > 360) return nil;
        if (dict[@"bandSize"] && [dict[@"bandSize"] doubleValue] < 0) return nil;
        if (dict[@"fillOpacity"] && [dict[@"fillOpacity"] doubleValue] < 0) return nil;
        if (dict[@"fillOpacity"] && [dict[@"fillOpacity"] doubleValue] > 1) return nil;
        if (dict[@"fontSize"] && [dict[@"fontSize"] doubleValue] < 0) return nil;
        if (dict[@"opacity"] && [dict[@"opacity"] doubleValue] < 0) return nil;
        if (dict[@"opacity"] && [dict[@"opacity"] doubleValue] > 1) return nil;
        if (dict[@"radius"] && [dict[@"radius"] doubleValue] < 0) return nil;
        if (dict[@"size"] && [dict[@"size"] doubleValue] < 0) return nil;
        if (dict[@"strokeOpacity"] && [dict[@"strokeOpacity"] doubleValue] < 0) return nil;
        if (dict[@"strokeOpacity"] && [dict[@"strokeOpacity"] doubleValue] > 1) return nil;
        if (dict[@"strokeWidth"] && [dict[@"strokeWidth"] doubleValue] < 0) return nil;
        if (dict[@"tension"] && [dict[@"tension"] doubleValue] < 0) return nil;
        if (dict[@"tension"] && [dict[@"tension"] doubleValue] > 1) return nil;
        if (dict[@"thickness"] && [dict[@"thickness"] doubleValue] < 0) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _align = [QTHorizontalAlign withValue:(id)_align];
        if (_align == nil && dict[@"align"] && ![dict[@"align"] isKindOfClass:NSNull.class]) return nil;
        _baseline = [QTVerticalAlign withValue:(id)_baseline];
        if (_baseline == nil && dict[@"baseline"] && ![dict[@"baseline"] isKindOfClass:NSNull.class]) return nil;
        _cursor = [QTCursor withValue:(id)_cursor];
        if (_cursor == nil && dict[@"cursor"] && ![dict[@"cursor"] isKindOfClass:NSNull.class]) return nil;
        _fontStyle = [QTFontStyle withValue:(id)_fontStyle];
        if (_fontStyle == nil && dict[@"fontStyle"] && ![dict[@"fontStyle"] isKindOfClass:NSNull.class]) return nil;
        _interpolate = [QTInterpolate withValue:(id)_interpolate];
        if (_interpolate == nil && dict[@"interpolate"] && ![dict[@"interpolate"] isKindOfClass:NSNull.class]) return nil;
        _orient = [QTOrient withValue:(id)_orient];
        if (_orient == nil && dict[@"orient"] && ![dict[@"orient"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTickConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTickConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTickConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"align": NSNullify([_align value]),
        @"baseline": NSNullify([_baseline value]),
        @"cursor": NSNullify([_cursor value]),
        @"fontStyle": NSNullify([_fontStyle value]),
        @"interpolate": NSNullify([_interpolate value]),
        @"orient": NSNullify([_orient value]),
    }];

    return dict;
}
@end

@implementation QTVGTitleConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"anchor": @"anchor",
        @"angle": @"angle",
        @"baseline": @"baseline",
        @"color": @"color",
        @"font": @"font",
        @"fontSize": @"fontSize",
        @"fontWeight": @"fontWeight",
        @"limit": @"limit",
        @"offset": @"offset",
        @"orient": @"orient",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVGTitleConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"fontSize"] && [dict[@"fontSize"] doubleValue] < 0) return nil;
        if (dict[@"limit"] && [dict[@"limit"] doubleValue] < 0) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _anchor = [QTAnchor withValue:(id)_anchor];
        if (_anchor == nil && dict[@"anchor"] && ![dict[@"anchor"] isKindOfClass:NSNull.class]) return nil;
        _baseline = [QTVerticalAlign withValue:(id)_baseline];
        if (_baseline == nil && dict[@"baseline"] && ![dict[@"baseline"] isKindOfClass:NSNull.class]) return nil;
        _orient = [QTTitleOrient withValue:(id)_orient];
        if (_orient == nil && dict[@"orient"] && ![dict[@"orient"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVGTitleConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVGTitleConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTVGTitleConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"anchor": NSNullify([_anchor value]),
        @"baseline": NSNullify([_baseline value]),
        @"orient": NSNullify([_orient value]),
    }];

    return dict;
}
@end

@implementation QTViewConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"clip": @"clip",
        @"fill": @"fill",
        @"fillOpacity": @"fillOpacity",
        @"height": @"height",
        @"stroke": @"stroke",
        @"strokeDash": @"strokeDash",
        @"strokeDashOffset": @"strokeDashOffset",
        @"strokeOpacity": @"strokeOpacity",
        @"strokeWidth": @"strokeWidth",
        @"width": @"width",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTViewConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTViewConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTViewConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTViewConfig.properties.allValues];
}
@end

@implementation QTData
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"format": @"format",
        @"url": @"url",
        @"values": @"values",
        @"name": @"name",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTData alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _format = [QTDataFormat fromJSONDictionary:(id)_format];
        if (!_format && dict[@"format"] && ![dict[@"format"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTData.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTData.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTData.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"format": NSNullify([_format isKindOfClass:NSNull.class] ? nil : [_format JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTDataFormat
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"parse": @"parse",
        @"type": @"type",
        @"property": @"property",
        @"feature": @"feature",
        @"mesh": @"mesh",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDataFormat alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _type = [QTDataFormatType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDataFormat.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDataFormat.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDataFormat.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTEncodingWithFacet
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"color": @"color",
        @"column": @"column",
        @"detail": @"detail",
        @"href": @"href",
        @"opacity": @"opacity",
        @"order": @"order",
        @"row": @"row",
        @"shape": @"shape",
        @"size": @"size",
        @"text": @"text",
        @"tooltip": @"tooltip",
        @"x": @"x",
        @"x2": @"x2",
        @"y": @"y",
        @"y2": @"y2",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTEncodingWithFacet alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _color = [QTMarkPropDefWithCondition fromJSONDictionary:(id)_color];
        if (!_color && dict[@"color"] && ![dict[@"color"] isKindOfClass:NSNull.class]) return nil;
        _column = [QTFacetFieldDef fromJSONDictionary:(id)_column];
        if (!_column && dict[@"column"] && ![dict[@"column"] isKindOfClass:NSNull.class]) return nil;
        _href = [QTDefWithCondition fromJSONDictionary:(id)_href];
        if (!_href && dict[@"href"] && ![dict[@"href"] isKindOfClass:NSNull.class]) return nil;
        _opacity = [QTMarkPropDefWithCondition fromJSONDictionary:(id)_opacity];
        if (!_opacity && dict[@"opacity"] && ![dict[@"opacity"] isKindOfClass:NSNull.class]) return nil;
        _row = [QTFacetFieldDef fromJSONDictionary:(id)_row];
        if (!_row && dict[@"row"] && ![dict[@"row"] isKindOfClass:NSNull.class]) return nil;
        _shape = [QTMarkPropDefWithCondition fromJSONDictionary:(id)_shape];
        if (!_shape && dict[@"shape"] && ![dict[@"shape"] isKindOfClass:NSNull.class]) return nil;
        _size = [QTMarkPropDefWithCondition fromJSONDictionary:(id)_size];
        if (!_size && dict[@"size"] && ![dict[@"size"] isKindOfClass:NSNull.class]) return nil;
        _text = [QTTextDefWithCondition fromJSONDictionary:(id)_text];
        if (!_text && dict[@"text"] && ![dict[@"text"] isKindOfClass:NSNull.class]) return nil;
        _tooltip = [QTTextDefWithCondition fromJSONDictionary:(id)_tooltip];
        if (!_tooltip && dict[@"tooltip"] && ![dict[@"tooltip"] isKindOfClass:NSNull.class]) return nil;
        _x = [QTXClass fromJSONDictionary:(id)_x];
        if (!_x && dict[@"x"] && ![dict[@"x"] isKindOfClass:NSNull.class]) return nil;
        _x2 = [QTX2Class fromJSONDictionary:(id)_x2];
        if (!_x2 && dict[@"x2"] && ![dict[@"x2"] isKindOfClass:NSNull.class]) return nil;
        _y = [QTXClass fromJSONDictionary:(id)_y];
        if (!_y && dict[@"y"] && ![dict[@"y"] isKindOfClass:NSNull.class]) return nil;
        _y2 = [QTX2Class fromJSONDictionary:(id)_y2];
        if (!_y2 && dict[@"y2"] && ![dict[@"y2"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTEncodingWithFacet.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTEncodingWithFacet.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTEncodingWithFacet.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"color": NSNullify([_color isKindOfClass:NSNull.class] ? nil : [_color JSONDictionary]),
        @"column": NSNullify([_column isKindOfClass:NSNull.class] ? nil : [_column JSONDictionary]),
        @"href": NSNullify([_href isKindOfClass:NSNull.class] ? nil : [_href JSONDictionary]),
        @"opacity": NSNullify([_opacity isKindOfClass:NSNull.class] ? nil : [_opacity JSONDictionary]),
        @"row": NSNullify([_row isKindOfClass:NSNull.class] ? nil : [_row JSONDictionary]),
        @"shape": NSNullify([_shape isKindOfClass:NSNull.class] ? nil : [_shape JSONDictionary]),
        @"size": NSNullify([_size isKindOfClass:NSNull.class] ? nil : [_size JSONDictionary]),
        @"text": NSNullify([_text isKindOfClass:NSNull.class] ? nil : [_text JSONDictionary]),
        @"tooltip": NSNullify([_tooltip isKindOfClass:NSNull.class] ? nil : [_tooltip JSONDictionary]),
        @"x": NSNullify([_x isKindOfClass:NSNull.class] ? nil : [_x JSONDictionary]),
        @"x2": NSNullify([_x2 isKindOfClass:NSNull.class] ? nil : [_x2 JSONDictionary]),
        @"y": NSNullify([_y isKindOfClass:NSNull.class] ? nil : [_y JSONDictionary]),
        @"y2": NSNullify([_y2 isKindOfClass:NSNull.class] ? nil : [_y2 JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTMarkPropDefWithCondition
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"aggregate": @"aggregate",
        @"bin": @"bin",
        @"condition": @"condition",
        @"field": @"field",
        @"legend": @"legend",
        @"scale": @"scale",
        @"sort": @"sort",
        @"timeUnit": @"timeUnit",
        @"type": @"type",
        @"value": @"value",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMarkPropDefWithCondition alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _aggregate = [QTAggregateOp withValue:(id)_aggregate];
        if (_aggregate == nil && dict[@"aggregate"] && ![dict[@"aggregate"] isKindOfClass:NSNull.class]) return nil;
        _legend = [QTLegend fromJSONDictionary:(id)_legend];
        if (!_legend && dict[@"legend"] && ![dict[@"legend"] isKindOfClass:NSNull.class]) return nil;
        _scale = [QTScale fromJSONDictionary:(id)_scale];
        if (!_scale && dict[@"scale"] && ![dict[@"scale"] isKindOfClass:NSNull.class]) return nil;
        _timeUnit = [QTTimeUnit withValue:(id)_timeUnit];
        if (_timeUnit == nil && dict[@"timeUnit"] && ![dict[@"timeUnit"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMarkPropDefWithCondition.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMarkPropDefWithCondition.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMarkPropDefWithCondition.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"aggregate": NSNullify([_aggregate value]),
        @"legend": NSNullify([_legend isKindOfClass:NSNull.class] ? nil : [_legend JSONDictionary]),
        @"scale": NSNullify([_scale isKindOfClass:NSNull.class] ? nil : [_scale JSONDictionary]),
        @"timeUnit": NSNullify([_timeUnit value]),
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTBinParams
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"base": @"base",
        @"divide": @"divide",
        @"extent": @"extent",
        @"maxbins": @"maxbins",
        @"minstep": @"minstep",
        @"nice": @"nice",
        @"step": @"step",
        @"steps": @"steps",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBinParams alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"divide"] && [(NSArray *)dict[@"divide"] count] < 1) return nil;
        if (dict[@"extent"] && [(NSArray *)dict[@"extent"] count] < 2) return nil;
        if ([(NSArray *)dict[@"extent"] count] > 2) return nil;
        if (dict[@"maxbins"] && [dict[@"maxbins"] doubleValue] < 2) return nil;
        if (dict[@"steps"] && [(NSArray *)dict[@"steps"] count] < 1) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBinParams.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBinParams.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTBinParams.properties.allValues];
}
@end

@implementation QTConditionalValueDef
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"test": @"test",
        @"value": @"value",
        @"selection": @"selection",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConditionalValueDef alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConditionalValueDef.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConditionalValueDef.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTConditionalValueDef.properties.allValues];
}
@end

@implementation QTSelection
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"not": @"not",
        @"and": @"and",
        @"or": @"or",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSelection alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSelection.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSelection.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSelection.properties.allValues];
}
@end

@implementation QTPredicate
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"not": @"not",
        @"and": @"and",
        @"or": @"or",
        @"equal": @"equal",
        @"field": @"field",
        @"timeUnit": @"timeUnit",
        @"range": @"range",
        @"oneOf": @"oneOf",
        @"selection": @"selection",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPredicate alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"range"] && [(NSArray *)dict[@"range"] count] < 2) return nil;
        if ([(NSArray *)dict[@"range"] count] > 2) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _timeUnit = [QTTimeUnit withValue:(id)_timeUnit];
        if (_timeUnit == nil && dict[@"timeUnit"] && ![dict[@"timeUnit"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPredicate.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPredicate.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPredicate.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"timeUnit": NSNullify([_timeUnit value]),
    }];

    return dict;
}
@end

@implementation QTDateTime
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"date": @"date",
        @"day": @"day",
        @"hours": @"hours",
        @"milliseconds": @"milliseconds",
        @"minutes": @"minutes",
        @"month": @"month",
        @"quarter": @"quarter",
        @"seconds": @"seconds",
        @"utc": @"utc",
        @"year": @"year",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDateTime alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"date"] && [dict[@"date"] doubleValue] < 1) return nil;
        if (dict[@"date"] && [dict[@"date"] doubleValue] > 31) return nil;
        if (dict[@"hours"] && [dict[@"hours"] doubleValue] < 0) return nil;
        if (dict[@"hours"] && [dict[@"hours"] doubleValue] > 23) return nil;
        if (dict[@"milliseconds"] && [dict[@"milliseconds"] doubleValue] < 0) return nil;
        if (dict[@"milliseconds"] && [dict[@"milliseconds"] doubleValue] > 999) return nil;
        if (dict[@"minutes"] && [dict[@"minutes"] doubleValue] < 0) return nil;
        if (dict[@"minutes"] && [dict[@"minutes"] doubleValue] > 59) return nil;
        if (dict[@"quarter"] && [dict[@"quarter"] doubleValue] < 1) return nil;
        if (dict[@"quarter"] && [dict[@"quarter"] doubleValue] > 4) return nil;
        if (dict[@"seconds"] && [dict[@"seconds"] doubleValue] < 0) return nil;
        if (dict[@"seconds"] && [dict[@"seconds"] doubleValue] > 59) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDateTime.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDateTime.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDateTime.properties.allValues];
}
@end

@implementation QTConditionalPredicateMarkPropFieldDefClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"test": @"test",
        @"value": @"value",
        @"selection": @"selection",
        @"aggregate": @"aggregate",
        @"bin": @"bin",
        @"field": @"field",
        @"legend": @"legend",
        @"scale": @"scale",
        @"sort": @"sort",
        @"timeUnit": @"timeUnit",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConditionalPredicateMarkPropFieldDefClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _aggregate = [QTAggregateOp withValue:(id)_aggregate];
        if (_aggregate == nil && dict[@"aggregate"] && ![dict[@"aggregate"] isKindOfClass:NSNull.class]) return nil;
        _legend = [QTLegend fromJSONDictionary:(id)_legend];
        if (!_legend && dict[@"legend"] && ![dict[@"legend"] isKindOfClass:NSNull.class]) return nil;
        _scale = [QTScale fromJSONDictionary:(id)_scale];
        if (!_scale && dict[@"scale"] && ![dict[@"scale"] isKindOfClass:NSNull.class]) return nil;
        _timeUnit = [QTTimeUnit withValue:(id)_timeUnit];
        if (_timeUnit == nil && dict[@"timeUnit"] && ![dict[@"timeUnit"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConditionalPredicateMarkPropFieldDefClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConditionalPredicateMarkPropFieldDefClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTConditionalPredicateMarkPropFieldDefClass.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"aggregate": NSNullify([_aggregate value]),
        @"legend": NSNullify([_legend isKindOfClass:NSNull.class] ? nil : [_legend JSONDictionary]),
        @"scale": NSNullify([_scale isKindOfClass:NSNull.class] ? nil : [_scale JSONDictionary]),
        @"timeUnit": NSNullify([_timeUnit value]),
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTRepeatRef
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"repeat": @"repeat",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRepeatRef alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"repeat"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _repeat = [QTRepeatEnum withValue:(id)_repeat];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRepeatRef.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRepeatRef.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTRepeatRef.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"repeat": [_repeat value],
    }];

    return dict;
}
@end

@implementation QTLegend
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"entryPadding": @"entryPadding",
        @"format": @"format",
        @"offset": @"offset",
        @"orient": @"orient",
        @"padding": @"padding",
        @"tickCount": @"tickCount",
        @"title": @"title",
        @"type": @"type",
        @"values": @"values",
        @"zindex": @"zindex",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLegend alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"zindex"] && [dict[@"zindex"] doubleValue] < 0) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _orient = [QTLegendOrient withValue:(id)_orient];
        if (_orient == nil && dict[@"orient"] && ![dict[@"orient"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTLegendType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLegend.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLegend.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLegend.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"orient": NSNullify([_orient value]),
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTScale
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"base": @"base",
        @"clamp": @"clamp",
        @"domain": @"domain",
        @"exponent": @"exponent",
        @"interpolate": @"interpolate",
        @"nice": @"nice",
        @"padding": @"padding",
        @"paddingInner": @"paddingInner",
        @"paddingOuter": @"paddingOuter",
        @"range": @"range",
        @"rangeStep": @"rangeStep",
        @"round": @"round",
        @"scheme": @"scheme",
        @"type": @"type",
        @"zero": @"zero",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTScale alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"padding"] && [dict[@"padding"] doubleValue] < 0) return nil;
        if (dict[@"paddingInner"] && [dict[@"paddingInner"] doubleValue] < 0) return nil;
        if (dict[@"paddingInner"] && [dict[@"paddingInner"] doubleValue] > 1) return nil;
        if (dict[@"paddingOuter"] && [dict[@"paddingOuter"] doubleValue] < 0) return nil;
        if (dict[@"paddingOuter"] && [dict[@"paddingOuter"] doubleValue] > 1) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _type = [QTScaleType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTScale.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTScale.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTScale.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTDomainClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"field": @"field",
        @"selection": @"selection",
        @"encoding": @"encoding",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDomainClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"selection"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDomainClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDomainClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDomainClass.properties.allValues];
}
@end

@implementation QTInterpolateParams
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"gamma": @"gamma",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTInterpolateParams alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _type = [QTInterpolateParamsType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTInterpolateParams.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTInterpolateParams.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTInterpolateParams.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTNiceClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"interval": @"interval",
        @"step": @"step",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNiceClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"interval"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"step"] isKindOfClass:NSNumber.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNiceClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNiceClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTNiceClass.properties.allValues];
}
@end

@implementation QTSchemeParams
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"extent": @"extent",
        @"name": @"name",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSchemeParams alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSchemeParams.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSchemeParams.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSchemeParams.properties.allValues];
}
@end

@implementation QTSortField
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"field": @"field",
        @"op": @"op",
        @"order": @"order",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSortField alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"op"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _op = [QTAggregateOp withValue:(id)_op];
        _order = [QTSortEnum withValue:(id)_order];
        if (_order == nil && dict[@"order"] && ![dict[@"order"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSortField.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSortField.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSortField.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"op": [_op value],
        @"order": NSNullify([_order value]),
    }];

    return dict;
}
@end

@implementation QTFacetFieldDef
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"aggregate": @"aggregate",
        @"bin": @"bin",
        @"field": @"field",
        @"header": @"header",
        @"sort": @"sort",
        @"timeUnit": @"timeUnit",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFacetFieldDef alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _aggregate = [QTAggregateOp withValue:(id)_aggregate];
        if (_aggregate == nil && dict[@"aggregate"] && ![dict[@"aggregate"] isKindOfClass:NSNull.class]) return nil;
        _header = [QTHeader fromJSONDictionary:(id)_header];
        if (!_header && dict[@"header"] && ![dict[@"header"] isKindOfClass:NSNull.class]) return nil;
        _sort = [QTSortEnum withValue:(id)_sort];
        if (_sort == nil && dict[@"sort"] && ![dict[@"sort"] isKindOfClass:NSNull.class]) return nil;
        _timeUnit = [QTTimeUnit withValue:(id)_timeUnit];
        if (_timeUnit == nil && dict[@"timeUnit"] && ![dict[@"timeUnit"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFacetFieldDef.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFacetFieldDef.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFacetFieldDef.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"aggregate": NSNullify([_aggregate value]),
        @"header": NSNullify([_header isKindOfClass:NSNull.class] ? nil : [_header JSONDictionary]),
        @"sort": NSNullify([_sort value]),
        @"timeUnit": NSNullify([_timeUnit value]),
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTHeader
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"format": @"format",
        @"labelAngle": @"labelAngle",
        @"title": @"title",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTHeader alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"labelAngle"] && [dict[@"labelAngle"] doubleValue] < -360) return nil;
        if (dict[@"labelAngle"] && [dict[@"labelAngle"] doubleValue] > 360) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTHeader.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTHeader.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTHeader.properties.allValues];
}
@end

@implementation QTFieldDef
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"aggregate": @"aggregate",
        @"bin": @"bin",
        @"field": @"field",
        @"timeUnit": @"timeUnit",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFieldDef alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _aggregate = [QTAggregateOp withValue:(id)_aggregate];
        if (_aggregate == nil && dict[@"aggregate"] && ![dict[@"aggregate"] isKindOfClass:NSNull.class]) return nil;
        _timeUnit = [QTTimeUnit withValue:(id)_timeUnit];
        if (_timeUnit == nil && dict[@"timeUnit"] && ![dict[@"timeUnit"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFieldDef.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFieldDef.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFieldDef.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"aggregate": NSNullify([_aggregate value]),
        @"timeUnit": NSNullify([_timeUnit value]),
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTDefWithCondition
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"aggregate": @"aggregate",
        @"bin": @"bin",
        @"condition": @"condition",
        @"field": @"field",
        @"timeUnit": @"timeUnit",
        @"type": @"type",
        @"value": @"value",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDefWithCondition alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _aggregate = [QTAggregateOp withValue:(id)_aggregate];
        if (_aggregate == nil && dict[@"aggregate"] && ![dict[@"aggregate"] isKindOfClass:NSNull.class]) return nil;
        _timeUnit = [QTTimeUnit withValue:(id)_timeUnit];
        if (_timeUnit == nil && dict[@"timeUnit"] && ![dict[@"timeUnit"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDefWithCondition.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDefWithCondition.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDefWithCondition.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"aggregate": NSNullify([_aggregate value]),
        @"timeUnit": NSNullify([_timeUnit value]),
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTConditionalPredicateFieldDefClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"test": @"test",
        @"value": @"value",
        @"selection": @"selection",
        @"aggregate": @"aggregate",
        @"bin": @"bin",
        @"field": @"field",
        @"timeUnit": @"timeUnit",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConditionalPredicateFieldDefClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _aggregate = [QTAggregateOp withValue:(id)_aggregate];
        if (_aggregate == nil && dict[@"aggregate"] && ![dict[@"aggregate"] isKindOfClass:NSNull.class]) return nil;
        _timeUnit = [QTTimeUnit withValue:(id)_timeUnit];
        if (_timeUnit == nil && dict[@"timeUnit"] && ![dict[@"timeUnit"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConditionalPredicateFieldDefClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConditionalPredicateFieldDefClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTConditionalPredicateFieldDefClass.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"aggregate": NSNullify([_aggregate value]),
        @"timeUnit": NSNullify([_timeUnit value]),
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTOrderFieldDef
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"aggregate": @"aggregate",
        @"bin": @"bin",
        @"field": @"field",
        @"sort": @"sort",
        @"timeUnit": @"timeUnit",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOrderFieldDef alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _aggregate = [QTAggregateOp withValue:(id)_aggregate];
        if (_aggregate == nil && dict[@"aggregate"] && ![dict[@"aggregate"] isKindOfClass:NSNull.class]) return nil;
        _sort = [QTSortEnum withValue:(id)_sort];
        if (_sort == nil && dict[@"sort"] && ![dict[@"sort"] isKindOfClass:NSNull.class]) return nil;
        _timeUnit = [QTTimeUnit withValue:(id)_timeUnit];
        if (_timeUnit == nil && dict[@"timeUnit"] && ![dict[@"timeUnit"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOrderFieldDef.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOrderFieldDef.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTOrderFieldDef.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"aggregate": NSNullify([_aggregate value]),
        @"sort": NSNullify([_sort value]),
        @"timeUnit": NSNullify([_timeUnit value]),
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTTextDefWithCondition
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"aggregate": @"aggregate",
        @"bin": @"bin",
        @"condition": @"condition",
        @"field": @"field",
        @"format": @"format",
        @"timeUnit": @"timeUnit",
        @"type": @"type",
        @"value": @"value",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTextDefWithCondition alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _aggregate = [QTAggregateOp withValue:(id)_aggregate];
        if (_aggregate == nil && dict[@"aggregate"] && ![dict[@"aggregate"] isKindOfClass:NSNull.class]) return nil;
        _timeUnit = [QTTimeUnit withValue:(id)_timeUnit];
        if (_timeUnit == nil && dict[@"timeUnit"] && ![dict[@"timeUnit"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTextDefWithCondition.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTextDefWithCondition.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTextDefWithCondition.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"aggregate": NSNullify([_aggregate value]),
        @"timeUnit": NSNullify([_timeUnit value]),
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTConditionalPredicateTextFieldDefClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"test": @"test",
        @"value": @"value",
        @"selection": @"selection",
        @"aggregate": @"aggregate",
        @"bin": @"bin",
        @"field": @"field",
        @"format": @"format",
        @"timeUnit": @"timeUnit",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConditionalPredicateTextFieldDefClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _aggregate = [QTAggregateOp withValue:(id)_aggregate];
        if (_aggregate == nil && dict[@"aggregate"] && ![dict[@"aggregate"] isKindOfClass:NSNull.class]) return nil;
        _timeUnit = [QTTimeUnit withValue:(id)_timeUnit];
        if (_timeUnit == nil && dict[@"timeUnit"] && ![dict[@"timeUnit"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConditionalPredicateTextFieldDefClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConditionalPredicateTextFieldDefClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTConditionalPredicateTextFieldDefClass.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"aggregate": NSNullify([_aggregate value]),
        @"timeUnit": NSNullify([_timeUnit value]),
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTXClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"aggregate": @"aggregate",
        @"axis": @"axis",
        @"bin": @"bin",
        @"field": @"field",
        @"scale": @"scale",
        @"sort": @"sort",
        @"stack": @"stack",
        @"timeUnit": @"timeUnit",
        @"type": @"type",
        @"value": @"value",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTXClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _aggregate = [QTAggregateOp withValue:(id)_aggregate];
        if (_aggregate == nil && dict[@"aggregate"] && ![dict[@"aggregate"] isKindOfClass:NSNull.class]) return nil;
        _axis = [QTAxis fromJSONDictionary:(id)_axis];
        if (!_axis && dict[@"axis"] && ![dict[@"axis"] isKindOfClass:NSNull.class]) return nil;
        _scale = [QTScale fromJSONDictionary:(id)_scale];
        if (!_scale && dict[@"scale"] && ![dict[@"scale"] isKindOfClass:NSNull.class]) return nil;
        _stack = [QTStackOffset withValue:(id)_stack];
        if (_stack == nil && dict[@"stack"] && ![dict[@"stack"] isKindOfClass:NSNull.class]) return nil;
        _timeUnit = [QTTimeUnit withValue:(id)_timeUnit];
        if (_timeUnit == nil && dict[@"timeUnit"] && ![dict[@"timeUnit"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTXClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTXClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTXClass.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"aggregate": NSNullify([_aggregate value]),
        @"axis": NSNullify([_axis isKindOfClass:NSNull.class] ? nil : [_axis JSONDictionary]),
        @"scale": NSNullify([_scale isKindOfClass:NSNull.class] ? nil : [_scale JSONDictionary]),
        @"stack": NSNullify([_stack value]),
        @"timeUnit": NSNullify([_timeUnit value]),
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTAxis
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"domain": @"domain",
        @"format": @"format",
        @"grid": @"grid",
        @"labelAngle": @"labelAngle",
        @"labelBound": @"labelBound",
        @"labelFlush": @"labelFlush",
        @"labelOverlap": @"labelOverlap",
        @"labelPadding": @"labelPadding",
        @"labels": @"labels",
        @"maxExtent": @"maxExtent",
        @"minExtent": @"minExtent",
        @"offset": @"offset",
        @"orient": @"orient",
        @"position": @"position",
        @"tickCount": @"tickCount",
        @"ticks": @"ticks",
        @"tickSize": @"tickSize",
        @"title": @"title",
        @"titleMaxLength": @"titleMaxLength",
        @"titlePadding": @"titlePadding",
        @"values": @"values",
        @"zindex": @"zindex",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAxis alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"labelAngle"] && [dict[@"labelAngle"] doubleValue] < -360) return nil;
        if (dict[@"labelAngle"] && [dict[@"labelAngle"] doubleValue] > 360) return nil;
        if (dict[@"tickSize"] && [dict[@"tickSize"] doubleValue] < 0) return nil;
        if (dict[@"zindex"] && [dict[@"zindex"] doubleValue] < 0) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _orient = [QTTitleOrient withValue:(id)_orient];
        if (_orient == nil && dict[@"orient"] && ![dict[@"orient"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAxis.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAxis.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAxis.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"orient": NSNullify([_orient value]),
    }];

    return dict;
}
@end

@implementation QTX2Class
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"aggregate": @"aggregate",
        @"bin": @"bin",
        @"field": @"field",
        @"timeUnit": @"timeUnit",
        @"type": @"type",
        @"value": @"value",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTX2Class alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _aggregate = [QTAggregateOp withValue:(id)_aggregate];
        if (_aggregate == nil && dict[@"aggregate"] && ![dict[@"aggregate"] isKindOfClass:NSNull.class]) return nil;
        _timeUnit = [QTTimeUnit withValue:(id)_timeUnit];
        if (_timeUnit == nil && dict[@"timeUnit"] && ![dict[@"timeUnit"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTX2Class.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTX2Class.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTX2Class.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"aggregate": NSNullify([_aggregate value]),
        @"timeUnit": NSNullify([_timeUnit value]),
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTFacetMapping
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"column": @"column",
        @"row": @"row",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFacetMapping alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _column = [QTFacetFieldDef fromJSONDictionary:(id)_column];
        if (!_column && dict[@"column"] && ![dict[@"column"] isKindOfClass:NSNull.class]) return nil;
        _row = [QTFacetFieldDef fromJSONDictionary:(id)_row];
        if (!_row && dict[@"row"] && ![dict[@"row"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFacetMapping.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFacetMapping.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFacetMapping.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"column": NSNullify([_column isKindOfClass:NSNull.class] ? nil : [_column JSONDictionary]),
        @"row": NSNullify([_row isKindOfClass:NSNull.class] ? nil : [_row JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTSpec
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"data": @"data",
        @"description": @"theDescription",
        @"height": @"height",
        @"layer": @"layer",
        @"name": @"name",
        @"resolve": @"resolve",
        @"title": @"title",
        @"transform": @"transform",
        @"width": @"width",
        @"encoding": @"encoding",
        @"mark": @"mark",
        @"projection": @"projection",
        @"selection": @"selection",
        @"facet": @"facet",
        @"spec": @"spec",
        @"repeat": @"repeat",
        @"vconcat": @"vconcat",
        @"hconcat": @"hconcat",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSpec alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _data = [QTData fromJSONDictionary:(id)_data];
        if (!_data && dict[@"data"] && ![dict[@"data"] isKindOfClass:NSNull.class]) return nil;
        _layer = map(_layer, λ(id x, [QTLayerSpec fromJSONDictionary:x]));
        _resolve = [QTResolve fromJSONDictionary:(id)_resolve];
        if (!_resolve && dict[@"resolve"] && ![dict[@"resolve"] isKindOfClass:NSNull.class]) return nil;
        _transform = map(_transform, λ(id x, [QTTransform fromJSONDictionary:x]));
        _encoding = [QTEncoding fromJSONDictionary:(id)_encoding];
        if (!_encoding && dict[@"encoding"] && ![dict[@"encoding"] isKindOfClass:NSNull.class]) return nil;
        _projection = [QTProjection fromJSONDictionary:(id)_projection];
        if (!_projection && dict[@"projection"] && ![dict[@"projection"] isKindOfClass:NSNull.class]) return nil;
        _selection = map(_selection, λ(id x, [QTSelectionDef fromJSONDictionary:x]));
        _facet = [QTFacetMapping fromJSONDictionary:(id)_facet];
        if (!_facet && dict[@"facet"] && ![dict[@"facet"] isKindOfClass:NSNull.class]) return nil;
        _spec = [QTSpec fromJSONDictionary:(id)_spec];
        if (!_spec && dict[@"spec"] && ![dict[@"spec"] isKindOfClass:NSNull.class]) return nil;
        _repeat = [QTRepeat fromJSONDictionary:(id)_repeat];
        if (!_repeat && dict[@"repeat"] && ![dict[@"repeat"] isKindOfClass:NSNull.class]) return nil;
        _vconcat = map(_vconcat, λ(id x, [QTSpec fromJSONDictionary:x]));
        _hconcat = map(_hconcat, λ(id x, [QTSpec fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSpec.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSpec.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSpec.properties.allValues] mutableCopy];

    for (id jsonName in QTSpec.properties) {
        id propertyName = QTSpec.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"data": NSNullify([_data isKindOfClass:NSNull.class] ? nil : [_data JSONDictionary]),
        @"layer": NSNullify(map(_layer, λ(id x, [x JSONDictionary]))),
        @"resolve": NSNullify([_resolve isKindOfClass:NSNull.class] ? nil : [_resolve JSONDictionary]),
        @"transform": NSNullify(map(_transform, λ(id x, [x JSONDictionary]))),
        @"encoding": NSNullify([_encoding isKindOfClass:NSNull.class] ? nil : [_encoding JSONDictionary]),
        @"projection": NSNullify([_projection isKindOfClass:NSNull.class] ? nil : [_projection JSONDictionary]),
        @"selection": NSNullify(map(_selection, λ(id x, [x JSONDictionary]))),
        @"facet": NSNullify([_facet isKindOfClass:NSNull.class] ? nil : [_facet JSONDictionary]),
        @"spec": NSNullify([_spec isKindOfClass:NSNull.class] ? nil : [_spec JSONDictionary]),
        @"repeat": NSNullify([_repeat isKindOfClass:NSNull.class] ? nil : [_repeat JSONDictionary]),
        @"vconcat": NSNullify(map(_vconcat, λ(id x, [x JSONDictionary]))),
        @"hconcat": NSNullify(map(_hconcat, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTEncoding
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"color": @"color",
        @"detail": @"detail",
        @"href": @"href",
        @"opacity": @"opacity",
        @"order": @"order",
        @"shape": @"shape",
        @"size": @"size",
        @"text": @"text",
        @"tooltip": @"tooltip",
        @"x": @"x",
        @"x2": @"x2",
        @"y": @"y",
        @"y2": @"y2",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTEncoding alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _color = [QTMarkPropDefWithCondition fromJSONDictionary:(id)_color];
        if (!_color && dict[@"color"] && ![dict[@"color"] isKindOfClass:NSNull.class]) return nil;
        _href = [QTDefWithCondition fromJSONDictionary:(id)_href];
        if (!_href && dict[@"href"] && ![dict[@"href"] isKindOfClass:NSNull.class]) return nil;
        _opacity = [QTMarkPropDefWithCondition fromJSONDictionary:(id)_opacity];
        if (!_opacity && dict[@"opacity"] && ![dict[@"opacity"] isKindOfClass:NSNull.class]) return nil;
        _shape = [QTMarkPropDefWithCondition fromJSONDictionary:(id)_shape];
        if (!_shape && dict[@"shape"] && ![dict[@"shape"] isKindOfClass:NSNull.class]) return nil;
        _size = [QTMarkPropDefWithCondition fromJSONDictionary:(id)_size];
        if (!_size && dict[@"size"] && ![dict[@"size"] isKindOfClass:NSNull.class]) return nil;
        _text = [QTTextDefWithCondition fromJSONDictionary:(id)_text];
        if (!_text && dict[@"text"] && ![dict[@"text"] isKindOfClass:NSNull.class]) return nil;
        _tooltip = [QTTextDefWithCondition fromJSONDictionary:(id)_tooltip];
        if (!_tooltip && dict[@"tooltip"] && ![dict[@"tooltip"] isKindOfClass:NSNull.class]) return nil;
        _x = [QTXClass fromJSONDictionary:(id)_x];
        if (!_x && dict[@"x"] && ![dict[@"x"] isKindOfClass:NSNull.class]) return nil;
        _x2 = [QTX2Class fromJSONDictionary:(id)_x2];
        if (!_x2 && dict[@"x2"] && ![dict[@"x2"] isKindOfClass:NSNull.class]) return nil;
        _y = [QTXClass fromJSONDictionary:(id)_y];
        if (!_y && dict[@"y"] && ![dict[@"y"] isKindOfClass:NSNull.class]) return nil;
        _y2 = [QTX2Class fromJSONDictionary:(id)_y2];
        if (!_y2 && dict[@"y2"] && ![dict[@"y2"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTEncoding.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTEncoding.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTEncoding.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"color": NSNullify([_color isKindOfClass:NSNull.class] ? nil : [_color JSONDictionary]),
        @"href": NSNullify([_href isKindOfClass:NSNull.class] ? nil : [_href JSONDictionary]),
        @"opacity": NSNullify([_opacity isKindOfClass:NSNull.class] ? nil : [_opacity JSONDictionary]),
        @"shape": NSNullify([_shape isKindOfClass:NSNull.class] ? nil : [_shape JSONDictionary]),
        @"size": NSNullify([_size isKindOfClass:NSNull.class] ? nil : [_size JSONDictionary]),
        @"text": NSNullify([_text isKindOfClass:NSNull.class] ? nil : [_text JSONDictionary]),
        @"tooltip": NSNullify([_tooltip isKindOfClass:NSNull.class] ? nil : [_tooltip JSONDictionary]),
        @"x": NSNullify([_x isKindOfClass:NSNull.class] ? nil : [_x JSONDictionary]),
        @"x2": NSNullify([_x2 isKindOfClass:NSNull.class] ? nil : [_x2 JSONDictionary]),
        @"y": NSNullify([_y isKindOfClass:NSNull.class] ? nil : [_y JSONDictionary]),
        @"y2": NSNullify([_y2 isKindOfClass:NSNull.class] ? nil : [_y2 JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTLayerSpec
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"data": @"data",
        @"description": @"theDescription",
        @"height": @"height",
        @"layer": @"layer",
        @"name": @"name",
        @"resolve": @"resolve",
        @"title": @"title",
        @"transform": @"transform",
        @"width": @"width",
        @"encoding": @"encoding",
        @"mark": @"mark",
        @"projection": @"projection",
        @"selection": @"selection",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLayerSpec alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _data = [QTData fromJSONDictionary:(id)_data];
        if (!_data && dict[@"data"] && ![dict[@"data"] isKindOfClass:NSNull.class]) return nil;
        _layer = map(_layer, λ(id x, [QTLayerSpec fromJSONDictionary:x]));
        _resolve = [QTResolve fromJSONDictionary:(id)_resolve];
        if (!_resolve && dict[@"resolve"] && ![dict[@"resolve"] isKindOfClass:NSNull.class]) return nil;
        _transform = map(_transform, λ(id x, [QTTransform fromJSONDictionary:x]));
        _encoding = [QTEncoding fromJSONDictionary:(id)_encoding];
        if (!_encoding && dict[@"encoding"] && ![dict[@"encoding"] isKindOfClass:NSNull.class]) return nil;
        _projection = [QTProjection fromJSONDictionary:(id)_projection];
        if (!_projection && dict[@"projection"] && ![dict[@"projection"] isKindOfClass:NSNull.class]) return nil;
        _selection = map(_selection, λ(id x, [QTSelectionDef fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLayerSpec.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLayerSpec.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLayerSpec.properties.allValues] mutableCopy];

    for (id jsonName in QTLayerSpec.properties) {
        id propertyName = QTLayerSpec.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"data": NSNullify([_data isKindOfClass:NSNull.class] ? nil : [_data JSONDictionary]),
        @"layer": NSNullify(map(_layer, λ(id x, [x JSONDictionary]))),
        @"resolve": NSNullify([_resolve isKindOfClass:NSNull.class] ? nil : [_resolve JSONDictionary]),
        @"transform": NSNullify(map(_transform, λ(id x, [x JSONDictionary]))),
        @"encoding": NSNullify([_encoding isKindOfClass:NSNull.class] ? nil : [_encoding JSONDictionary]),
        @"projection": NSNullify([_projection isKindOfClass:NSNull.class] ? nil : [_projection JSONDictionary]),
        @"selection": NSNullify(map(_selection, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTMarkDef
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"align": @"align",
        @"angle": @"angle",
        @"baseline": @"baseline",
        @"clip": @"clip",
        @"color": @"color",
        @"cursor": @"cursor",
        @"dx": @"dx",
        @"dy": @"dy",
        @"fill": @"fill",
        @"filled": @"filled",
        @"fillOpacity": @"fillOpacity",
        @"font": @"font",
        @"fontSize": @"fontSize",
        @"fontStyle": @"fontStyle",
        @"fontWeight": @"fontWeight",
        @"href": @"href",
        @"interpolate": @"interpolate",
        @"limit": @"limit",
        @"opacity": @"opacity",
        @"orient": @"orient",
        @"radius": @"radius",
        @"shape": @"shape",
        @"size": @"size",
        @"stroke": @"stroke",
        @"strokeDash": @"strokeDash",
        @"strokeDashOffset": @"strokeDashOffset",
        @"strokeOpacity": @"strokeOpacity",
        @"strokeWidth": @"strokeWidth",
        @"style": @"style",
        @"tension": @"tension",
        @"text": @"text",
        @"theta": @"theta",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMarkDef alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"angle"] && [dict[@"angle"] doubleValue] < 0) return nil;
        if (dict[@"angle"] && [dict[@"angle"] doubleValue] > 360) return nil;
        if (dict[@"fillOpacity"] && [dict[@"fillOpacity"] doubleValue] < 0) return nil;
        if (dict[@"fillOpacity"] && [dict[@"fillOpacity"] doubleValue] > 1) return nil;
        if (dict[@"fontSize"] && [dict[@"fontSize"] doubleValue] < 0) return nil;
        if (dict[@"opacity"] && [dict[@"opacity"] doubleValue] < 0) return nil;
        if (dict[@"opacity"] && [dict[@"opacity"] doubleValue] > 1) return nil;
        if (dict[@"radius"] && [dict[@"radius"] doubleValue] < 0) return nil;
        if (dict[@"size"] && [dict[@"size"] doubleValue] < 0) return nil;
        if (dict[@"strokeOpacity"] && [dict[@"strokeOpacity"] doubleValue] < 0) return nil;
        if (dict[@"strokeOpacity"] && [dict[@"strokeOpacity"] doubleValue] > 1) return nil;
        if (dict[@"strokeWidth"] && [dict[@"strokeWidth"] doubleValue] < 0) return nil;
        if (dict[@"tension"] && [dict[@"tension"] doubleValue] < 0) return nil;
        if (dict[@"tension"] && [dict[@"tension"] doubleValue] > 1) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _align = [QTHorizontalAlign withValue:(id)_align];
        if (_align == nil && dict[@"align"] && ![dict[@"align"] isKindOfClass:NSNull.class]) return nil;
        _baseline = [QTVerticalAlign withValue:(id)_baseline];
        if (_baseline == nil && dict[@"baseline"] && ![dict[@"baseline"] isKindOfClass:NSNull.class]) return nil;
        _cursor = [QTCursor withValue:(id)_cursor];
        if (_cursor == nil && dict[@"cursor"] && ![dict[@"cursor"] isKindOfClass:NSNull.class]) return nil;
        _fontStyle = [QTFontStyle withValue:(id)_fontStyle];
        if (_fontStyle == nil && dict[@"fontStyle"] && ![dict[@"fontStyle"] isKindOfClass:NSNull.class]) return nil;
        _interpolate = [QTInterpolate withValue:(id)_interpolate];
        if (_interpolate == nil && dict[@"interpolate"] && ![dict[@"interpolate"] isKindOfClass:NSNull.class]) return nil;
        _orient = [QTOrient withValue:(id)_orient];
        if (_orient == nil && dict[@"orient"] && ![dict[@"orient"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTMark withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMarkDef.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMarkDef.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMarkDef.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"align": NSNullify([_align value]),
        @"baseline": NSNullify([_baseline value]),
        @"cursor": NSNullify([_cursor value]),
        @"fontStyle": NSNullify([_fontStyle value]),
        @"interpolate": NSNullify([_interpolate value]),
        @"orient": NSNullify([_orient value]),
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTProjection
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"center": @"center",
        @"clipAngle": @"clipAngle",
        @"clipExtent": @"clipExtent",
        @"coefficient": @"coefficient",
        @"distance": @"distance",
        @"fraction": @"fraction",
        @"lobes": @"lobes",
        @"parallel": @"parallel",
        @"precision": @"precision",
        @"radius": @"radius",
        @"ratio": @"ratio",
        @"rotate": @"rotate",
        @"spacing": @"spacing",
        @"tilt": @"tilt",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTProjection alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _type = [QTVGProjectionType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTProjection.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTProjection.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTProjection.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

@implementation QTResolve
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"axis": @"axis",
        @"legend": @"legend",
        @"scale": @"scale",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTResolve alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _axis = [QTAxisResolveMap fromJSONDictionary:(id)_axis];
        if (!_axis && dict[@"axis"] && ![dict[@"axis"] isKindOfClass:NSNull.class]) return nil;
        _legend = [QTLegendResolveMap fromJSONDictionary:(id)_legend];
        if (!_legend && dict[@"legend"] && ![dict[@"legend"] isKindOfClass:NSNull.class]) return nil;
        _scale = [QTScaleResolveMap fromJSONDictionary:(id)_scale];
        if (!_scale && dict[@"scale"] && ![dict[@"scale"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTResolve.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTResolve.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTResolve.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"axis": NSNullify([_axis isKindOfClass:NSNull.class] ? nil : [_axis JSONDictionary]),
        @"legend": NSNullify([_legend isKindOfClass:NSNull.class] ? nil : [_legend JSONDictionary]),
        @"scale": NSNullify([_scale isKindOfClass:NSNull.class] ? nil : [_scale JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTAxisResolveMap
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"x": @"x",
        @"y": @"y",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAxisResolveMap alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _x = [QTResolveMode withValue:(id)_x];
        if (_x == nil && dict[@"x"] && ![dict[@"x"] isKindOfClass:NSNull.class]) return nil;
        _y = [QTResolveMode withValue:(id)_y];
        if (_y == nil && dict[@"y"] && ![dict[@"y"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAxisResolveMap.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAxisResolveMap.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAxisResolveMap.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"x": NSNullify([_x value]),
        @"y": NSNullify([_y value]),
    }];

    return dict;
}
@end

@implementation QTLegendResolveMap
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"color": @"color",
        @"opacity": @"opacity",
        @"shape": @"shape",
        @"size": @"size",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLegendResolveMap alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _color = [QTResolveMode withValue:(id)_color];
        if (_color == nil && dict[@"color"] && ![dict[@"color"] isKindOfClass:NSNull.class]) return nil;
        _opacity = [QTResolveMode withValue:(id)_opacity];
        if (_opacity == nil && dict[@"opacity"] && ![dict[@"opacity"] isKindOfClass:NSNull.class]) return nil;
        _shape = [QTResolveMode withValue:(id)_shape];
        if (_shape == nil && dict[@"shape"] && ![dict[@"shape"] isKindOfClass:NSNull.class]) return nil;
        _size = [QTResolveMode withValue:(id)_size];
        if (_size == nil && dict[@"size"] && ![dict[@"size"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLegendResolveMap.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLegendResolveMap.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLegendResolveMap.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"color": NSNullify([_color value]),
        @"opacity": NSNullify([_opacity value]),
        @"shape": NSNullify([_shape value]),
        @"size": NSNullify([_size value]),
    }];

    return dict;
}
@end

@implementation QTScaleResolveMap
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"color": @"color",
        @"opacity": @"opacity",
        @"shape": @"shape",
        @"size": @"size",
        @"x": @"x",
        @"y": @"y",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTScaleResolveMap alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _color = [QTResolveMode withValue:(id)_color];
        if (_color == nil && dict[@"color"] && ![dict[@"color"] isKindOfClass:NSNull.class]) return nil;
        _opacity = [QTResolveMode withValue:(id)_opacity];
        if (_opacity == nil && dict[@"opacity"] && ![dict[@"opacity"] isKindOfClass:NSNull.class]) return nil;
        _shape = [QTResolveMode withValue:(id)_shape];
        if (_shape == nil && dict[@"shape"] && ![dict[@"shape"] isKindOfClass:NSNull.class]) return nil;
        _size = [QTResolveMode withValue:(id)_size];
        if (_size == nil && dict[@"size"] && ![dict[@"size"] isKindOfClass:NSNull.class]) return nil;
        _x = [QTResolveMode withValue:(id)_x];
        if (_x == nil && dict[@"x"] && ![dict[@"x"] isKindOfClass:NSNull.class]) return nil;
        _y = [QTResolveMode withValue:(id)_y];
        if (_y == nil && dict[@"y"] && ![dict[@"y"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTScaleResolveMap.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTScaleResolveMap.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTScaleResolveMap.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"color": NSNullify([_color value]),
        @"opacity": NSNullify([_opacity value]),
        @"shape": NSNullify([_shape value]),
        @"size": NSNullify([_size value]),
        @"x": NSNullify([_x value]),
        @"y": NSNullify([_y value]),
    }];

    return dict;
}
@end

@implementation QTSelectionDef
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bind": @"bind",
        @"empty": @"empty",
        @"encodings": @"encodings",
        @"fields": @"fields",
        @"nearest": @"nearest",
        @"on": @"on",
        @"resolve": @"resolve",
        @"type": @"type",
        @"toggle": @"toggle",
        @"mark": @"mark",
        @"translate": @"translate",
        @"zoom": @"zoom",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSelectionDef alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _empty = [QTEmpty withValue:(id)_empty];
        if (_empty == nil && dict[@"empty"] && ![dict[@"empty"] isKindOfClass:NSNull.class]) return nil;
        _encodings = map(_encodings, λ(id x, [QTSingleDefChannel withValue:x]));
        _resolve = [QTSelectionResolution withValue:(id)_resolve];
        if (_resolve == nil && dict[@"resolve"] && ![dict[@"resolve"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTSelectionDefType withValue:(id)_type];
        _mark = [QTBrushConfig fromJSONDictionary:(id)_mark];
        if (!_mark && dict[@"mark"] && ![dict[@"mark"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSelectionDef.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSelectionDef.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSelectionDef.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"empty": NSNullify([_empty value]),
        @"encodings": NSNullify(map(_encodings, λ(id x, [x value]))),
        @"resolve": NSNullify([_resolve value]),
        @"type": [_type value],
        @"mark": NSNullify([_mark isKindOfClass:NSNull.class] ? nil : [_mark JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTTitleParams
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"anchor": @"anchor",
        @"offset": @"offset",
        @"orient": @"orient",
        @"style": @"style",
        @"text": @"text",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTitleParams alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"text"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _anchor = [QTAnchor withValue:(id)_anchor];
        if (_anchor == nil && dict[@"anchor"] && ![dict[@"anchor"] isKindOfClass:NSNull.class]) return nil;
        _orient = [QTTitleOrient withValue:(id)_orient];
        if (_orient == nil && dict[@"orient"] && ![dict[@"orient"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTitleParams.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTitleParams.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTitleParams.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"anchor": NSNullify([_anchor value]),
        @"orient": NSNullify([_orient value]),
    }];

    return dict;
}
@end

@implementation QTTransform
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"filter": @"filter",
        @"as": @"as",
        @"calculate": @"calculate",
        @"default": @"transformDefault",
        @"from": @"from",
        @"lookup": @"lookup",
        @"bin": @"bin",
        @"field": @"field",
        @"timeUnit": @"timeUnit",
        @"aggregate": @"aggregate",
        @"groupby": @"groupby",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTransform alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _from = [QTLookupData fromJSONDictionary:(id)_from];
        if (!_from && dict[@"from"] && ![dict[@"from"] isKindOfClass:NSNull.class]) return nil;
        _timeUnit = [QTTimeUnit withValue:(id)_timeUnit];
        if (_timeUnit == nil && dict[@"timeUnit"] && ![dict[@"timeUnit"] isKindOfClass:NSNull.class]) return nil;
        _aggregate = map(_aggregate, λ(id x, [QTAggregatedFieldDef fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTransform.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTransform.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTransform.properties.allValues] mutableCopy];

    for (id jsonName in QTTransform.properties) {
        id propertyName = QTTransform.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"from": NSNullify([_from isKindOfClass:NSNull.class] ? nil : [_from JSONDictionary]),
        @"timeUnit": NSNullify([_timeUnit value]),
        @"aggregate": NSNullify(map(_aggregate, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTAggregatedFieldDef
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"as": @"as",
        @"field": @"field",
        @"op": @"op",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAggregatedFieldDef alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"as"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"field"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"op"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _op = [QTAggregateOp withValue:(id)_op];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAggregatedFieldDef.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAggregatedFieldDef.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAggregatedFieldDef.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"op": [_op value],
    }];

    return dict;
}
@end

@implementation QTLookupData
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"data": @"data",
        @"fields": @"fields",
        @"key": @"key",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLookupData alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"data"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"key"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _data = [QTData fromJSONDictionary:(id)_data];
        if (!_data && dict[@"data"] && ![dict[@"data"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLookupData.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLookupData.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLookupData.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"data": [_data JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTRepeat
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"column": @"column",
        @"row": @"row",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRepeat alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRepeat.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRepeat.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTRepeat.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
