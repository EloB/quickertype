package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONWriter.Deserializer.class)
@JsonSerialize(using = UnionJSONWriter.Serializer.class)
public class UnionJSONWriter {
    public Double doubleValue;
    public JSONWriter jsonWriterValue;

    static class Deserializer extends JsonDeserializer<UnionJSONWriter> {
        @Override
        public UnionJSONWriter deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONWriter value = new UnionJSONWriter();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonWriterValue = jsonParser.readValueAs(JSONWriter.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONWriter");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONWriter> {
        @Override
        public void serialize(UnionJSONWriter obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonWriterValue != null) {
                jsonGenerator.writeObject(obj.jsonWriterValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
