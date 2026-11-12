package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionHasOwnProperty.Deserializer.class)
@JsonSerialize(using = UnionHasOwnProperty.Serializer.class)
public class UnionHasOwnProperty {
    public Double doubleValue;
    public HasOwnProperty hasOwnPropertyValue;

    static class Deserializer extends JsonDeserializer<UnionHasOwnProperty> {
        @Override
        public UnionHasOwnProperty deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionHasOwnProperty value = new UnionHasOwnProperty();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.hasOwnPropertyValue = jsonParser.readValueAs(HasOwnProperty.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionHasOwnProperty");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionHasOwnProperty> {
        @Override
        public void serialize(UnionHasOwnProperty obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.hasOwnPropertyValue != null) {
                jsonGenerator.writeObject(obj.hasOwnPropertyValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
