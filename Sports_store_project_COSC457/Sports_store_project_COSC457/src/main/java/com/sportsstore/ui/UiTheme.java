package com.sportsstore.ui;

import javax.swing.*;
import javax.swing.border.Border;
import javax.swing.table.JTableHeader;
import java.awt.*;

/** Shared colors and component styling for the presentation-ready Swing UI. */
final class UiTheme {
    static final Color NAVY = new Color(0x16324F);
    static final Color TEAL = new Color(0x2A9D8F);
    static final Color GOLD = new Color(0xE9C46A);
    static final Color RED = new Color(0xD95D39);
    static final Color INK = new Color(0x1F2933);
    static final Color MUTED = new Color(0x64748B);
    static final Color BORDER = new Color(0xCBD5E1);
    static final Color BACKGROUND = new Color(0xEEF4F8);
    static final Color PANEL = Color.WHITE;
    static final Color ROW_ALT = new Color(0xF8FAFC);
    static final Font BODY = new Font(Font.SANS_SERIF, Font.PLAIN, 13);
    static final Font BODY_BOLD = BODY.deriveFont(Font.BOLD);
    static final Font TITLE = new Font(Font.SANS_SERIF, Font.BOLD, 24);

    private UiTheme() {}

    static void install() {
        UIManager.put("Panel.background", BACKGROUND);
        UIManager.put("OptionPane.background", PANEL);
        UIManager.put("OptionPane.messageForeground", INK);
        UIManager.put("Label.font", BODY);
        UIManager.put("Button.font", BODY_BOLD);
        UIManager.put("ComboBox.font", BODY);
        UIManager.put("TextField.font", BODY);
        UIManager.put("TabbedPane.font", BODY_BOLD);
        UIManager.put("TabbedPane.selected", PANEL);
        UIManager.put("Table.font", BODY);
        UIManager.put("TableHeader.font", BODY_BOLD);
    }

    static Border panelBorder() {
        return BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(BORDER),
                BorderFactory.createEmptyBorder(14, 16, 14, 16));
    }

    static JButton button(String label, Color fill, Color foreground) {
        JButton b = new JButton(label);
        b.setFocusPainted(false);
        b.setBorderPainted(false);
        b.setOpaque(true);
        b.setBackground(fill);
        b.setForeground(foreground);
        b.setFont(BODY_BOLD);
        b.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        b.setBorder(BorderFactory.createEmptyBorder(8, 14, 8, 14));
        return b;
    }

    static void styleTable(JTable table) {
        table.setRowHeight(30);
        table.setGridColor(new Color(0xE2E8F0));
        table.setSelectionBackground(new Color(0xCDEDE8));
        table.setSelectionForeground(INK);
        table.setShowVerticalLines(false);
        table.setIntercellSpacing(new Dimension(0, 1));
        table.setFillsViewportHeight(true);
        table.setAutoCreateRowSorter(true);

        JTableHeader header = table.getTableHeader();
        header.setBackground(NAVY);
        header.setForeground(Color.WHITE);
        header.setFont(BODY_BOLD);
        header.setReorderingAllowed(false);
        header.setPreferredSize(new Dimension(header.getPreferredSize().width, 34));
    }

    static JPanel whitePanel(LayoutManager layout) {
        JPanel panel = new JPanel(layout);
        panel.setBackground(PANEL);
        panel.setBorder(panelBorder());
        return panel;
    }
}
