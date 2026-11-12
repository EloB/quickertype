package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionVolatile.Deserializer.class)
@JsonSerialize(using = UnionVolatile.Serializer.class)
public class UnionVolatile {
    public Double doubleValue;
    public Volatile volatileValue;

    static class Deserializer extends JsonDeserializer<UnionVolatile> {
        @Override
        public UnionVolatile deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionVolatile value = new UnionVolatile();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.volatileValue = jsonParser.readValueAs(Volatile.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionVolatile");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionVolatile> {
        @Override
        public void serialize(UnionVolatile obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.volatileValue != null) {
                jsonGenerator.writeObject(obj.volatileValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
