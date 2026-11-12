package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONTokenType.Deserializer.class)
@JsonSerialize(using = UnionJSONTokenType.Serializer.class)
public class UnionJSONTokenType {
    public Double doubleValue;
    public JSONTokenType jsonTokenTypeValue;

    static class Deserializer extends JsonDeserializer<UnionJSONTokenType> {
        @Override
        public UnionJSONTokenType deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONTokenType value = new UnionJSONTokenType();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonTokenTypeValue = jsonParser.readValueAs(JSONTokenType.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONTokenType");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONTokenType> {
        @Override
        public void serialize(UnionJSONTokenType obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonTokenTypeValue != null) {
                jsonGenerator.writeObject(obj.jsonTokenTypeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
