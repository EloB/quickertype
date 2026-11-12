package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionOffsetTime.Deserializer.class)
@JsonSerialize(using = UnionOffsetTime.Serializer.class)
public class UnionOffsetTime {
    public Double doubleValue;
    public OffsetTimeClass offsetTimeClassValue;

    static class Deserializer extends JsonDeserializer<UnionOffsetTime> {
        @Override
        public UnionOffsetTime deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionOffsetTime value = new UnionOffsetTime();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.offsetTimeClassValue = jsonParser.readValueAs(OffsetTimeClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionOffsetTime");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionOffsetTime> {
        @Override
        public void serialize(UnionOffsetTime obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.offsetTimeClassValue != null) {
                jsonGenerator.writeObject(obj.offsetTimeClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
