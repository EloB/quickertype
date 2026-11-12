package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Mulishly.Deserializer.class)
@JsonSerialize(using = Mulishly.Serializer.class)
public class Mulishly {
    public List<Long> integerArrayValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<Mulishly> {
        @Override
        public Mulishly deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Mulishly value = new Mulishly();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                default: throw new IOException("Cannot deserialize Mulishly");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Mulishly> {
        @Override
        public void serialize(Mulishly obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
