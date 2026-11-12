package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = Hemicrystalline.Deserializer.class)
@JsonSerialize(using = Hemicrystalline.Serializer.class)
public class Hemicrystalline {
    public CimeliaClass cimeliaClassValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Hemicrystalline> {
        @Override
        public Hemicrystalline deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Hemicrystalline value = new Hemicrystalline();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.cimeliaClassValue = jsonParser.readValueAs(CimeliaClass.class);
                    break;
                default: throw new IOException("Cannot deserialize Hemicrystalline");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Hemicrystalline> {
        @Override
        public void serialize(Hemicrystalline obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.cimeliaClassValue != null) {
                jsonGenerator.writeObject(obj.cimeliaClassValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Hemicrystalline must not be null");
        }
    }
}
