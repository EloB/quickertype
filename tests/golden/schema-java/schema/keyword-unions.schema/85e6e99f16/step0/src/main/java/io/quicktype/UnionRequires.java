package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionRequires.Deserializer.class)
@JsonSerialize(using = UnionRequires.Serializer.class)
public class UnionRequires {
    public Double doubleValue;
    public Requires requiresValue;

    static class Deserializer extends JsonDeserializer<UnionRequires> {
        @Override
        public UnionRequires deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionRequires value = new UnionRequires();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.requiresValue = jsonParser.readValueAs(Requires.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionRequires");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionRequires> {
        @Override
        public void serialize(UnionRequires obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.requiresValue != null) {
                jsonGenerator.writeObject(obj.requiresValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
