package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSealed.Deserializer.class)
@JsonSerialize(using = UnionSealed.Serializer.class)
public class UnionSealed {
    public Double doubleValue;
    public Sealed sealedValue;

    static class Deserializer extends JsonDeserializer<UnionSealed> {
        @Override
        public UnionSealed deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSealed value = new UnionSealed();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.sealedValue = jsonParser.readValueAs(Sealed.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSealed");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSealed> {
        @Override
        public void serialize(UnionSealed obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.sealedValue != null) {
                jsonGenerator.writeObject(obj.sealedValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
