package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTimeOnly.Deserializer.class)
@JsonSerialize(using = UnionTimeOnly.Serializer.class)
public class UnionTimeOnly {
    public Double doubleValue;
    public TimeOnly timeOnlyValue;

    static class Deserializer extends JsonDeserializer<UnionTimeOnly> {
        @Override
        public UnionTimeOnly deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTimeOnly value = new UnionTimeOnly();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.timeOnlyValue = jsonParser.readValueAs(TimeOnly.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTimeOnly");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTimeOnly> {
        @Override
        public void serialize(UnionTimeOnly obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.timeOnlyValue != null) {
                jsonGenerator.writeObject(obj.timeOnlyValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
