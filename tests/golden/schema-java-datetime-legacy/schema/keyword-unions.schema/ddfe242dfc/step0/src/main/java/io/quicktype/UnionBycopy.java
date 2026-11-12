package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionBycopy.Deserializer.class)
@JsonSerialize(using = UnionBycopy.Serializer.class)
public class UnionBycopy {
    public Double doubleValue;
    public Bycopy bycopyValue;

    static class Deserializer extends JsonDeserializer<UnionBycopy> {
        @Override
        public UnionBycopy deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionBycopy value = new UnionBycopy();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.bycopyValue = jsonParser.readValueAs(Bycopy.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionBycopy");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionBycopy> {
        @Override
        public void serialize(UnionBycopy obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.bycopyValue != null) {
                jsonGenerator.writeObject(obj.bycopyValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
