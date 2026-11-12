package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAlignas.Deserializer.class)
@JsonSerialize(using = UnionAlignas.Serializer.class)
public class UnionAlignas {
    public Double doubleValue;
    public Alignas alignasValue;

    static class Deserializer extends JsonDeserializer<UnionAlignas> {
        @Override
        public UnionAlignas deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAlignas value = new UnionAlignas();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.alignasValue = jsonParser.readValueAs(Alignas.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAlignas");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAlignas> {
        @Override
        public void serialize(UnionAlignas obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.alignasValue != null) {
                jsonGenerator.writeObject(obj.alignasValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
