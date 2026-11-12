-- To decode the JSON data, add this file to your project, run
--
--     elm install NoRedInk/elm-json-decode-pipeline
--
-- add these imports
--
--     import Json.Decode exposing (decodeString)
--     import QuickType exposing (quickType)
--
-- and you're off to the races with
--
--     decodeString quickType myJsonString

module QuickType exposing
    ( QuickType
    , quickTypeToString
    , quickType
    , A
    , B
    , C
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { a : A
    , b : B
    , c : C
    }

type alias A =
    { a : String
    , a0 : String
    , a00 : String
    , a000 : String
    , a0000 : String
    , a1 : String
    , a10 : String
    , a100000000 : String
    , a1E02 : String
    , aAlert123T : String
    , aFalse : String
    , aHrefJava123456781112ScriptJavascriptAlert1XXXA : String
    , aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestA : String
    , aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aTest : String
    , aTrue : String
    , abcDivStyleXExpX00RessionJavascriptAlert1DEF : String
    , abcDivStyleXExpX5CressionJavascriptAlert1DEF : String
    , abcDivStyleXX09ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXX0BexpressionJavascriptAlert1DEF : String
    , abcDivStyleXX20ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXX3AexpressionJavascriptAlert1DEF : String
    , abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEF : String
    , alert123 : String
    , alert123T : String
    , alertXSS : String
    , ambitious : String
    , andU200BZEROWIDTHSPACEWhichAreInTheCCategoriesButAreOften : String
    , arsenalCanal : String
    , autofocusOnkeyupJavascriptAlert123 : String
    , aux : String
    , braggadocious : String
    , changingLengthWhenLowercased : String
    , charactersWhichIncreaseInLength2To3BytesWhenLowercased : String
    , classic : String
    , commandInjectionRuby : String
    , cunning : String
    , d : String
    , dickVanDyke : String
    , dontMakeAMap : Bool
    , drHermanILibshitz : String
    , empty : String
    , envHome : String
    , etcHosts : String
    , etcPasswd00 : String
    , false : String
    , fluffy : String
    , fluffy0 : String
    , fluffyTest : String
    , fontsAndHaveANumberOfSpecialBehaviors : String
    , fooValBar : String
    , frisky : String
    , hilarious : String
    , home : String
    , humanInjection : String
    , iNVOkINGTHEFLINGOFCHOS : String
    , ifImgSrcXOnerrorJavascriptAlert1 : String
    , ifScriptJavascriptAlert1Script : String
    , imgSRCJavAscriptAlertXSS : String
    , imgSRCJavX0AAscriptAlertXSS : String
    , imgSRCJavX0DAscriptAlertXSS : String
    , imgSrc106971189711599114105112116589710810111411640398883833941 : String
    , imgSrcX09XOnerrorJavascriptAlert1 : String
    , imgSrcX11XOnerrorJavascriptAlert1 : String
    , imgSrcXOnerrorX00JavascriptAlert1 : String
    , imgSrcXOnerrorX09JavascriptAlert1 : String
    , imgSrcXX09OnerrorJavascriptAlert1 : String
    , imgSrcXX10OnerrorJavascriptAlert1 : String
    , imgSrcXX11OnerrorJavascriptAlert1 : String
    , imgSrcXX12OnerrorJavascriptAlert1 : String
    , imgSrcXX13OnerrorJavascriptAlert1 : String
    , imgSrcXxxXX00OnerrorJavascriptAlert1 : String
    , imgSrcXxxXX0BonerrorJavascriptAlert1 : String
    , imgSrcXxxXX2FonerrorJavascriptAlert1 : String
    , imgX00SrcXOnerrorAlert1 : String
    , imgX10SrcXOnerrorJavascriptAlert1 : String
    , imgX13SrcXOnerrorJavascriptAlert1 : String
    , imgX32SrcXOnerrorJavascriptAlert1 : String
    , imgX39SrcXOnerrorJavascriptAlert1 : String
    , indecent : String
    , indigo : String
    , inf : String
    , infinity : String
    , innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblem : String
    , jimmyClitheroe : String
    , kernelExit1 : String
    , knownCVEsAndVulnerabilities : String
    , lightwaterCountryPark : String
    , lpt2 : String
    , lpt3 : String
    , lsAl : String
    , magenta : String
    , mischievous : String
    , msdosWindowsSpecialFilenames : String
    , nil : String
    , nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F : String
    , none : String
    , null : String
    , onfocusJaVaSCriptAlert123Autofocus : String
    , or11 : String
    , penistoneCommunityChurch : String
    , perlEPrintIMGSRCJava0ScriptAlertXSSOut : String
    , prn : String
    , purple : String
    , purple0 : String
    , purple1 : String
    , purpleTest : String
    , romansInSussexCoUk : String
    , s : String
    , sUnSU : String
    , scScriptRiptAlert123ScScriptRipt : String
    , scriptAlert123ScriptX : String
    , scriptInjection : String
    , scriptSRCHTTPHaCkersOrgXSSJSB : String
    , scriptSRCHTTPHaCkersOrgXSSJSSCRIPT : String
    , scriptScriptAlert123Script : String
    , scriptX00JavascriptAlert1Script : String
    , scriptX09TypeTextJavascriptJavascriptAlert1Script : String
    , scriptX0CjavascriptAlert1Script : String
    , scriptX0DjavascriptAlert1Script : String
    , scriptX20TypeTextJavascriptJavascriptAlert1Script : String
    , scriptX3EtypeTextJavascriptJavascriptAlert1Script : String
    , scriptXC2X85JavascriptAlert1Script : String
    , scriptXC2XA0JavascriptAlert1Script : String
    , scriptXE1X9AX80JavascriptAlert1Script : String
    , scriptXE1XA0X8EjavascriptAlert1Script : String
    , scriptXE2X80X81JavascriptAlert1Script : String
    , scriptXE2X80X86JavascriptAlert1Script : String
    , scriptXE2X80X89JavascriptAlert1Script : String
    , scriptXE2X81X9FjavascriptAlert1Script : String
    , scriptXEFXBBXBFjavascriptAlert1Script : String
    , scriptXF0X90X96X9AjavascriptAlert1Script : String
    , scriptXSSSRCHTTPHaCkersOrgXSSJSSCRIPT : String
    , sqlInjection : String
    , sticky : String
    , stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParser : String
    , stringsThatTestForKnownVulnerabilities : String
    , stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString : String
    , stringsWhichCanCallSystemCommandsWithinRubyRailsApplications : String
    , stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb : String
    , stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters : String
    , stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes : String
    , stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways : String
    , stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors : String
    , stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues : String
    , stringsWhichCrashedIMessageInVariousVersionsOfIOS : String
    , stringsWhichMayCauseHumanToReinterpretWorldview : String
    , superBowlXXX : String
    , tentacled : String
    , test : String
    , textareaScriptAlert123Script : String
    , the0 : String
    , the00 : String
    , the000 : String
    , the0000 : String
    , the0X0 : String
    , the1 : String
    , the10 : String
    , the100 : String
    , the1000 : String
    , the100000 : String
    , the100000000 : String
    , the11 : String
    , the12 : String
    , the123456789012345678901234567890123456789 : String
    , the15 : String
    , the16 : String
    , the17 : String
    , the18 : String
    , the19 : String
    , the1DROPTABLEUsers : String
    , the1E02 : String
    , the1E2 : String
    , the1Qnan : String
    , the1Snan : String
    , the2 : String
    , the20 : String
    , the21 : String
    , the22 : String
    , the23 : String
    , the24 : String
    , the26 : String
    , the27 : String
    , the3 : String
    , the4 : String
    , the5 : String
    , the6 : String
    , the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 : String
    , theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers : String
    , theQuicKBrownFoXBeeeep : String
    , the_12 : String
    , the_13 : String
    , the_14 : String
    , the_25 : String
    , the_7 : String
    , the_8 : String
    , the_9 : String
    , true : String
    , twoByteCharacters : String
    , u0000U000AOrU000DNULLFCR : String
    , uOncopyAlertCopyMeU : String
    , undef : String
    , unicodeFont : String
    , unicodeNumbers : String
    , unwantedInterpolation : String
    , xLsAl : String
    , zGO : String
    }

type alias B =
    { aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A : String
    , aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestA : String
    , aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , abcDivStyleXExpressionX5CJavascriptAlert1DEF : String
    , abcDivStyleXX0AexpressionJavascriptAlert1DEF : String
    , abcDivStyleXX0DexpressionJavascriptAlert1DEF : String
    , abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEF : String
    , ambitious : String
    , appearInInput : String
    , ath0 : String
    , autofocusOnkeyupJavascriptAlert123 : String
    , b : String
    , b100000 : String
    , bIMGSRCOnmouseoverAlertXxs : String
    , bScriptAlert123Script : String
    , bTouchTmpBlnsFail : String
    , basement : String
    , braggadocious : String
    , butNow20CforMyGreatestTrick8M : String
    , byteOrderMarksUFEFFAndUFFFEEachOnItsOwnLine : String
    , com1 : String
    , com3 : String
    , commonlyMisinterpretedAsAdditionalGraphicCharacters : String
    , con : String
    , contextsDividedIntoThreeGroupsBasedOnUSLayoutKeyboardPosition : String
    , creditHTTPSTwitterCOMJifaStatus625776454479970304 : String
    , cunning : String
    , devNullTouchTmpBlnsFailEcho : String
    , dontMakeAMap : Bool
    , empty : String
    , evalPutsHelloWorld : String
    , expression : String
    , false : String
    , file : String
    , fileInclusion : String
    , fluffy : String
    , fooValBar : String
    , frisky : String
    , generalCategoryCFInUnicode800 : String
    , hEWHOWATSBEHINDTHEWAL : String
    , help : String
    , hilarious : String
    , httpA3030 : String
    , iOSVulnerabilities : String
    , ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou : String
    , iframeSrcHTTPHaCkersOrgScriptletHTML : String
    , imgSRC14JavascriptAlertXSS : String
    , imgSRCJavX09AscriptAlertXSS : String
    , imgSRCOnmouseoverAlertXxs : String
    , imgSRCX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29 : String
    , imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041 : String
    , imgSrcX00XOnerrorJavascriptAlert1 : String
    , imgSrcXOnerrorX11JavascriptAlert1 : String
    , imgSrcXOnerrorX12JavascriptAlert1 : String
    , imgSrcXxxXX0AonerrorJavascriptAlert1 : String
    , imgSrcXxxXX0ConerrorJavascriptAlert1 : String
    , imgSrcXxxXX0DonerrorJavascriptAlert1 : String
    , imgX00SrcXOnerrorJavascriptAlert1 : String
    , imgX11SrcXOnerrorJavascriptAlert1 : String
    , imgX12SrcXOnerrorJavascriptAlert1 : String
    , imgX47SrcXOnerrorJavascriptAlert1 : String
    , indecent : String
    , indigo : String
    , ircSpecificStrings : String
    , japaneseEmoticons : String
    , kernelExecLsAl : String
    , lindaCallahan : String
    , magenta : String
    , mischievous : String
    , nblUOlopOqlNUnppuOdPosnOpPsLUsdpNsuoSOlopNsdO : String
    , nil : String
    , nul : String
    , null : String
    , numericStrings : String
    , oINVOKTHEHIVEMINDREPRESETINGCHAOS : String
    , oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXML : String
    , onfocusJaVaSCriptAlert123Autofocus : String
    , or111 : String
    , purple : String
    , purpleScriptAlert123Script : String
    , quotationMarks : String
    , regionalIndicatorSymbols : String
    , regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross : String
    , reservedStrings : String
    , scriptAlert123Script : String
    , scriptAlert123ScriptX : String
    , scriptAlertXSSSCRIPT : String
    , scriptSRCHaCkersOrgJ : String
    , scriptSrcJscriptSScript : String
    , scriptX09JavascriptAlert1Script : String
    , scriptX0AtypeTextJavascriptJavascriptAlert1Script : String
    , scriptX0DtypeTextJavascriptJavascriptAlert1Script : String
    , scriptX21JavascriptAlert1Script : String
    , scriptX3BjavascriptAlert1Script : String
    , scriptXE2X80X85JavascriptAlert1Script : String
    , scriptXE2X80X87JavascriptAlert1Script : String
    , scriptXE2X80X8AjavascriptAlert1Script : String
    , scriptXE2X80XA8JavascriptAlert1Script : String
    , scriptXE2X80XA9JavascriptAlert1Script : String
    , scriptXE2X80XAFjavascriptAlert1Script : String
    , scriptXE3X80X80JavascriptAlert1Script : String
    , scunthorpeProblem : String
    , sticky : String
    , stringsThatMayOccurOnIRCClientsThatMakeSecurityProductsFreakOut : String
    , stringsWhichAreReservedCharactersInMSDOSWindows : String
    , stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSS : String
    , stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrew : String
    , stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues : String
    , stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric : String
    , stringsWhichMayBeUsedElsewhereInCode : String
    , tentacled : String
    , terminalEscapeCodes : String
    , the000 : String
    , the01000 : String
    , the08 : String
    , the09 : String
    , the0Xffffffffffffffff : String
    , the1 : String
    , the100 : String
    , the1000 : String
    , the100000 : String
    , the100000000 : String
    , the1DROPTABLEUsers1 : String
    , the1Ind : String
    , the1Inf : String
    , the21474836481 : String
    , the22250738585072011E308 : String
    , theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers : String
    , theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers : String
    , theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers : String
    , the_ : String
    , the_2 : String
    , the_3 : String
    , thisFileUnfortunatelyCannotExpressStringsContaining : String
    , touchTmpBlnsFail : String
    , touchTmpBlnsShellshock2Fail : String
    , tysonGay : String
    , unicodeSymbols : String
    , x00ScriptJavascriptAlert1Script : String
    , x3CscriptJavascriptAlert1Script : String
    }

type alias C =
    { a : String
    , aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA : String
    , abcDivStyleXExpressionX00JavascriptAlert1DEF : String
    , abcDivStyleXX00ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXX0CexpressionJavascriptAlert1DEF : String
    , abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEF : String
    , abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEF : String
    , ambitious : String
    , andU007FDEL : String
    , asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome : String
    , bodyOnloadAlertXSS : String
    , braggadocious : String
    , c : String
    , c00 : String
    , c000 : String
    , c100 : String
    , c100000 : String
    , c100000000 : String
    , c1E02 : String
    , cScriptAlert123Script : String
    , clock : String
    , com2 : String
    , com4 : String
    , craigCockburnSoftwareSpecialist : String
    , cunning : String
    , dccSendStartkeylogger000 : String
    , dontMakeAMap : Bool
    , emoji : String
    , empty : String
    , evaluate : String
    , fluffy : String
    , fluffy00 : String
    , fooValBar : String
    , frisky : String
    , hENEZPERDIANHIVMINFCASZALGO : String
    , hasOwnProperty : String
    , hilarious : String
    , hornimanMuseum : String
    , httpWWWCumQcCA : String
    , iOnwheelAlert1ScrollOverMeI : String
    , imgABCSrcDXEOnerrorFAlert1 : String
    , imgOnmouseoverAlertXxs : String
    , imgSCRIPTAlertXSSSCRIPT : String
    , imgSRCJavascriptAlertStringFromCharCode888383 : String
    , imgSRCJavascriptAlertXSS : String
    , imgSrcOnerrorAltJavascriptAlert1 : String
    , imgSrcX10XOnerrorJavascriptAlert1 : String
    , imgSrcX12XOnerrorJavascriptAlert1 : String
    , imgSrcX13XOnerrorJavascriptAlert1 : String
    , imgSrcX32XOnerrorJavascriptAlert1 : String
    , imgSrcX47XOnerrorJavascriptAlert1 : String
    , imgSrcXOnerrorAlert123 : String
    , imgSrcXOnerrorX10JavascriptAlert1 : String
    , imgSrcXOnerrorX32JavascriptAlert1 : String
    , imgSrcXScriptJavascriptAlert1Script : String
    , imgSrcXxxXX09OnerrorJavascriptAlert1 : String
    , imgSrcXxxXX20OnerrorJavascriptAlert1 : String
    , imgSrcXxxXX22OnerrorJavascriptAlert1 : String
    , imgSrcXxxXX27OnerrorJavascriptAlert1 : String
    , imgX11SrcXOnerrorJavascriptAlert1 : String
    , imgX34SrcXOnerrorJavascriptAlert1 : String
    , imgX47SrcXOnerrorJavascriptAlert1 : String
    , indecent : String
    , indigo : String
    , infinity : String
    , javaSCriptAlert123 : String
    , lpt1 : String
    , ltScriptGtAlert3912339LtScriptGt : String
    , magenta : String
    , magnaCumLaude : String
    , medievalErectionOfParapets : String
    , mischievous : String
    , mocha : String
    , naN : String
    , nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F : String
    , null : String
    , onfocusJaVaSCriptAlert123Autofocus : String
    , orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever : String
    , plaintext : String
    , powerH : String
    , purple : String
    , purple00 : String
    , purple100000 : String
    , purple100000000 : String
    , purpleScriptAlert123Script : String
    , rightToLeftStrings : String
    , rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue : String
    , s : String
    , scriptAlert123Script : String
    , scriptAlert123ScriptX : String
    , scriptJavascriptAlert1Script : String
    , scriptScriptAlert123Script : String
    , scriptSrcJscriptSScript : String
    , scriptX0AjavascriptAlert1Script : String
    , scriptX0BjavascriptAlert1Script : String
    , scriptX0CtypeTextJavascriptJavascriptAlert1Script : String
    , scriptX20JavascriptAlert1Script : String
    , scriptX2BjavascriptAlert1Script : String
    , scriptX2FtypeTextJavascriptJavascriptAlert1Script : String
    , scriptX7EjavascriptAlert1Script : String
    , scriptXE2X80X80JavascriptAlert1Script : String
    , scriptXE2X80X82JavascriptAlert1Script : String
    , scriptXE2X80X83JavascriptAlert1Script : String
    , scriptXE2X80X84JavascriptAlert1Script : String
    , scriptXE2X80X88JavascriptAlert1Script : String
    , scriptXE2X80X8BjavascriptAlert1Script : String
    , scriptXEFXBFXAEjavascriptAlert1Script : String
    , scriptXEFXBFXBEjavascriptAlert1Script : String
    , scunthorpeGeneralHospital : String
    , serverCodeInjection : String
    , shitakeMushrooms : String
    , specialCharacters : String
    , srcJaVaSCriptPrompt132 : String
    , sticky : String
    , stringsWhichCanBeInterpretedAsNumeric : String
    , stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitized : String
    , stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer : String
    , stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153 : String
    , stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNet : String
    , stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOM : String
    , stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDF : String
    , stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile : String
    , svgScript1231Alert123Script : String
    , systemLsAl : String
    , systemTouchTmpBlnsFail : String
    , tentacled : String
    , test : String
    , testTest : String
    , the0 : String
    , the00 : String
    , the000 : String
    , the0123456789 : String
    , the0TouchTmpBlnsShellshock1Fail : String
    , the0Xabad1Dea : String
    , the0Xffffffff : String
    , the1 : String
    , the10 : String
    , the100 : String
    , the100000 : String
    , the100000000 : String
    , the11 : String
    , the12 : String
    , the13 : String
    , the1E02 : String
    , the1E2 : String
    , the1Ind : String
    , the3 : String
    , the4 : String
    , the5 : String
    , the6 : String
    , the8 : String
    , the9 : String
    , the92233720368547758081 : String
    , the_ : String
    , the_1 : String
    , the_12 : String
    , the_2 : String
    , the_7 : String
    , titleOnpropertychangeJavascriptAlert1TitleTitleTitle : String
    , treatedAsWhitespaceInSomeContexts : String
    , trickUnicode : String
    , true : String
    , undefined : String
    , unicodeAdditionalControlCharactersAllOfTheCharactersWith : String
    , unicodeSubscriptSuperscriptAccents : String
    , unicodeUpsidedown : String
    , user : String
    , version : String
    , version800PlusU0009HTU000BVTU000CFFU0085NEL : String
    , whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode : String
    , xmlVersion10EncodingISO88591DOCTYPEFooELEMENTFooANYENTITYXxeSYSTEMFileEtcPasswdFooXxeFoo : String
    , xxeInjectionXML : String
    , zalgoText : String
    , zz : String
    }

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (encodeQuickType r)

quickType : Jdec.Decoder QuickType
quickType =
    Jdec.succeed QuickType
        |> Jpipe.required "a" a
        |> Jpipe.required "b" b
        |> Jpipe.required "c" c

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("a", encodeA x.a)
        , ("b", encodeB x.b)
        , ("c", encodeC x.c)
        ]

