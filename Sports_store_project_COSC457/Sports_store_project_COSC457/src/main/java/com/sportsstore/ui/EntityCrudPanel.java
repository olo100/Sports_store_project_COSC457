package com.sportsstore.ui;

import com.sportsstore.dao.GenericDao;
import com.sportsstore.dao.AuditLogger;
import com.sportsstore.ui.EntitySchema.Column;
import com.sportsstore.ui.EntitySchema.ColumnType;

import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableRowSorter;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

/**
 * Generic CRUD panel that drives any {@link EntitySchema}: data table on top,
 * action buttons in the middle, status bar at the bottom. Edit/Add opens a
 * modal form built from the schema (text fields for strings, dropdowns for
 * FK/choice columns, etc.).
 */
public class EntityCrudPanel extends JPanel {

    private final EntitySchema schema;
    private final LoginDialog.Account account;
    private final JTable table;
    private final EntityTableModel model;
    private final TableRowSorter<EntityTableModel> sorter;
    private final JLabel status;
    private JTextField searchField;
    private JSlider numericSlider;
    private JLabel numericSliderValue;
    private int numericFilterColumn = -1;
    private String numericFilterLabel;

    public EntityCrudPanel(EntitySchema schema, LoginDialog.Account account) {
        super(new BorderLayout(8, 8));
        this.schema = schema;
        this.account = account;
        this.model = new EntityTableModel(schema);
        this.table = new JTable(model);
        this.sorter = new TableRowSorter<>(model);
        this.status = new JLabel(" ");
        setBackground(UiTheme.BACKGROUND);
        setBorder(BorderFactory.createEmptyBorder(10, 0, 0, 0));
        buildUi();
        refresh();
    }

