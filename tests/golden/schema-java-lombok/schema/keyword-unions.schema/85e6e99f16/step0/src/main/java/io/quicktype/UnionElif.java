package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionElif.Deserializer.class)
@JsonSerialize(using = UnionElif.Serializer.class)
public class UnionElif {
    public Double doubleValue;
    public Elif elifValue;

    static class Deserializer extends JsonDeserializer<UnionElif> {
        @Override
        public UnionElif deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionElif value = new UnionElif();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.elifValue = jsonParser.readValueAs(Elif.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionElif");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionElif> {
        @Override
        public void serialize(UnionElif obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.elifValue != null) {
                jsonGenerator.writeObject(obj.elifValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
