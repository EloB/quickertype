package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionVirtual.Deserializer.class)
@JsonSerialize(using = UnionVirtual.Serializer.class)
public class UnionVirtual {
    public Double doubleValue;
    public Virtual virtualValue;

    static class Deserializer extends JsonDeserializer<UnionVirtual> {
        @Override
        public UnionVirtual deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionVirtual value = new UnionVirtual();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.virtualValue = jsonParser.readValueAs(Virtual.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionVirtual");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionVirtual> {
        @Override
        public void serialize(UnionVirtual obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.virtualValue != null) {
                jsonGenerator.writeObject(obj.virtualValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
