package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Hyperpiesi.Deserializer.class)
@JsonSerialize(using = Hyperpiesi.Serializer.class)
public class Hyperpiesi {
    public List<Object> nullArrayValue;
    public CimeliaClass cimeliaClassValue;

    static class Deserializer extends JsonDeserializer<Hyperpiesi> {
        @Override
        public Hyperpiesi deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Hyperpiesi value = new Hyperpiesi();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(new TypeReference<List<Object>>() {});
                    break;
                case START_OBJECT:
                    value.cimeliaClassValue = jsonParser.readValueAs(CimeliaClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Hyperpiesi");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Hyperpiesi> {
        @Override
        public void serialize(Hyperpiesi obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.cimeliaClassValue != null) {
                jsonGenerator.writeObject(obj.cimeliaClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
