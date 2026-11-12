package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTimeOnlyConverter.Deserializer.class)
@JsonSerialize(using = UnionTimeOnlyConverter.Serializer.class)
public class UnionTimeOnlyConverter {
    public Double doubleValue;
    public TimeOnlyConverter timeOnlyConverterValue;

    static class Deserializer extends JsonDeserializer<UnionTimeOnlyConverter> {
        @Override
        public UnionTimeOnlyConverter deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTimeOnlyConverter value = new UnionTimeOnlyConverter();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.timeOnlyConverterValue = jsonParser.readValueAs(TimeOnlyConverter.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTimeOnlyConverter");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTimeOnlyConverter> {
        @Override
        public void serialize(UnionTimeOnlyConverter obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.timeOnlyConverterValue != null) {
                jsonGenerator.writeObject(obj.timeOnlyConverterValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
