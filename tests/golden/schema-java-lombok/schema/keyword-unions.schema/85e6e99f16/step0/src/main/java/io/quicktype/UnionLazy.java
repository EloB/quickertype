package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionLazy.Deserializer.class)
@JsonSerialize(using = UnionLazy.Serializer.class)
public class UnionLazy {
    public Double doubleValue;
    public Lazy lazyValue;

    static class Deserializer extends JsonDeserializer<UnionLazy> {
        @Override
        public UnionLazy deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionLazy value = new UnionLazy();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.lazyValue = jsonParser.readValueAs(Lazy.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionLazy");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionLazy> {
        @Override
        public void serialize(UnionLazy obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.lazyValue != null) {
                jsonGenerator.writeObject(obj.lazyValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
