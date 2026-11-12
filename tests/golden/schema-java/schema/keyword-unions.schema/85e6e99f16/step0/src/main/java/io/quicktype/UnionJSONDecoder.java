package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONDecoder.Deserializer.class)
@JsonSerialize(using = UnionJSONDecoder.Serializer.class)
public class UnionJSONDecoder {
    public Double doubleValue;
    public JSONDecoder jsonDecoderValue;

    static class Deserializer extends JsonDeserializer<UnionJSONDecoder> {
        @Override
        public UnionJSONDecoder deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONDecoder value = new UnionJSONDecoder();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonDecoderValue = jsonParser.readValueAs(JSONDecoder.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONDecoder");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONDecoder> {
        @Override
        public void serialize(UnionJSONDecoder obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonDecoderValue != null) {
                jsonGenerator.writeObject(obj.jsonDecoderValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
