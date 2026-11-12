package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionStaticCast.Deserializer.class)
@JsonSerialize(using = UnionStaticCast.Serializer.class)
public class UnionStaticCast {
    public Double doubleValue;
    public StaticCast staticCastValue;

    static class Deserializer extends JsonDeserializer<UnionStaticCast> {
        @Override
        public UnionStaticCast deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionStaticCast value = new UnionStaticCast();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.staticCastValue = jsonParser.readValueAs(StaticCast.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionStaticCast");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionStaticCast> {
        @Override
        public void serialize(UnionStaticCast obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.staticCastValue != null) {
                jsonGenerator.writeObject(obj.staticCastValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
