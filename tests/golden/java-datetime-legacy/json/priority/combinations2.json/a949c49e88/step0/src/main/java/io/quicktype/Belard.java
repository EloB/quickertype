package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Belard.Deserializer.class)
@JsonSerialize(using = Belard.Serializer.class)
public class Belard {
    public long[] integerArrayValue;
    public Rebecca rebeccaValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<Belard> {
        @Override
        public Belard deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Belard value = new Belard();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(long[].class);
                    break;
                case START_OBJECT:
                    value.rebeccaValue = jsonParser.readValueAs(Rebecca.class);
                    break;
                default: throw new IOException("Cannot deserialize Belard");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Belard> {
        @Override
        public void serialize(Belard obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.rebeccaValue != null) {
                jsonGenerator.writeObject(obj.rebeccaValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("Belard must not be null");
        }
    }
}
