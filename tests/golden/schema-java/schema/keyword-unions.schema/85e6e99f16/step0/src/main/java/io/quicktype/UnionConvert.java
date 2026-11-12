package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionConvert.Deserializer.class)
@JsonSerialize(using = UnionConvert.Serializer.class)
public class UnionConvert {
    public Double doubleValue;
    public Convert convertValue;

    static class Deserializer extends JsonDeserializer<UnionConvert> {
        @Override
        public UnionConvert deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionConvert value = new UnionConvert();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.convertValue = jsonParser.readValueAs(Convert.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionConvert");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionConvert> {
        @Override
        public void serialize(UnionConvert obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.convertValue != null) {
                jsonGenerator.writeObject(obj.convertValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
