package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDateOnly.Deserializer.class)
@JsonSerialize(using = UnionDateOnly.Serializer.class)
public class UnionDateOnly {
    public Double doubleValue;
    public DateOnly dateOnlyValue;

    static class Deserializer extends JsonDeserializer<UnionDateOnly> {
        @Override
        public UnionDateOnly deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDateOnly value = new UnionDateOnly();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.dateOnlyValue = jsonParser.readValueAs(DateOnly.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDateOnly");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDateOnly> {
        @Override
        public void serialize(UnionDateOnly obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dateOnlyValue != null) {
                jsonGenerator.writeObject(obj.dateOnlyValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
