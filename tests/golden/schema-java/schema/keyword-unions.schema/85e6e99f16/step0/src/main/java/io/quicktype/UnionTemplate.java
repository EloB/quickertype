package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTemplate.Deserializer.class)
@JsonSerialize(using = UnionTemplate.Serializer.class)
public class UnionTemplate {
    public Double doubleValue;
    public Template templateValue;

    static class Deserializer extends JsonDeserializer<UnionTemplate> {
        @Override
        public UnionTemplate deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTemplate value = new UnionTemplate();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.templateValue = jsonParser.readValueAs(Template.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTemplate");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTemplate> {
        @Override
        public void serialize(UnionTemplate obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.templateValue != null) {
                jsonGenerator.writeObject(obj.templateValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
