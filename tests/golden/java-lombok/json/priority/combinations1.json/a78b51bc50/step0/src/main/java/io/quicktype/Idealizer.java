package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Idealizer.Deserializer.class)
@JsonSerialize(using = Idealizer.Serializer.class)
public class Idealizer {
    public List<Object> nullArrayValue;
    public CimeliaClass cimeliaClassValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<Idealizer> {
        @Override
        public Idealizer deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Idealizer value = new Idealizer();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(new TypeReference<List<Object>>() {});
                    break;
                case START_OBJECT:
                    value.cimeliaClassValue = jsonParser.readValueAs(CimeliaClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Idealizer");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Idealizer> {
        @Override
        public void serialize(Idealizer obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.cimeliaClassValue != null) {
                jsonGenerator.writeObject(obj.cimeliaClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("Idealizer must not be null");
        }
    }
}
