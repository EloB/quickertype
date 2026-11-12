package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUnowned.Deserializer.class)
@JsonSerialize(using = UnionUnowned.Serializer.class)
public class UnionUnowned {
    public Double doubleValue;
    public Unowned unownedValue;

    static class Deserializer extends JsonDeserializer<UnionUnowned> {
        @Override
        public UnionUnowned deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUnowned value = new UnionUnowned();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.unownedValue = jsonParser.readValueAs(Unowned.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUnowned");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUnowned> {
        @Override
        public void serialize(UnionUnowned obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.unownedValue != null) {
                jsonGenerator.writeObject(obj.unownedValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
