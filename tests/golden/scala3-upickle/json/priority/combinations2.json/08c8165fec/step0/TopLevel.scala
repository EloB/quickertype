package quicktype

// Custom pickler so that missing keys and JSON nulls both read as None,
// and None is left out when writing (upickle's default for Option is a
// JSON array).
object OptionPickler extends upickle.AttributeTagged:
    import upickle.default.Writer
    import upickle.default.Reader
    override implicit def OptionWriter[T: Writer]: Writer[Option[T]] =
        implicitly[Writer[T]].comap[Option[T]] {
            case None => null.asInstanceOf[T]
            case Some(x) => x
        }

    override implicit def OptionReader[T: Reader]: Reader[Option[T]] = {
        new Reader.Delegate[Any, Option[T]](implicitly[Reader[T]].map(Some(_))){
        override def visitNull(index: Int) = None
        }
    }
end OptionPickler

// If a union has a null in, then we'll need this too...
type NullValue = None.type
given OptionPickler.ReadWriter[NullValue] = OptionPickler.readwriter[ujson.Value].bimap[NullValue](
    _ => ujson.Null,
    json => if json.isNull then None else throw new upickle.core.Abort("not null")
)
given OptionPickler.ReadWriter[java.time.Instant] = OptionPickler.readwriter[ujson.Value].bimap(
    value => ujson.Str(value.toString),
    json => json match
        case ujson.Str(value) => java.time.Instant.parse(value)
        case other => throw new upickle.core.Abort("expected date-time, got " + other)
)
given OptionPickler.ReadWriter[java.util.UUID] = OptionPickler.readwriter[String].bimap(
    _.toString,
    value =>
        val uuid = java.util.UUID.fromString(value)
        if uuid.toString.equalsIgnoreCase(value) then uuid else throw new upickle.core.Abort("invalid UUID")
)

object JsonExt:
    val valueReader = OptionPickler.readwriter[ujson.Value]

    // upickle's built-in primitive readers are lenient -- the numeric and
    // boolean readers accept strings, and the string reader accepts
    // numbers and booleans -- so untagged unions need strict readers to
    // pick the right member.
    val strictString: OptionPickler.Reader[String] = valueReader.map {
        case ujson.Str(s) => s
        case json => throw new upickle.core.Abort("expected string, got " + json)
    }
    val strictLong: OptionPickler.Reader[Long] = valueReader.map {
        case ujson.Num(n) if n.isWhole => n.toLong
        case json => throw new upickle.core.Abort("expected integer, got " + json)
    }
    val strictDouble: OptionPickler.Reader[Double] = valueReader.map {
        case ujson.Num(n) => n
        case json => throw new upickle.core.Abort("expected number, got " + json)
    }
    val strictBoolean: OptionPickler.Reader[Boolean] = valueReader.map {
        case ujson.Bool(b) => b
        case json => throw new upickle.core.Abort("expected boolean, got " + json)
    }

    def badMerge[T](r1: => OptionPickler.Reader[?], rest: OptionPickler.Reader[?]*): OptionPickler.Reader[T] = valueReader.map { json =>
        var t: T | Null = null
        val stack       = Vector.newBuilder[Throwable]
        (r1 +: rest).foreach { reader =>
            if t == null then
            try
                t = OptionPickler.read[T](json, trace = true)(using reader.asInstanceOf[OptionPickler.Reader[T]])
            catch
                case exc => stack += exc
        }
        if t != null then t.nn else throw new Exception(json.toString(), stack.result().headOption.getOrElse(null))
    }
end JsonExt
given OptionPickler.Reader[Long] = JsonExt.strictLong


