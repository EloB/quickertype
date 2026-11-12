package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionRange.Deserializer.class)
@JsonSerialize(using = UnionRange.Serializer.class)
public class UnionRange {
    public Double doubleValue;
    public Range rangeValue;

    static class Deserializer extends JsonDeserializer<UnionRange> {
        @Override
        public UnionRange deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionRange value = new UnionRange();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.rangeValue = jsonParser.readValueAs(Range.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionRange");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionRange> {
        @Override
        public void serialize(UnionRange obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.rangeValue != null) {
                jsonGenerator.writeObject(obj.rangeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
