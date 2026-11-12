package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Aphasia.Deserializer.class)
@JsonSerialize(using = Aphasia.Serializer.class)
public class Aphasia {
    public long[] integerArrayValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<Aphasia> {
        @Override
        public Aphasia deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Aphasia value = new Aphasia();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(long[].class);
                    break;
                default: throw new IOException("Cannot deserialize Aphasia");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Aphasia> {
        @Override
        public void serialize(Aphasia obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("Aphasia must not be null");
        }
    }
}