a : Jdec.Decoder A
a =
    Jdec.succeed A
        |> Jpipe.required "!@#$%^&*()`~" Jdec.string
        |> Jpipe.required "-0" Jdec.string
        |> Jpipe.required "00˙Ɩ$-" Jdec.string
        |> Jpipe.required "0,00" Jdec.string
        |> Jpipe.required "0.0/0.0" Jdec.string
        |> Jpipe.required "-1" Jdec.string
        |> Jpipe.required "1/0" Jdec.string
        |> Jpipe.required "1'000'000.00" Jdec.string
        |> Jpipe.required "1E02" Jdec.string
        |> Jpipe.required "';alert(123);t='" Jdec.string
        |> Jpipe.required "false" Jdec.string
        |> Jpipe.required "<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>" Jdec.string
        |> Jpipe.required "<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "\u{202A}\u{202A}test\u{202A}" Jdec.string
        |> Jpipe.required "True" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required ";alert(123);" Jdec.string
        |> Jpipe.required "\";alert(123);t=\"" Jdec.string
        |> Jpipe.required "\\\";alert('XSS');//" Jdec.string
        |> Jpipe.required "-." Jdec.string
        |> Jpipe.required "# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often" Jdec.string
        |> Jpipe.required "Arsenal canal" Jdec.string
        |> Jpipe.required "\" autofocus onkeyup=\"javascript:alert(123)" Jdec.string
        |> Jpipe.required "AUX" Jdec.string
        |> Jpipe.required "¡™£¢∞§¶•ªº–≠" Jdec.string
        |> Jpipe.required "#\tChanging length when lowercased" Jdec.string
        |> Jpipe.required "#\tCharacters which increase in length (2 to 3 bytes) when lowercased" Jdec.string
        |> Jpipe.required "classic" Jdec.string
        |> Jpipe.required "#\tCommand Injection (Ruby)" Jdec.string
        |> Jpipe.required "<>?:\"{}|_+" Jdec.string
        |> Jpipe.required "%d" Jdec.string
        |> Jpipe.required "Dick Van Dyke" Jdec.string
        |> Jpipe.required "dontMakeAMap" Jdec.bool
        |> Jpipe.required "Dr. Herman I. Libshitz" Jdec.string
        |> Jpipe.required " " Jdec.string
        |> Jpipe.required "$ENV{'HOME'}" Jdec.string
        |> Jpipe.required "../../../../../../../../../../../etc/hosts" Jdec.string
        |> Jpipe.required "../../../../../../../../../../../etc/passwd%00" Jdec.string
        |> Jpipe.required "False" Jdec.string
        |> Jpipe.required "'\"'" Jdec.string
        |> Jpipe.required "{0}" Jdec.string
        |> Jpipe.required "\u{2066}test\u{2067}" Jdec.string
        |> Jpipe.required "#       fonts, and have a number of special behaviors" Jdec.string
        |> Jpipe.required "<foo val=`bar' />" Jdec.string
        |> Jpipe.required "`⁄€‹›ﬁﬂ‡°·‚—±" Jdec.string
        |> Jpipe.required "-," Jdec.string
        |> Jpipe.required "$HOME" Jdec.string
        |> Jpipe.required "#\tHuman injection" Jdec.string
        |> Jpipe.required "̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰" Jdec.string
        |> Jpipe.required "<!--[if<img src=x onerror=javascript:alert(1)//]> -->" Jdec.string
        |> Jpipe.required "<!--[if]><script>javascript:alert(1)</script -->" Jdec.string
        |> Jpipe.required "<IMG SRC=\"jav   ascript:alert('XSS');\">" Jdec.string
        |> Jpipe.required "<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">" Jdec.string
        |> Jpipe.required "<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">" Jdec.string
        |> Jpipe.required "<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>" Jdec.string
        |> Jpipe.required "<img src\\x09=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src\\x11=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src=x onerror=\\x00\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src=x onerror=\\x09\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src=x\\x09onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src=x\\x10onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src=x\\x11onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src=x\\x12onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src=x\\x13onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>" Jdec.string
        |> Jpipe.required "`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>" Jdec.string
        |> Jpipe.required "`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>" Jdec.string
        |> Jpipe.required "<img \\x00src=x onerror=\"alert(1)\">" Jdec.string
        |> Jpipe.required "<img\\x10src=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img\\x13src=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img\\x32src=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img \\x39src=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required ",./;'[]\\-=" Jdec.string
        |> Jpipe.required "," Jdec.string
        |> Jpipe.required "INF" Jdec.string
        |> Jpipe.required "-Infinity" Jdec.string
        |> Jpipe.required "#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)" Jdec.string
        |> Jpipe.required "Jimmy Clitheroe" Jdec.string
        |> Jpipe.required "Kernel.exit(1)" Jdec.string
        |> Jpipe.required "#\tKnown CVEs and Vulnerabilities" Jdec.string
        |> Jpipe.required "Lightwater Country Park" Jdec.string
        |> Jpipe.required "LPT2" Jdec.string
        |> Jpipe.required "LPT3" Jdec.string
        |> Jpipe.required "`ls -al /`" Jdec.string
        |> Jpipe.required "\\" Jdec.string
        |> Jpipe.required "\u{0080}\u{0081}\u{0082}\u{0083}\u{0084}\u{0086}\u{0087}\u{0088}\u{0089}\u{008A}\u{008B}\u{008C}\u{008D}\u{008E}\u{008F}\u{0090}\u{0091}\u{0092}\u{0093}\u{0094}\u{0095}\u{0096}\u{0097}\u{0098}\u{0099}\u{009A}\u{009B}\u{009C}\u{009D}\u{009E}\u{009F}" Jdec.string
        |> Jpipe.required "#\tMSDOS/Windows Special Filenames" Jdec.string
        |> Jpipe.required "nil" Jdec.string
        |> Jpipe.required "# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F." Jdec.string
        |> Jpipe.required "None" Jdec.string
        |> Jpipe.required "(null)" Jdec.string
        |> Jpipe.required " onfocus=JaVaSCript:alert(123) autofocus" Jdec.string
        |> Jpipe.required "' OR '1'='1" Jdec.string
        |> Jpipe.required "Penistone Community Church" Jdec.string
        |> Jpipe.required "perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out" Jdec.string
        |> Jpipe.required "PRN" Jdec.string
        |> Jpipe.required "'" Jdec.string
        |> Jpipe.required "0" Jdec.string
        |> Jpipe.required "1" Jdec.string
        |> Jpipe.required "\u{202B}test\u{202B}" Jdec.string
        |> Jpipe.required "RomansInSussex.co.uk" Jdec.string
        |> Jpipe.required "%s" Jdec.string
        |> Jpipe.required "<<< %s(un='%s') = %u" Jdec.string
        |> Jpipe.required "<sc<script>ript>alert(123)</sc</script>ript>" Jdec.string
        |> Jpipe.required "\"><script>alert(123);</script x=\"" Jdec.string
        |> Jpipe.required "#\tScript Injection" Jdec.string
        |> Jpipe.required "<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >" Jdec.string
        |> Jpipe.required "<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>" Jdec.string
        |> Jpipe.required "</script><script>alert(123)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\x00javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "<script\\x09type=\"text/javascript\">javascript:alert(1);</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\x0Cjavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\x0Djavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "<script\\x20type=\"text/javascript\">javascript:alert(1);</script>" Jdec.string
        |> Jpipe.required "<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xC2\\x85javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xC2\\xA0javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>" Jdec.string
        |> Jpipe.required "#\tSQL Injection" Jdec.string
        |> Jpipe.required "(╯°□°）╯︵ ┻━┻)" Jdec.string
        |> Jpipe.required "#\tString which can reveal system files when parsed by a badly configured XML parser" Jdec.string
        |> Jpipe.required "#\tStrings that test for known vulnerabilities" Jdec.string
        |> Jpipe.required "#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string." Jdec.string
        |> Jpipe.required "#\tStrings which can call system commands within Ruby/Rails applications" Jdec.string
        |> Jpipe.required "#\tStrings which consists of Japanese-style emoticons which are popular on the web" Jdec.string
        |> Jpipe.required "#\tStrings which contain bold/italic/etc. versions of normal characters" Jdec.string
        |> Jpipe.required "#\tStrings which contain common unicode symbols (e.g. smart quotes)" Jdec.string
        |> Jpipe.required "#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always" Jdec.string
        |> Jpipe.required "#\tStrings which contain misplaced quotation marks; can cause encoding errors" Jdec.string
        |> Jpipe.required "#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues" Jdec.string
        |> Jpipe.required "#\tStrings which crashed iMessage in various versions of iOS" Jdec.string
        |> Jpipe.required "#\tStrings which may cause human to reinterpret worldview" Jdec.string
        |> Jpipe.required "Super Bowl XXX" Jdec.string
        |> Jpipe.required "( ͡° ͜ʖ ͡°)" Jdec.string
        |> Jpipe.required "הָיְתָהtestالصفحات التّحول" Jdec.string
        |> Jpipe.required "</textarea><script>alert(123)</script>" Jdec.string
        |> Jpipe.required "+0" Jdec.string
        |> Jpipe.required "0..0" Jdec.string
        |> Jpipe.required "0,0,0" Jdec.string
        |> Jpipe.required "0,0/0,0" Jdec.string
        |> Jpipe.required "0x0" Jdec.string
        |> Jpipe.required "\u{00AD}\u{0600}\u{0601}\u{0602}\u{0603}\u{0604}\u{0605}\u{061C}\u{06DD}\u{070F}\u{180E}\u{200B}\u{200C}\u{200D}\u{200E}\u{200F}\u{202A}\u{202B}\u{202C}\u{202D}\u{202E}\u{2060}\u{2061}\u{2062}\u{2063}\u{2064}\u{2066}\u{2067}\u{2068}\u{2069}\u{206A}\u{206B}\u{206C}\u{206D}\u{206E}\u{206F}\u{FEFF}\u{FFF9}\u{FFFA}\u{FFFB}\u{110BD}\u{1BCA0}\u{1BCA1}\u{1BCA2}\u{1BCA3}\u{1D173}\u{1D174}\u{1D175}\u{1D176}\u{1D177}\u{1D178}\u{1D179}\u{1D17A}\u{E0001}\u{E0020}\u{E0021}\u{E0022}\u{E0023}\u{E0024}\u{E0025}\u{E0026}\u{E0027}\u{E0028}\u{E0029}\u{E002A}\u{E002B}\u{E002C}\u{E002D}\u{E002E}\u{E002F}\u{E0030}\u{E0031}\u{E0032}\u{E0033}\u{E0034}\u{E0035}\u{E0036}\u{E0037}\u{E0038}\u{E0039}\u{E003A}\u{E003B}\u{E003C}\u{E003D}\u{E003E}\u{E003F}\u{E0040}\u{E0041}\u{E0042}\u{E0043}\u{E0044}\u{E0045}\u{E0046}\u{E0047}\u{E0048}\u{E0049}\u{E004A}\u{E004B}\u{E004C}\u{E004D}\u{E004E}\u{E004F}\u{E0050}\u{E0051}\u{E0052}\u{E0053}\u{E0054}\u{E0055}\u{E0056}\u{E0057}\u{E0058}\u{E0059}\u{E005A}\u{E005B}\u{E005C}\u{E005D}\u{E005E}\u{E005F}\u{E0060}\u{E0061}\u{E0062}\u{E0063}\u{E0064}\u{E0065}\u{E0066}\u{E0067}\u{E0068}\u{E0069}\u{E006A}\u{E006B}\u{E006C}\u{E006D}\u{E006E}\u{E006F}\u{E0070}\u{E0071}\u{E0072}\u{E0073}\u{E0074}\u{E0075}\u{E0076}\u{E0077}\u{E0078}\u{E0079}\u{E007A}\u{E007B}\u{E007C}\u{E007D}\u{E007E}\u{E007F}" Jdec.string
        |> Jpipe.required "₀₁₂" Jdec.string
        |> Jpipe.required "1.00" Jdec.string
        |> Jpipe.required "1.0/0.0" Jdec.string
        |> Jpipe.required "1'000,00" Jdec.string
        |> Jpipe.required "1 000 000.00" Jdec.string
        |> Jpipe.required "⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢" Jdec.string
        |> Jpipe.required "1/2" Jdec.string
        |> Jpipe.required "123456789012345678901234567890123456789" Jdec.string
        |> Jpipe.required "\u{1D47B}\u{1D489}\u{1D486} \u{1D492}\u{1D496}\u{1D48A}\u{1D484}\u{1D48C} \u{1D483}\u{1D493}\u{1D490}\u{1D498}\u{1D48F} \u{1D487}\u{1D490}\u{1D499} \u{1D48B}\u{1D496}\u{1D48E}\u{1D491}\u{1D494} \u{1D490}\u{1D497}\u{1D486}\u{1D493} \u{1D495}\u{1D489}\u{1D486} \u{1D48D}\u{1D482}\u{1D49B}\u{1D49A} \u{1D485}\u{1D490}\u{1D488}" Jdec.string
        |> Jpipe.required "\u{1D4E3}\u{1D4F1}\u{1D4EE} \u{1D4FA}\u{1D4FE}\u{1D4F2}\u{1D4EC}\u{1D4F4} \u{1D4EB}\u{1D4FB}\u{1D4F8}\u{1D500}\u{1D4F7} \u{1D4EF}\u{1D4F8}\u{1D501} \u{1D4F3}\u{1D4FE}\u{1D4F6}\u{1D4F9}\u{1D4FC} \u{1D4F8}\u{1D4FF}\u{1D4EE}\u{1D4FB} \u{1D4FD}\u{1D4F1}\u{1D4EE} \u{1D4F5}\u{1D4EA}\u{1D503}\u{1D502} \u{1D4ED}\u{1D4F8}\u{1D4F0}" Jdec.string
        |> Jpipe.required "\u{1D57F}\u{1D58D}\u{1D58A} \u{1D596}\u{1D59A}\u{1D58E}\u{1D588}\u{1D590} \u{1D587}\u{1D597}\u{1D594}\u{1D59C}\u{1D593} \u{1D58B}\u{1D594}\u{1D59D} \u{1D58F}\u{1D59A}\u{1D592}\u{1D595}\u{1D598} \u{1D594}\u{1D59B}\u{1D58A}\u{1D597} \u{1D599}\u{1D58D}\u{1D58A} \u{1D591}\u{1D586}\u{1D59F}\u{1D59E} \u{1D589}\u{1D594}\u{1D58C}" Jdec.string
        |> Jpipe.required "\u{1F1FA}\u{1F1F8}\u{1F1F7}\u{1F1FA}\u{1F1F8} \u{1F1E6}\u{1F1EB}\u{1F1E6}\u{1F1F2}\u{1F1F8}" Jdec.string
        |> Jpipe.required "\u{1F1FA}\u{1F1F8}\u{1F1F7}\u{1F1FA}\u{1F1F8}\u{1F1E6}" Jdec.string
        |> Jpipe.required "1;DROP TABLE users" Jdec.string
        |> Jpipe.required "-1E02" Jdec.string
        |> Jpipe.required "1E2" Jdec.string
        |> Jpipe.required "1#QNAN" Jdec.string
        |> Jpipe.required "1#SNAN" Jdec.string
        |> Jpipe.required "¸˛Ç◊ı˜Â¯˘¿" Jdec.string
        |> Jpipe.required "\u{1F1FA}\u{1F1F8}\u{1F1F7}\u{1F1FA}\u{1F1F8}\u{1F1E6}\u{1F1EB}\u{1F1E6}\u{1F1F2}" Jdec.string
        |> Jpipe.required "\u{1F469}\u{1F3FD}" Jdec.string
        |> Jpipe.required "\u{1F6BE} \u{1F192} \u{1F193} \u{1F195} \u{1F196} \u{1F197} \u{1F199} \u{1F3E7}" Jdec.string
        |> Jpipe.required "﷽" Jdec.string
        |> Jpipe.required "\u{FEFF}" Jdec.string
        |> Jpipe.required "ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ" Jdec.string
        |> Jpipe.required "\u{FFFE}" Jdec.string
        |> Jpipe.required "Œ„´‰ˇÁ¨ˆØ∏”’" Jdec.string
        |> Jpipe.required "œ∑´®†¥¨ˆøπ“‘" Jdec.string
        |> Jpipe.required "Ⱥ" Jdec.string
        |> Jpipe.required "Ⱦ" Jdec.string
        |> Jpipe.required "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999" Jdec.string
        |> Jpipe.required "# The next two lines may appear to be blank or mojibake in some viewers." Jdec.string
        |> Jpipe.required "The quic\u{0008}\u{0008}\u{0008}\u{0008}\u{0008}\u{0008}k brown fo\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}x... [Beeeep]" Jdec.string
        |> Jpipe.required "パーティーへ行かないか" Jdec.string
        |> Jpipe.required "和製漢語" Jdec.string
        |> Jpipe.required "田中さんにあげて下さい" Jdec.string
        |> Jpipe.required "｀ｨ(´∀｀∩" Jdec.string
        |> Jpipe.required "ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو." Jdec.string
        |> Jpipe.required "٠١٢٣٤٥٦٧٨٩" Jdec.string
        |> Jpipe.required "ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็" Jdec.string
        |> Jpipe.required "TRUE" Jdec.string
        |> Jpipe.required "#\tTwo-Byte Characters" Jdec.string
        |> Jpipe.required "# U+0000, U+000A, or U+000D (NUL, LF, CR)." Jdec.string
        |> Jpipe.required "<u oncopy=alert()> Copy me</u>" Jdec.string
        |> Jpipe.required "undef" Jdec.string
        |> Jpipe.required "#\tUnicode font" Jdec.string
        |> Jpipe.required "#\tUnicode Numbers" Jdec.string
        |> Jpipe.required "#\tUnwanted Interpolation" Jdec.string
        |> Jpipe.required "%x('ls -al /')" Jdec.string
        |> Jpipe.required "Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮" Jdec.string

