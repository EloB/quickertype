package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Foo.Deserializer.class)
@JsonSerialize(using = Foo.Serializer.class)
public class Foo {
    public TopLevel topLevelValue;
    public List<TopLevel> topLevelArrayValue;

    static class Deserializer extends JsonDeserializer<Foo> {
        @Override
        public Foo deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Foo value = new Foo();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.topLevelArrayValue = jsonParser.readValueAs(new TypeReference<List<TopLevel>>() {});
                    break;
                case START_OBJECT:
                    value.topLevelValue = jsonParser.readValueAs(TopLevel.class);
                    break;
                default: throw new IOException("Cannot deserialize Foo");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Foo> {
        @Override
        public void serialize(Foo obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.topLevelValue != null) {
                jsonGenerator.writeObject(obj.topLevelValue);
                return;
            }
            if (obj.topLevelArrayValue != null) {
                jsonGenerator.writeObject(obj.topLevelArrayValue);
                return;
            }
            throw new IOException("Foo must not be null");
        }
    }
}
