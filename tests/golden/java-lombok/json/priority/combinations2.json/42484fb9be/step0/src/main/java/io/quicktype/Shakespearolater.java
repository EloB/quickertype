package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Shakespearolater.Deserializer.class)
@JsonSerialize(using = Shakespearolater.Serializer.class)
public class Shakespearolater {
    public long[] integerArrayValue;
    public Double doubleValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Shakespearolater> {
        @Override
        public Shakespearolater deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Shakespearolater value = new Shakespearolater();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(long[].class);
                    break;
                default: throw new IOException("Cannot deserialize Shakespearolater");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Shakespearolater> {
        @Override
        public void serialize(Shakespearolater obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Shakespearolater must not be null");
        }
    }
}
