package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONParser.Deserializer.class)
@JsonSerialize(using = UnionJSONParser.Serializer.class)
public class UnionJSONParser {
    public Double doubleValue;
    public JSONParser jsonParserValue;

    static class Deserializer extends JsonDeserializer<UnionJSONParser> {
        @Override
        public UnionJSONParser deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONParser value = new UnionJSONParser();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonParserValue = jsonParser.readValueAs(JSONParser.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONParser");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONParser> {
        @Override
        public void serialize(UnionJSONParser obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonParserValue != null) {
                jsonGenerator.writeObject(obj.jsonParserValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
