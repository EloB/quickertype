package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

/**
 * Filter using a selection name.
 *
 * A [selection name](selection.html), or a series of [composed
 * selections](selection.html#compose).
 */
@JsonDeserialize(using = SelectionOperandElement.Deserializer.class)
@JsonSerialize(using = SelectionOperandElement.Serializer.class)
public class SelectionOperandElement {
    public Selection selectionValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<SelectionOperandElement> {
        @Override
        public SelectionOperandElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            SelectionOperandElement value = new SelectionOperandElement();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.selectionValue = jsonParser.readValueAs(Selection.class);
                    break;
                default: throw new IOException("Cannot deserialize SelectionOperandElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<SelectionOperandElement> {
        @Override
        public void serialize(SelectionOperandElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.selectionValue != null) {
                jsonGenerator.writeObject(obj.selectionValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("SelectionOperandElement must not be null");
        }
    }
}
