package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUnchecked.Deserializer.class)
@JsonSerialize(using = UnionUnchecked.Serializer.class)
public class UnionUnchecked {
    public Double doubleValue;
    public Unchecked uncheckedValue;

    static class Deserializer extends JsonDeserializer<UnionUnchecked> {
        @Override
        public UnionUnchecked deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUnchecked value = new UnionUnchecked();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.uncheckedValue = jsonParser.readValueAs(Unchecked.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUnchecked");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUnchecked> {
        @Override
        public void serialize(UnionUnchecked obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.uncheckedValue != null) {
                jsonGenerator.writeObject(obj.uncheckedValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
