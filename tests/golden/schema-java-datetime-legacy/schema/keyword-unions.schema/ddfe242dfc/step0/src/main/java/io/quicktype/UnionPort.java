package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionPort.Deserializer.class)
@JsonSerialize(using = UnionPort.Serializer.class)
public class UnionPort {
    public Double doubleValue;
    public Port portValue;

    static class Deserializer extends JsonDeserializer<UnionPort> {
        @Override
        public UnionPort deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionPort value = new UnionPort();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.portValue = jsonParser.readValueAs(Port.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionPort");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionPort> {
        @Override
        public void serialize(UnionPort obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.portValue != null) {
                jsonGenerator.writeObject(obj.portValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
