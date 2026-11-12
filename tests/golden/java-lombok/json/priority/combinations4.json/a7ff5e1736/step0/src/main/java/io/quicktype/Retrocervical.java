package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Retrocervical.Deserializer.class)
@JsonSerialize(using = Retrocervical.Serializer.class)
public class Retrocervical {
    public Long[] unionArrayValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<Retrocervical> {
        @Override
        public Retrocervical deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Retrocervical value = new Retrocervical();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_ARRAY:
                    value.unionArrayValue = jsonParser.readValueAs(Long[].class);
                    break;
                default: throw new IOException("Cannot deserialize Retrocervical");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Retrocervical> {
        @Override
        public void serialize(Retrocervical obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.unionArrayValue != null) {
                jsonGenerator.writeObject(obj.unionArrayValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("Retrocervical must not be null");
        }
    }
}
