package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUndefined.Deserializer.class)
@JsonSerialize(using = UnionUndefined.Serializer.class)
public class UnionUndefined {
    public Double doubleValue;
    public Undefined undefinedValue;

    static class Deserializer extends JsonDeserializer<UnionUndefined> {
        @Override
        public UnionUndefined deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUndefined value = new UnionUndefined();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.undefinedValue = jsonParser.readValueAs(Undefined.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUndefined");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUndefined> {
        @Override
        public void serialize(UnionUndefined obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.undefinedValue != null) {
                jsonGenerator.writeObject(obj.undefinedValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