    private void buildUi() {
        UiTheme.styleTable(table);
        table.setRowSorter(sorter);
        table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        table.setDefaultRenderer(Object.class, new EntityRenderer(schema, model));

        JLabel title = new JLabel(schema.displayName);
        title.setFont(UiTheme.TITLE.deriveFont(20f));
        title.setForeground(UiTheme.NAVY);

        JLabel hint = new JLabel(schema.tableName + "  |  " + permissionText());
        hint.setFont(UiTheme.BODY);
        hint.setForeground(UiTheme.MUTED);

        JPanel headingText = new JPanel(new GridLayout(2, 1, 0, 3));
        headingText.setOpaque(false);
        headingText.add(title);
        headingText.add(hint);

        searchField = new JTextField(22);
        searchField.setToolTipText("Search this table");
        searchField.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(UiTheme.BORDER),
                BorderFactory.createEmptyBorder(7, 10, 7, 10)));
        searchField.getDocument().addDocumentListener(new DocumentListener() {
            @Override public void insertUpdate(DocumentEvent e) { applyFilter(); }
            @Override public void removeUpdate(DocumentEvent e) { applyFilter(); }
            @Override public void changedUpdate(DocumentEvent e) { applyFilter(); }
        });

        JLabel searchLabel = new JLabel("Search");
        searchLabel.setFont(UiTheme.BODY_BOLD);
        searchLabel.setForeground(UiTheme.NAVY);

        JPanel filters = new JPanel();
        filters.setLayout(new BoxLayout(filters, BoxLayout.Y_AXIS));
        filters.setOpaque(false);

        JPanel search = new JPanel(new FlowLayout(FlowLayout.RIGHT, 8, 0));
        search.setOpaque(false);
        search.add(searchLabel);
        search.add(searchField);
        filters.add(search);

        JPanel sliderPanel = buildNumericSlider();
        if (sliderPanel != null) filters.add(sliderPanel);

        JPanel heading = new JPanel(new BorderLayout(16, 0));
        heading.setOpaque(false);
        heading.add(headingText, BorderLayout.WEST);
        heading.add(filters, BorderLayout.EAST);

        JScrollPane scroll = new JScrollPane(table);
        scroll.setBorder(BorderFactory.createLineBorder(UiTheme.BORDER));

        JPanel content = UiTheme.whitePanel(new BorderLayout(0, 14));
        content.add(heading, BorderLayout.NORTH);
        content.add(scroll, BorderLayout.CENTER);
        add(content, BorderLayout.CENTER);

        JPanel buttons = new JPanel(new FlowLayout(FlowLayout.LEFT, 8, 0));
        buttons.setOpaque(false);
        JButton add = button("Add", UiTheme.TEAL, Color.WHITE, this::onAdd);
        JButton edit = button("Edit", UiTheme.GOLD, UiTheme.NAVY, this::onEdit);
        JButton delete = button("Delete", UiTheme.RED, Color.WHITE, this::onDelete);
        add.setEnabled(canAdd());
        edit.setEnabled(canEdit());
        delete.setEnabled(canDelete());
        buttons.add(add);
        buttons.add(edit);
        buttons.add(delete);
        buttons.add(button("Refresh", UiTheme.NAVY, Color.WHITE, e -> refresh()));

        JPanel south = UiTheme.whitePanel(new BorderLayout());
        south.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createEmptyBorder(10, 0, 0, 0),
                UiTheme.panelBorder()));
        south.add(buttons, BorderLayout.WEST);
        south.add(status,  BorderLayout.EAST);
        add(south, BorderLayout.SOUTH);
    }

    private JButton button(String label, Color fill, Color foreground, java.awt.event.ActionListener handler) {
        JButton b = UiTheme.button(label, fill, foreground);
        b.addActionListener(handler);
        return b;
    }

    private String permissionText() {
        if (isManager()) return "Manager access: add, edit, delete, search, and refresh.";
        if (canAdd()) return "Employee access: add sales records, search, and refresh.";
        return "Employee access: view, search, and refresh only.";
    }

    private boolean isManager() {
        return account != null && "Manager".equalsIgnoreCase(account.role);
    }

    private boolean canAdd() {
        return isManager() || "SALE".equals(schema.tableName) || "SALE_ITEM".equals(schema.tableName);
    }

    private boolean canEdit() {
        return isManager();
    }

    private boolean canDelete() {
        return isManager();
    }

    private void applyFilter() {
        List<RowFilter<EntityTableModel, Integer>> filters = new ArrayList<>();
        String text = searchField == null ? "" : searchField.getText().trim();
        if (!text.isEmpty()) {
            filters.add(RowFilter.regexFilter("(?i)" + Pattern.quote(text)));
        }
        if (numericSlider != null && numericFilterColumn >= 0 && numericSlider.isEnabled()
                && numericSlider.getValue() < numericSlider.getMaximum()) {
            final int max = numericSlider.getValue();
            filters.add(new RowFilter<>() {
                @Override
                public boolean include(Entry<? extends EntityTableModel, ? extends Integer> entry) {
                    Object value = entry.getValue(numericFilterColumn);
                    return asDouble(value) <= max;
                }
            });
        }
        sorter.setRowFilter(filters.isEmpty() ? null : RowFilter.andFilter(filters));
        setStatus(table.getRowCount() + " visible / " + model.getRowCount() + " total row(s)");
    }

    public final void refresh() {
        try {
            List<Object[]> rows = GenericDao.selectAll(buildSelect());
            model.setRows(rows);
            updateNumericSliderRange();
            applyFilter();
        } catch (SQLException e) {
            error("Refresh failed: " + e.getMessage());
        }
    }

    private String buildSelect() {
        StringBuilder sb = new StringBuilder("SELECT ");
        for (int i = 0; i < schema.columns.size(); i++) {
            if (i > 0) sb.append(", ");
            sb.append(schema.columns.get(i).name);
        }
        sb.append(" FROM ").append(schema.tableName);
        if (schema.orderBy != null) sb.append(" ORDER BY ").append(schema.orderBy);
        return sb.toString();
    }

    private JPanel buildNumericSlider() {
        String column = numericColumnForTable();
        if (column == null) return null;
        numericFilterColumn = columnIndex(column);
        if (numericFilterColumn < 0) return null;

        numericFilterLabel = switch (schema.tableName) {
            case "PRODUCT" -> "Max Price";
            case "INVENTORY" -> "Max Qty";
            case "SALE" -> "Max Total";
            case "SALE_ITEM" -> "Max Line Total";
            default -> "Max";
        };

        JLabel label = new JLabel(numericFilterLabel);
        label.setFont(UiTheme.BODY_BOLD);
        label.setForeground(UiTheme.NAVY);

        numericSlider = new JSlider(0, 100, 100);
        numericSlider.setPreferredSize(new Dimension(190, 34));
        numericSlider.setOpaque(false);
        numericSlider.setPaintTicks(false);
        numericSlider.setToolTipText("Drag to filter " + schema.displayName);
        numericSlider.addChangeListener(e -> {
            updateNumericSliderLabel();
            applyFilter();
        });

        numericSliderValue = new JLabel("All");
        numericSliderValue.setFont(UiTheme.BODY);
        numericSliderValue.setForeground(UiTheme.MUTED);
        numericSliderValue.setPreferredSize(new Dimension(64, 24));

        JPanel panel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 8, 0));
        panel.setOpaque(false);
        panel.add(label);
        panel.add(numericSlider);
        panel.add(numericSliderValue);
        return panel;
    }

    private String numericColumnForTable() {
        return switch (schema.tableName) {
            case "PRODUCT" -> "price";
            case "INVENTORY" -> "quantity";
            case "SALE" -> "total";
            case "SALE_ITEM" -> "total";
            default -> null;
        };
    }

    private void updateNumericSliderRange() {
        if (numericSlider == null || numericFilterColumn < 0) return;
        int max = 0;
        for (int r = 0; r < model.getRowCount(); r++) {
            max = Math.max(max, (int) Math.ceil(asDouble(model.getValueAt(r, numericFilterColumn))));
        }
        numericSlider.setEnabled(max > 0);
        numericSlider.setMaximum(Math.max(max, 1));
        numericSlider.setValue(Math.max(max, 1));
        updateNumericSliderLabel();
    }

    private void updateNumericSliderLabel() {
        if (numericSlider == null || numericSliderValue == null) return;
        if (!numericSlider.isEnabled() || numericSlider.getValue() >= numericSlider.getMaximum()) {
            numericSliderValue.setText("All");
        } else {
            numericSliderValue.setText(String.valueOf(numericSlider.getValue()));
        }
    }

    private Object[] selectedRow() {
        int viewRow = table.getSelectedRow();
        if (viewRow < 0) return null;
        int modelRow = table.convertRowIndexToModel(viewRow);
        return model.row(modelRow);
    }

    private void onAdd(ActionEvent e) {
        if (!canAdd()) { error("Your role cannot add rows on this tab."); return; }
        Object[] blank = new Object[schema.columns.size()];
        for (int i = 0; i < schema.columns.size(); i++) {
            Column c = schema.columns.get(i);
            if (c.autoGenerate) blank[i] = UUID.randomUUID().toString();
        }
        Object[] result = EntityFormDialog.prompt(this, schema, blank, false);
        if (result == null) return;
        String validation = validate(result);
        if (validation != null) { error(validation); return; }
        try {
            doInsert(result);
            if ("SALE_ITEM".equals(schema.tableName)) adjustInventoryForSaleItem(result, -asInt(value(result, "quantity")));
            AuditLogger.log(account, "INSERT", schema.tableName, value(result, schema.primaryKeyColumn().name));
            refresh();
            setStatus("Inserted.");
        } catch (SQLException ex) {
            error("Insert failed: " + ex.getMessage());
        }
    }

    private void onEdit(ActionEvent e) {
        if (!canEdit()) { error("Your role cannot edit rows."); return; }
        Object[] row = selectedRow();
        if (row == null) { error("Select a row to edit."); return; }
        Object[] result = EntityFormDialog.prompt(this, schema, row, true);
        if (result == null) return;
        String validation = validate(result);
        if (validation != null) { error(validation); return; }
        try {
            doUpdate(result);
            if ("SALE_ITEM".equals(schema.tableName)) {
                adjustInventoryForSaleItem(row, asInt(value(row, "quantity")));
                adjustInventoryForSaleItem(result, -asInt(value(result, "quantity")));
            }
            AuditLogger.log(account, "UPDATE", schema.tableName, value(result, schema.primaryKeyColumn().name));
            refresh();
            setStatus("Updated.");
        } catch (SQLException ex) {
            error("Update failed: " + ex.getMessage());
        }
    }

    private void onDelete(ActionEvent e) {
        if (!canDelete()) { error("Your role cannot delete rows."); return; }
        Object[] row = selectedRow();
        if (row == null) { error("Select a row to delete."); return; }
        int answer = JOptionPane.showConfirmDialog(this,
                "Delete this " + schema.displayName.toLowerCase() + " row?",
                "Confirm delete",
                JOptionPane.YES_NO_OPTION);
        if (answer != JOptionPane.YES_OPTION) return;
        Column pk = schema.primaryKeyColumn();
        Object pkValue = row[schema.columns.indexOf(pk)];
        String sql = "DELETE FROM " + schema.tableName + " WHERE " + pk.name + " = ?";
        try {
            int n = GenericDao.execute(sql, pkValue);
            if ("SALE_ITEM".equals(schema.tableName)) adjustInventoryForSaleItem(row, asInt(value(row, "quantity")));
            AuditLogger.log(account, "DELETE", schema.tableName, pkValue);
            refresh();
            setStatus("Deleted " + n + " row(s).");
        } catch (SQLException ex) {
            error("Delete failed (probably referenced by another table): " + ex.getMessage());
        }
    }

    private void doInsert(Object[] values) throws SQLException {
        StringBuilder cols = new StringBuilder();
        StringBuilder qs = new StringBuilder();
        List<Object> params = new ArrayList<>();
        for (int i = 0; i < schema.columns.size(); i++) {
            Column c = schema.columns.get(i);
            if (cols.length() > 0) { cols.append(", "); qs.append(", "); }
            cols.append(c.name);
            qs.append("?");
            params.add(values[i]);
        }
        String sql = "INSERT INTO " + schema.tableName + " (" + cols + ") VALUES (" + qs + ")";
        GenericDao.execute(sql, params.toArray());
    }

    private void doUpdate(Object[] values) throws SQLException {
        Column pk = schema.primaryKeyColumn();
        StringBuilder set = new StringBuilder();
        List<Object> params = new ArrayList<>();
        Object pkValue = null;
        for (int i = 0; i < schema.columns.size(); i++) {
            Column c = schema.columns.get(i);
            if (c.primaryKey) { pkValue = values[i]; continue; }
            if (set.length() > 0) set.append(", ");
            set.append(c.name).append(" = ?");
            params.add(values[i]);
        }
        params.add(pkValue);
        String sql = "UPDATE " + schema.tableName + " SET " + set + " WHERE " + pk.name + " = ?";
        GenericDao.execute(sql, params.toArray());
    }

    private String validate(Object[] values) {
        for (int i = 0; i < schema.columns.size(); i++) {
            Column c = schema.columns.get(i);
            Object v = values[i];
            if (v == null) continue;
            if ("email".equalsIgnoreCase(c.name) && !String.valueOf(v).contains("@")) {
                return c.label + " must be a valid email address.";
            }
            if (c.type == ColumnType.INTEGER && !(v instanceof Number)) {
                return c.label + " must be a whole number.";
            }
            if (c.type == ColumnType.DECIMAL && !(v instanceof Number)) {
                return c.label + " must be a number.";
            }
            if ((c.type == ColumnType.DATE || c.type == ColumnType.TIME || c.type == ColumnType.TIMESTAMP)
                    && v instanceof String) {
                return c.label + " has an invalid date/time format.";
            }
            String lower = c.name.toLowerCase();
            if ((lower.contains("quantity") || lower.contains("level") || lower.contains("price")
                    || lower.contains("cost") || lower.contains("total") || lower.contains("tax")
                    || lower.contains("subtotal") || lower.contains("discount") || lower.contains("rate"))
                    && v instanceof Number && new BigDecimal(String.valueOf(v)).compareTo(BigDecimal.ZERO) < 0) {
                return c.label + " cannot be negative.";
            }
        }
        return null;
    }

    private void adjustInventoryForSaleItem(Object[] saleItem, int quantityChange) throws SQLException {
        if (quantityChange == 0) return;
        Object saleId = value(saleItem, "sale_id");
        Object productId = value(saleItem, "product_id");
        if (saleId == null || productId == null) return;
        GenericDao.execute(
                "UPDATE INVENTORY i JOIN SALE s ON s.store_id = i.store_id " +
                "SET i.quantity = GREATEST(i.quantity + ?, 0) " +
                "WHERE s.sale_id = ? AND i.product_id = ?",
                quantityChange, saleId, productId);
    }

    private Object value(Object[] row, String columnName) {
        int index = columnIndex(columnName);
        return index < 0 ? null : row[index];
    }

    private int columnIndex(String columnName) {
        for (int i = 0; i < schema.columns.size(); i++) {
            if (schema.columns.get(i).name.equals(columnName)) return i;
        }
        return -1;
    }

    private int asInt(Object value) {
        if (value instanceof Number) return ((Number) value).intValue();
        try {
            return Integer.parseInt(String.valueOf(value));
        } catch (Exception e) {
            return 0;
        }
    }

    private double asDouble(Object value) {
        if (value instanceof Number) return ((Number) value).doubleValue();
        try {
            return Double.parseDouble(String.valueOf(value));
        } catch (Exception e) {
            return 0;
        }
    }

    private void setStatus(String s) { status.setText(s); status.setForeground(UiTheme.MUTED); }
    private void error(String s)     { status.setText(s); status.setForeground(UiTheme.RED); }

    /* ----------------------------- table model ----------------------------- */

    private static class EntityTableModel extends AbstractTableModel {
        private final EntitySchema schema;
        private List<Object[]> rows = new ArrayList<>();

        EntityTableModel(EntitySchema schema) { this.schema = schema; }

        void setRows(List<Object[]> r) { this.rows = r; fireTableDataChanged(); }
        Object[] row(int i) { return rows.get(i); }

        @Override public int getRowCount() { return rows.size(); }
        @Override public int getColumnCount() { return schema.columns.size(); }
        @Override public String getColumnName(int c) { return schema.columns.get(c).label; }
        @Override public Object getValueAt(int r, int c) { return rows.get(r)[c]; }
        @Override public boolean isCellEditable(int r, int c) { return false; }

        @Override
        public Class<?> getColumnClass(int c) {
            ColumnType t = schema.columns.get(c).type;
            switch (t) {
                case INTEGER: return Integer.class;
                case DECIMAL: return BigDecimal.class;
                case BOOLEAN: return Boolean.class;
                default:      return Object.class;
            }
        }
    }

    private static class EntityRenderer extends DefaultTableCellRenderer {
        private final EntitySchema schema;
        private final EntityTableModel model;
        private final int quantityColumn;
        private final int reorderColumn;

        EntityRenderer(EntitySchema schema, EntityTableModel model) {
            this.schema = schema;
            this.model = model;
            this.quantityColumn = columnIndex(schema, "quantity");
            this.reorderColumn = columnIndex(schema, "reorder_level");
        }

        @Override
        public Component getTableCellRendererComponent(JTable table, Object value, boolean selected,
                                                       boolean focused, int row, int column) {
            Component c = super.getTableCellRendererComponent(table, value, selected, focused, row, column);
            if (!selected) {
                c.setBackground(isLowStock(table, row)
                        ? new Color(0xFDE2E1)
                        : row % 2 == 0 ? Color.WHITE : UiTheme.ROW_ALT);
                c.setForeground(UiTheme.INK);
            }
            setBorder(BorderFactory.createEmptyBorder(0, 8, 0, 8));
            return c;
        }

        private boolean isLowStock(JTable table, int viewRow) {
            if (!"INVENTORY".equals(schema.tableName) || quantityColumn < 0 || reorderColumn < 0) {
                return false;
            }
            int modelRow = table.convertRowIndexToModel(viewRow);
            Object quantity = model.getValueAt(modelRow, quantityColumn);
            Object reorder = model.getValueAt(modelRow, reorderColumn);
            return asInt(quantity) < asInt(reorder);
        }

        private static int columnIndex(EntitySchema schema, String name) {
            for (int i = 0; i < schema.columns.size(); i++) {
                if (schema.columns.get(i).name.equals(name)) return i;
            }
            return -1;
        }

        private static int asInt(Object value) {
            if (value instanceof Number) return ((Number) value).intValue();
            try {
                return Integer.parseInt(String.valueOf(value));
            } catch (Exception e) {
                return 0;
            }
        }
    }

    /* ----------------------------- form dialog ----------------------------- */

    static class EntityFormDialog {
        static Object[] prompt(Component parent, EntitySchema schema, Object[] initial, boolean editing) {
            JPanel form = new JPanel(new GridBagLayout());
            form.setBackground(Color.WHITE);
            form.setBorder(BorderFactory.createEmptyBorder(8, 8, 8, 8));
            GridBagConstraints gc = new GridBagConstraints();
            gc.insets = new Insets(6, 8, 6, 8);
            gc.anchor = GridBagConstraints.WEST;

            Map<Column, JComponent> editors = new LinkedHashMap<>();
            int row = 0;
            for (int i = 0; i < schema.columns.size(); i++) {
                Column c = schema.columns.get(i);
                JComponent editor = makeEditor(c, initial[i], editing);
                editors.put(c, editor);

                gc.gridx = 0; gc.gridy = row; gc.weightx = 0;
                gc.fill = GridBagConstraints.NONE;
                JLabel label = new JLabel(c.label + (c.required ? " *" : "") + ":");
                label.setForeground(UiTheme.NAVY);
                label.setFont(UiTheme.BODY_BOLD);
                form.add(label, gc);

                gc.gridx = 1; gc.gridy = row; gc.weightx = 1;
                gc.fill = GridBagConstraints.HORIZONTAL;
                form.add(editor, gc);
                row++;
            }

            String title = (editing ? "Edit " : "Add ") + schema.displayName;
            int n = JOptionPane.showConfirmDialog(parent, form, title,
                    JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);
            if (n != JOptionPane.OK_OPTION) return null;

            Object[] out = new Object[schema.columns.size()];
            for (int i = 0; i < schema.columns.size(); i++) {
                Column c = schema.columns.get(i);
                Object v = readEditor(c, editors.get(c));
                if (c.required && (v == null || (v instanceof String && ((String) v).isBlank()))) {
                    JOptionPane.showMessageDialog(parent, c.label + " is required.",
                            "Missing field", JOptionPane.WARNING_MESSAGE);
                    return prompt(parent, schema, captureCurrent(schema, editors), editing);
                }
                out[i] = v;
            }
            return out;
        }

        private static JComponent makeEditor(Column c, Object initial, boolean editing) {
            String text = initial == null ? "" : String.valueOf(initial);
            if (c.foreignKeyQuery != null) {
                JComboBox<KV> box = new JComboBox<>();
                box.setBackground(Color.WHITE);
                box.addItem(new KV(null, "(none)"));
                try {
                    for (Object[] r : GenericDao.selectAll(c.foreignKeyQuery)) {
                        box.addItem(new KV(r[0], String.valueOf(r.length > 1 ? r[1] : r[0])));
                    }
                } catch (SQLException ignored) {}
                if (initial != null) {
                    for (int i = 0; i < box.getItemCount(); i++) {
                        if (initial.equals(box.getItemAt(i).key)) { box.setSelectedIndex(i); break; }
                    }
                }
                return box;
            }
            if (c.choices != null) {
                JComboBox<String> box = new JComboBox<>(c.choices);
                box.setBackground(Color.WHITE);
                if (initial != null) box.setSelectedItem(text);
                return box;
            }
            if (c.type == ColumnType.BOOLEAN) {
                JCheckBox cb = new JCheckBox();
                cb.setSelected(Boolean.TRUE.equals(initial)
                        || "1".equals(text) || "true".equalsIgnoreCase(text));
                return cb;
            }
            JTextField tf = new JTextField(text, 24);
            tf.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(UiTheme.BORDER),
                    BorderFactory.createEmptyBorder(5, 8, 5, 8)));
            if (c.primaryKey && c.autoGenerate) tf.setEditable(false);
            return tf;
        }

        private static Object readEditor(Column c, JComponent editor) {
            if (editor instanceof JComboBox) {
                Object sel = ((JComboBox<?>) editor).getSelectedItem();
                if (sel instanceof KV) return ((KV) sel).key;
                return sel == null ? null : sel.toString();
            }
            if (editor instanceof JCheckBox) {
                return ((JCheckBox) editor).isSelected();
            }
            String raw = ((JTextField) editor).getText().trim();
            if (raw.isEmpty()) return null;
            try {
                switch (c.type) {
                    case INTEGER:  return Integer.parseInt(raw);
                    case DECIMAL:  return new BigDecimal(raw);
                    case DATE:     return new java.sql.Date(parseDate(raw).getTime());
                    case TIME:     return Time.valueOf(raw.length() == 5 ? raw + ":00" : raw);
                    case TIMESTAMP:return new Timestamp(parseTimestamp(raw).getTime());
                    default:       return raw;
                }
            } catch (Exception ex) {
                return raw; // let the DB reject it; the SQLException surfaces in the panel
            }
        }

        private static Date parseDate(String s) throws java.text.ParseException {
            return new SimpleDateFormat("yyyy-MM-dd").parse(s);
        }

        private static Date parseTimestamp(String s) throws java.text.ParseException {
            String fmt = s.length() <= 10 ? "yyyy-MM-dd"
                    : s.length() <= 16 ? "yyyy-MM-dd HH:mm"
                    : "yyyy-MM-dd HH:mm:ss";
            return new SimpleDateFormat(fmt).parse(s);
        }

        private static Object[] captureCurrent(EntitySchema schema, Map<Column, JComponent> editors) {
            Object[] out = new Object[schema.columns.size()];
            for (int i = 0; i < schema.columns.size(); i++) {
                out[i] = readEditor(schema.columns.get(i), editors.get(schema.columns.get(i)));
            }
            return out;
        }
    }

    /** Key/value holder for FK dropdowns. */
    private static class KV {
        final Object key;
        final String label;
        KV(Object key, String label) { this.key = key; this.label = label; }
        @Override public String toString() { return label; }
    }
}
