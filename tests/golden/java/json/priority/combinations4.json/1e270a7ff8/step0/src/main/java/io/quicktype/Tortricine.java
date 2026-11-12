package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Tortricine.Deserializer.class)
@JsonSerialize(using = Tortricine.Serializer.class)
public class Tortricine {
    public List<Long> unionArrayValue;
    public QuebrachineClass quebrachineClassValue;

    static class Deserializer extends JsonDeserializer<Tortricine> {
        @Override
        public Tortricine deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Tortricine value = new Tortricine();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.unionArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.quebrachineClassValue = jsonParser.readValueAs(QuebrachineClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Tortricine");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Tortricine> {
        @Override
        public void serialize(Tortricine obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.unionArrayValue != null) {
                jsonGenerator.writeObject(obj.unionArrayValue);
                return;
            }
            if (obj.quebrachineClassValue != null) {
                jsonGenerator.writeObject(obj.quebrachineClassValue);
                return;
            }
            throw new IOException("Tortricine must not be null");
        }
    }
}
