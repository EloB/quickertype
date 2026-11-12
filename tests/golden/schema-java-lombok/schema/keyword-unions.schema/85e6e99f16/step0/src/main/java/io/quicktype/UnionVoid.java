package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionVoid.Deserializer.class)
@JsonSerialize(using = UnionVoid.Serializer.class)
public class UnionVoid {
    public Double doubleValue;
    public Void voidValue;

    static class Deserializer extends JsonDeserializer<UnionVoid> {
        @Override
        public UnionVoid deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionVoid value = new UnionVoid();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.voidValue = jsonParser.readValueAs(Void.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionVoid");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionVoid> {
        @Override
        public void serialize(UnionVoid obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.voidValue != null) {
                jsonGenerator.writeObject(obj.voidValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