case class TopLevel (
    val Abranchiata : Seq[Abranchiata],
    val academe : Seq[Academe],
    val acquirable : Seq[Acquirable],
    val aerometry : Seq[Aerometry],
    val alexin : Seq[Alexin],
    val alleviate : Seq[AlleviateElement],
    val amaas : Seq[Amaa],
    val ambassage : Seq[Ambassage],
    val amphithyron : Seq[Option[Amphithyron]],
    val Andriana : Seq[Option[String]],
    val ankee : Seq[AnkeeElement],
    val annihilator : Seq[Option[Map[String, Option[Long]]]],
    val annulose : Option[ujson.Value],
    val Ansarie : Seq[AnsarieElement],
    val aphasia : Seq[Aphasia],
    val asprawl : Seq[Asprawl],
    val attractive : Seq[Option[Boolean]],
    val barksome : Map[String, Long],
    val bedesman : Seq[Bedesman],
    val belard : Seq[Belard],
    val bocking : Seq[Bocking],
    val brawlingly : Seq[Brawlingly],
    val brookie : Seq[Brookie],
    val bumboatman : Seq[Bumboatman],
    val bystreet : Seq[Option[ujson.Value]],
    val calaverite : Seq[Calaverite],
    val catallactic : Seq[Catallactic],
    val cemental : Seq[Cemental],
    val Chytridiaceae : Seq[ChytridiaceaeElement],
    val Discordia : Seq[DiscordiaElement],
    val Endomyces : Seq[Endomyce],
    val Epinephelidae : Seq[Epinephelidae],
    val Eupatorium : Seq[Eupatorium],
    val Gryphosaurus : Seq[GryphosaurusElement],
    val Koryak : Seq[Koryak],
    val Lavinia : Seq[LaviniaElement],
    val Oskar : Seq[OskarElement],
    val Rebecca : Seq[RebeccaElement],
    val Rhomboganoidei : Seq[Rhomboganoidei],
    val Rigsmal : Boolean,
    val Ruellia : Seq[Ruellia],
    val School : Seq[School],
    val Shakespearolater : Seq[Shakespearolater],
    val Svan : Seq[Double],
    val Wayao : Map[String, Double]
) derives OptionPickler.ReadWriter

type Abranchiata = Seq[Long] | Long | NullValue
given unionReaderAbranchiata: OptionPickler.Reader[Abranchiata] = JsonExt.badMerge[Abranchiata](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterAbranchiata: OptionPickler.Writer[Abranchiata] = OptionPickler.writer[ujson.Value].comap[Abranchiata]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Academe = Seq[Long] | Map[String, Long] | Long
given unionReaderAcademe: OptionPickler.Reader[Academe] = JsonExt.badMerge[Academe](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterAcademe: OptionPickler.Writer[Academe] = OptionPickler.writer[ujson.Value].comap[Academe]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Acquirable = Map[String, Long] | Seq[Option[Long]]
given unionReaderAcquirable: OptionPickler.Reader[Acquirable] = JsonExt.badMerge[Acquirable](
    summon[OptionPickler.Reader[Seq[Option[Long]]]],
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterAcquirable: OptionPickler.Writer[Acquirable] = OptionPickler.writer[ujson.Value].comap[Acquirable]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Option[Long]] => OptionPickler.writeJs[Seq[Option[Long]]](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Aerometry = Boolean | Double
given unionReaderAerometry: OptionPickler.Reader[Aerometry] = JsonExt.badMerge[Aerometry](
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    )

given unionWriterAerometry: OptionPickler.Writer[Aerometry] = OptionPickler.writer[ujson.Value].comap[Aerometry]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
}

type Alexin = Boolean | Seq[Long]
given unionReaderAlexin: OptionPickler.Reader[Alexin] = JsonExt.badMerge[Alexin](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Seq[Long]]],
    )

given unionWriterAlexin: OptionPickler.Writer[Alexin] = OptionPickler.writer[ujson.Value].comap[Alexin]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
}

type AlleviateElement = AlleviateClass | Seq[Option[Long]]
given unionReaderAlleviateElement: OptionPickler.Reader[AlleviateElement] = JsonExt.badMerge[AlleviateElement](
    summon[OptionPickler.Reader[Seq[Option[Long]]]],
    summon[OptionPickler.Reader[AlleviateClass]],
    )

given unionWriterAlleviateElement: OptionPickler.Writer[AlleviateElement] = OptionPickler.writer[ujson.Value].comap[AlleviateElement]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Option[Long]] => OptionPickler.writeJs[Seq[Option[Long]]](v)
        case v: AlleviateClass => OptionPickler.writeJs[AlleviateClass](v)
}

