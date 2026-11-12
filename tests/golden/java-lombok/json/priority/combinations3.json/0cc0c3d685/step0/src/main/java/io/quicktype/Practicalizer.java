package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Practicalizer.Deserializer.class)
@JsonSerialize(using = Practicalizer.Serializer.class)
public class Practicalizer {
    public List<Object> nullArrayValue;
    public MonaziteClass monaziteClassValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Practicalizer> {
        @Override
        public Practicalizer deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Practicalizer value = new Practicalizer();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(new TypeReference<List<Object>>() {});
                    break;
                case START_OBJECT:
                    value.monaziteClassValue = jsonParser.readValueAs(MonaziteClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Practicalizer");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Practicalizer> {
        @Override
        public void serialize(Practicalizer obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.monaziteClassValue != null) {
                jsonGenerator.writeObject(obj.monaziteClassValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Practicalizer must not be null");
        }
    }
}
