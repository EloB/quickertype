package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = Field.Deserializer.class)
@JsonSerialize(using = Field.Serializer.class)
public class Field {
    public RepeatRef repeatRefValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Field> {
        @Override
        public Field deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Field value = new Field();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.repeatRefValue = jsonParser.readValueAs(RepeatRef.class);
                    break;
                default: throw new IOException("Cannot deserialize Field");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Field> {
        @Override
        public void serialize(Field obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.repeatRefValue != null) {
                jsonGenerator.writeObject(obj.repeatRefValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
