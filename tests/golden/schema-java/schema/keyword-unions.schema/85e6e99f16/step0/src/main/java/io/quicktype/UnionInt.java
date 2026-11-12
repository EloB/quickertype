package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionInt.Deserializer.class)
@JsonSerialize(using = UnionInt.Serializer.class)
public class UnionInt {
    public Double doubleValue;
    public Int intValue;

    static class Deserializer extends JsonDeserializer<UnionInt> {
        @Override
        public UnionInt deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionInt value = new UnionInt();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.intValue = jsonParser.readValueAs(Int.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionInt");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionInt> {
        @Override
        public void serialize(UnionInt obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.intValue != null) {
                jsonGenerator.writeObject(obj.intValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
