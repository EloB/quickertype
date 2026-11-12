package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = OccupationalistElement.Deserializer.class)
@JsonSerialize(using = OccupationalistElement.Serializer.class)
public class OccupationalistElement {
    public List<Object> nullArrayValue;
    public OccupationalistClass occupationalistClassValue;

    static class Deserializer extends JsonDeserializer<OccupationalistElement> {
        @Override
        public OccupationalistElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            OccupationalistElement value = new OccupationalistElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(new TypeReference<List<Object>>() {});
                    break;
                case START_OBJECT:
                    value.occupationalistClassValue = jsonParser.readValueAs(OccupationalistClass.class);
                    break;
                default: throw new IOException("Cannot deserialize OccupationalistElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<OccupationalistElement> {
        @Override
        public void serialize(OccupationalistElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.occupationalistClassValue != null) {
                jsonGenerator.writeObject(obj.occupationalistClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