case class AlleviateClass (
    val apriori : Option[ujson.Value],
    val beggarer : Option[ujson.Value],
    val brokenheartedly : Option[ujson.Value],
    val debilitation : Option[ujson.Value],
    val frike : Option[ujson.Value],
    val gastrolith : Option[ujson.Value],
    val Hulsean : Option[ujson.Value],
    val orthocentric : Option[ujson.Value],
    val petaly : Option[ujson.Value],
    val probudgeting : Option[ujson.Value],
    val reacquire : Option[ujson.Value],
    val scow : Option[ujson.Value],
    val shutoff : Option[ujson.Value],
    val subcontiguous : Option[ujson.Value],
    val suffumigate : Option[ujson.Value],
    val transformable : Option[ujson.Value],
    val uncoroneted : Option[ujson.Value],
    val unparking : Option[ujson.Value],
    val unvarnishedness : Option[ujson.Value],
    val wherewithal : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Amaa = Boolean | Long | Rebecca
given unionReaderAmaa: OptionPickler.Reader[Amaa] = JsonExt.badMerge[Amaa](
    JsonExt.strictBoolean,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Rebecca]],
    )

given unionWriterAmaa: OptionPickler.Writer[Amaa] = OptionPickler.writer[ujson.Value].comap[Amaa]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Rebecca => OptionPickler.writeJs[Rebecca](v)
}

case class Rebecca (
    val catharticalness : Double,
    val Chirotherium : Long,
    val disdiapason : String,
    val homocerc : Boolean,
    val nonbookish : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Ambassage = Seq[Option[ujson.Value]] | String
given unionReaderAmbassage: OptionPickler.Reader[Ambassage] = JsonExt.badMerge[Ambassage](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    )

given unionWriterAmbassage: OptionPickler.Writer[Ambassage] = OptionPickler.writer[ujson.Value].comap[Ambassage]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
}

case class Amphithyron (
    val akroasis : Option[Long] = None,
    val antiphonical : Option[Long] = None,
    val basebred : Option[Long] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val conductometric : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val ensilation : Option[Long] = None,
    val eyebolt : Option[Long] = None,
    val fistulated : Option[Long] = None,
    val heteropod : Option[Long] = None,
    val homocerc : Option[Boolean] = None,
    val Juniperus : Option[Long] = None,
    val labyrinthically : Option[Long] = None,
    val martyrization : Option[Long] = None,
    val mispolicy : Option[Long] = None,
    val multipara : Option[Long] = None,
    val Nazirite : Option[Long] = None,
    val nonbookish : Option[ujson.Value] = None,
    val possessorial : Option[Long] = None,
    val shamed : Option[Long] = None,
    val shelfworn : Option[Long] = None,
    val stagnum : Option[Long] = None,
    val Those : Option[Long] = None,
    val undecimal : Option[Long] = None
) derives OptionPickler.ReadWriter

type AnkeeElement = AnkeeClass | Seq[Long] | Long
given unionReaderAnkeeElement: OptionPickler.Reader[AnkeeElement] = JsonExt.badMerge[AnkeeElement](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[AnkeeClass]],
    )

given unionWriterAnkeeElement: OptionPickler.Writer[AnkeeElement] = OptionPickler.writer[ujson.Value].comap[AnkeeElement]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: AnkeeClass => OptionPickler.writeJs[AnkeeClass](v)
}

