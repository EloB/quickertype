package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNO.Deserializer.class)
@JsonSerialize(using = UnionNO.Serializer.class)
public class UnionNO {
    public Double doubleValue;
    public No noValue;

    static class Deserializer extends JsonDeserializer<UnionNO> {
        @Override
        public UnionNO deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNO value = new UnionNO();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.noValue = jsonParser.readValueAs(No.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNO");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNO> {
        @Override
        public void serialize(UnionNO obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.noValue != null) {
                jsonGenerator.writeObject(obj.noValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
