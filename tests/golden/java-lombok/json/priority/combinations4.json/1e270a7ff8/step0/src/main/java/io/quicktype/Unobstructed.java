package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = Unobstructed.Deserializer.class)
@JsonSerialize(using = Unobstructed.Serializer.class)
public class Unobstructed {
    public QuebrachineClass quebrachineClassValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<Unobstructed> {
        @Override
        public Unobstructed deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Unobstructed value = new Unobstructed();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_OBJECT:
                    value.quebrachineClassValue = jsonParser.readValueAs(QuebrachineClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Unobstructed");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Unobstructed> {
        @Override
        public void serialize(Unobstructed obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.quebrachineClassValue != null) {
                jsonGenerator.writeObject(obj.quebrachineClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
