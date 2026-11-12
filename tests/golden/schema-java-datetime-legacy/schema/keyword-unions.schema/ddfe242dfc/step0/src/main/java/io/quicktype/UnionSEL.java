package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSEL.Deserializer.class)
@JsonSerialize(using = UnionSEL.Serializer.class)
public class UnionSEL {
    public Double doubleValue;
    public Sel selValue;

    static class Deserializer extends JsonDeserializer<UnionSEL> {
        @Override
        public UnionSEL deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSEL value = new UnionSEL();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.selValue = jsonParser.readValueAs(Sel.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSEL");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSEL> {
        @Override
        public void serialize(UnionSEL obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.selValue != null) {
                jsonGenerator.writeObject(obj.selValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
