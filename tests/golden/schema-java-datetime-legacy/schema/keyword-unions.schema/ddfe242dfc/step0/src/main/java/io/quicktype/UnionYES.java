package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionYES.Deserializer.class)
@JsonSerialize(using = UnionYES.Serializer.class)
public class UnionYES {
    public Double doubleValue;
    public Yes yesValue;

    static class Deserializer extends JsonDeserializer<UnionYES> {
        @Override
        public UnionYES deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionYES value = new UnionYES();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.yesValue = jsonParser.readValueAs(Yes.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionYES");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionYES> {
        @Override
        public void serialize(UnionYES obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.yesValue != null) {
                jsonGenerator.writeObject(obj.yesValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
