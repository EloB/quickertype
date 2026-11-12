package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionExposing.Deserializer.class)
@JsonSerialize(using = UnionExposing.Serializer.class)
public class UnionExposing {
    public Double doubleValue;
    public Exposing exposingValue;

    static class Deserializer extends JsonDeserializer<UnionExposing> {
        @Override
        public UnionExposing deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionExposing value = new UnionExposing();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.exposingValue = jsonParser.readValueAs(Exposing.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionExposing");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionExposing> {
        @Override
        public void serialize(UnionExposing obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.exposingValue != null) {
                jsonGenerator.writeObject(obj.exposingValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
