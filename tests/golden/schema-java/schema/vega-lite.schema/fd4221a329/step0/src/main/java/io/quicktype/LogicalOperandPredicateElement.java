package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

/**
 * The `filter` property must be one of the predicate definitions:
 * (1) an [expression](types.html#expression) string,
 * where `datum` can be used to refer to the current data object;
 * (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
 * [range predicate](filter.html#range-predicate), [one-of
 * predicate](filter.html#one-of-predicate);
 * (3) a [selection predicate](filter.html#selection-predicate);
 * or (4) a logical operand that combines (1), (2), or (3).
 */
@JsonDeserialize(using = LogicalOperandPredicateElement.Deserializer.class)
@JsonSerialize(using = LogicalOperandPredicateElement.Serializer.class)
public class LogicalOperandPredicateElement {
    public Predicate predicateValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<LogicalOperandPredicateElement> {
        @Override
        public LogicalOperandPredicateElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            LogicalOperandPredicateElement value = new LogicalOperandPredicateElement();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.predicateValue = jsonParser.readValueAs(Predicate.class);
                    break;
                default: throw new IOException("Cannot deserialize LogicalOperandPredicateElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<LogicalOperandPredicateElement> {
        @Override
        public void serialize(LogicalOperandPredicateElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.predicateValue != null) {
                jsonGenerator.writeObject(obj.predicateValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("LogicalOperandPredicateElement must not be null");
        }
    }
}
