package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionISODateTimeOffsetConverter.Deserializer.class)
@JsonSerialize(using = UnionISODateTimeOffsetConverter.Serializer.class)
public class UnionISODateTimeOffsetConverter {
    public Double doubleValue;
    public ISODateTimeOffsetConverter isoDateTimeOffsetConverterValue;

    static class Deserializer extends JsonDeserializer<UnionISODateTimeOffsetConverter> {
        @Override
        public UnionISODateTimeOffsetConverter deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionISODateTimeOffsetConverter value = new UnionISODateTimeOffsetConverter();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.isoDateTimeOffsetConverterValue = jsonParser.readValueAs(ISODateTimeOffsetConverter.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionISODateTimeOffsetConverter");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionISODateTimeOffsetConverter> {
        @Override
        public void serialize(UnionISODateTimeOffsetConverter obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.isoDateTimeOffsetConverterValue != null) {
                jsonGenerator.writeObject(obj.isoDateTimeOffsetConverterValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
