package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDateOnlyConverter.Deserializer.class)
@JsonSerialize(using = UnionDateOnlyConverter.Serializer.class)
public class UnionDateOnlyConverter {
    public Double doubleValue;
    public DateOnlyConverter dateOnlyConverterValue;

    static class Deserializer extends JsonDeserializer<UnionDateOnlyConverter> {
        @Override
        public UnionDateOnlyConverter deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDateOnlyConverter value = new UnionDateOnlyConverter();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.dateOnlyConverterValue = jsonParser.readValueAs(DateOnlyConverter.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDateOnlyConverter");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDateOnlyConverter> {
        @Override
        public void serialize(UnionDateOnlyConverter obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dateOnlyConverterValue != null) {
                jsonGenerator.writeObject(obj.dateOnlyConverterValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
