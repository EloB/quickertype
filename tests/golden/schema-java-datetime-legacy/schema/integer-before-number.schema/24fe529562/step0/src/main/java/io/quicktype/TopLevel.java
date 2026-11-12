package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

/**
 * An integer or non-integer number
 */
@JsonDeserialize(using = TopLevel.Deserializer.class)
@JsonSerialize(using = TopLevel.Serializer.class)
public class TopLevel {
    public Double doubleValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<TopLevel> {
        @Override
        public TopLevel deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            TopLevel value = new TopLevel();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                default: throw new IOException("Cannot deserialize TopLevel");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<TopLevel> {
        @Override
        public void serialize(TopLevel obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("TopLevel must not be null");
        }
    }
}
