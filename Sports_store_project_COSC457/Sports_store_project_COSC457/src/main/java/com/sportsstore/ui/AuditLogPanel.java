package com.sportsstore.ui;

import com.sportsstore.dao.AuditLogger;
import com.sportsstore.dao.GenericDao;

import javax.swing.*;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.DefaultTableCellRenderer;
import java.awt.*;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/** Read-only view of recent application changes. */
public class AuditLogPanel extends JPanel {
    private final JTable table;
    private final AuditModel model = new AuditModel();
    private final JLabel status = new JLabel(" ");

    public AuditLogPanel() {
        super(new BorderLayout(0, 10));
        setBackground(UiTheme.BACKGROUND);
        setBorder(BorderFactory.createEmptyBorder(10, 0, 0, 0));

        JLabel title = new JLabel("Audit Log");
        title.setFont(UiTheme.TITLE.deriveFont(20f));
        title.setForeground(UiTheme.NAVY);

        JLabel hint = new JLabel("Recent add, edit, and delete actions recorded from the app.");
        hint.setFont(UiTheme.BODY);
        hint.setForeground(UiTheme.MUTED);

        JPanel copy = new JPanel(new GridLayout(2, 1, 0, 3));
        copy.setOpaque(false);
        copy.add(title);
        copy.add(hint);

        JButton refresh = UiTheme.button("Refresh Log", UiTheme.TEAL, Color.WHITE);
        refresh.addActionListener(e -> refresh());

        JPanel north = UiTheme.whitePanel(new BorderLayout());
        north.add(copy, BorderLayout.WEST);
        north.add(refresh, BorderLayout.EAST);
        add(north, BorderLayout.NORTH);

        table = new JTable(model);
        UiTheme.styleTable(table);
        table.setDefaultRenderer(Object.class, new AuditRenderer());
        JScrollPane scroll = new JScrollPane(table);
        scroll.setBorder(BorderFactory.createLineBorder(UiTheme.BORDER));

        JPanel center = UiTheme.whitePanel(new BorderLayout());
        center.add(scroll, BorderLayout.CENTER);
        add(center, BorderLayout.CENTER);

        JPanel footer = UiTheme.whitePanel(new BorderLayout());
        status.setFont(UiTheme.BODY);
        status.setForeground(UiTheme.MUTED);
        footer.add(status, BorderLayout.WEST);
        add(footer, BorderLayout.SOUTH);

        refresh();
    }

    private void refresh() {
        try {
            AuditLogger.ensureTable();
            model.set(GenericDao.selectAll(
                    "SELECT created_at, username, role_name, action_name, table_name, record_id " +
                    "FROM APP_AUDIT_LOG ORDER BY created_at DESC LIMIT 100"));
            status.setText(model.getRowCount() + " recent audit event(s).");
            status.setForeground(UiTheme.MUTED);
        } catch (SQLException e) {
            status.setText("Audit log unavailable: " + e.getMessage());
            status.setForeground(UiTheme.RED);
        }
    }

    private static class AuditModel extends AbstractTableModel {
        private final List<String> columns = List.of("Time", "User", "Role", "Action", "Table", "Record ID");
        private List<Object[]> rows = new ArrayList<>();

        void set(List<Object[]> rows) {
            this.rows = rows;
            fireTableDataChanged();
        }

        @Override public int getRowCount() { return rows.size(); }
        @Override public int getColumnCount() { return columns.size(); }
        @Override public String getColumnName(int c) { return columns.get(c); }
        @Override public Object getValueAt(int r, int c) { return rows.get(r)[c]; }
    }

    private static class AuditRenderer extends DefaultTableCellRenderer {
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
