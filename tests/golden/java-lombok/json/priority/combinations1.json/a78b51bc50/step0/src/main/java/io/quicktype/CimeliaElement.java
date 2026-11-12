package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = CimeliaElement.Deserializer.class)
@JsonSerialize(using = CimeliaElement.Serializer.class)
public class CimeliaElement {
    public List<Long> integerArrayValue;
    public CimeliaClass cimeliaClassValue;

    static class Deserializer extends JsonDeserializer<CimeliaElement> {
        @Override
        public CimeliaElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            CimeliaElement value = new CimeliaElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.cimeliaClassValue = jsonParser.readValueAs(CimeliaClass.class);
                    break;
                default: throw new IOException("Cannot deserialize CimeliaElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<CimeliaElement> {
        @Override
        public void serialize(CimeliaElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.cimeliaClassValue != null) {
                jsonGenerator.writeObject(obj.cimeliaClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
