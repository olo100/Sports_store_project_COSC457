package com.sportsstore.ui;

import com.sportsstore.dao.GenericDao;

import javax.swing.*;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.DefaultTableCellRenderer;
import java.awt.*;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Read-only canned queries that exercise multi-table joins, aggregates and
 * filters. Each one corresponds to an "Expected Database Query" the design
 * report calls out. Adding more queries is just one more entry in the map.
 */
public class ReportsPanel extends JPanel {

    private final JComboBox<String> picker;
    private final JTable table;
    private final ResultModel model = new ResultModel();
    private final Map<String, String> queries = new LinkedHashMap<>();

    public ReportsPanel() {
        super(new BorderLayout(8, 8));
        setBackground(UiTheme.BACKGROUND);
        setBorder(BorderFactory.createEmptyBorder(10, 0, 0, 0));

        queries.put("Inventory below reorder level",
                "SELECT s.store_name, p.name AS product, i.quantity, i.reorder_level " +
                "FROM INVENTORY i JOIN PRODUCT p ON i.product_id = p.product_id " +
                "JOIN STORE_LOCATION s ON i.store_id = s.store_id " +
                "WHERE i.quantity < i.reorder_level " +
                "ORDER BY s.store_name, p.name");

        queries.put("Top 10 products by revenue",
                "SELECT p.name AS product, SUM(si.quantity) AS units_sold, " +
                "       ROUND(SUM(si.total),2) AS revenue " +
                "FROM SALE_ITEM si JOIN PRODUCT p ON si.product_id = p.product_id " +
                "GROUP BY p.product_id, p.name " +
                "ORDER BY revenue DESC LIMIT 10");

        queries.put("Sales totals by store",
                "SELECT s.store_name, COUNT(*) AS sales, " +
                "       ROUND(SUM(sa.total),2) AS gross " +
                "FROM SALE sa JOIN STORE_LOCATION s ON sa.store_id = s.store_id " +
                "GROUP BY s.store_id, s.store_name " +
                "ORDER BY gross DESC");

        queries.put("Customers by lifetime spend",
                "SELECT c.first_name, c.last_name, c.email, " +
                "       ROUND(COALESCE(SUM(sa.total),0),2) AS lifetime_spend " +
                "FROM CUSTOMER c LEFT JOIN SALE sa ON sa.customer_id = c.customer_id " +
                "GROUP BY c.customer_id ORDER BY lifetime_spend DESC LIMIT 25");

        queries.put("Employees per department",
                "SELECT d.name AS department, COUNT(e.employee_id) AS employees " +
                "FROM DEPARTMENT d LEFT JOIN EMPLOYEE e ON e.department_id = d.department_id " +
                "GROUP BY d.department_id, d.name ORDER BY employees DESC");

        queries.put("Products that have never sold",
                "SELECT p.name AS product, p.sku FROM PRODUCT p " +
                "LEFT JOIN SALE_ITEM si ON si.product_id = p.product_id " +
                "WHERE si.item_id IS NULL ORDER BY p.name");

        queries.put("Recent sales (last 30 rows)",
                "SELECT sa.sale_date, s.store_name, " +
                "       CONCAT(c.first_name,' ',c.last_name) AS customer, " +
                "       ROUND(sa.total,2) AS total " +
                "FROM SALE sa JOIN STORE_LOCATION s ON sa.store_id = s.store_id " +
                "LEFT JOIN CUSTOMER c ON sa.customer_id = c.customer_id " +
                "ORDER BY sa.sale_date DESC LIMIT 30");

        picker = new JComboBox<>(queries.keySet().toArray(new String[0]));
        picker.setBackground(Color.WHITE);
        picker.setFont(UiTheme.BODY);
        JButton run = UiTheme.button("Run Report", UiTheme.TEAL, Color.WHITE);
        run.addActionListener(e -> run());
        JButton export = UiTheme.button("Export CSV", UiTheme.NAVY, Color.WHITE);
        export.addActionListener(e -> exportCsv());

        JLabel title = new JLabel("Business Reports");
        title.setFont(UiTheme.TITLE.deriveFont(20f));
        title.setForeground(UiTheme.NAVY);

        JLabel hint = new JLabel("Choose a report to show live SQL results for sales, products, customers, and inventory.");
        hint.setFont(UiTheme.BODY);
        hint.setForeground(UiTheme.MUTED);

        JPanel copy = new JPanel(new GridLayout(2, 1, 0, 3));
        copy.setOpaque(false);
        copy.add(title);
        copy.add(hint);

        JPanel controls = new JPanel(new FlowLayout(FlowLayout.LEFT, 8, 0));
        controls.setOpaque(false);
        JLabel reportLabel = new JLabel("Report:");
        reportLabel.setFont(UiTheme.BODY_BOLD);
        reportLabel.setForeground(UiTheme.NAVY);
        controls.add(reportLabel);
        controls.add(picker);
        controls.add(run);
        controls.add(export);

        JPanel north = UiTheme.whitePanel(new BorderLayout(0, 12));
        north.add(copy, BorderLayout.NORTH);
        north.add(controls, BorderLayout.SOUTH);

        table = new JTable(model);
        UiTheme.styleTable(table);
        table.setDefaultRenderer(Object.class, new ReportRenderer());
        JScrollPane scroll = new JScrollPane(table);
        scroll.setBorder(BorderFactory.createLineBorder(UiTheme.BORDER));

        JPanel center = UiTheme.whitePanel(new BorderLayout());
        center.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createEmptyBorder(10, 0, 0, 0),
                UiTheme.panelBorder()));
        center.add(scroll, BorderLayout.CENTER);

        add(north, BorderLayout.NORTH);
        add(center, BorderLayout.CENTER);

        run();
    }

    private void run() {
        String name = (String) picker.getSelectedItem();
        if (name == null) return;
        String sql = queries.get(name);
        try {
            List<String> cols = GenericDao.selectColumns(sql);
            List<Object[]> rows = GenericDao.selectAll(sql);
            model.set(cols, rows);
        } catch (SQLException e) {
            List<Object[]> errorRows = new ArrayList<>();
            errorRows.add(new Object[]{e.getMessage()});
            model.set(List.of("error"), errorRows);
        }
    }

    private void exportCsv() {
        if (model.getRowCount() == 0) {
            JOptionPane.showMessageDialog(this, "Run a report with rows before exporting.",
                    "Nothing to export", JOptionPane.INFORMATION_MESSAGE);
            return;
        }
        String reportName = String.valueOf(picker.getSelectedItem()).replaceAll("[^A-Za-z0-9]+", "_");
        JFileChooser chooser = new JFileChooser();
        chooser.setSelectedFile(new File(reportName + ".csv"));
        if (chooser.showSaveDialog(this) != JFileChooser.APPROVE_OPTION) return;

        try (FileWriter writer = new FileWriter(chooser.getSelectedFile())) {
            for (int c = 0; c < model.getColumnCount(); c++) {
                if (c > 0) writer.write(",");
                writer.write(csv(model.getColumnName(c)));
            }
            writer.write("\n");
            for (int r = 0; r < model.getRowCount(); r++) {
                for (int c = 0; c < model.getColumnCount(); c++) {
                    if (c > 0) writer.write(",");
                    writer.write(csv(model.getValueAt(r, c)));
                }
                writer.write("\n");
            }
            JOptionPane.showMessageDialog(this, "Report exported successfully.",
                    "Export complete", JOptionPane.INFORMATION_MESSAGE);
        } catch (IOException e) {
            JOptionPane.showMessageDialog(this, "Export failed: " + e.getMessage(),
                    "Export failed", JOptionPane.ERROR_MESSAGE);
        }
    }

    private String csv(Object value) {
        String text = value == null ? "" : String.valueOf(value);
        return "\"" + text.replace("\"", "\"\"") + "\"";
    }

    private static class ResultModel extends AbstractTableModel {
        private List<String> cols = new ArrayList<>();
        private List<Object[]> rows = new ArrayList<>();
        void set(List<String> c, List<Object[]> r) { this.cols = c; this.rows = r; fireTableStructureChanged(); }
        @Override public int getRowCount() { return rows.size(); }
        @Override public int getColumnCount() { return cols.size(); }
        @Override public String getColumnName(int c) { return cols.get(c); }
        @Override public Object getValueAt(int r, int c) { return rows.get(r)[c]; }
    }

    private static class ReportRenderer extends DefaultTableCellRenderer {
        @Override
        public Component getTableCellRendererComponent(JTable table, Object value, boolean selected,
                                                       boolean focused, int row, int column) {
            Component c = super.getTableCellRendererComponent(table, value, selected, focused, row, column);
            if (!selected) {
                c.setBackground(row % 2 == 0 ? Color.WHITE : UiTheme.ROW_ALT);
                c.setForeground(UiTheme.INK);
            }
            setBorder(BorderFactory.createEmptyBorder(0, 8, 0, 8));
            return c;
        }
    }
}
