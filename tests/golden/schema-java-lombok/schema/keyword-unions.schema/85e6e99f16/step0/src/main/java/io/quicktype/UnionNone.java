package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNone.Deserializer.class)
@JsonSerialize(using = UnionNone.Serializer.class)
public class UnionNone {
    public Double doubleValue;
    public NoneClass noneClassValue;

    static class Deserializer extends JsonDeserializer<UnionNone> {
        @Override
        public UnionNone deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNone value = new UnionNone();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.noneClassValue = jsonParser.readValueAs(NoneClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNone");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNone> {
        @Override
        public void serialize(UnionNone obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.noneClassValue != null) {
                jsonGenerator.writeObject(obj.noneClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
