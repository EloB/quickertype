package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Entomoid.Deserializer.class)
@JsonSerialize(using = Entomoid.Serializer.class)
public class Entomoid {
    public CimeliaClass cimeliaClassValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<Entomoid> {
        @Override
        public Entomoid deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Entomoid value = new Entomoid();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_OBJECT:
                    value.cimeliaClassValue = jsonParser.readValueAs(CimeliaClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Entomoid");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Entomoid> {
        @Override
        public void serialize(Entomoid obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.cimeliaClassValue != null) {
                jsonGenerator.writeObject(obj.cimeliaClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("Entomoid must not be null");
        }
    }
}
