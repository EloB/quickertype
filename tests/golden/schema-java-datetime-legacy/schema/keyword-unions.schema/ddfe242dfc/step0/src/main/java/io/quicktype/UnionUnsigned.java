package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUnsigned.Deserializer.class)
@JsonSerialize(using = UnionUnsigned.Serializer.class)
public class UnionUnsigned {
    public Double doubleValue;
    public Unsigned unsignedValue;

    static class Deserializer extends JsonDeserializer<UnionUnsigned> {
        @Override
        public UnionUnsigned deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUnsigned value = new UnionUnsigned();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.unsignedValue = jsonParser.readValueAs(Unsigned.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUnsigned");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUnsigned> {
        @Override
        public void serialize(UnionUnsigned obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.unsignedValue != null) {
                jsonGenerator.writeObject(obj.unsignedValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
