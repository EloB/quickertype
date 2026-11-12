package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Rhomboganoidei.Deserializer.class)
@JsonSerialize(using = Rhomboganoidei.Serializer.class)
public class Rhomboganoidei {
    public long[] integerArrayValue;
    public Rebecca rebeccaValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Rhomboganoidei> {
        @Override
        public Rhomboganoidei deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Rhomboganoidei value = new Rhomboganoidei();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(long[].class);
                    break;
                case START_OBJECT:
                    value.rebeccaValue = jsonParser.readValueAs(Rebecca.class);
                    break;
                default: throw new IOException("Cannot deserialize Rhomboganoidei");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Rhomboganoidei> {
        @Override
        public void serialize(Rhomboganoidei obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.rebeccaValue != null) {
                jsonGenerator.writeObject(obj.rebeccaValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Rhomboganoidei must not be null");
        }
    }
}
