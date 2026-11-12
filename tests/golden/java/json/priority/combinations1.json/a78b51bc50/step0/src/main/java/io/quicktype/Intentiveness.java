package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = Intentiveness.Deserializer.class)
@JsonSerialize(using = Intentiveness.Serializer.class)
public class Intentiveness {
    public CimeliaClass cimeliaClassValue;
    public Double doubleValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Intentiveness> {
        @Override
        public Intentiveness deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Intentiveness value = new Intentiveness();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.cimeliaClassValue = jsonParser.readValueAs(CimeliaClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Intentiveness");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Intentiveness> {
        @Override
        public void serialize(Intentiveness obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.cimeliaClassValue != null) {
                jsonGenerator.writeObject(obj.cimeliaClassValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Intentiveness must not be null");
        }
    }
}
