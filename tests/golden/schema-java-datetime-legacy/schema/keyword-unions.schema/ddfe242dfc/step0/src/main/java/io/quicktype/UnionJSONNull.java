package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONNull.Deserializer.class)
@JsonSerialize(using = UnionJSONNull.Serializer.class)
public class UnionJSONNull {
    public Double doubleValue;
    public JSONNull jsonNullValue;

    static class Deserializer extends JsonDeserializer<UnionJSONNull> {
        @Override
        public UnionJSONNull deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONNull value = new UnionJSONNull();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonNullValue = jsonParser.readValueAs(JSONNull.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONNull");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONNull> {
        @Override
        public void serialize(UnionJSONNull obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonNullValue != null) {
                jsonGenerator.writeObject(obj.jsonNullValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
