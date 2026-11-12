package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = DiaereseElement.Deserializer.class)
@JsonSerialize(using = DiaereseElement.Serializer.class)
public class DiaereseElement {
    public List<Long> integerArrayValue;
    public Boolean boolValue;
    public DiaereseClass diaereseClassValue;

    static class Deserializer extends JsonDeserializer<DiaereseElement> {
        @Override
        public DiaereseElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            DiaereseElement value = new DiaereseElement();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.diaereseClassValue = jsonParser.readValueAs(DiaereseClass.class);
                    break;
                default: throw new IOException("Cannot deserialize DiaereseElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<DiaereseElement> {
        @Override
        public void serialize(DiaereseElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.diaereseClassValue != null) {
                jsonGenerator.writeObject(obj.diaereseClassValue);
                return;
            }
            throw new IOException("DiaereseElement must not be null");
        }
    }
}
