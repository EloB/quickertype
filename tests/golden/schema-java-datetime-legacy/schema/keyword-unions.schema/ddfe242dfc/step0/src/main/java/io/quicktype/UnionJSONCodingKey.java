package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONCodingKey.Deserializer.class)
@JsonSerialize(using = UnionJSONCodingKey.Serializer.class)
public class UnionJSONCodingKey {
    public Double doubleValue;
    public JSONCodingKey jsonCodingKeyValue;

    static class Deserializer extends JsonDeserializer<UnionJSONCodingKey> {
        @Override
        public UnionJSONCodingKey deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONCodingKey value = new UnionJSONCodingKey();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonCodingKeyValue = jsonParser.readValueAs(JSONCodingKey.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONCodingKey");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONCodingKey> {
        @Override
        public void serialize(UnionJSONCodingKey obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonCodingKeyValue != null) {
                jsonGenerator.writeObject(obj.jsonCodingKeyValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
