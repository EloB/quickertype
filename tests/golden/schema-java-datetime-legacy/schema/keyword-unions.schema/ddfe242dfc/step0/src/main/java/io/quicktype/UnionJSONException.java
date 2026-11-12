package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONException.Deserializer.class)
@JsonSerialize(using = UnionJSONException.Serializer.class)
public class UnionJSONException {
    public Double doubleValue;
    public JSONException jsonExceptionValue;

    static class Deserializer extends JsonDeserializer<UnionJSONException> {
        @Override
        public UnionJSONException deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONException value = new UnionJSONException();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonExceptionValue = jsonParser.readValueAs(JSONException.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONException");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONException> {
        @Override
        public void serialize(UnionJSONException obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonExceptionValue != null) {
                jsonGenerator.writeObject(obj.jsonExceptionValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
