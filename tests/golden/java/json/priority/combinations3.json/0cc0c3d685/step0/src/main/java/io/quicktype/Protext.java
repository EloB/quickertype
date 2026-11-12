package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Protext.Deserializer.class)
@JsonSerialize(using = Protext.Serializer.class)
public class Protext {
    public List<Long> integerArrayValue;
    public Boolean boolValue;
    public MonaziteClass monaziteClassValue;

    static class Deserializer extends JsonDeserializer<Protext> {
        @Override
        public Protext deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Protext value = new Protext();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.monaziteClassValue = jsonParser.readValueAs(MonaziteClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Protext");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Protext> {
        @Override
        public void serialize(Protext obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.monaziteClassValue != null) {
                jsonGenerator.writeObject(obj.monaziteClassValue);
                return;
            }
            throw new IOException("Protext must not be null");
        }
    }
}