case class AnkeeClass (
    val Anomoean : Option[ujson.Value],
    val barleyhood : Option[ujson.Value],
    val befriender : Option[ujson.Value],
    val brutishness : Option[ujson.Value],
    val cephalalgy : Option[ujson.Value],
    val cirurgian : Option[ujson.Value],
    val conventionally : Option[ujson.Value],
    val jackshay : Option[ujson.Value],
    val milammeter : Option[ujson.Value],
    val Naja : Option[ujson.Value],
    val ombrological : Option[ujson.Value],
    val phonasthenia : Option[ujson.Value],
    val retrievableness : Option[ujson.Value],
    val snakily : Option[ujson.Value],
    val swot : Option[ujson.Value],
    val tartlet : Option[ujson.Value],
    val thiofuran : Option[ujson.Value],
    val tracheophone : Option[ujson.Value],
    val tuglike : Option[ujson.Value],
    val unscratchingly : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type AnsarieElement = AnsarieClass | Seq[Long] | NullValue
given unionReaderAnsarieElement: OptionPickler.Reader[AnsarieElement] = JsonExt.badMerge[AnsarieElement](
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[AnsarieClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterAnsarieElement: OptionPickler.Writer[AnsarieElement] = OptionPickler.writer[ujson.Value].comap[AnsarieElement]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: AnsarieClass => OptionPickler.writeJs[AnsarieClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

case class AnsarieClass (
    val accension : Option[ujson.Value],
    val Alida : Option[ujson.Value],
    val asteria : Option[ujson.Value],
    val beriberic : Option[ujson.Value],
    val edgebone : Option[ujson.Value],
    val gastrodialysis : Option[ujson.Value],
    val geographic : Option[ujson.Value],
    val Ictonyx : Option[ujson.Value],
    val metrocele : Option[ujson.Value],
    val misgraft : Option[ujson.Value],
    val monteith : Option[ujson.Value],
    val notcher : Option[ujson.Value],
    val prorestriction : Option[ujson.Value],
    val Ramist : Option[ujson.Value],
    val throatlet : Option[ujson.Value],
    val unfair : Option[ujson.Value],
    val unsynonymous : Option[ujson.Value],
    val water : Option[ujson.Value],
    val zestfully : Option[ujson.Value],
    val zincic : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Aphasia = Seq[Long] | Long
given unionReaderAphasia: OptionPickler.Reader[Aphasia] = JsonExt.badMerge[Aphasia](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Long]]],
    )

given unionWriterAphasia: OptionPickler.Writer[Aphasia] = OptionPickler.writer[ujson.Value].comap[Aphasia]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
}

type Asprawl = Double | String
given unionReaderAsprawl: OptionPickler.Reader[Asprawl] = JsonExt.badMerge[Asprawl](
    JsonExt.strictString,
    JsonExt.strictDouble,
    )

given unionWriterAsprawl: OptionPickler.Writer[Asprawl] = OptionPickler.writer[ujson.Value].comap[Asprawl]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Double => OptionPickler.writeJs[Double](v)
}

type Bedesman = Boolean | Double | String
given unionReaderBedesman: OptionPickler.Reader[Bedesman] = JsonExt.badMerge[Bedesman](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    )

given unionWriterBedesman: OptionPickler.Writer[Bedesman] = OptionPickler.writer[ujson.Value].comap[Bedesman]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
}

type Belard = Double | Seq[Long] | Rebecca
given unionReaderBelard: OptionPickler.Reader[Belard] = JsonExt.badMerge[Belard](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[Rebecca]],
    )

given unionWriterBelard: OptionPickler.Writer[Belard] = OptionPickler.writer[ujson.Value].comap[Belard]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: Rebecca => OptionPickler.writeJs[Rebecca](v)
}

type Bocking = Boolean | Seq[Long] | Map[String, Long]
given unionReaderBocking: OptionPickler.Reader[Bocking] = JsonExt.badMerge[Bocking](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterBocking: OptionPickler.Writer[Bocking] = OptionPickler.writer[ujson.Value].comap[Bocking]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Brawlingly = Seq[Option[ujson.Value]] | Map[String, Option[Long]]
given unionReaderBrawlingly: OptionPickler.Reader[Brawlingly] = JsonExt.badMerge[Brawlingly](
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[Map[String, Option[Long]]]],
    )

given unionWriterBrawlingly: OptionPickler.Writer[Brawlingly] = OptionPickler.writer[ujson.Value].comap[Brawlingly]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: Map[String, Option[Long]] => OptionPickler.writeJs[Map[String, Option[Long]]](v)
}

type Brookie = Seq[Long] | Rebecca
given unionReaderBrookie: OptionPickler.Reader[Brookie] = JsonExt.badMerge[Brookie](
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[Rebecca]],
    )

given unionWriterBrookie: OptionPickler.Writer[Brookie] = OptionPickler.writer[ujson.Value].comap[Brookie]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: Rebecca => OptionPickler.writeJs[Rebecca](v)
}

