package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionConstCast.Deserializer.class)
@JsonSerialize(using = UnionConstCast.Serializer.class)
public class UnionConstCast {
    public Double doubleValue;
    public ConstCast constCastValue;

    static class Deserializer extends JsonDeserializer<UnionConstCast> {
        @Override
        public UnionConstCast deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionConstCast value = new UnionConstCast();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.constCastValue = jsonParser.readValueAs(ConstCast.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionConstCast");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionConstCast> {
        @Override
        public void serialize(UnionConstCast obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.constCastValue != null) {
                jsonGenerator.writeObject(obj.constCastValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
