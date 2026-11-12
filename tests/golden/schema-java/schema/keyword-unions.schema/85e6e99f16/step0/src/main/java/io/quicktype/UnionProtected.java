package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionProtected.Deserializer.class)
@JsonSerialize(using = UnionProtected.Serializer.class)
public class UnionProtected {
    public Double doubleValue;
    public Protected protectedValue;

    static class Deserializer extends JsonDeserializer<UnionProtected> {
        @Override
        public UnionProtected deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionProtected value = new UnionProtected();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.protectedValue = jsonParser.readValueAs(Protected.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionProtected");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionProtected> {
        @Override
        public void serialize(UnionProtected obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.protectedValue != null) {
                jsonGenerator.writeObject(obj.protectedValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
