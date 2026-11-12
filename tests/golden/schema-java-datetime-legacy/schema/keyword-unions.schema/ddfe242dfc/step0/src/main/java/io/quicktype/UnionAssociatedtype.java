package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAssociatedtype.Deserializer.class)
@JsonSerialize(using = UnionAssociatedtype.Serializer.class)
public class UnionAssociatedtype {
    public Double doubleValue;
    public Associatedtype associatedtypeValue;

    static class Deserializer extends JsonDeserializer<UnionAssociatedtype> {
        @Override
        public UnionAssociatedtype deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAssociatedtype value = new UnionAssociatedtype();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.associatedtypeValue = jsonParser.readValueAs(Associatedtype.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAssociatedtype");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAssociatedtype> {
        @Override
        public void serialize(UnionAssociatedtype obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.associatedtypeValue != null) {
                jsonGenerator.writeObject(obj.associatedtypeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
