package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = YArrayHeterogeneousJSON.Deserializer.class)
@JsonSerialize(using = YArrayHeterogeneousJSON.Serializer.class)
public class YArrayHeterogeneousJSON {
    public JSON jsonValue;
    public Long integerValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<YArrayHeterogeneousJSON> {
        @Override
        public YArrayHeterogeneousJSON deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            YArrayHeterogeneousJSON value = new YArrayHeterogeneousJSON();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.jsonValue = jsonParser.readValueAs(JSON.class);
                    break;
                default: throw new IOException("Cannot deserialize YArrayHeterogeneousJSON");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<YArrayHeterogeneousJSON> {
        @Override
        public void serialize(YArrayHeterogeneousJSON obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.jsonValue != null) {
                jsonGenerator.writeObject(obj.jsonValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
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
