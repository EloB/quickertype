package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Prevoidance.Deserializer.class)
@JsonSerialize(using = Prevoidance.Serializer.class)
public class Prevoidance {
    public List<Long> integerArrayValue;
    public MonaziteClass monaziteClassValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<Prevoidance> {
        @Override
        public Prevoidance deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Prevoidance value = new Prevoidance();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.monaziteClassValue = jsonParser.readValueAs(MonaziteClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Prevoidance");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Prevoidance> {
        @Override
        public void serialize(Prevoidance obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.monaziteClassValue != null) {
                jsonGenerator.writeObject(obj.monaziteClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("Prevoidance must not be null");
        }
    }
}
