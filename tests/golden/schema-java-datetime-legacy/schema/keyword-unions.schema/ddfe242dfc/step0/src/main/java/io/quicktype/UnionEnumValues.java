package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionEnumValues.Deserializer.class)
@JsonSerialize(using = UnionEnumValues.Serializer.class)
public class UnionEnumValues {
    public Double doubleValue;
    public EnumValues enumValuesValue;

    static class Deserializer extends JsonDeserializer<UnionEnumValues> {
        @Override
        public UnionEnumValues deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionEnumValues value = new UnionEnumValues();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.enumValuesValue = jsonParser.readValueAs(EnumValues.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionEnumValues");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionEnumValues> {
        @Override
        public void serialize(UnionEnumValues obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.enumValuesValue != null) {
                jsonGenerator.writeObject(obj.enumValuesValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
