package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONGenerator.Deserializer.class)
@JsonSerialize(using = UnionJSONGenerator.Serializer.class)
public class UnionJSONGenerator {
    public Double doubleValue;
    public JSONGenerator jsonGeneratorValue;

    static class Deserializer extends JsonDeserializer<UnionJSONGenerator> {
        @Override
        public UnionJSONGenerator deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONGenerator value = new UnionJSONGenerator();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonGeneratorValue = jsonParser.readValueAs(JSONGenerator.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONGenerator");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONGenerator> {
        @Override
        public void serialize(UnionJSONGenerator obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonGeneratorValue != null) {
                jsonGenerator.writeObject(obj.jsonGeneratorValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
