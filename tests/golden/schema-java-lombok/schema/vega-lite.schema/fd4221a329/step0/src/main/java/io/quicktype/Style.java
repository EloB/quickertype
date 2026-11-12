package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

/**
 * A string or array of strings indicating the name of custom styles to apply to the mark. A
 * style is a named collection of mark property defaults defined within the [style
 * configuration](mark.html#style-config). If style is an array, later styles will override
 * earlier styles. Any [mark properties](encoding.html#mark-prop) explicitly defined within
 * the `encoding` will override a style default.
 *
 * __Default value:__ The mark's name.  For example, a bar mark will have style `"bar"` by
 * default.
 * __Note:__ Any specified style will augment the default style. For example, a bar mark
 * with `"style": "foo"` will receive from `config.style.bar` and `config.style.foo` (the
 * specified style `"foo"` has higher precedence).
 *
 * A [mark style property](config.html#style) to apply to the title text mark.
 *
 * __Default value:__ `"group-title"`.
 */
@JsonDeserialize(using = Style.Deserializer.class)
@JsonSerialize(using = Style.Serializer.class)
public class Style {
    public List<String> stringArrayValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Style> {
        @Override
        public Style deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Style value = new Style();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_ARRAY:
                    value.stringArrayValue = jsonParser.readValueAs(new TypeReference<List<String>>() {});
                    break;
                default: throw new IOException("Cannot deserialize Style");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Style> {
        @Override
        public void serialize(Style obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.stringArrayValue != null) {
                jsonGenerator.writeObject(obj.stringArrayValue);
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
