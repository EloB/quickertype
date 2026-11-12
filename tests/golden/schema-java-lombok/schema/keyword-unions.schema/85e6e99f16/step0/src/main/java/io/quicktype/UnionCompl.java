package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionCompl.Deserializer.class)
@JsonSerialize(using = UnionCompl.Serializer.class)
public class UnionCompl {
    public Double doubleValue;
    public Compl complValue;

    static class Deserializer extends JsonDeserializer<UnionCompl> {
        @Override
        public UnionCompl deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionCompl value = new UnionCompl();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.complValue = jsonParser.readValueAs(Compl.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionCompl");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionCompl> {
        @Override
        public void serialize(UnionCompl obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.complValue != null) {
                jsonGenerator.writeObject(obj.complValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
