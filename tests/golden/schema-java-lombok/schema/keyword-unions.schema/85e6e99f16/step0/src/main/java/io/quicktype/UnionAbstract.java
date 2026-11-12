package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAbstract.Deserializer.class)
@JsonSerialize(using = UnionAbstract.Serializer.class)
public class UnionAbstract {
    public Double doubleValue;
    public Abstract abstractValue;

    static class Deserializer extends JsonDeserializer<UnionAbstract> {
        @Override
        public UnionAbstract deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAbstract value = new UnionAbstract();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.abstractValue = jsonParser.readValueAs(Abstract.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAbstract");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAbstract> {
        @Override
        public void serialize(UnionAbstract obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.abstractValue != null) {
                jsonGenerator.writeObject(obj.abstractValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