encodeA : A -> Jenc.Value
encodeA x =
    Jenc.object
        [ ("!@#$%^&*()`~", Jenc.string x.a)
        , ("-0", Jenc.string x.a0)
        , ("00˙Ɩ$-", Jenc.string x.a00)
        , ("0,00", Jenc.string x.a000)
        , ("0.0/0.0", Jenc.string x.a0000)
        , ("-1", Jenc.string x.a1)
        , ("1/0", Jenc.string x.a10)
        , ("1'000'000.00", Jenc.string x.a100000000)
        , ("1E02", Jenc.string x.a1E02)
        , ("';alert(123);t='", Jenc.string x.aAlert123T)
        , ("false", Jenc.string x.aFalse)
        , ("<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>", Jenc.string x.aHrefJava123456781112ScriptJavascriptAlert1XXXA)
        , ("<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("\u{202A}\u{202A}test\u{202A}", Jenc.string x.aTest)
        , ("True", Jenc.string x.aTrue)
        , ("ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXExpX00RessionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXExpX5CressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXX09ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXX0BexpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXX20ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXX3AexpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEF)
        , (";alert(123);", Jenc.string x.alert123)
        , ("\";alert(123);t=\"", Jenc.string x.alert123T)
        , ("\\\";alert('XSS');//", Jenc.string x.alertXSS)
        , ("-.", Jenc.string x.ambitious)
        , ("# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often", Jenc.string x.andU200BZEROWIDTHSPACEWhichAreInTheCCategoriesButAreOften)
        , ("Arsenal canal", Jenc.string x.arsenalCanal)
        , ("\" autofocus onkeyup=\"javascript:alert(123)", Jenc.string x.autofocusOnkeyupJavascriptAlert123)
        , ("AUX", Jenc.string x.aux)
        , ("¡™£¢∞§¶•ªº–≠", Jenc.string x.braggadocious)
        , ("#\tChanging length when lowercased", Jenc.string x.changingLengthWhenLowercased)
        , ("#\tCharacters which increase in length (2 to 3 bytes) when lowercased", Jenc.string x.charactersWhichIncreaseInLength2To3BytesWhenLowercased)
        , ("classic", Jenc.string x.classic)
        , ("#\tCommand Injection (Ruby)", Jenc.string x.commandInjectionRuby)
        , ("<>?:\"{}|_+", Jenc.string x.cunning)
        , ("%d", Jenc.string x.d)
        , ("Dick Van Dyke", Jenc.string x.dickVanDyke)
        , ("dontMakeAMap", Jenc.bool x.dontMakeAMap)
        , ("Dr. Herman I. Libshitz", Jenc.string x.drHermanILibshitz)
        , (" ", Jenc.string x.empty)
        , ("$ENV{'HOME'}", Jenc.string x.envHome)
        , ("../../../../../../../../../../../etc/hosts", Jenc.string x.etcHosts)
        , ("../../../../../../../../../../../etc/passwd%00", Jenc.string x.etcPasswd00)
        , ("False", Jenc.string x.false)
        , ("'\"'", Jenc.string x.fluffy)
        , ("{0}", Jenc.string x.fluffy0)
        , ("\u{2066}test\u{2067}", Jenc.string x.fluffyTest)
        , ("#       fonts, and have a number of special behaviors", Jenc.string x.fontsAndHaveANumberOfSpecialBehaviors)
        , ("<foo val=`bar' />", Jenc.string x.fooValBar)
        , ("`⁄€‹›ﬁﬂ‡°·‚—±", Jenc.string x.frisky)
        , ("-,", Jenc.string x.hilarious)
        , ("$HOME", Jenc.string x.home)
        , ("#\tHuman injection", Jenc.string x.humanInjection)
        , ("̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰", Jenc.string x.iNVOkINGTHEFLINGOFCHOS)
        , ("<!--[if<img src=x onerror=javascript:alert(1)//]> -->", Jenc.string x.ifImgSrcXOnerrorJavascriptAlert1)
        , ("<!--[if]><script>javascript:alert(1)</script -->", Jenc.string x.ifScriptJavascriptAlert1Script)
        , ("<IMG SRC=\"jav   ascript:alert('XSS');\">", Jenc.string x.imgSRCJavAscriptAlertXSS)
        , ("<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">", Jenc.string x.imgSRCJavX0AAscriptAlertXSS)
        , ("<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">", Jenc.string x.imgSRCJavX0DAscriptAlertXSS)
        , ("<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>", Jenc.string x.imgSrc106971189711599114105112116589710810111411640398883833941)
        , ("<img src\\x09=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgSrcX09XOnerrorJavascriptAlert1)
        , ("<img src\\x11=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgSrcX11XOnerrorJavascriptAlert1)
        , ("<img src=x onerror=\\x00\"javascript:alert(1)\">", Jenc.string x.imgSrcXOnerrorX00JavascriptAlert1)
        , ("<img src=x onerror=\\x09\"javascript:alert(1)\">", Jenc.string x.imgSrcXOnerrorX09JavascriptAlert1)
        , ("<img src=x\\x09onerror=\"javascript:alert(1)\">", Jenc.string x.imgSrcXX09OnerrorJavascriptAlert1)
        , ("<img src=x\\x10onerror=\"javascript:alert(1)\">", Jenc.string x.imgSrcXX10OnerrorJavascriptAlert1)
        , ("<img src=x\\x11onerror=\"javascript:alert(1)\">", Jenc.string x.imgSrcXX11OnerrorJavascriptAlert1)
        , ("<img src=x\\x12onerror=\"javascript:alert(1)\">", Jenc.string x.imgSrcXX12OnerrorJavascriptAlert1)
        , ("<img src=x\\x13onerror=\"javascript:alert(1)\">", Jenc.string x.imgSrcXX13OnerrorJavascriptAlert1)
        , ("`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>", Jenc.string x.imgSrcXxxXX00OnerrorJavascriptAlert1)
        , ("`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>", Jenc.string x.imgSrcXxxXX0BonerrorJavascriptAlert1)
        , ("`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>", Jenc.string x.imgSrcXxxXX2FonerrorJavascriptAlert1)
        , ("<img \\x00src=x onerror=\"alert(1)\">", Jenc.string x.imgX00SrcXOnerrorAlert1)
        , ("<img\\x10src=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgX10SrcXOnerrorJavascriptAlert1)
        , ("<img\\x13src=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgX13SrcXOnerrorJavascriptAlert1)
        , ("<img\\x32src=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgX32SrcXOnerrorJavascriptAlert1)
        , ("<img \\x39src=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgX39SrcXOnerrorJavascriptAlert1)
        , (",./;'[]\\-=", Jenc.string x.indecent)
        , (",", Jenc.string x.indigo)
        , ("INF", Jenc.string x.inf)
        , ("-Infinity", Jenc.string x.infinity)
        , ("#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)", Jenc.string x.innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblem)
        , ("Jimmy Clitheroe", Jenc.string x.jimmyClitheroe)
        , ("Kernel.exit(1)", Jenc.string x.kernelExit1)
        , ("#\tKnown CVEs and Vulnerabilities", Jenc.string x.knownCVEsAndVulnerabilities)
        , ("Lightwater Country Park", Jenc.string x.lightwaterCountryPark)
        , ("LPT2", Jenc.string x.lpt2)
        , ("LPT3", Jenc.string x.lpt3)
        , ("`ls -al /`", Jenc.string x.lsAl)
        , ("\\", Jenc.string x.magenta)
        , ("\u{0080}\u{0081}\u{0082}\u{0083}\u{0084}\u{0086}\u{0087}\u{0088}\u{0089}\u{008A}\u{008B}\u{008C}\u{008D}\u{008E}\u{008F}\u{0090}\u{0091}\u{0092}\u{0093}\u{0094}\u{0095}\u{0096}\u{0097}\u{0098}\u{0099}\u{009A}\u{009B}\u{009C}\u{009D}\u{009E}\u{009F}", Jenc.string x.mischievous)
        , ("#\tMSDOS/Windows Special Filenames", Jenc.string x.msdosWindowsSpecialFilenames)
        , ("nil", Jenc.string x.nil)
        , ("# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F.", Jenc.string x.nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F)
        , ("None", Jenc.string x.none)
        , ("(null)", Jenc.string x.null)
        , (" onfocus=JaVaSCript:alert(123) autofocus", Jenc.string x.onfocusJaVaSCriptAlert123Autofocus)
        , ("' OR '1'='1", Jenc.string x.or11)
        , ("Penistone Community Church", Jenc.string x.penistoneCommunityChurch)
        , ("perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out", Jenc.string x.perlEPrintIMGSRCJava0ScriptAlertXSSOut)
        , ("PRN", Jenc.string x.prn)
        , ("'", Jenc.string x.purple)
        , ("0", Jenc.string x.purple0)
        , ("1", Jenc.string x.purple1)
        , ("\u{202B}test\u{202B}", Jenc.string x.purpleTest)
        , ("RomansInSussex.co.uk", Jenc.string x.romansInSussexCoUk)
        , ("%s", Jenc.string x.s)
        , ("<<< %s(un='%s') = %u", Jenc.string x.sUnSU)
        , ("<sc<script>ript>alert(123)</sc</script>ript>", Jenc.string x.scScriptRiptAlert123ScScriptRipt)
        , ("\"><script>alert(123);</script x=\"", Jenc.string x.scriptAlert123ScriptX)
        , ("#\tScript Injection", Jenc.string x.scriptInjection)
        , ("<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >", Jenc.string x.scriptSRCHTTPHaCkersOrgXSSJSB)
        , ("<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", Jenc.string x.scriptSRCHTTPHaCkersOrgXSSJSSCRIPT)
        , ("</script><script>alert(123)</script>", Jenc.string x.scriptScriptAlert123Script)
        , ("\"`'><script>\\x00javascript:alert(1)</script>", Jenc.string x.scriptX00JavascriptAlert1Script)
        , ("<script\\x09type=\"text/javascript\">javascript:alert(1);</script>", Jenc.string x.scriptX09TypeTextJavascriptJavascriptAlert1Script)
        , ("\"`'><script>\\x0Cjavascript:alert(1)</script>", Jenc.string x.scriptX0CjavascriptAlert1Script)
        , ("\"`'><script>\\x0Djavascript:alert(1)</script>", Jenc.string x.scriptX0DjavascriptAlert1Script)
        , ("<script\\x20type=\"text/javascript\">javascript:alert(1);</script>", Jenc.string x.scriptX20TypeTextJavascriptJavascriptAlert1Script)
        , ("<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>", Jenc.string x.scriptX3EtypeTextJavascriptJavascriptAlert1Script)
        , ("\"`'><script>\\xC2\\x85javascript:alert(1)</script>", Jenc.string x.scriptXC2X85JavascriptAlert1Script)
        , ("\"`'><script>\\xC2\\xA0javascript:alert(1)</script>", Jenc.string x.scriptXC2XA0JavascriptAlert1Script)
        , ("\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>", Jenc.string x.scriptXE1X9AX80JavascriptAlert1Script)
        , ("\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>", Jenc.string x.scriptXE1XA0X8EjavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>", Jenc.string x.scriptXE2X80X81JavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>", Jenc.string x.scriptXE2X80X86JavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>", Jenc.string x.scriptXE2X80X89JavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>", Jenc.string x.scriptXE2X81X9FjavascriptAlert1Script)
        , ("\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>", Jenc.string x.scriptXEFXBBXBFjavascriptAlert1Script)
        , ("\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>", Jenc.string x.scriptXF0X90X96X9AjavascriptAlert1Script)
        , ("<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", Jenc.string x.scriptXSSSRCHTTPHaCkersOrgXSSJSSCRIPT)
        , ("#\tSQL Injection", Jenc.string x.sqlInjection)
        , ("(╯°□°）╯︵ ┻━┻)", Jenc.string x.sticky)
        , ("#\tString which can reveal system files when parsed by a badly configured XML parser", Jenc.string x.stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParser)
        , ("#\tStrings that test for known vulnerabilities", Jenc.string x.stringsThatTestForKnownVulnerabilities)
        , ("#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string.", Jenc.string x.stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString)
        , ("#\tStrings which can call system commands within Ruby/Rails applications", Jenc.string x.stringsWhichCanCallSystemCommandsWithinRubyRailsApplications)
        , ("#\tStrings which consists of Japanese-style emoticons which are popular on the web", Jenc.string x.stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb)
        , ("#\tStrings which contain bold/italic/etc. versions of normal characters", Jenc.string x.stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters)
        , ("#\tStrings which contain common unicode symbols (e.g. smart quotes)", Jenc.string x.stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes)
        , ("#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always", Jenc.string x.stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways)
        , ("#\tStrings which contain misplaced quotation marks; can cause encoding errors", Jenc.string x.stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors)
        , ("#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues", Jenc.string x.stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues)
        , ("#\tStrings which crashed iMessage in various versions of iOS", Jenc.string x.stringsWhichCrashedIMessageInVariousVersionsOfIOS)
        , ("#\tStrings which may cause human to reinterpret worldview", Jenc.string x.stringsWhichMayCauseHumanToReinterpretWorldview)
        , ("Super Bowl XXX", Jenc.string x.superBowlXXX)
        , ("( ͡° ͜ʖ ͡°)", Jenc.string x.tentacled)
        , ("הָיְתָהtestالصفحات التّحول", Jenc.string x.test)
        , ("</textarea><script>alert(123)</script>", Jenc.string x.textareaScriptAlert123Script)
        , ("+0", Jenc.string x.the0)
        , ("0..0", Jenc.string x.the00)
        , ("0,0,0", Jenc.string x.the000)
        , ("0,0/0,0", Jenc.string x.the0000)
        , ("0x0", Jenc.string x.the0X0)
        , ("\u{00AD}\u{0600}\u{0601}\u{0602}\u{0603}\u{0604}\u{0605}\u{061C}\u{06DD}\u{070F}\u{180E}\u{200B}\u{200C}\u{200D}\u{200E}\u{200F}\u{202A}\u{202B}\u{202C}\u{202D}\u{202E}\u{2060}\u{2061}\u{2062}\u{2063}\u{2064}\u{2066}\u{2067}\u{2068}\u{2069}\u{206A}\u{206B}\u{206C}\u{206D}\u{206E}\u{206F}\u{FEFF}\u{FFF9}\u{FFFA}\u{FFFB}\u{110BD}\u{1BCA0}\u{1BCA1}\u{1BCA2}\u{1BCA3}\u{1D173}\u{1D174}\u{1D175}\u{1D176}\u{1D177}\u{1D178}\u{1D179}\u{1D17A}\u{E0001}\u{E0020}\u{E0021}\u{E0022}\u{E0023}\u{E0024}\u{E0025}\u{E0026}\u{E0027}\u{E0028}\u{E0029}\u{E002A}\u{E002B}\u{E002C}\u{E002D}\u{E002E}\u{E002F}\u{E0030}\u{E0031}\u{E0032}\u{E0033}\u{E0034}\u{E0035}\u{E0036}\u{E0037}\u{E0038}\u{E0039}\u{E003A}\u{E003B}\u{E003C}\u{E003D}\u{E003E}\u{E003F}\u{E0040}\u{E0041}\u{E0042}\u{E0043}\u{E0044}\u{E0045}\u{E0046}\u{E0047}\u{E0048}\u{E0049}\u{E004A}\u{E004B}\u{E004C}\u{E004D}\u{E004E}\u{E004F}\u{E0050}\u{E0051}\u{E0052}\u{E0053}\u{E0054}\u{E0055}\u{E0056}\u{E0057}\u{E0058}\u{E0059}\u{E005A}\u{E005B}\u{E005C}\u{E005D}\u{E005E}\u{E005F}\u{E0060}\u{E0061}\u{E0062}\u{E0063}\u{E0064}\u{E0065}\u{E0066}\u{E0067}\u{E0068}\u{E0069}\u{E006A}\u{E006B}\u{E006C}\u{E006D}\u{E006E}\u{E006F}\u{E0070}\u{E0071}\u{E0072}\u{E0073}\u{E0074}\u{E0075}\u{E0076}\u{E0077}\u{E0078}\u{E0079}\u{E007A}\u{E007B}\u{E007C}\u{E007D}\u{E007E}\u{E007F}", Jenc.string x.the1)
        , ("₀₁₂", Jenc.string x.the10)
        , ("1.00", Jenc.string x.the100)
        , ("1.0/0.0", Jenc.string x.the1000)
        , ("1'000,00", Jenc.string x.the100000)
        , ("1 000 000.00", Jenc.string x.the100000000)
        , ("⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢", Jenc.string x.the11)
        , ("1/2", Jenc.string x.the12)
        , ("123456789012345678901234567890123456789", Jenc.string x.the123456789012345678901234567890123456789)
        , ("\u{1D47B}\u{1D489}\u{1D486} \u{1D492}\u{1D496}\u{1D48A}\u{1D484}\u{1D48C} \u{1D483}\u{1D493}\u{1D490}\u{1D498}\u{1D48F} \u{1D487}\u{1D490}\u{1D499} \u{1D48B}\u{1D496}\u{1D48E}\u{1D491}\u{1D494} \u{1D490}\u{1D497}\u{1D486}\u{1D493} \u{1D495}\u{1D489}\u{1D486} \u{1D48D}\u{1D482}\u{1D49B}\u{1D49A} \u{1D485}\u{1D490}\u{1D488}", Jenc.string x.the15)
        , ("\u{1D4E3}\u{1D4F1}\u{1D4EE} \u{1D4FA}\u{1D4FE}\u{1D4F2}\u{1D4EC}\u{1D4F4} \u{1D4EB}\u{1D4FB}\u{1D4F8}\u{1D500}\u{1D4F7} \u{1D4EF}\u{1D4F8}\u{1D501} \u{1D4F3}\u{1D4FE}\u{1D4F6}\u{1D4F9}\u{1D4FC} \u{1D4F8}\u{1D4FF}\u{1D4EE}\u{1D4FB} \u{1D4FD}\u{1D4F1}\u{1D4EE} \u{1D4F5}\u{1D4EA}\u{1D503}\u{1D502} \u{1D4ED}\u{1D4F8}\u{1D4F0}", Jenc.string x.the16)
        , ("\u{1D57F}\u{1D58D}\u{1D58A} \u{1D596}\u{1D59A}\u{1D58E}\u{1D588}\u{1D590} \u{1D587}\u{1D597}\u{1D594}\u{1D59C}\u{1D593} \u{1D58B}\u{1D594}\u{1D59D} \u{1D58F}\u{1D59A}\u{1D592}\u{1D595}\u{1D598} \u{1D594}\u{1D59B}\u{1D58A}\u{1D597} \u{1D599}\u{1D58D}\u{1D58A} \u{1D591}\u{1D586}\u{1D59F}\u{1D59E} \u{1D589}\u{1D594}\u{1D58C}", Jenc.string x.the17)
        , ("\u{1F1FA}\u{1F1F8}\u{1F1F7}\u{1F1FA}\u{1F1F8} \u{1F1E6}\u{1F1EB}\u{1F1E6}\u{1F1F2}\u{1F1F8}", Jenc.string x.the18)
        , ("\u{1F1FA}\u{1F1F8}\u{1F1F7}\u{1F1FA}\u{1F1F8}\u{1F1E6}", Jenc.string x.the19)
        , ("1;DROP TABLE users", Jenc.string x.the1DROPTABLEUsers)
        , ("-1E02", Jenc.string x.the1E02)
        , ("1E2", Jenc.string x.the1E2)
        , ("1#QNAN", Jenc.string x.the1Qnan)
        , ("1#SNAN", Jenc.string x.the1Snan)
        , ("¸˛Ç◊ı˜Â¯˘¿", Jenc.string x.the2)
        , ("\u{1F1FA}\u{1F1F8}\u{1F1F7}\u{1F1FA}\u{1F1F8}\u{1F1E6}\u{1F1EB}\u{1F1E6}\u{1F1F2}", Jenc.string x.the20)
        , ("\u{1F469}\u{1F3FD}", Jenc.string x.the21)
        , ("\u{1F6BE} \u{1F192} \u{1F193} \u{1F195} \u{1F196} \u{1F197} \u{1F199} \u{1F3E7}", Jenc.string x.the22)
        , ("﷽", Jenc.string x.the23)
        , ("\u{FEFF}", Jenc.string x.the24)
        , ("ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ", Jenc.string x.the26)
        , ("\u{FFFE}", Jenc.string x.the27)
        , ("Œ„´‰ˇÁ¨ˆØ∏”’", Jenc.string x.the3)
        , ("œ∑´®†¥¨ˆøπ“‘", Jenc.string x.the4)
        , ("Ⱥ", Jenc.string x.the5)
        , ("Ⱦ", Jenc.string x.the6)
        , ("999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999", Jenc.string x.the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)
        , ("# The next two lines may appear to be blank or mojibake in some viewers.", Jenc.string x.theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers)
        , ("The quic\u{0008}\u{0008}\u{0008}\u{0008}\u{0008}\u{0008}k brown fo\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}x... [Beeeep]", Jenc.string x.theQuicKBrownFoXBeeeep)
        , ("パーティーへ行かないか", Jenc.string x.the_12)
        , ("和製漢語", Jenc.string x.the_13)
        , ("田中さんにあげて下さい", Jenc.string x.the_14)
        , ("｀ｨ(´∀｀∩", Jenc.string x.the_25)
        , ("ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو.", Jenc.string x.the_7)
        , ("٠١٢٣٤٥٦٧٨٩", Jenc.string x.the_8)
        , ("ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็", Jenc.string x.the_9)
        , ("TRUE", Jenc.string x.true)
        , ("#\tTwo-Byte Characters", Jenc.string x.twoByteCharacters)
        , ("# U+0000, U+000A, or U+000D (NUL, LF, CR).", Jenc.string x.u0000U000AOrU000DNULLFCR)
        , ("<u oncopy=alert()> Copy me</u>", Jenc.string x.uOncopyAlertCopyMeU)
        , ("undef", Jenc.string x.undef)
        , ("#\tUnicode font", Jenc.string x.unicodeFont)
        , ("#\tUnicode Numbers", Jenc.string x.unicodeNumbers)
        , ("#\tUnwanted Interpolation", Jenc.string x.unwantedInterpolation)
        , ("%x('ls -al /')", Jenc.string x.xLsAl)
        , ("Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮", Jenc.string x.zGO)
        ]

b : Jdec.Decoder B
b =
    Jdec.succeed B
        |> Jpipe.required "<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">" Jdec.string
        |> Jpipe.required "<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ" Jdec.string
        |> Jpipe.required "# appear in input." Jdec.string
        |> Jpipe.required "+++ATH0" Jdec.string
        |> Jpipe.required "' autofocus onkeyup='javascript:alert(123)" Jdec.string
        |> Jpipe.required "\t\u{000B}\u{000C} \u{0085}             \u{200B}\u{2028}\u{2029}  　" Jdec.string
        |> Jpipe.required "1'000.00" Jdec.string
        |> Jpipe.required "<IMG SRC=# onmouseover=\"alert('xxs')\">" Jdec.string
        |> Jpipe.required "--><script>alert(123)</script>" Jdec.string
        |> Jpipe.required "`touch /tmp/blns.fail`" Jdec.string
        |> Jpipe.required "basement" Jdec.string
        |> Jpipe.required "\u{1D54B}\u{1D559}\u{1D556} \u{1D562}\u{1D566}\u{1D55A}\u{1D554}\u{1D55C} \u{1D553}\u{1D563}\u{1D560}\u{1D568}\u{1D55F} \u{1D557}\u{1D560}\u{1D569} \u{1D55B}\u{1D566}\u{1D55E}\u{1D561}\u{1D564} \u{1D560}\u{1D567}\u{1D556}\u{1D563} \u{1D565}\u{1D559}\u{1D556} \u{1D55D}\u{1D552}\u{1D56B}\u{1D56A} \u{1D555}\u{1D560}\u{1D558}" Jdec.string
        |> Jpipe.required "But now...\u{001B}[20Cfor my greatest trick...\u{001B}[8m" Jdec.string
        |> Jpipe.required "# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line." Jdec.string
        |> Jpipe.required "COM1" Jdec.string
        |> Jpipe.required "COM3" Jdec.string
        |> Jpipe.required "# Commonly misinterpreted as additional graphic characters." Jdec.string
        |> Jpipe.required "CON" Jdec.string
        |> Jpipe.required "# contexts.  Divided into three groups based on (US-layout) keyboard position." Jdec.string
        |> Jpipe.required "#\tCredit: https://twitter.com/jifa/status/625776454479970304" Jdec.string
        |> Jpipe.required "社會科學院語學研究所" Jdec.string
        |> Jpipe.required "/dev/null; touch /tmp/blns.fail ; echo" Jdec.string
        |> Jpipe.required "dontMakeAMap" Jdec.bool
        |> Jpipe.required "\u{0001}\u{0002}\u{0003}\u{0004}\u{0005}\u{0006}\u{0007}\u{0008}\u{000E}\u{000F}\u{0010}\u{0011}\u{0012}\u{0013}\u{0014}\u{0015}\u{0016}\u{0017}\u{0018}\u{0019}\u{001A}\u{001B}\u{001C}\u{001D}\u{001E}\u{001F}\u{007F}" Jdec.string
        |> Jpipe.required "eval(\"puts 'hello world'\")" Jdec.string
        |> Jpipe.required "expression" Jdec.string
        |> Jpipe.required "FALSE" Jdec.string
        |> Jpipe.required "File:///" Jdec.string
        |> Jpipe.required "#\tFile Inclusion" Jdec.string
        |> Jpipe.required "#" Jdec.string
        |> Jpipe.required "<foo val=”bar“ />" Jdec.string
        |> Jpipe.required "사회과학원 어학연구소" Jdec.string
        |> Jpipe.required "# general category Cf (in Unicode 8.0.0)." Jdec.string
        |> Jpipe.required "̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕" Jdec.string
        |> Jpipe.required "--help" Jdec.string
        |> Jpipe.required "❤️ \u{1F494} \u{1F48C} \u{1F495} \u{1F49E} \u{1F493} \u{1F497} \u{1F496} \u{1F498} \u{1F49D} \u{1F49F} \u{1F49C} \u{1F49B} \u{1F49A} \u{1F499}" Jdec.string
        |> Jpipe.required "http://a/%%30%30" Jdec.string
        |> Jpipe.required "#\tiOS Vulnerabilities" Jdec.string
        |> Jpipe.required "If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you." Jdec.string
        |> Jpipe.required "<iframe src=http://ha.ckers.org/scriptlet.html <" Jdec.string
        |> Jpipe.required "<IMG SRC=\" &#14;  javascript:alert('XSS');\">" Jdec.string
        |> Jpipe.required "<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">" Jdec.string
        |> Jpipe.required "<IMG SRC= onmouseover=\"alert('xxs')\">" Jdec.string
        |> Jpipe.required "<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>" Jdec.string
        |> Jpipe.required "<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>" Jdec.string
        |> Jpipe.required "<img src\\x00=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src=x onerror=\\x11\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src=x onerror=\\x12\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>" Jdec.string
        |> Jpipe.required "`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>" Jdec.string
        |> Jpipe.required "`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>" Jdec.string
        |> Jpipe.required "<img \\x00src=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img \\x11src=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img \\x12src=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img \\x47src=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "⁰⁴⁵₀₁₂" Jdec.string
        |> Jpipe.required "Ω≈ç√∫˜µ≤≥÷" Jdec.string
        |> Jpipe.required "#   IRC specific strings" Jdec.string
        |> Jpipe.required "#\tJapanese Emoticons" Jdec.string
        |> Jpipe.required "Kernel.exec(\"ls -al /\")" Jdec.string
        |> Jpipe.required "Linda Callahan" Jdec.string
        |> Jpipe.required "部落格" Jdec.string
        |> Jpipe.required "찦차를 타고 온 펲시맨과 쑛다리 똠방각하" Jdec.string
        |> Jpipe.required "˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥" Jdec.string
        |> Jpipe.required "NIL" Jdec.string
        |> Jpipe.required "NUL" Jdec.string
        |> Jpipe.required "null" Jdec.string
        |> Jpipe.required "#\tNumeric Strings" Jdec.string
        |> Jpipe.required "Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣" Jdec.string
        |> Jpipe.required "# Often forbidden to appear in various text-based file formats (e.g. XML)," Jdec.string
        |> Jpipe.required "\" onfocus=JaVaSCript:alert(123) autofocus" Jdec.string
        |> Jpipe.required "' OR 1=1 -- 1" Jdec.string
        |> Jpipe.required "\"" Jdec.string
        |> Jpipe.required "<script>alert(123)</script>" Jdec.string
        |> Jpipe.required "#\tQuotation Marks" Jdec.string
        |> Jpipe.required "#       Regional Indicator Symbols" Jdec.string
        |> Jpipe.required "#       Regional Indicator Symbols can be displayed differently across" Jdec.string
        |> Jpipe.required "#\tReserved Strings" Jdec.string
        |> Jpipe.required "\"><script>alert(123)</script>" Jdec.string
        |> Jpipe.required "><script>alert(123);</script x=" Jdec.string
        |> Jpipe.required "<<SCRIPT>alert(\"XSS\");//<</SCRIPT>" Jdec.string
        |> Jpipe.required "<SCRIPT SRC=//ha.ckers.org/.j>" Jdec.string
        |> Jpipe.required "<script src=\"\\\\%(jscript)s\"></script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\x09javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>" Jdec.string
        |> Jpipe.required "<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\x21javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\x3Bjavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "#\tScunthorpe Problem" Jdec.string
        |> Jpipe.required "åß∂ƒ©˙∆˚¬…æ" Jdec.string
        |> Jpipe.required "#   Strings that may occur on IRC clients that make security products freak out" Jdec.string
        |> Jpipe.required "#\tStrings which are reserved characters in MSDOS/Windows" Jdec.string
        |> Jpipe.required "#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS" Jdec.string
        |> Jpipe.required "#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)" Jdec.string
        |> Jpipe.required "#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues" Jdec.string
        |> Jpipe.required "#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric" Jdec.string
        |> Jpipe.required "#\tStrings which may be used elsewhere in code" Jdec.string
        |> Jpipe.required "(｡◕ ∀ ◕｡)" Jdec.string
        |> Jpipe.required "#\tTerminal escape codes" Jdec.string
        |> Jpipe.required "0.00" Jdec.string
        |> Jpipe.required "01000" Jdec.string
        |> Jpipe.required "08" Jdec.string
        |> Jpipe.required "09" Jdec.string
        |> Jpipe.required "0xffffffffffffffff" Jdec.string
        |> Jpipe.required "\u{1F60D}" Jdec.string
        |> Jpipe.required "$1.00" Jdec.string
        |> Jpipe.required "1,0/0,0" Jdec.string
        |> Jpipe.required "1 000.00" Jdec.string
        |> Jpipe.required "1 000 000,00" Jdec.string
        |> Jpipe.required "1'; DROP TABLE users-- 1" Jdec.string
        |> Jpipe.required "1#IND" Jdec.string
        |> Jpipe.required "1#INF" Jdec.string
        |> Jpipe.required "-2147483648/-1" Jdec.string
        |> Jpipe.required "2.2250738585072011e-308" Jdec.string
        |> Jpipe.required "# The next line may appear to be blank, mojibake, or dingbats in some viewers." Jdec.string
        |> Jpipe.required "# The next line may appear to be blank or mojibake in some viewers." Jdec.string
        |> Jpipe.required "# The next line may be flagged for \"trailing whitespace\" in some viewers." Jdec.string
        |> Jpipe.required "__ﾛ(,_,*)" Jdec.string
        |> Jpipe.required "ﷺ" Jdec.string
        |> Jpipe.required "１２３" Jdec.string
        |> Jpipe.required "# This file unfortunately cannot express strings containing" Jdec.string
        |> Jpipe.required "$(touch /tmp/blns.fail)" Jdec.string
        |> Jpipe.required "() { _; } >_[$($())] { touch /tmp/blns.shellshock2.fail; }" Jdec.string
        |> Jpipe.required "Tyson Gay" Jdec.string
        |> Jpipe.required "#\tUnicode Symbols" Jdec.string
        |> Jpipe.required "'`\"><\\x00script>javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "'`\"><\\x3Cscript>javascript:alert(1)</script>" Jdec.string

encodeB : B -> Jenc.Value
encodeB x =
    Jenc.object
        [ ("<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">", Jenc.string x.aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A)
        , ("<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXExpressionX5CJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXX0AexpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXX0DexpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEF)
        , ("ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ", Jenc.string x.ambitious)
        , ("# appear in input.", Jenc.string x.appearInInput)
        , ("+++ATH0", Jenc.string x.ath0)
        , ("' autofocus onkeyup='javascript:alert(123)", Jenc.string x.autofocusOnkeyupJavascriptAlert123)
        , ("\t\u{000B}\u{000C} \u{0085}             \u{200B}\u{2028}\u{2029}  　", Jenc.string x.b)
        , ("1'000.00", Jenc.string x.b100000)
        , ("<IMG SRC=# onmouseover=\"alert('xxs')\">", Jenc.string x.bIMGSRCOnmouseoverAlertXxs)
        , ("--><script>alert(123)</script>", Jenc.string x.bScriptAlert123Script)
        , ("`touch /tmp/blns.fail`", Jenc.string x.bTouchTmpBlnsFail)
        , ("basement", Jenc.string x.basement)
        , ("\u{1D54B}\u{1D559}\u{1D556} \u{1D562}\u{1D566}\u{1D55A}\u{1D554}\u{1D55C} \u{1D553}\u{1D563}\u{1D560}\u{1D568}\u{1D55F} \u{1D557}\u{1D560}\u{1D569} \u{1D55B}\u{1D566}\u{1D55E}\u{1D561}\u{1D564} \u{1D560}\u{1D567}\u{1D556}\u{1D563} \u{1D565}\u{1D559}\u{1D556} \u{1D55D}\u{1D552}\u{1D56B}\u{1D56A} \u{1D555}\u{1D560}\u{1D558}", Jenc.string x.braggadocious)
        , ("But now...\u{001B}[20Cfor my greatest trick...\u{001B}[8m", Jenc.string x.butNow20CforMyGreatestTrick8M)
        , ("# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line.", Jenc.string x.byteOrderMarksUFEFFAndUFFFEEachOnItsOwnLine)
        , ("COM1", Jenc.string x.com1)
        , ("COM3", Jenc.string x.com3)
        , ("# Commonly misinterpreted as additional graphic characters.", Jenc.string x.commonlyMisinterpretedAsAdditionalGraphicCharacters)
        , ("CON", Jenc.string x.con)
        , ("# contexts.  Divided into three groups based on (US-layout) keyboard position.", Jenc.string x.contextsDividedIntoThreeGroupsBasedOnUSLayoutKeyboardPosition)
        , ("#\tCredit: https://twitter.com/jifa/status/625776454479970304", Jenc.string x.creditHTTPSTwitterCOMJifaStatus625776454479970304)
        , ("社會科學院語學研究所", Jenc.string x.cunning)
        , ("/dev/null; touch /tmp/blns.fail ; echo", Jenc.string x.devNullTouchTmpBlnsFailEcho)
        , ("dontMakeAMap", Jenc.bool x.dontMakeAMap)
        , ("\u{0001}\u{0002}\u{0003}\u{0004}\u{0005}\u{0006}\u{0007}\u{0008}\u{000E}\u{000F}\u{0010}\u{0011}\u{0012}\u{0013}\u{0014}\u{0015}\u{0016}\u{0017}\u{0018}\u{0019}\u{001A}\u{001B}\u{001C}\u{001D}\u{001E}\u{001F}\u{007F}", Jenc.string x.empty)
        , ("eval(\"puts 'hello world'\")", Jenc.string x.evalPutsHelloWorld)
        , ("expression", Jenc.string x.expression)
        , ("FALSE", Jenc.string x.false)
        , ("File:///", Jenc.string x.file)
        , ("#\tFile Inclusion", Jenc.string x.fileInclusion)
        , ("#", Jenc.string x.fluffy)
        , ("<foo val=”bar“ />", Jenc.string x.fooValBar)
        , ("사회과학원 어학연구소", Jenc.string x.frisky)
        , ("# general category Cf (in Unicode 8.0.0).", Jenc.string x.generalCategoryCFInUnicode800)
        , ("̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕", Jenc.string x.hEWHOWATSBEHINDTHEWAL)
        , ("--help", Jenc.string x.help)
        , ("❤️ \u{1F494} \u{1F48C} \u{1F495} \u{1F49E} \u{1F493} \u{1F497} \u{1F496} \u{1F498} \u{1F49D} \u{1F49F} \u{1F49C} \u{1F49B} \u{1F49A} \u{1F499}", Jenc.string x.hilarious)
        , ("http://a/%%30%30", Jenc.string x.httpA3030)
        , ("#\tiOS Vulnerabilities", Jenc.string x.iOSVulnerabilities)
        , ("If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you.", Jenc.string x.ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou)
        , ("<iframe src=http://ha.ckers.org/scriptlet.html <", Jenc.string x.iframeSrcHTTPHaCkersOrgScriptletHTML)
        , ("<IMG SRC=\" &#14;  javascript:alert('XSS');\">", Jenc.string x.imgSRC14JavascriptAlertXSS)
        , ("<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">", Jenc.string x.imgSRCJavX09AscriptAlertXSS)
        , ("<IMG SRC= onmouseover=\"alert('xxs')\">", Jenc.string x.imgSRCOnmouseoverAlertXxs)
        , ("<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>", Jenc.string x.imgSRCX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29)
        , ("<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>", Jenc.string x.imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041)
        , ("<img src\\x00=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgSrcX00XOnerrorJavascriptAlert1)
        , ("<img src=x onerror=\\x11\"javascript:alert(1)\">", Jenc.string x.imgSrcXOnerrorX11JavascriptAlert1)
        , ("<img src=x onerror=\\x12\"javascript:alert(1)\">", Jenc.string x.imgSrcXOnerrorX12JavascriptAlert1)
        , ("`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>", Jenc.string x.imgSrcXxxXX0AonerrorJavascriptAlert1)
        , ("`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>", Jenc.string x.imgSrcXxxXX0ConerrorJavascriptAlert1)
        , ("`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>", Jenc.string x.imgSrcXxxXX0DonerrorJavascriptAlert1)
        , ("<img \\x00src=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgX00SrcXOnerrorJavascriptAlert1)
        , ("<img \\x11src=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgX11SrcXOnerrorJavascriptAlert1)
        , ("<img \\x12src=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgX12SrcXOnerrorJavascriptAlert1)
        , ("<img \\x47src=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgX47SrcXOnerrorJavascriptAlert1)
        , ("⁰⁴⁵₀₁₂", Jenc.string x.indecent)
        , ("Ω≈ç√∫˜µ≤≥÷", Jenc.string x.indigo)
        , ("#   IRC specific strings", Jenc.string x.ircSpecificStrings)
        , ("#\tJapanese Emoticons", Jenc.string x.japaneseEmoticons)
        , ("Kernel.exec(\"ls -al /\")", Jenc.string x.kernelExecLsAl)
        , ("Linda Callahan", Jenc.string x.lindaCallahan)
        , ("部落格", Jenc.string x.magenta)
        , ("찦차를 타고 온 펲시맨과 쑛다리 똠방각하", Jenc.string x.mischievous)
        , ("˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥", Jenc.string x.nblUOlopOqlNUnppuOdPosnOpPsLUsdpNsuoSOlopNsdO)
        , ("NIL", Jenc.string x.nil)
        , ("NUL", Jenc.string x.nul)
        , ("null", Jenc.string x.null)
        , ("#\tNumeric Strings", Jenc.string x.numericStrings)
        , ("Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣", Jenc.string x.oINVOKTHEHIVEMINDREPRESETINGCHAOS)
        , ("# Often forbidden to appear in various text-based file formats (e.g. XML),", Jenc.string x.oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXML)
        , ("\" onfocus=JaVaSCript:alert(123) autofocus", Jenc.string x.onfocusJaVaSCriptAlert123Autofocus)
        , ("' OR 1=1 -- 1", Jenc.string x.or111)
        , ("\"", Jenc.string x.purple)
        , ("<script>alert(123)</script>", Jenc.string x.purpleScriptAlert123Script)
        , ("#\tQuotation Marks", Jenc.string x.quotationMarks)
        , ("#       Regional Indicator Symbols", Jenc.string x.regionalIndicatorSymbols)
        , ("#       Regional Indicator Symbols can be displayed differently across", Jenc.string x.regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross)
        , ("#\tReserved Strings", Jenc.string x.reservedStrings)
        , ("\"><script>alert(123)</script>", Jenc.string x.scriptAlert123Script)
        , ("><script>alert(123);</script x=", Jenc.string x.scriptAlert123ScriptX)
        , ("<<SCRIPT>alert(\"XSS\");//<</SCRIPT>", Jenc.string x.scriptAlertXSSSCRIPT)
        , ("<SCRIPT SRC=//ha.ckers.org/.j>", Jenc.string x.scriptSRCHaCkersOrgJ)
        , ("<script src=\"\\\\%(jscript)s\"></script>", Jenc.string x.scriptSrcJscriptSScript)
        , ("\"`'><script>\\x09javascript:alert(1)</script>", Jenc.string x.scriptX09JavascriptAlert1Script)
        , ("<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>", Jenc.string x.scriptX0AtypeTextJavascriptJavascriptAlert1Script)
        , ("<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>", Jenc.string x.scriptX0DtypeTextJavascriptJavascriptAlert1Script)
        , ("\"`'><script>\\x21javascript:alert(1)</script>", Jenc.string x.scriptX21JavascriptAlert1Script)
        , ("\"`'><script>\\x3Bjavascript:alert(1)</script>", Jenc.string x.scriptX3BjavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>", Jenc.string x.scriptXE2X80X85JavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>", Jenc.string x.scriptXE2X80X87JavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>", Jenc.string x.scriptXE2X80X8AjavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>", Jenc.string x.scriptXE2X80XA8JavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>", Jenc.string x.scriptXE2X80XA9JavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>", Jenc.string x.scriptXE2X80XAFjavascriptAlert1Script)
        , ("\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>", Jenc.string x.scriptXE3X80X80JavascriptAlert1Script)
        , ("#\tScunthorpe Problem", Jenc.string x.scunthorpeProblem)
        , ("åß∂ƒ©˙∆˚¬…æ", Jenc.string x.sticky)
        , ("#   Strings that may occur on IRC clients that make security products freak out", Jenc.string x.stringsThatMayOccurOnIRCClientsThatMakeSecurityProductsFreakOut)
        , ("#\tStrings which are reserved characters in MSDOS/Windows", Jenc.string x.stringsWhichAreReservedCharactersInMSDOSWindows)
        , ("#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS", Jenc.string x.stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSS)
        , ("#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)", Jenc.string x.stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrew)
        , ("#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues", Jenc.string x.stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues)
        , ("#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric", Jenc.string x.stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric)
        , ("#\tStrings which may be used elsewhere in code", Jenc.string x.stringsWhichMayBeUsedElsewhereInCode)
        , ("(｡◕ ∀ ◕｡)", Jenc.string x.tentacled)
        , ("#\tTerminal escape codes", Jenc.string x.terminalEscapeCodes)
        , ("0.00", Jenc.string x.the000)
        , ("01000", Jenc.string x.the01000)
        , ("08", Jenc.string x.the08)
        , ("09", Jenc.string x.the09)
        , ("0xffffffffffffffff", Jenc.string x.the0Xffffffffffffffff)
        , ("\u{1F60D}", Jenc.string x.the1)
        , ("$1.00", Jenc.string x.the100)
        , ("1,0/0,0", Jenc.string x.the1000)
        , ("1 000.00", Jenc.string x.the100000)
        , ("1 000 000,00", Jenc.string x.the100000000)
        , ("1'; DROP TABLE users-- 1", Jenc.string x.the1DROPTABLEUsers1)
        , ("1#IND", Jenc.string x.the1Ind)
        , ("1#INF", Jenc.string x.the1Inf)
        , ("-2147483648/-1", Jenc.string x.the21474836481)
        , ("2.2250738585072011e-308", Jenc.string x.the22250738585072011E308)
        , ("# The next line may appear to be blank, mojibake, or dingbats in some viewers.", Jenc.string x.theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers)
        , ("# The next line may appear to be blank or mojibake in some viewers.", Jenc.string x.theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers)
        , ("# The next line may be flagged for \"trailing whitespace\" in some viewers.", Jenc.string x.theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers)
        , ("__ﾛ(,_,*)", Jenc.string x.the_)
        , ("ﷺ", Jenc.string x.the_2)
        , ("１２３", Jenc.string x.the_3)
        , ("# This file unfortunately cannot express strings containing", Jenc.string x.thisFileUnfortunatelyCannotExpressStringsContaining)
        , ("$(touch /tmp/blns.fail)", Jenc.string x.touchTmpBlnsFail)
        , ("() { _; } >_[$($())] { touch /tmp/blns.shellshock2.fail; }", Jenc.string x.touchTmpBlnsShellshock2Fail)
        , ("Tyson Gay", Jenc.string x.tysonGay)
        , ("#\tUnicode Symbols", Jenc.string x.unicodeSymbols)
        , ("'`\"><\\x00script>javascript:alert(1)</script>", Jenc.string x.x00ScriptJavascriptAlert1Script)
        , ("'`\"><\\x3Cscript>javascript:alert(1)</script>", Jenc.string x.x3CscriptJavascriptAlert1Script)
        ]

c : Jdec.Decoder C
c =
    Jdec.succeed C
        |> Jpipe.required "A:" Jdec.string
        |> Jpipe.required "<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF" Jdec.string
        |> Jpipe.required "." Jdec.string
        |> Jpipe.required "# and U+007F (DEL)" Jdec.string
        |> Jpipe.required "# ASCII punctuation.  All of these characters may need to be escaped in some" Jdec.string
        |> Jpipe.required "<BODY onload!#$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>" Jdec.string
        |> Jpipe.required "בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ" Jdec.string
        |> Jpipe.required "\"'\"'\"''''\"" Jdec.string
        |> Jpipe.required "-0.0" Jdec.string
        |> Jpipe.required "0.0/0" Jdec.string
        |> Jpipe.required "-1.00" Jdec.string
        |> Jpipe.required "1,000.00" Jdec.string
        |> Jpipe.required "1,000,000.00" Jdec.string
        |> Jpipe.required "1E+02" Jdec.string
        |> Jpipe.required "><script>alert(123)</script>" Jdec.string
        |> Jpipe.required "CLOCK$" Jdec.string
        |> Jpipe.required "COM2" Jdec.string
        |> Jpipe.required "COM4" Jdec.string
        |> Jpipe.required "Craig Cockburn, Software Specialist" Jdec.string
        |> Jpipe.required "\\\\" Jdec.string
        |> Jpipe.required "DCC SEND STARTKEYLOGGER 0 0 0" Jdec.string
        |> Jpipe.required "dontMakeAMap" Jdec.bool
        |> Jpipe.required "#\tEmoji" Jdec.string
        |> Jpipe.required "\"\"" Jdec.string
        |> Jpipe.required "evaluate" Jdec.string
        |> Jpipe.required "%" Jdec.string
        |> Jpipe.required "0/0" Jdec.string
        |> Jpipe.required "<foo val=“bar” />" Jdec.string
        |> Jpipe.required "ÅÍÎÏ˝ÓÔ\u{F8FF}ÒÚÆ☃" Jdec.string
        |> Jpipe.required "̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟" Jdec.string
        |> Jpipe.required "hasOwnProperty" Jdec.string
        |> Jpipe.required "--" Jdec.string
        |> Jpipe.required "Horniman Museum" Jdec.string
        |> Jpipe.required "http://www.cum.qc.ca/" Jdec.string
        |> Jpipe.required "<i onwheel=alert(1)> Scroll over me </i>" Jdec.string
        |> Jpipe.required "<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">" Jdec.string
        |> Jpipe.required "<IMG onmouseover=\"alert('xxs')\">" Jdec.string
        |> Jpipe.required "<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">" Jdec.string
        |> Jpipe.required "<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>" Jdec.string
        |> Jpipe.required "<IMG SRC=\"javascript:alert('XSS')\"" Jdec.string
        |> Jpipe.required "<img src onerror /\" '\"= alt=javascript:alert(1)//\">" Jdec.string
        |> Jpipe.required "<img src\\x10=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src\\x12=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src\\x13=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src\\x32=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src\\x47=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src=x onerror=alert(123) />" Jdec.string
        |> Jpipe.required "<img src=x onerror=\\x10\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src=x onerror=\\x32\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img src=\"x` `<script>javascript:alert(1)</script>\"` `>" Jdec.string
        |> Jpipe.required "`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>" Jdec.string
        |> Jpipe.required "`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>" Jdec.string
        |> Jpipe.required "`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>" Jdec.string
        |> Jpipe.required "`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>" Jdec.string
        |> Jpipe.required "<img\\x11src=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img \\x34src=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "<img\\x47src=x onerror=\"javascript:alert(1)\">" Jdec.string
        |> Jpipe.required "-" Jdec.string
        |> Jpipe.required ",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’" Jdec.string
        |> Jpipe.required "Infinity" Jdec.string
        |> Jpipe.required "JavaSCript:alert(123)" Jdec.string
        |> Jpipe.required "LPT1" Jdec.string
        |> Jpipe.required "&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;" Jdec.string
        |> Jpipe.required "_" Jdec.string
        |> Jpipe.required "magna cum laude" Jdec.string
        |> Jpipe.required "medieval erection of parapets" Jdec.string
        |> Jpipe.required "ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя" Jdec.string
        |> Jpipe.required "mocha" Jdec.string
        |> Jpipe.required "NaN" Jdec.string
        |> Jpipe.required "# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F," Jdec.string
        |> Jpipe.required "NULL" Jdec.string
        |> Jpipe.required "' onfocus=JaVaSCript:alert(123) autofocus" Jdec.string
        |> Jpipe.required "# or reused for internal delimiters on the theory that they should never" Jdec.string
        |> Jpipe.required "<plaintext>" Jdec.string
        |> Jpipe.required "Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗" Jdec.string
        |> Jpipe.required "\"''''\"'\"" Jdec.string
        |> Jpipe.required "0,,0" Jdec.string
        |> Jpipe.required "1.000,00" Jdec.string
        |> Jpipe.required "1.000.000,00" Jdec.string
        |> Jpipe.required "＜script＞alert(123)＜/script＞" Jdec.string
        |> Jpipe.required "#\tRight-To-Left Strings" Jdec.string
        |> Jpipe.required "Roses are \u{001B}[0;31mred\u{001B}[0m, violets are \u{001B}[0;34mblue. Hope you enjoy terminal hue" Jdec.string
        |> Jpipe.required "%*.*s" Jdec.string
        |> Jpipe.required "'><script>alert(123)</script>" Jdec.string
        |> Jpipe.required "'><script>alert(123);</script x='" Jdec.string
        |> Jpipe.required "\"`'><script>-javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "< / script >< script >alert(123)< / script >" Jdec.string
        |> Jpipe.required "<script src=\"/\\%(jscript)s\"></script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\x0Ajavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\x0Bjavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\x20javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\x2Bjavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\x7Ejavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>" Jdec.string
        |> Jpipe.required "Scunthorpe General Hospital" Jdec.string
        |> Jpipe.required "#\tServer Code Injection" Jdec.string
        |> Jpipe.required "shitake mushrooms" Jdec.string
        |> Jpipe.required "#\tSpecial Characters" Jdec.string
        |> Jpipe.required "src=JaVaSCript:prompt(132)" Jdec.string
        |> Jpipe.required "(ﾉಥ益ಥ）ﾉ\u{FEFF} ┻━┻" Jdec.string
        |> Jpipe.required "#\tStrings which can be interpreted as numeric" Jdec.string
        |> Jpipe.required "#\tStrings which can cause a SQL injection if inputs are not sanitized" Jdec.string
        |> Jpipe.required "#\tStrings which can cause user to pull in files that should not be a part of a web server" Jdec.string
        |> Jpipe.required "#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)" Jdec.string
        |> Jpipe.required "#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)" Jdec.string
        |> Jpipe.required "#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)" Jdec.string
        |> Jpipe.required "#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)" Jdec.string
        |> Jpipe.required "#\tStrings which punish the fools who use cat/type on this file" Jdec.string
        |> Jpipe.required "<svg><script>123<1>alert(123)</script>" Jdec.string
        |> Jpipe.required "System(\"ls -al /\")" Jdec.string
        |> Jpipe.required "@{[system \"touch /tmp/blns.fail\"]}" Jdec.string
        |> Jpipe.required "''" Jdec.string
        |> Jpipe.required "\u{2029}test\u{2029}" Jdec.string
        |> Jpipe.required "test\u{2060}test\u{202B}" Jdec.string
        |> Jpipe.required "\u{1F3F3}0\u{1F308}️" Jdec.string
        |> Jpipe.required "+0.0" Jdec.string
        |> Jpipe.required "0.0.0" Jdec.string
        |> Jpipe.required "0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \u{1F51F}" Jdec.string
        |> Jpipe.required "() { 0; }; touch /tmp/blns.shellshock1.fail;" Jdec.string
        |> Jpipe.required "0xabad1dea" Jdec.string
        |> Jpipe.required "0xffffffff" Jdec.string
        |> Jpipe.required "--1" Jdec.string
        |> Jpipe.required "\u{1F435} \u{1F648} \u{1F649} \u{1F64A}" Jdec.string
        |> Jpipe.required "-$1.00" Jdec.string
        |> Jpipe.required "1 000,00" Jdec.string
        |> Jpipe.required "1'000'000,00" Jdec.string
        |> Jpipe.required "\u{1F47E} \u{1F647} \u{1F481} \u{1F645} \u{1F646} \u{1F64B} \u{1F64E} \u{1F64D}" Jdec.string
        |> Jpipe.required "-1/2" Jdec.string
        |> Jpipe.required "Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ" Jdec.string
        |> Jpipe.required "-1E+02" Jdec.string
        |> Jpipe.required "-1E2" Jdec.string
        |> Jpipe.required "-1#IND" Jdec.string
        |> Jpipe.required "⁰⁴⁵" Jdec.string
        |> Jpipe.required "⅛⅜⅝⅞" Jdec.string
        |> Jpipe.required "✋\u{1F3FF} \u{1F4AA}\u{1F3FF} \u{1F450}\u{1F3FF} \u{1F64C}\u{1F3FF} \u{1F44F}\u{1F3FF} \u{1F64F}\u{1F3FF}" Jdec.string
        |> Jpipe.required "・(￣∀￣)・:*:" Jdec.string
        |> Jpipe.required "\u{1D413}\u{1D421}\u{1D41E} \u{1D42A}\u{1D42E}\u{1D422}\u{1D41C}\u{1D424} \u{1D41B}\u{1D42B}\u{1D428}\u{1D430}\u{1D427} \u{1D41F}\u{1D428}\u{1D431} \u{1D423}\u{1D42E}\u{1D426}\u{1D429}\u{1D42C} \u{1D428}\u{1D42F}\u{1D41E}\u{1D42B} \u{1D42D}\u{1D421}\u{1D41E} \u{1D425}\u{1D41A}\u{1D433}\u{1D432} \u{1D41D}\u{1D428}\u{1D420}" Jdec.string
        |> Jpipe.required "\u{1D683}\u{1D691}\u{1D68E} \u{1D69A}\u{1D69E}\u{1D692}\u{1D68C}\u{1D694} \u{1D68B}\u{1D69B}\u{1D698}\u{1D6A0}\u{1D697} \u{1D68F}\u{1D698}\u{1D6A1} \u{1D693}\u{1D69E}\u{1D696}\u{1D699}\u{1D69C} \u{1D698}\u{1D69F}\u{1D68E}\u{1D69B} \u{1D69D}\u{1D691}\u{1D68E} \u{1D695}\u{1D68A}\u{1D6A3}\u{1D6A2} \u{1D68D}\u{1D698}\u{1D690}" Jdec.string
        |> Jpipe.required "-9223372036854775808/-1" Jdec.string
        |> Jpipe.required "┬─┬ノ( º _ ºノ)" Jdec.string
        |> Jpipe.required "مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، " Jdec.string
        |> Jpipe.required "\u{2070E}\u{20731}\u{20779}\u{20C53}\u{20C78}\u{20C96}\u{20CCF}" Jdec.string
        |> Jpipe.required "١٢٣" Jdec.string
        |> Jpipe.required "울란바토르" Jdec.string
        |> Jpipe.required "<title onpropertychange=javascript:alert(1)></title><title title=>" Jdec.string
        |> Jpipe.required "# treated as whitespace in some contexts." Jdec.string
        |> Jpipe.required "#\tTrick Unicode" Jdec.string
        |> Jpipe.required "true" Jdec.string
        |> Jpipe.required "undefined" Jdec.string
        |> Jpipe.required "# Unicode additional control characters: all of the characters with" Jdec.string
        |> Jpipe.required "#\tUnicode Subscript/Superscript/Accents" Jdec.string
        |> Jpipe.required "#\tUnicode Upsidedown" Jdec.string
        |> Jpipe.required "$USER" Jdec.string
        |> Jpipe.required "--version" Jdec.string
        |> Jpipe.required "# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL)," Jdec.string
        |> Jpipe.required "# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode" Jdec.string
        |> Jpipe.required "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>" Jdec.string
        |> Jpipe.required "#      XXE Injection (XML)" Jdec.string
        |> Jpipe.required "#\tZalgo Text" Jdec.string
        |> Jpipe.required "ZZ:" Jdec.string

encodeC : C -> Jenc.Value
encodeC x =
    Jenc.object
        [ ("A:", Jenc.string x.a)
        , ("<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", Jenc.string x.aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA)
        , ("ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXExpressionX00JavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXX00ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXX0CexpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEF)
        , ("ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF", Jenc.string x.abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEF)
        , (".", Jenc.string x.ambitious)
        , ("# and U+007F (DEL)", Jenc.string x.andU007FDEL)
        , ("# ASCII punctuation.  All of these characters may need to be escaped in some", Jenc.string x.asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome)
        , ("<BODY onload!#$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>", Jenc.string x.bodyOnloadAlertXSS)
        , ("בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ", Jenc.string x.braggadocious)
        , ("\"'\"'\"''''\"", Jenc.string x.c)
        , ("-0.0", Jenc.string x.c00)
        , ("0.0/0", Jenc.string x.c000)
        , ("-1.00", Jenc.string x.c100)
        , ("1,000.00", Jenc.string x.c100000)
        , ("1,000,000.00", Jenc.string x.c100000000)
        , ("1E+02", Jenc.string x.c1E02)
        , ("><script>alert(123)</script>", Jenc.string x.cScriptAlert123Script)
        , ("CLOCK$", Jenc.string x.clock)
        , ("COM2", Jenc.string x.com2)
        , ("COM4", Jenc.string x.com4)
        , ("Craig Cockburn, Software Specialist", Jenc.string x.craigCockburnSoftwareSpecialist)
        , ("\\\\", Jenc.string x.cunning)
        , ("DCC SEND STARTKEYLOGGER 0 0 0", Jenc.string x.dccSendStartkeylogger000)
        , ("dontMakeAMap", Jenc.bool x.dontMakeAMap)
        , ("#\tEmoji", Jenc.string x.emoji)
        , ("\"\"", Jenc.string x.empty)
        , ("evaluate", Jenc.string x.evaluate)
        , ("%", Jenc.string x.fluffy)
        , ("0/0", Jenc.string x.fluffy00)
        , ("<foo val=“bar” />", Jenc.string x.fooValBar)
        , ("ÅÍÎÏ˝ÓÔ\u{F8FF}ÒÚÆ☃", Jenc.string x.frisky)
        , ("̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟", Jenc.string x.hENEZPERDIANHIVMINFCASZALGO)
        , ("hasOwnProperty", Jenc.string x.hasOwnProperty)
        , ("--", Jenc.string x.hilarious)
        , ("Horniman Museum", Jenc.string x.hornimanMuseum)
        , ("http://www.cum.qc.ca/", Jenc.string x.httpWWWCumQcCA)
        , ("<i onwheel=alert(1)> Scroll over me </i>", Jenc.string x.iOnwheelAlert1ScrollOverMeI)
        , ("<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">", Jenc.string x.imgABCSrcDXEOnerrorFAlert1)
        , ("<IMG onmouseover=\"alert('xxs')\">", Jenc.string x.imgOnmouseoverAlertXxs)
        , ("<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">", Jenc.string x.imgSCRIPTAlertXSSSCRIPT)
        , ("<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>", Jenc.string x.imgSRCJavascriptAlertStringFromCharCode888383)
        , ("<IMG SRC=\"javascript:alert('XSS')\"", Jenc.string x.imgSRCJavascriptAlertXSS)
        , ("<img src onerror /\" '\"= alt=javascript:alert(1)//\">", Jenc.string x.imgSrcOnerrorAltJavascriptAlert1)
        , ("<img src\\x10=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgSrcX10XOnerrorJavascriptAlert1)
        , ("<img src\\x12=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgSrcX12XOnerrorJavascriptAlert1)
        , ("<img src\\x13=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgSrcX13XOnerrorJavascriptAlert1)
        , ("<img src\\x32=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgSrcX32XOnerrorJavascriptAlert1)
        , ("<img src\\x47=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgSrcX47XOnerrorJavascriptAlert1)
        , ("<img src=x onerror=alert(123) />", Jenc.string x.imgSrcXOnerrorAlert123)
        , ("<img src=x onerror=\\x10\"javascript:alert(1)\">", Jenc.string x.imgSrcXOnerrorX10JavascriptAlert1)
        , ("<img src=x onerror=\\x32\"javascript:alert(1)\">", Jenc.string x.imgSrcXOnerrorX32JavascriptAlert1)
        , ("<img src=\"x` `<script>javascript:alert(1)</script>\"` `>", Jenc.string x.imgSrcXScriptJavascriptAlert1Script)
        , ("`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>", Jenc.string x.imgSrcXxxXX09OnerrorJavascriptAlert1)
        , ("`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>", Jenc.string x.imgSrcXxxXX20OnerrorJavascriptAlert1)
        , ("`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>", Jenc.string x.imgSrcXxxXX22OnerrorJavascriptAlert1)
        , ("`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>", Jenc.string x.imgSrcXxxXX27OnerrorJavascriptAlert1)
        , ("<img\\x11src=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgX11SrcXOnerrorJavascriptAlert1)
        , ("<img \\x34src=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgX34SrcXOnerrorJavascriptAlert1)
        , ("<img\\x47src=x onerror=\"javascript:alert(1)\">", Jenc.string x.imgX47SrcXOnerrorJavascriptAlert1)
        , ("-", Jenc.string x.indecent)
        , (",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’", Jenc.string x.indigo)
        , ("Infinity", Jenc.string x.infinity)
        , ("JavaSCript:alert(123)", Jenc.string x.javaSCriptAlert123)
        , ("LPT1", Jenc.string x.lpt1)
        , ("&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;", Jenc.string x.ltScriptGtAlert3912339LtScriptGt)
        , ("_", Jenc.string x.magenta)
        , ("magna cum laude", Jenc.string x.magnaCumLaude)
        , ("medieval erection of parapets", Jenc.string x.medievalErectionOfParapets)
        , ("ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя", Jenc.string x.mischievous)
        , ("mocha", Jenc.string x.mocha)
        , ("NaN", Jenc.string x.naN)
        , ("# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,", Jenc.string x.nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F)
        , ("NULL", Jenc.string x.null)
        , ("' onfocus=JaVaSCript:alert(123) autofocus", Jenc.string x.onfocusJaVaSCriptAlert123Autofocus)
        , ("# or reused for internal delimiters on the theory that they should never", Jenc.string x.orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever)
        , ("<plaintext>", Jenc.string x.plaintext)
        , ("Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗", Jenc.string x.powerH)
        , ("\"''''\"'\"", Jenc.string x.purple)
        , ("0,,0", Jenc.string x.purple00)
        , ("1.000,00", Jenc.string x.purple100000)
        , ("1.000.000,00", Jenc.string x.purple100000000)
        , ("＜script＞alert(123)＜/script＞", Jenc.string x.purpleScriptAlert123Script)
        , ("#\tRight-To-Left Strings", Jenc.string x.rightToLeftStrings)
        , ("Roses are \u{001B}[0;31mred\u{001B}[0m, violets are \u{001B}[0;34mblue. Hope you enjoy terminal hue", Jenc.string x.rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue)
        , ("%*.*s", Jenc.string x.s)
        , ("'><script>alert(123)</script>", Jenc.string x.scriptAlert123Script)
        , ("'><script>alert(123);</script x='", Jenc.string x.scriptAlert123ScriptX)
        , ("\"`'><script>-javascript:alert(1)</script>", Jenc.string x.scriptJavascriptAlert1Script)
        , ("< / script >< script >alert(123)< / script >", Jenc.string x.scriptScriptAlert123Script)
        , ("<script src=\"/\\%(jscript)s\"></script>", Jenc.string x.scriptSrcJscriptSScript)
        , ("\"`'><script>\\x0Ajavascript:alert(1)</script>", Jenc.string x.scriptX0AjavascriptAlert1Script)
        , ("\"`'><script>\\x0Bjavascript:alert(1)</script>", Jenc.string x.scriptX0BjavascriptAlert1Script)
        , ("<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>", Jenc.string x.scriptX0CtypeTextJavascriptJavascriptAlert1Script)
        , ("\"`'><script>\\x20javascript:alert(1)</script>", Jenc.string x.scriptX20JavascriptAlert1Script)
        , ("\"`'><script>\\x2Bjavascript:alert(1)</script>", Jenc.string x.scriptX2BjavascriptAlert1Script)
        , ("<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>", Jenc.string x.scriptX2FtypeTextJavascriptJavascriptAlert1Script)
        , ("\"`'><script>\\x7Ejavascript:alert(1)</script>", Jenc.string x.scriptX7EjavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>", Jenc.string x.scriptXE2X80X80JavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>", Jenc.string x.scriptXE2X80X82JavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>", Jenc.string x.scriptXE2X80X83JavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>", Jenc.string x.scriptXE2X80X84JavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>", Jenc.string x.scriptXE2X80X88JavascriptAlert1Script)
        , ("\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>", Jenc.string x.scriptXE2X80X8BjavascriptAlert1Script)
        , ("\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>", Jenc.string x.scriptXEFXBFXAEjavascriptAlert1Script)
        , ("\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>", Jenc.string x.scriptXEFXBFXBEjavascriptAlert1Script)
        , ("Scunthorpe General Hospital", Jenc.string x.scunthorpeGeneralHospital)
        , ("#\tServer Code Injection", Jenc.string x.serverCodeInjection)
        , ("shitake mushrooms", Jenc.string x.shitakeMushrooms)
        , ("#\tSpecial Characters", Jenc.string x.specialCharacters)
        , ("src=JaVaSCript:prompt(132)", Jenc.string x.srcJaVaSCriptPrompt132)
        , ("(ﾉಥ益ಥ）ﾉ\u{FEFF} ┻━┻", Jenc.string x.sticky)
        , ("#\tStrings which can be interpreted as numeric", Jenc.string x.stringsWhichCanBeInterpretedAsNumeric)
        , ("#\tStrings which can cause a SQL injection if inputs are not sanitized", Jenc.string x.stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitized)
        , ("#\tStrings which can cause user to pull in files that should not be a part of a web server", Jenc.string x.stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer)
        , ("#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)", Jenc.string x.stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153)
        , ("#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)", Jenc.string x.stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNet)
        , ("#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)", Jenc.string x.stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOM)
        , ("#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)", Jenc.string x.stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDF)
        , ("#\tStrings which punish the fools who use cat/type on this file", Jenc.string x.stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile)
        , ("<svg><script>123<1>alert(123)</script>", Jenc.string x.svgScript1231Alert123Script)
        , ("System(\"ls -al /\")", Jenc.string x.systemLsAl)
        , ("@{[system \"touch /tmp/blns.fail\"]}", Jenc.string x.systemTouchTmpBlnsFail)
        , ("''", Jenc.string x.tentacled)
        , ("\u{2029}test\u{2029}", Jenc.string x.test)
        , ("test\u{2060}test\u{202B}", Jenc.string x.testTest)
        , ("\u{1F3F3}0\u{1F308}️", Jenc.string x.the0)
        , ("+0.0", Jenc.string x.the00)
        , ("0.0.0", Jenc.string x.the000)
        , ("0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \u{1F51F}", Jenc.string x.the0123456789)
        , ("() { 0; }; touch /tmp/blns.shellshock1.fail;", Jenc.string x.the0TouchTmpBlnsShellshock1Fail)
        , ("0xabad1dea", Jenc.string x.the0Xabad1Dea)
        , ("0xffffffff", Jenc.string x.the0Xffffffff)
        , ("--1", Jenc.string x.the1)
        , ("\u{1F435} \u{1F648} \u{1F649} \u{1F64A}", Jenc.string x.the10)
        , ("-$1.00", Jenc.string x.the100)
        , ("1 000,00", Jenc.string x.the100000)
        , ("1'000'000,00", Jenc.string x.the100000000)
        , ("\u{1F47E} \u{1F647} \u{1F481} \u{1F645} \u{1F646} \u{1F64B} \u{1F64E} \u{1F64D}", Jenc.string x.the11)
        , ("-1/2", Jenc.string x.the12)
        , ("Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ", Jenc.string x.the13)
        , ("-1E+02", Jenc.string x.the1E02)
        , ("-1E2", Jenc.string x.the1E2)
        , ("-1#IND", Jenc.string x.the1Ind)
        , ("⁰⁴⁵", Jenc.string x.the3)
        , ("⅛⅜⅝⅞", Jenc.string x.the4)
        , ("✋\u{1F3FF} \u{1F4AA}\u{1F3FF} \u{1F450}\u{1F3FF} \u{1F64C}\u{1F3FF} \u{1F44F}\u{1F3FF} \u{1F64F}\u{1F3FF}", Jenc.string x.the5)
        , ("・(￣∀￣)・:*:", Jenc.string x.the6)
        , ("\u{1D413}\u{1D421}\u{1D41E} \u{1D42A}\u{1D42E}\u{1D422}\u{1D41C}\u{1D424} \u{1D41B}\u{1D42B}\u{1D428}\u{1D430}\u{1D427} \u{1D41F}\u{1D428}\u{1D431} \u{1D423}\u{1D42E}\u{1D426}\u{1D429}\u{1D42C} \u{1D428}\u{1D42F}\u{1D41E}\u{1D42B} \u{1D42D}\u{1D421}\u{1D41E} \u{1D425}\u{1D41A}\u{1D433}\u{1D432} \u{1D41D}\u{1D428}\u{1D420}", Jenc.string x.the8)
        , ("\u{1D683}\u{1D691}\u{1D68E} \u{1D69A}\u{1D69E}\u{1D692}\u{1D68C}\u{1D694} \u{1D68B}\u{1D69B}\u{1D698}\u{1D6A0}\u{1D697} \u{1D68F}\u{1D698}\u{1D6A1} \u{1D693}\u{1D69E}\u{1D696}\u{1D699}\u{1D69C} \u{1D698}\u{1D69F}\u{1D68E}\u{1D69B} \u{1D69D}\u{1D691}\u{1D68E} \u{1D695}\u{1D68A}\u{1D6A3}\u{1D6A2} \u{1D68D}\u{1D698}\u{1D690}", Jenc.string x.the9)
        , ("-9223372036854775808/-1", Jenc.string x.the92233720368547758081)
        , ("┬─┬ノ( º _ ºノ)", Jenc.string x.the_)
        , ("مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، ", Jenc.string x.the_1)
        , ("\u{2070E}\u{20731}\u{20779}\u{20C53}\u{20C78}\u{20C96}\u{20CCF}", Jenc.string x.the_12)
        , ("١٢٣", Jenc.string x.the_2)
        , ("울란바토르", Jenc.string x.the_7)
        , ("<title onpropertychange=javascript:alert(1)></title><title title=>", Jenc.string x.titleOnpropertychangeJavascriptAlert1TitleTitleTitle)
        , ("# treated as whitespace in some contexts.", Jenc.string x.treatedAsWhitespaceInSomeContexts)
        , ("#\tTrick Unicode", Jenc.string x.trickUnicode)
        , ("true", Jenc.string x.true)
        , ("undefined", Jenc.string x.undefined)
        , ("# Unicode additional control characters: all of the characters with", Jenc.string x.unicodeAdditionalControlCharactersAllOfTheCharactersWith)
        , ("#\tUnicode Subscript/Superscript/Accents", Jenc.string x.unicodeSubscriptSuperscriptAccents)
        , ("#\tUnicode Upsidedown", Jenc.string x.unicodeUpsidedown)
        , ("$USER", Jenc.string x.user)
        , ("--version", Jenc.string x.version)
        , ("# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),", Jenc.string x.version800PlusU0009HTU000BVTU000CFFU0085NEL)
        , ("# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode", Jenc.string x.whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode)
        , ("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>", Jenc.string x.xmlVersion10EncodingISO88591DOCTYPEFooELEMENTFooANYENTITYXxeSYSTEMFileEtcPasswdFooXxeFoo)
        , ("#      XXE Injection (XML)", Jenc.string x.xxeInjectionXML)
        , ("#\tZalgo Text", Jenc.string x.zalgoText)
        , ("ZZ:", Jenc.string x.zz)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
