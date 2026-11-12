package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNonmutating.Deserializer.class)
@JsonSerialize(using = UnionNonmutating.Serializer.class)
public class UnionNonmutating {
    public Double doubleValue;
    public Nonmutating nonmutatingValue;

    static class Deserializer extends JsonDeserializer<UnionNonmutating> {
        @Override
        public UnionNonmutating deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNonmutating value = new UnionNonmutating();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.nonmutatingValue = jsonParser.readValueAs(Nonmutating.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNonmutating");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNonmutating> {
        @Override
        public void serialize(UnionNonmutating obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.nonmutatingValue != null) {
                jsonGenerator.writeObject(obj.nonmutatingValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
