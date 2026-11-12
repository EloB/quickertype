package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionProtocol.Deserializer.class)
@JsonSerialize(using = UnionProtocol.Serializer.class)
public class UnionProtocol {
    public Double doubleValue;
    public Protocol protocolValue;

    static class Deserializer extends JsonDeserializer<UnionProtocol> {
        @Override
        public UnionProtocol deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionProtocol value = new UnionProtocol();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.protocolValue = jsonParser.readValueAs(Protocol.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionProtocol");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionProtocol> {
        @Override
        public void serialize(UnionProtocol obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.protocolValue != null) {
                jsonGenerator.writeObject(obj.protocolValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
