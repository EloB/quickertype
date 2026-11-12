package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import java.util.Map;

@JsonDeserialize(using = School.Deserializer.class)
@JsonSerialize(using = School.Serializer.class)
public class School {
    public Long integerValue;
    public Map<String, Long> integerMapValue;

    static class Deserializer extends JsonDeserializer<School> {
        @Override
        public School deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            School value = new School();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize School");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<School> {
        @Override
        public void serialize(School obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.integerMapValue != null) {
                jsonGenerator.writeObject(obj.integerMapValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
