package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = ChytridiaceaeElement.Deserializer.class)
@JsonSerialize(using = ChytridiaceaeElement.Serializer.class)
public class ChytridiaceaeElement {
    public Boolean boolValue;
    public ChytridiaceaeClass chytridiaceaeClassValue;

    static class Deserializer extends JsonDeserializer<ChytridiaceaeElement> {
        @Override
        public ChytridiaceaeElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            ChytridiaceaeElement value = new ChytridiaceaeElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.chytridiaceaeClassValue = jsonParser.readValueAs(ChytridiaceaeClass.class);
                    break;
                default: throw new IOException("Cannot deserialize ChytridiaceaeElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<ChytridiaceaeElement> {
        @Override
        public void serialize(ChytridiaceaeElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.chytridiaceaeClassValue != null) {
                jsonGenerator.writeObject(obj.chytridiaceaeClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
