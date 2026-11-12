package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDate.Deserializer.class)
@JsonSerialize(using = UnionDate.Serializer.class)
public class UnionDate {
    public Double doubleValue;
    public DateClass dateClassValue;

    static class Deserializer extends JsonDeserializer<UnionDate> {
        @Override
        public UnionDate deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDate value = new UnionDate();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.dateClassValue = jsonParser.readValueAs(DateClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDate");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDate> {
        @Override
        public void serialize(UnionDate obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dateClassValue != null) {
                jsonGenerator.writeObject(obj.dateClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
