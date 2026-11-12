package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDelegate.Deserializer.class)
@JsonSerialize(using = UnionDelegate.Serializer.class)
public class UnionDelegate {
    public Double doubleValue;
    public Delegate delegateValue;

    static class Deserializer extends JsonDeserializer<UnionDelegate> {
        @Override
        public UnionDelegate deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDelegate value = new UnionDelegate();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.delegateValue = jsonParser.readValueAs(Delegate.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDelegate");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDelegate> {
        @Override
        public void serialize(UnionDelegate obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.delegateValue != null) {
                jsonGenerator.writeObject(obj.delegateValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
