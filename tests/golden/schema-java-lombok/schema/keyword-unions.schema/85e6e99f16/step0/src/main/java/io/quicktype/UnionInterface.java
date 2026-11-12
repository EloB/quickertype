package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionInterface.Deserializer.class)
@JsonSerialize(using = UnionInterface.Serializer.class)
public class UnionInterface {
    public Double doubleValue;
    public Interface interfaceValue;

    static class Deserializer extends JsonDeserializer<UnionInterface> {
        @Override
        public UnionInterface deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionInterface value = new UnionInterface();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.interfaceValue = jsonParser.readValueAs(Interface.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionInterface");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionInterface> {
        @Override
        public void serialize(UnionInterface obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.interfaceValue != null) {
                jsonGenerator.writeObject(obj.interfaceValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
