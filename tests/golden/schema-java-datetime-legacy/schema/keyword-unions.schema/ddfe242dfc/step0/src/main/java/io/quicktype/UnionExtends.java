package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionExtends.Deserializer.class)
@JsonSerialize(using = UnionExtends.Serializer.class)
public class UnionExtends {
    public Double doubleValue;
    public Extends extendsValue;

    static class Deserializer extends JsonDeserializer<UnionExtends> {
        @Override
        public UnionExtends deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionExtends value = new UnionExtends();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.extendsValue = jsonParser.readValueAs(Extends.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionExtends");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionExtends> {
        @Override
        public void serialize(UnionExtends obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.extendsValue != null) {
                jsonGenerator.writeObject(obj.extendsValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
