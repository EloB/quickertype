package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONToken.Deserializer.class)
@JsonSerialize(using = UnionJSONToken.Serializer.class)
public class UnionJSONToken {
    public Double doubleValue;
    public JSONToken jsonTokenValue;

    static class Deserializer extends JsonDeserializer<UnionJSONToken> {
        @Override
        public UnionJSONToken deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONToken value = new UnionJSONToken();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonTokenValue = jsonParser.readValueAs(JSONToken.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONToken");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONToken> {
        @Override
        public void serialize(UnionJSONToken obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonTokenValue != null) {
                jsonGenerator.writeObject(obj.jsonTokenValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
