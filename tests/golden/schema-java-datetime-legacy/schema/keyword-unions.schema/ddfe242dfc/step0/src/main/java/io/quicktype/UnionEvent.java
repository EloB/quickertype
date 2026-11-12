package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionEvent.Deserializer.class)
@JsonSerialize(using = UnionEvent.Serializer.class)
public class UnionEvent {
    public Double doubleValue;
    public Event eventValue;

    static class Deserializer extends JsonDeserializer<UnionEvent> {
        @Override
        public UnionEvent deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionEvent value = new UnionEvent();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.eventValue = jsonParser.readValueAs(Event.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionEvent");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionEvent> {
        @Override
        public void serialize(UnionEvent obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.eventValue != null) {
                jsonGenerator.writeObject(obj.eventValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
