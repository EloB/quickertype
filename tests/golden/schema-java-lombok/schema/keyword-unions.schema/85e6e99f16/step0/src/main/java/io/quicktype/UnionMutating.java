package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionMutating.Deserializer.class)
@JsonSerialize(using = UnionMutating.Serializer.class)
public class UnionMutating {
    public Double doubleValue;
    public Mutating mutatingValue;

    static class Deserializer extends JsonDeserializer<UnionMutating> {
        @Override
        public UnionMutating deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionMutating value = new UnionMutating();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.mutatingValue = jsonParser.readValueAs(Mutating.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionMutating");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionMutating> {
        @Override
        public void serialize(UnionMutating obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.mutatingValue != null) {
                jsonGenerator.writeObject(obj.mutatingValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
