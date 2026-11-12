package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionWeak.Deserializer.class)
@JsonSerialize(using = UnionWeak.Serializer.class)
public class UnionWeak {
    public Double doubleValue;
    public Weak weakValue;

    static class Deserializer extends JsonDeserializer<UnionWeak> {
        @Override
        public UnionWeak deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionWeak value = new UnionWeak();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.weakValue = jsonParser.readValueAs(Weak.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionWeak");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionWeak> {
        @Override
        public void serialize(UnionWeak obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.weakValue != null) {
                jsonGenerator.writeObject(obj.weakValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