type Bumboatman = Seq[Option[ujson.Value]] | String | NullValue
given unionReaderBumboatman: OptionPickler.Reader[Bumboatman] = JsonExt.badMerge[Bumboatman](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterBumboatman: OptionPickler.Writer[Bumboatman] = OptionPickler.writer[ujson.Value].comap[Bumboatman]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Calaverite = Seq[Long] | String
given unionReaderCalaverite: OptionPickler.Reader[Calaverite] = JsonExt.badMerge[Calaverite](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[Long]]],
    )

given unionWriterCalaverite: OptionPickler.Writer[Calaverite] = OptionPickler.writer[ujson.Value].comap[Calaverite]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
}

type Catallactic = Boolean | Map[String, Long] | Seq[Option[ujson.Value]]
given unionReaderCatallactic: OptionPickler.Reader[Catallactic] = JsonExt.badMerge[Catallactic](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterCatallactic: OptionPickler.Writer[Catallactic] = OptionPickler.writer[ujson.Value].comap[Catallactic]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Cemental = Double | Seq[Long] | Map[String, Long]
given unionReaderCemental: OptionPickler.Reader[Cemental] = JsonExt.badMerge[Cemental](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterCemental: OptionPickler.Writer[Cemental] = OptionPickler.writer[ujson.Value].comap[Cemental]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type ChytridiaceaeElement = Boolean | ChytridiaceaeClass | NullValue
given unionReaderChytridiaceaeElement: OptionPickler.Reader[ChytridiaceaeElement] = JsonExt.badMerge[ChytridiaceaeElement](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[ChytridiaceaeClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterChytridiaceaeElement: OptionPickler.Writer[ChytridiaceaeElement] = OptionPickler.writer[ujson.Value].comap[ChytridiaceaeElement]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: ChytridiaceaeClass => OptionPickler.writeJs[ChytridiaceaeClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

case class ChytridiaceaeClass (
    val Batidaceae : Option[ujson.Value],
    val Brechites : Option[ujson.Value],
    val codespairer : Option[ujson.Value],
    val Emery : Option[ujson.Value],
    val enervative : Option[ujson.Value],
    val excriminate : Option[ujson.Value],
    val goshenite : Option[ujson.Value],
    val grime : Option[ujson.Value],
    val gritten : Option[ujson.Value],
    val hectorly : Option[ujson.Value],
    val intermediation : Option[ujson.Value],
    val meeterly : Option[ujson.Value],
    val Narraganset : Option[ujson.Value],
    val onymatic : Option[ujson.Value],
    val paddlecock : Option[ujson.Value],
    val thana : Option[ujson.Value],
    val thornily : Option[ujson.Value],
    val uckia : Option[ujson.Value],
    val unmettle : Option[ujson.Value],
    val vorticellid : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type DiscordiaElement = DiscordiaClass | Seq[Long]
given unionReaderDiscordiaElement: OptionPickler.Reader[DiscordiaElement] = JsonExt.badMerge[DiscordiaElement](
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[DiscordiaClass]],
    )

given unionWriterDiscordiaElement: OptionPickler.Writer[DiscordiaElement] = OptionPickler.writer[ujson.Value].comap[DiscordiaElement]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: DiscordiaClass => OptionPickler.writeJs[DiscordiaClass](v)
}

case class DiscordiaClass (
    val Altaic : Option[Long] = None,
    val amoristic : Option[Long] = None,
    val blennophthalmia : Option[Long] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val disciplinability : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val goofer : Option[Long] = None,
    val homocerc : Option[Boolean] = None,
    val laryngograph : Option[Long] = None,
    val leucitis : Option[Long] = None,
    val lymphocyst : Option[Long] = None,
    val microcosmology : Option[Long] = None,
    val nauseation : Option[Long] = None,
    val nonbookish : Option[ujson.Value] = None,
    val Patarin : Option[Long] = None,
    val preliberal : Option[Long] = None,
    val prettifier : Option[Long] = None,
    val rangework : Option[Long] = None,
    val redient : Option[Long] = None,
    val subfusiform : Option[Long] = None,
    val suicidical : Option[Long] = None,
    val swow : Option[Long] = None,
    val wastrel : Option[Long] = None,
    val wingle : Option[Long] = None
) derives OptionPickler.ReadWriter

type Endomyce = Long | String
given unionReaderEndomyce: OptionPickler.Reader[Endomyce] = JsonExt.badMerge[Endomyce](
    JsonExt.strictString,
    JsonExt.strictLong,
    )

given unionWriterEndomyce: OptionPickler.Writer[Endomyce] = OptionPickler.writer[ujson.Value].comap[Endomyce]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Long => OptionPickler.writeJs[Long](v)
}

type Epinephelidae = Boolean | Long | String
given unionReaderEpinephelidae: OptionPickler.Reader[Epinephelidae] = JsonExt.badMerge[Epinephelidae](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    JsonExt.strictLong,
    )

given unionWriterEpinephelidae: OptionPickler.Writer[Epinephelidae] = OptionPickler.writer[ujson.Value].comap[Epinephelidae]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Long => OptionPickler.writeJs[Long](v)
}

type Eupatorium = Map[String, Long] | Seq[Option[ujson.Value]]
given unionReaderEupatorium: OptionPickler.Reader[Eupatorium] = JsonExt.badMerge[Eupatorium](
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterEupatorium: OptionPickler.Writer[Eupatorium] = OptionPickler.writer[ujson.Value].comap[Eupatorium]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type GryphosaurusElement = GryphosaurusClass | Seq[Long] | String
given unionReaderGryphosaurusElement: OptionPickler.Reader[GryphosaurusElement] = JsonExt.badMerge[GryphosaurusElement](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[GryphosaurusClass]],
    )

given unionWriterGryphosaurusElement: OptionPickler.Writer[GryphosaurusElement] = OptionPickler.writer[ujson.Value].comap[GryphosaurusElement]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: GryphosaurusClass => OptionPickler.writeJs[GryphosaurusClass](v)
}

case class GryphosaurusClass (
    val amissibility : Option[ujson.Value],
    val Burushaski : Option[ujson.Value],
    val citronin : Option[ujson.Value],
    val coplaintiff : Option[ujson.Value],
    val disquisitionary : Option[ujson.Value],
    val enoplan : Option[ujson.Value],
    val faintness : Option[ujson.Value],
    val hebetomy : Option[ujson.Value],
    val islandry : Option[ujson.Value],
    val lameduck : Option[ujson.Value],
    val overbattle : Option[ujson.Value],
    val overinterested : Option[ujson.Value],
    val phrenologic : Option[ujson.Value],
    val rainband : Option[ujson.Value],
    val shiningly : Option[ujson.Value],
    val stamineous : Option[ujson.Value],
    val subscapularis : Option[ujson.Value],
    val Tahami : Option[ujson.Value],
    val undaubed : Option[ujson.Value],
    val underntime : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Koryak = String | Map[String, Option[Long]]
given unionReaderKoryak: OptionPickler.Reader[Koryak] = JsonExt.badMerge[Koryak](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Map[String, Option[Long]]]],
    )

