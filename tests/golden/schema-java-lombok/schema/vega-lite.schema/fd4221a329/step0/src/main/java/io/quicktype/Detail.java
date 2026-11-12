package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Detail.Deserializer.class)
@JsonSerialize(using = Detail.Serializer.class)
public class Detail {
    public FieldDef fieldDefValue;
    public List<FieldDef> fieldDefArrayValue;

    static class Deserializer extends JsonDeserializer<Detail> {
        @Override
        public Detail deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Detail value = new Detail();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case START_ARRAY:
                    value.fieldDefArrayValue = jsonParser.readValueAs(new TypeReference<List<FieldDef>>() {});
                    break;
                case START_OBJECT:
                    value.fieldDefValue = jsonParser.readValueAs(FieldDef.class);
                    break;
                default: throw new IOException("Cannot deserialize Detail");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Detail> {
        @Override
        public void serialize(Detail obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.fieldDefValue != null) {
                jsonGenerator.writeObject(obj.fieldDefValue);
                return;
            }
            if (obj.fieldDefArrayValue != null) {
                jsonGenerator.writeObject(obj.fieldDefArrayValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
