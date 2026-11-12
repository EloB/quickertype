package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionEquatable.Deserializer.class)
@JsonSerialize(using = UnionEquatable.Serializer.class)
public class UnionEquatable {
    public Double doubleValue;
    public Equatable equatableValue;

    static class Deserializer extends JsonDeserializer<UnionEquatable> {
        @Override
        public UnionEquatable deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionEquatable value = new UnionEquatable();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.equatableValue = jsonParser.readValueAs(Equatable.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionEquatable");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionEquatable> {
        @Override
        public void serialize(UnionEquatable obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.equatableValue != null) {
                jsonGenerator.writeObject(obj.equatableValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
