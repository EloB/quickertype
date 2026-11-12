package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONConverter.Deserializer.class)
@JsonSerialize(using = UnionJSONConverter.Serializer.class)
public class UnionJSONConverter {
    public Double doubleValue;
    public JSONConverter jsonConverterValue;

    static class Deserializer extends JsonDeserializer<UnionJSONConverter> {
        @Override
        public UnionJSONConverter deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONConverter value = new UnionJSONConverter();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonConverterValue = jsonParser.readValueAs(JSONConverter.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONConverter");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONConverter> {
        @Override
        public void serialize(UnionJSONConverter obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonConverterValue != null) {
                jsonGenerator.writeObject(obj.jsonConverterValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
