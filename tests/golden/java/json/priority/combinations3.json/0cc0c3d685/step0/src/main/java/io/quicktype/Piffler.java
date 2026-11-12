package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Piffler.Deserializer.class)
@JsonSerialize(using = Piffler.Serializer.class)
public class Piffler {
    public List<Object> nullArrayValue;
    public MonaziteClass monaziteClassValue;

    static class Deserializer extends JsonDeserializer<Piffler> {
        @Override
        public Piffler deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Piffler value = new Piffler();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(new TypeReference<List<Object>>() {});
                    break;
                case START_OBJECT:
                    value.monaziteClassValue = jsonParser.readValueAs(MonaziteClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Piffler");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Piffler> {
        @Override
        public void serialize(Piffler obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.monaziteClassValue != null) {
                jsonGenerator.writeObject(obj.monaziteClassValue);
                return;
            }
            throw new IOException("Piffler must not be null");
        }
    }
}
