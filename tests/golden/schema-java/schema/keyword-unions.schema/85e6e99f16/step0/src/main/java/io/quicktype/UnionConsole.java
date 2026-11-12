package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionConsole.Deserializer.class)
@JsonSerialize(using = UnionConsole.Serializer.class)
public class UnionConsole {
    public Double doubleValue;
    public Console consoleValue;

    static class Deserializer extends JsonDeserializer<UnionConsole> {
        @Override
        public UnionConsole deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionConsole value = new UnionConsole();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.consoleValue = jsonParser.readValueAs(Console.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionConsole");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionConsole> {
        @Override
        public void serialize(UnionConsole obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.consoleValue != null) {
                jsonGenerator.writeObject(obj.consoleValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
