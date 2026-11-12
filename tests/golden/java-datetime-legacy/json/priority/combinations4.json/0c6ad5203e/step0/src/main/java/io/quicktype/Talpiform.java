package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Talpiform.Deserializer.class)
@JsonSerialize(using = Talpiform.Serializer.class)
public class Talpiform {
    public QuebrachineClass quebrachineClassValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<Talpiform> {
        @Override
        public Talpiform deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Talpiform value = new Talpiform();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.quebrachineClassValue = jsonParser.readValueAs(QuebrachineClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Talpiform");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Talpiform> {
        @Override
        public void serialize(Talpiform obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.quebrachineClassValue != null) {
                jsonGenerator.writeObject(obj.quebrachineClassValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
