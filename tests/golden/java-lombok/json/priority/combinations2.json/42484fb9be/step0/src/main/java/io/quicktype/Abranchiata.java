package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Abranchiata.Deserializer.class)
@JsonSerialize(using = Abranchiata.Serializer.class)
public class Abranchiata {
    public long[] integerArrayValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<Abranchiata> {
        @Override
        public Abranchiata deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Abranchiata value = new Abranchiata();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(long[].class);
                    break;
                default: throw new IOException("Cannot deserialize Abranchiata");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Abranchiata> {
        @Override
        public void serialize(Abranchiata obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
