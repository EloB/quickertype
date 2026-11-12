package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONEncoder.Deserializer.class)
@JsonSerialize(using = UnionJSONEncoder.Serializer.class)
public class UnionJSONEncoder {
    public Double doubleValue;
    public JSONEncoder jsonEncoderValue;

    static class Deserializer extends JsonDeserializer<UnionJSONEncoder> {
        @Override
        public UnionJSONEncoder deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONEncoder value = new UnionJSONEncoder();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonEncoderValue = jsonParser.readValueAs(JSONEncoder.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONEncoder");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONEncoder> {
        @Override
        public void serialize(UnionJSONEncoder obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonEncoderValue != null) {
                jsonGenerator.writeObject(obj.jsonEncoderValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
