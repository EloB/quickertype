package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDateParseHandling.Deserializer.class)
@JsonSerialize(using = UnionDateParseHandling.Serializer.class)
public class UnionDateParseHandling {
    public Double doubleValue;
    public DateParseHandling dateParseHandlingValue;

    static class Deserializer extends JsonDeserializer<UnionDateParseHandling> {
        @Override
        public UnionDateParseHandling deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDateParseHandling value = new UnionDateParseHandling();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.dateParseHandlingValue = jsonParser.readValueAs(DateParseHandling.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDateParseHandling");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDateParseHandling> {
        @Override
        public void serialize(UnionDateParseHandling obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dateParseHandlingValue != null) {
                jsonGenerator.writeObject(obj.dateParseHandlingValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
