package com.sportsstore.ui;

import java.util.ArrayList;
import java.util.List;

/**
 * Declarative description of a database table for the generic CRUD panel.
 *
 * <p>Use the fluent builder methods (text/integer/decimal/date/...) to add columns
 * in display order. The first column added is treated as the primary key and is
 * auto-generated as a UUID for new rows.
 */
public class EntitySchema {

    public final String tableName;
    public final String displayName;
    public final List<Column> columns = new ArrayList<>();
    public String orderBy;

    public EntitySchema(String tableName, String displayName) {
        this.tableName = tableName;
        this.displayName = displayName;
    }

    public EntitySchema orderBy(String s) { this.orderBy = s; return this; }

    public Column primaryKey(String name, String label) {
        Column c = new Column(name, label, ColumnType.STRING);
        c.primaryKey = true;
        c.autoGenerate = true;
        c.required = true;
        columns.add(c);
        return c;
    }

    public Column text(String name, String label) {
        Column c = new Column(name, label, ColumnType.STRING);
        columns.add(c);
        return c;
    }

    public Column integer(String name, String label) {
        Column c = new Column(name, label, ColumnType.INTEGER);
        columns.add(c);
        return c;
    }

    public Column decimal(String name, String label) {
        Column c = new Column(name, label, ColumnType.DECIMAL);
        columns.add(c);
        return c;
    }

    public Column date(String name, String label) {
        Column c = new Column(name, label, ColumnType.DATE);
        columns.add(c);
        return c;
    }

    public Column timestamp(String name, String label) {
        Column c = new Column(name, label, ColumnType.TIMESTAMP);
        columns.add(c);
        return c;
    }

    public Column time(String name, String label) {
        Column c = new Column(name, label, ColumnType.TIME);
        columns.add(c);
        return c;
    }

    public Column bool(String name, String label) {
        Column c = new Column(name, label, ColumnType.BOOLEAN);
        columns.add(c);
        return c;
    }

    public Column foreignKey(String name, String label, String displayQuery) {
        Column c = new Column(name, label, ColumnType.STRING);
        c.foreignKeyQuery = displayQuery;
        columns.add(c);
        return c;
    }

    public Column dropdown(String name, String label, String... choices) {
        Column c = new Column(name, label, ColumnType.STRING);
        c.choices = choices;
        columns.add(c);
        return c;
    }

    public Column primaryKeyColumn() {
        for (Column c : columns) if (c.primaryKey) return c;
        throw new IllegalStateException("No primary key defined for " + tableName);
    }

    public enum ColumnType { STRING, INTEGER, DECIMAL, DATE, TIME, TIMESTAMP, BOOLEAN }

    public static class Column {
        public final String name;
        public final String label;
        public final ColumnType type;
        public boolean required;
        public boolean primaryKey;
        public boolean autoGenerate;
        public String foreignKeyQuery;     // SELECT id, display_label FROM ...
        public String[] choices;            // fixed dropdown values (status fields, etc.)

        public Column(String name, String label, ColumnType type) {
            this.name = name;
            this.label = label;
            this.type = type;
        }

        public Column required() { this.required = true; return this; }
    }
}
