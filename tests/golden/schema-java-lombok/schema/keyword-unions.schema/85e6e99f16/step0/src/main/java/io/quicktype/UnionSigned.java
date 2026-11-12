package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSigned.Deserializer.class)
@JsonSerialize(using = UnionSigned.Serializer.class)
public class UnionSigned {
    public Double doubleValue;
    public Signed signedValue;

    static class Deserializer extends JsonDeserializer<UnionSigned> {
        @Override
        public UnionSigned deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSigned value = new UnionSigned();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.signedValue = jsonParser.readValueAs(Signed.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSigned");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSigned> {
        @Override
        public void serialize(UnionSigned obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.signedValue != null) {
                jsonGenerator.writeObject(obj.signedValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
