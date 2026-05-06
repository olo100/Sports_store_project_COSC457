package com.sportsstore.ui;

import com.sportsstore.dao.GenericDao;

import javax.swing.*;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.DefaultTableCellRenderer;
import java.awt.*;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/** Presentation-friendly landing page with live business summary metrics. */
public class DashboardPanel extends JPanel {

    private final List<MetricCard> cards = new ArrayList<>();
    private final ResultModel topProductsModel = new ResultModel();
    private final ResultModel lowInventoryModel = new ResultModel();
    private final BarChartPanel revenueByStoreChart = new BarChartPanel("Revenue by Store", UiTheme.TEAL);
    private final BarChartPanel topProductsChart = new BarChartPanel("Top Product Revenue", new Color(0x6A4C93));
    private final JLabel status = new JLabel(" ");

    public DashboardPanel() {
        super(new BorderLayout(0, 10));
        setBackground(UiTheme.BACKGROUND);
        setBorder(BorderFactory.createEmptyBorder(10, 0, 0, 0));
        buildUi();
        refresh();
    }

    private void buildUi() {
        JPanel hero = UiTheme.whitePanel(new BorderLayout(0, 12));
        JLabel title = new JLabel("Store Dashboard");
        title.setFont(UiTheme.TITLE.deriveFont(22f));
        title.setForeground(UiTheme.NAVY);

        JLabel hint = new JLabel("Live summary of stores, products, customers, sales, revenue, and inventory risk.");
        hint.setFont(UiTheme.BODY);
        hint.setForeground(UiTheme.MUTED);

        JPanel copy = new JPanel(new GridLayout(2, 1, 0, 3));
        copy.setOpaque(false);
        copy.add(title);
        copy.add(hint);

        JButton refresh = UiTheme.button("Refresh Dashboard", UiTheme.TEAL, Color.WHITE);
        refresh.addActionListener(e -> refresh());

        hero.add(copy, BorderLayout.WEST);
        hero.add(refresh, BorderLayout.EAST);
        add(hero, BorderLayout.NORTH);

        JPanel body = new JPanel(new BorderLayout(0, 10));
        body.setOpaque(false);
        body.add(buildCards(), BorderLayout.NORTH);
        JPanel detail = new JPanel(new GridLayout(2, 1, 0, 10));
        detail.setOpaque(false);
        detail.add(buildCharts());
        detail.add(buildTables());
        body.add(detail, BorderLayout.CENTER);
        add(body, BorderLayout.CENTER);

        JPanel footer = UiTheme.whitePanel(new BorderLayout());
        footer.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createEmptyBorder(0, 0, 0, 0),
                UiTheme.panelBorder()));
        status.setFont(UiTheme.BODY);
        status.setForeground(UiTheme.MUTED);
        footer.add(status, BorderLayout.WEST);
        add(footer, BorderLayout.SOUTH);
    }

    private JPanel buildCards() {
        JPanel grid = new JPanel(new GridLayout(2, 3, 10, 10));
        grid.setOpaque(false);
        addCard(grid, "Stores", "STORE_LOCATION", UiTheme.NAVY);
        addCard(grid, "Products", "PRODUCT", UiTheme.TEAL);
        addCard(grid, "Customers", "CUSTOMER", UiTheme.GOLD);
        addCard(grid, "Sales", "SALE", new Color(0x457B9D));
        addCard(grid, "Revenue", "SALE.total", new Color(0x6A4C93));
        addCard(grid, "Low Stock", "INVENTORY", UiTheme.RED);
        return grid;
    }

    private void addCard(JPanel grid, String title, String subtitle, Color accent) {
        MetricCard card = new MetricCard(title, subtitle, accent);
        cards.add(card);
        grid.add(card);
    }

    private JPanel buildTables() {
        JPanel tables = new JPanel(new GridLayout(1, 2, 10, 0));
        tables.setOpaque(false);
        tables.add(tablePanel("Top Products by Revenue", topProductsModel));
        tables.add(tablePanel("Inventory Below Reorder Level", lowInventoryModel));
        return tables;
    }

    private JPanel buildCharts() {
        JPanel charts = new JPanel(new GridLayout(1, 2, 10, 0));
        charts.setOpaque(false);
        charts.add(revenueByStoreChart);
        charts.add(topProductsChart);
        return charts;
    }

    private JPanel tablePanel(String titleText, ResultModel model) {
        JPanel panel = UiTheme.whitePanel(new BorderLayout(0, 10));
        JLabel title = new JLabel(titleText);
        title.setFont(UiTheme.BODY_BOLD.deriveFont(15f));
        title.setForeground(UiTheme.NAVY);
        panel.add(title, BorderLayout.NORTH);

        JTable table = new JTable(model);
        UiTheme.styleTable(table);
        table.setDefaultRenderer(Object.class, new DashboardRenderer());
        JScrollPane scroll = new JScrollPane(table);
        scroll.setBorder(BorderFactory.createLineBorder(UiTheme.BORDER));
        panel.add(scroll, BorderLayout.CENTER);
        return panel;
    }

    private void refresh() {
        try {
            cards.get(0).setValue(formatCount(count("STORE_LOCATION")));
            cards.get(1).setValue(formatCount(count("PRODUCT")));
            cards.get(2).setValue(formatCount(count("CUSTOMER")));
            cards.get(3).setValue(formatCount(count("SALE")));
            cards.get(4).setValue(formatCurrency(sum("SALE", "total")));
            cards.get(5).setValue(formatCount(lowStockCount()));
            topProductsModel.set(
                    List.of("Product", "Units", "Revenue"),
                    GenericDao.selectAll(
                            "SELECT p.name, SUM(si.quantity), ROUND(SUM(si.total), 2) " +
                            "FROM SALE_ITEM si JOIN PRODUCT p ON p.product_id = si.product_id " +
                            "GROUP BY p.product_id, p.name ORDER BY SUM(si.total) DESC LIMIT 6"));
            lowInventoryModel.set(
                    List.of("Store", "Product", "Qty", "Reorder"),
                    GenericDao.selectAll(
                            "SELECT s.store_name, p.name, i.quantity, i.reorder_level " +
                            "FROM INVENTORY i JOIN PRODUCT p ON p.product_id = i.product_id " +
                            "JOIN STORE_LOCATION s ON s.store_id = i.store_id " +
                            "WHERE i.quantity < i.reorder_level " +
                            "ORDER BY i.quantity ASC, p.name LIMIT 8"));
            revenueByStoreChart.setData(GenericDao.selectAll(
                    "SELECT s.store_name, ROUND(SUM(sa.total), 2) " +
                    "FROM SALE sa JOIN STORE_LOCATION s ON s.store_id = sa.store_id " +
                    "GROUP BY s.store_id, s.store_name ORDER BY SUM(sa.total) DESC LIMIT 6"));
            topProductsChart.setData(GenericDao.selectAll(
                    "SELECT p.name, ROUND(SUM(si.total), 2) " +
                    "FROM SALE_ITEM si JOIN PRODUCT p ON p.product_id = si.product_id " +
                    "GROUP BY p.product_id, p.name ORDER BY SUM(si.total) DESC LIMIT 6"));
            status.setText("Dashboard refreshed from the database.");
            status.setForeground(UiTheme.MUTED);
        } catch (SQLException e) {
            status.setText("Dashboard refresh failed: " + e.getMessage());
            status.setForeground(UiTheme.RED);
        }
    }

    private int count(String table) throws SQLException {
        return ((Number) GenericDao.selectAll("SELECT COUNT(*) FROM " + table).get(0)[0]).intValue();
    }

    private int lowStockCount() throws SQLException {
        return ((Number) GenericDao.selectAll(
                "SELECT COUNT(*) FROM INVENTORY WHERE quantity < reorder_level").get(0)[0]).intValue();
    }

    private BigDecimal sum(String table, String column) throws SQLException {
        Object value = GenericDao.selectAll(
                "SELECT COALESCE(ROUND(SUM(" + column + "), 2), 0) FROM " + table).get(0)[0];
        if (value instanceof BigDecimal) return (BigDecimal) value;
        return new BigDecimal(String.valueOf(value));
    }

    private String formatCount(int n) {
        return NumberFormat.getIntegerInstance(Locale.US).format(n);
    }

    private String formatCurrency(BigDecimal n) {
        return NumberFormat.getCurrencyInstance(Locale.US).format(n);
    }

    private static class MetricCard extends JPanel {
        private final JLabel value = new JLabel("-");

        MetricCard(String title, String subtitle, Color accent) {
            super(new BorderLayout(0, 8));
            setBackground(Color.WHITE);
            setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createMatteBorder(4, 0, 0, 0, accent),
                    UiTheme.panelBorder()));

            JLabel label = new JLabel(title);
            label.setFont(UiTheme.BODY_BOLD);
            label.setForeground(UiTheme.NAVY);

            value.setFont(UiTheme.TITLE.deriveFont(26f));
            value.setForeground(accent.equals(UiTheme.GOLD) ? UiTheme.NAVY : accent);

            JLabel sub = new JLabel(subtitle);
            sub.setFont(UiTheme.BODY.deriveFont(12f));
            sub.setForeground(UiTheme.MUTED);

            add(label, BorderLayout.NORTH);
            add(value, BorderLayout.CENTER);
            add(sub, BorderLayout.SOUTH);
        }

        void setValue(String text) {
            value.setText(text);
        }
    }

    private static class ResultModel extends AbstractTableModel {
        private List<String> cols = new ArrayList<>();
        private List<Object[]> rows = new ArrayList<>();

        void set(List<String> c, List<Object[]> r) {
            cols = c;
            rows = r;
            fireTableStructureChanged();
        }

        @Override public int getRowCount() { return rows.size(); }
        @Override public int getColumnCount() { return cols.size(); }
        @Override public String getColumnName(int c) { return cols.get(c); }
        @Override public Object getValueAt(int r, int c) { return rows.get(r)[c]; }
    }

    private static class DashboardRenderer extends DefaultTableCellRenderer {
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

    private static class BarChartPanel extends JPanel {
        private final String title;
        private final Color barColor;
        private List<Object[]> data = new ArrayList<>();

        BarChartPanel(String title, Color barColor) {
            this.title = title;
            this.barColor = barColor;
            setBackground(Color.WHITE);
            setBorder(UiTheme.panelBorder());
        }

        void setData(List<Object[]> rows) {
            data = rows;
            repaint();
        }

        @Override
        protected void paintComponent(Graphics g) {
            super.paintComponent(g);
            Graphics2D g2 = (Graphics2D) g.create();
            g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            g2.setFont(UiTheme.BODY_BOLD.deriveFont(15f));
            g2.setColor(UiTheme.NAVY);
            g2.drawString(title, 12, 22);

            if (data.isEmpty()) {
                g2.setFont(UiTheme.BODY);
                g2.setColor(UiTheme.MUTED);
                g2.drawString("No chart data available.", 12, 52);
                g2.dispose();
                return;
            }

            double max = 0;
            for (Object[] row : data) max = Math.max(max, asDouble(row[1]));
            int left = 12;
            int top = 42;
            int gap = 8;
            int barHeight = Math.max(16, (getHeight() - top - 14) / data.size() - gap);
            int chartWidth = Math.max(80, getWidth() - 190);

            g2.setFont(UiTheme.BODY.deriveFont(11f));
            for (int i = 0; i < data.size(); i++) {
                Object[] row = data.get(i);
                int y = top + i * (barHeight + gap);
                double value = asDouble(row[1]);
                int width = max <= 0 ? 0 : (int) Math.round((value / max) * chartWidth);
                g2.setColor(new Color(0xE2E8F0));
                g2.fillRoundRect(left + 120, y, chartWidth, barHeight, 8, 8);
                g2.setColor(barColor);
                g2.fillRoundRect(left + 120, y, Math.max(width, 4), barHeight, 8, 8);
                g2.setColor(UiTheme.INK);
                g2.drawString(shorten(String.valueOf(row[0]), 16), left, y + barHeight - 4);
                g2.setColor(UiTheme.MUTED);
                g2.drawString(NumberFormat.getCurrencyInstance(Locale.US).format(value),
                        left + 128 + chartWidth, y + barHeight - 4);
            }
            g2.dispose();
        }

        private static double asDouble(Object value) {
            if (value instanceof Number) return ((Number) value).doubleValue();
            try {
                return Double.parseDouble(String.valueOf(value));
            } catch (Exception e) {
                return 0;
            }
        }

        private static String shorten(String text, int max) {
            return text.length() <= max ? text : text.substring(0, max - 1) + "...";
        }
    }
}
