package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDateTime.Deserializer.class)
@JsonSerialize(using = UnionDateTime.Serializer.class)
public class UnionDateTime {
    public Double doubleValue;
    public DateTime dateTimeValue;

    static class Deserializer extends JsonDeserializer<UnionDateTime> {
        @Override
        public UnionDateTime deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDateTime value = new UnionDateTime();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.dateTimeValue = jsonParser.readValueAs(DateTime.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDateTime");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDateTime> {
        @Override
        public void serialize(UnionDateTime obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dateTimeValue != null) {
                jsonGenerator.writeObject(obj.dateTimeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
