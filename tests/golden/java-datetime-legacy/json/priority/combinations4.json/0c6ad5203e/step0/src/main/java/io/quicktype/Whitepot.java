package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Whitepot.Deserializer.class)
@JsonSerialize(using = Whitepot.Serializer.class)
public class Whitepot {
    public QuebrachineClass quebrachineClassValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<Whitepot> {
        @Override
        public Whitepot deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Whitepot value = new Whitepot();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.quebrachineClassValue = jsonParser.readValueAs(QuebrachineClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Whitepot");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Whitepot> {
        @Override
        public void serialize(Whitepot obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.quebrachineClassValue != null) {
                jsonGenerator.writeObject(obj.quebrachineClassValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("Whitepot must not be null");
        }
    }
}
