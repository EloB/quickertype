package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = AnsarieElement.Deserializer.class)
@JsonSerialize(using = AnsarieElement.Serializer.class)
public class AnsarieElement {
    public List<Long> integerArrayValue;
    public AnsarieClass ansarieClassValue;

    static class Deserializer extends JsonDeserializer<AnsarieElement> {
        @Override
        public AnsarieElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            AnsarieElement value = new AnsarieElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.ansarieClassValue = jsonParser.readValueAs(AnsarieClass.class);
                    break;
                default: throw new IOException("Cannot deserialize AnsarieElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<AnsarieElement> {
        @Override
        public void serialize(AnsarieElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.ansarieClassValue != null) {
                jsonGenerator.writeObject(obj.ansarieClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
