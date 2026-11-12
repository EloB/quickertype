package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionLocalDate.Deserializer.class)
@JsonSerialize(using = UnionLocalDate.Serializer.class)
public class UnionLocalDate {
    public Double doubleValue;
    public LocalDateClass localDateClassValue;

    static class Deserializer extends JsonDeserializer<UnionLocalDate> {
        @Override
        public UnionLocalDate deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionLocalDate value = new UnionLocalDate();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.localDateClassValue = jsonParser.readValueAs(LocalDateClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionLocalDate");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionLocalDate> {
        @Override
        public void serialize(UnionLocalDate obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.localDateClassValue != null) {
                jsonGenerator.writeObject(obj.localDateClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
