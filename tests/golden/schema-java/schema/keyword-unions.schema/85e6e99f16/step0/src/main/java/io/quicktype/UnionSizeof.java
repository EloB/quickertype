package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSizeof.Deserializer.class)
@JsonSerialize(using = UnionSizeof.Serializer.class)
public class UnionSizeof {
    public Double doubleValue;
    public Sizeof sizeofValue;

    static class Deserializer extends JsonDeserializer<UnionSizeof> {
        @Override
        public UnionSizeof deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSizeof value = new UnionSizeof();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.sizeofValue = jsonParser.readValueAs(Sizeof.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSizeof");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSizeof> {
        @Override
        public void serialize(UnionSizeof obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.sizeofValue != null) {
                jsonGenerator.writeObject(obj.sizeofValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
