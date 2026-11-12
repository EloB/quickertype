package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDynamic.Deserializer.class)
@JsonSerialize(using = UnionDynamic.Serializer.class)
public class UnionDynamic {
    public Double doubleValue;
    public Dynamic dynamicValue;

    static class Deserializer extends JsonDeserializer<UnionDynamic> {
        @Override
        public UnionDynamic deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDynamic value = new UnionDynamic();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.dynamicValue = jsonParser.readValueAs(Dynamic.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDynamic");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDynamic> {
        @Override
        public void serialize(UnionDynamic obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dynamicValue != null) {
                jsonGenerator.writeObject(obj.dynamicValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
