package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSerialDescriptor.Deserializer.class)
@JsonSerialize(using = UnionSerialDescriptor.Serializer.class)
public class UnionSerialDescriptor {
    public Double doubleValue;
    public SerialDescriptor serialDescriptorValue;

    static class Deserializer extends JsonDeserializer<UnionSerialDescriptor> {
        @Override
        public UnionSerialDescriptor deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSerialDescriptor value = new UnionSerialDescriptor();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.serialDescriptorValue = jsonParser.readValueAs(SerialDescriptor.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSerialDescriptor");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSerialDescriptor> {
        @Override
        public void serialize(UnionSerialDescriptor obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.serialDescriptorValue != null) {
                jsonGenerator.writeObject(obj.serialDescriptorValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
