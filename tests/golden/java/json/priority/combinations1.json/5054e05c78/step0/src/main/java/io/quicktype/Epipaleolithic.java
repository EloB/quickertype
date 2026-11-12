package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Epipaleolithic.Deserializer.class)
@JsonSerialize(using = Epipaleolithic.Serializer.class)
public class Epipaleolithic {
    public long[] integerArrayValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<Epipaleolithic> {
        @Override
        public Epipaleolithic deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Epipaleolithic value = new Epipaleolithic();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(long[].class);
                    break;
                default: throw new IOException("Cannot deserialize Epipaleolithic");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Epipaleolithic> {
        @Override
        public void serialize(Epipaleolithic obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("Epipaleolithic must not be null");
        }
    }
}
