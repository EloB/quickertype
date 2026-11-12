package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Saccoderm.Deserializer.class)
@JsonSerialize(using = Saccoderm.Serializer.class)
public class Saccoderm {
    public List<Long> integerArrayValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Saccoderm> {
        @Override
        public Saccoderm deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Saccoderm value = new Saccoderm();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                default: throw new IOException("Cannot deserialize Saccoderm");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Saccoderm> {
        @Override
        public void serialize(Saccoderm obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
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
