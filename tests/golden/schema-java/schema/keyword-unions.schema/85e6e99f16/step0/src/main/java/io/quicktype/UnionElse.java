package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionElse.Deserializer.class)
@JsonSerialize(using = UnionElse.Serializer.class)
public class UnionElse {
    public Double doubleValue;
    public Else elseValue;

    static class Deserializer extends JsonDeserializer<UnionElse> {
        @Override
        public UnionElse deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionElse value = new UnionElse();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.elseValue = jsonParser.readValueAs(Else.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionElse");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionElse> {
        @Override
        public void serialize(UnionElse obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.elseValue != null) {
                jsonGenerator.writeObject(obj.elseValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
