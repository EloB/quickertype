package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAny.Deserializer.class)
@JsonSerialize(using = UnionAny.Serializer.class)
public class UnionAny {
    public Double doubleValue;
    public Any anyValue;

    static class Deserializer extends JsonDeserializer<UnionAny> {
        @Override
        public UnionAny deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAny value = new UnionAny();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.anyValue = jsonParser.readValueAs(Any.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAny");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAny> {
        @Override
        public void serialize(UnionAny obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.anyValue != null) {
                jsonGenerator.writeObject(obj.anyValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
