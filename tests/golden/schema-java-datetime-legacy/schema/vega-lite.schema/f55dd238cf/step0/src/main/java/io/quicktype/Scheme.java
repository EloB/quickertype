package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

/**
 * A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
 * `"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
 *
 * Discrete color schemes may be used with [discrete](scale.html#discrete) or
 * [discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
 * use with [sequential](scales.html#sequential) scales.
 *
 * For the full list of supported scheme, please refer to the [Vega
 * Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
 */
@JsonDeserialize(using = Scheme.Deserializer.class)
@JsonSerialize(using = Scheme.Serializer.class)
public class Scheme {
    public SchemeParams schemeParamsValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Scheme> {
        @Override
        public Scheme deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Scheme value = new Scheme();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.schemeParamsValue = jsonParser.readValueAs(SchemeParams.class);
                    break;
                default: throw new IOException("Cannot deserialize Scheme");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Scheme> {
        @Override
        public void serialize(Scheme obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.schemeParamsValue != null) {
                jsonGenerator.writeObject(obj.schemeParamsValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