given unionWriterKoryak: OptionPickler.Writer[Koryak] = OptionPickler.writer[ujson.Value].comap[Koryak]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Map[String, Option[Long]] => OptionPickler.writeJs[Map[String, Option[Long]]](v)
}

type LaviniaElement = LaviniaClass | String
given unionReaderLaviniaElement: OptionPickler.Reader[LaviniaElement] = JsonExt.badMerge[LaviniaElement](
    JsonExt.strictString,
    summon[OptionPickler.Reader[LaviniaClass]],
    )

given unionWriterLaviniaElement: OptionPickler.Writer[LaviniaElement] = OptionPickler.writer[ujson.Value].comap[LaviniaElement]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: LaviniaClass => OptionPickler.writeJs[LaviniaClass](v)
}

case class LaviniaClass (
    val agitable : Option[Long] = None,
    val asininity : Option[Long] = None,
    val benefiter : Option[Long] = None,
    val bronzelike : Option[Long] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val cholesteatomatous : Option[Long] = None,
    val deprivement : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val flippantness : Option[Long] = None,
    val fogproof : Option[Long] = None,
    val homocerc : Option[Boolean] = None,
    val merrymeeting : Option[Long] = None,
    val nonbookish : Option[ujson.Value] = None,
    val overcareful : Option[Long] = None,
    val panaris : Option[Long] = None,
    val preacceptance : Option[Long] = None,
    val quinoxaline : Option[Long] = None,
    val sig : Option[Long] = None,
    val superconfusion : Option[Long] = None,
    val Tacana : Option[Long] = None,
    val tillotter : Option[Long] = None,
    val tranquillize : Option[Long] = None,
    val unquestionable : Option[Long] = None,
    val uproute : Option[Long] = None
) derives OptionPickler.ReadWriter

