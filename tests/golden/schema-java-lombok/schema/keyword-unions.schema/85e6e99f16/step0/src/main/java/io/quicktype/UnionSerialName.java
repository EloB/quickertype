package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSerialName.Deserializer.class)
@JsonSerialize(using = UnionSerialName.Serializer.class)
public class UnionSerialName {
    public Double doubleValue;
    public SerialName serialNameValue;

    static class Deserializer extends JsonDeserializer<UnionSerialName> {
        @Override
        public UnionSerialName deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSerialName value = new UnionSerialName();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.serialNameValue = jsonParser.readValueAs(SerialName.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSerialName");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSerialName> {
        @Override
        public void serialize(UnionSerialName obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.serialNameValue != null) {
                jsonGenerator.writeObject(obj.serialNameValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
