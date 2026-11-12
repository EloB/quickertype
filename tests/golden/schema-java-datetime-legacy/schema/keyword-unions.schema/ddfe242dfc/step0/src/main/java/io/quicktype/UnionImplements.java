package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionImplements.Deserializer.class)
@JsonSerialize(using = UnionImplements.Serializer.class)
public class UnionImplements {
    public Double doubleValue;
    public Implements implementsValue;

    static class Deserializer extends JsonDeserializer<UnionImplements> {
        @Override
        public UnionImplements deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionImplements value = new UnionImplements();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.implementsValue = jsonParser.readValueAs(Implements.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionImplements");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionImplements> {
        @Override
        public void serialize(UnionImplements obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.implementsValue != null) {
                jsonGenerator.writeObject(obj.implementsValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
