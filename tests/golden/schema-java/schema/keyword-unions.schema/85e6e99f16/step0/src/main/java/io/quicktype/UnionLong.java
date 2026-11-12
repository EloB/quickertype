package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionLong.Deserializer.class)
@JsonSerialize(using = UnionLong.Serializer.class)
public class UnionLong {
    public Double doubleValue;
    public LongClass longClassValue;

    static class Deserializer extends JsonDeserializer<UnionLong> {
        @Override
        public UnionLong deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionLong value = new UnionLong();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.longClassValue = jsonParser.readValueAs(LongClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionLong");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionLong> {
        @Override
        public void serialize(UnionLong obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.longClassValue != null) {
                jsonGenerator.writeObject(obj.longClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
