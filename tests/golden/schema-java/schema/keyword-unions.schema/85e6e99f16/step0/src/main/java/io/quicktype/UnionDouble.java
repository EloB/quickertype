package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDouble.Deserializer.class)
@JsonSerialize(using = UnionDouble.Serializer.class)
public class UnionDouble {
    public Double doubleValue;
    public DoubleClass doubleClassValue;

    static class Deserializer extends JsonDeserializer<UnionDouble> {
        @Override
        public UnionDouble deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDouble value = new UnionDouble();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.doubleClassValue = jsonParser.readValueAs(DoubleClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDouble");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDouble> {
        @Override
        public void serialize(UnionDouble obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.doubleClassValue != null) {
                jsonGenerator.writeObject(obj.doubleClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
