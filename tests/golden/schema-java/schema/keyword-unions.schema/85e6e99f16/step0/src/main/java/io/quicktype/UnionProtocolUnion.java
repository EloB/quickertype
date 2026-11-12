package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionProtocolUnion.Deserializer.class)
@JsonSerialize(using = UnionProtocolUnion.Serializer.class)
public class UnionProtocolUnion {
    public Double doubleValue;
    public ProtocolClass protocolClassValue;

    static class Deserializer extends JsonDeserializer<UnionProtocolUnion> {
        @Override
        public UnionProtocolUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionProtocolUnion value = new UnionProtocolUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.protocolClassValue = jsonParser.readValueAs(ProtocolClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionProtocolUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionProtocolUnion> {
        @Override
        public void serialize(UnionProtocolUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.protocolClassValue != null) {
                jsonGenerator.writeObject(obj.protocolClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
