package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = GryphosaurusElement.Deserializer.class)
@JsonSerialize(using = GryphosaurusElement.Serializer.class)
public class GryphosaurusElement {
    public long[] integerArrayValue;
    public GryphosaurusClass gryphosaurusClassValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<GryphosaurusElement> {
        @Override
        public GryphosaurusElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            GryphosaurusElement value = new GryphosaurusElement();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(long[].class);
                    break;
                case START_OBJECT:
                    value.gryphosaurusClassValue = jsonParser.readValueAs(GryphosaurusClass.class);
                    break;
                default: throw new IOException("Cannot deserialize GryphosaurusElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<GryphosaurusElement> {
        @Override
        public void serialize(GryphosaurusElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.gryphosaurusClassValue != null) {
                jsonGenerator.writeObject(obj.gryphosaurusClassValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("GryphosaurusElement must not be null");
        }
    }
}
