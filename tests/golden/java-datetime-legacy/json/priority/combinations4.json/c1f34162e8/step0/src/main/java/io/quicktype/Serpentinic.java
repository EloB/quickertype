package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Serpentinic.Deserializer.class)
@JsonSerialize(using = Serpentinic.Serializer.class)
public class Serpentinic {
    public List<Long> integerArrayValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<Serpentinic> {
        @Override
        public Serpentinic deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Serpentinic value = new Serpentinic();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                default: throw new IOException("Cannot deserialize Serpentinic");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Serpentinic> {
        @Override
        public void serialize(Serpentinic obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("Serpentinic must not be null");
        }
    }
}
