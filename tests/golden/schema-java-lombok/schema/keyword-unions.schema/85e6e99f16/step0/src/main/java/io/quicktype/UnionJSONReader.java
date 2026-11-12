package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONReader.Deserializer.class)
@JsonSerialize(using = UnionJSONReader.Serializer.class)
public class UnionJSONReader {
    public Double doubleValue;
    public JSONReader jsonReaderValue;

    static class Deserializer extends JsonDeserializer<UnionJSONReader> {
        @Override
        public UnionJSONReader deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONReader value = new UnionJSONReader();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonReaderValue = jsonParser.readValueAs(JSONReader.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONReader");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONReader> {
        @Override
        public void serialize(UnionJSONReader obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonReaderValue != null) {
                jsonGenerator.writeObject(obj.jsonReaderValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