type OskarElement = Seq[Long] | OskarClass
given unionReaderOskarElement: OptionPickler.Reader[OskarElement] = JsonExt.badMerge[OskarElement](
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[OskarClass]],
    )

given unionWriterOskarElement: OptionPickler.Writer[OskarElement] = OptionPickler.writer[ujson.Value].comap[OskarElement]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: OskarClass => OptionPickler.writeJs[OskarClass](v)
}

case class OskarClass (
    val Acrobates : Option[ujson.Value],
    val beanshooter : Option[ujson.Value],
    val bearhound : Option[ujson.Value],
    val Cayuga : Option[ujson.Value],
    val guarneri : Option[ujson.Value],
    val hypochondriacism : Option[ujson.Value],
    val indication : Option[ujson.Value],
    val jaculative : Option[ujson.Value],
    val nagana : Option[ujson.Value],
    val Netherlandish : Option[ujson.Value],
    val noctivagous : Option[ujson.Value],
    val nonphysiological : Option[ujson.Value],
    val praxis : Option[ujson.Value],
    val provision : Option[ujson.Value],
    val subterhuman : Option[ujson.Value],
    val sunlit : Option[ujson.Value],
    val syncraniate : Option[ujson.Value],
    val teachment : Option[ujson.Value],
    val unmutinous : Option[ujson.Value],
    val unstoppable : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type RebeccaElement = Long | Rebecca | String
given unionReaderRebeccaElement: OptionPickler.Reader[RebeccaElement] = JsonExt.badMerge[RebeccaElement](
    JsonExt.strictString,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Rebecca]],
    )

given unionWriterRebeccaElement: OptionPickler.Writer[RebeccaElement] = OptionPickler.writer[ujson.Value].comap[RebeccaElement]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Rebecca => OptionPickler.writeJs[Rebecca](v)
}

type Rhomboganoidei = Seq[Long] | Rebecca | String
given unionReaderRhomboganoidei: OptionPickler.Reader[Rhomboganoidei] = JsonExt.badMerge[Rhomboganoidei](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[Rebecca]],
    )

given unionWriterRhomboganoidei: OptionPickler.Writer[Rhomboganoidei] = OptionPickler.writer[ujson.Value].comap[Rhomboganoidei]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: Rebecca => OptionPickler.writeJs[Rebecca](v)
}

type Ruellia = Boolean | Rebecca | String
given unionReaderRuellia: OptionPickler.Reader[Ruellia] = JsonExt.badMerge[Ruellia](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Rebecca]],
    )

given unionWriterRuellia: OptionPickler.Writer[Ruellia] = OptionPickler.writer[ujson.Value].comap[Ruellia]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Rebecca => OptionPickler.writeJs[Rebecca](v)
}

type School = Map[String, Long] | Long | NullValue
given unionReaderSchool: OptionPickler.Reader[School] = JsonExt.badMerge[School](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Map[String, Long]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterSchool: OptionPickler.Writer[School] = OptionPickler.writer[ujson.Value].comap[School]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Shakespearolater = Double | Seq[Long] | String
given unionReaderShakespearolater: OptionPickler.Reader[Shakespearolater] = JsonExt.badMerge[Shakespearolater](
    JsonExt.strictString,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Long]]],
    )

given unionWriterShakespearolater: OptionPickler.Writer[Shakespearolater] = OptionPickler.writer[ujson.Value].comap[Shakespearolater]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
}
