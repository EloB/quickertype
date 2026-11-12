package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionIndirect.Deserializer.class)
@JsonSerialize(using = UnionIndirect.Serializer.class)
public class UnionIndirect {
    public Double doubleValue;
    public Indirect indirectValue;

    static class Deserializer extends JsonDeserializer<UnionIndirect> {
        @Override
        public UnionIndirect deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionIndirect value = new UnionIndirect();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.indirectValue = jsonParser.readValueAs(Indirect.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionIndirect");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionIndirect> {
        @Override
        public void serialize(UnionIndirect obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.indirectValue != null) {
                jsonGenerator.writeObject(obj.indirectValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
