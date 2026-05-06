package com.sportsstore.ui;

import com.sportsstore.db.Database;

import javax.swing.*;
import java.awt.*;

/** Top-level window: tabs for each entity plus a Reports tab. */
public class MainFrame extends JFrame {
    private final LoginDialog.Account account;
    private final Runnable onLogout;

    public MainFrame(LoginDialog.Account account, Runnable onLogout) {
        super("Sports Store Management System");
        this.account = account;
        this.onLogout = onLogout;
        UiTheme.install();
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setMinimumSize(new Dimension(1120, 720));
        setSize(1240, 760);
        setLocationRelativeTo(null);
        setLayout(new BorderLayout());
        getContentPane().setBackground(UiTheme.BACKGROUND);

        JTabbedPane tabs = new JTabbedPane(JTabbedPane.TOP);
        tabs.setBorder(BorderFactory.createEmptyBorder(10, 14, 10, 14));
        tabs.setBackground(UiTheme.BACKGROUND);
        tabs.setForeground(UiTheme.INK);
        tabs.addTab("Dashboard",   new DashboardPanel());
        tabs.addTab("Stores",      new EntityCrudPanel(SchemaCatalog.store(), account));
        tabs.addTab("Departments", new EntityCrudPanel(SchemaCatalog.department(), account));
        tabs.addTab("Employees",   new EntityCrudPanel(SchemaCatalog.employee(), account));
        tabs.addTab("Categories",  new EntityCrudPanel(SchemaCatalog.category(), account));
        tabs.addTab("Products",    new EntityCrudPanel(SchemaCatalog.product(), account));
        tabs.addTab("Customers",   new EntityCrudPanel(SchemaCatalog.customer(), account));
        tabs.addTab("Inventory",   new EntityCrudPanel(SchemaCatalog.inventory(), account));
        tabs.addTab("Sales",       new EntityCrudPanel(SchemaCatalog.sale(), account));
        tabs.addTab("Sale Items",  new EntityCrudPanel(SchemaCatalog.saleItem(), account));
        tabs.addTab("Reports",     new ReportsPanel());
        if ("Manager".equalsIgnoreCase(account.role)) {
            tabs.addTab("Audit Log", new AuditLogPanel());
        }
        add(buildHeader(), BorderLayout.NORTH);
        add(tabs, BorderLayout.CENTER);

        JLabel footer = new JLabel("  Connected to " + Database.describeTarget()
                + "    |    Logged in as " + account.username + " (" + account.role + ")");
        footer.setOpaque(true);
        footer.setBackground(Color.WHITE);
        footer.setBorder(BorderFactory.createMatteBorder(1, 0, 0, 0, UiTheme.BORDER));
        footer.setForeground(UiTheme.MUTED);
        footer.setFont(UiTheme.BODY);
        add(footer, BorderLayout.SOUTH);

        setJMenuBar(buildMenu());
    }

    private JPanel buildHeader() {
        JPanel header = new JPanel(new BorderLayout());
        header.setBackground(UiTheme.NAVY);
        header.setBorder(BorderFactory.createEmptyBorder(18, 24, 18, 24));

        JLabel title = new JLabel("Sports Store Management System");
        title.setFont(UiTheme.TITLE);
        title.setForeground(Color.WHITE);

        JLabel subtitle = new JLabel("Java Swing + MySQL dashboard for stores, inventory, customers, sales, and reports");
        subtitle.setFont(UiTheme.BODY);
        subtitle.setForeground(new Color(0xD8E6F2));

        JPanel copy = new JPanel(new GridLayout(2, 1, 0, 3));
        copy.setOpaque(false);
        copy.add(title);
        copy.add(subtitle);

        JLabel badge = new JLabel(account.role + "  |  Logout", SwingConstants.CENTER);
        badge.setOpaque(true);
        badge.setBackground(UiTheme.GOLD);
        badge.setForeground(UiTheme.NAVY);
        badge.setFont(UiTheme.BODY_BOLD);
        badge.setBorder(BorderFactory.createEmptyBorder(8, 14, 8, 14));
        badge.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        badge.addMouseListener(new java.awt.event.MouseAdapter() {
            @Override public void mouseClicked(java.awt.event.MouseEvent e) {
                logout();
            }
        });

        header.add(copy, BorderLayout.WEST);
        header.add(badge, BorderLayout.EAST);
        return header;
    }

    private JMenuBar buildMenu() {
        JMenuBar mb = new JMenuBar();
        mb.setBackground(Color.WHITE);
        mb.setBorder(BorderFactory.createMatteBorder(0, 0, 1, 0, UiTheme.BORDER));
        JMenu file = new JMenu("File");
        JMenuItem logout = new JMenuItem("Logout");
        logout.addActionListener(e -> logout());
        JMenuItem exit = new JMenuItem("Exit");
        exit.addActionListener(e -> dispose());
        file.add(logout);
        file.addSeparator();
        file.add(exit);

        JMenu help = new JMenu("Help");
        JMenuItem about = new JMenuItem("About");
        about.addActionListener(e -> JOptionPane.showMessageDialog(this,
                "Sports Store Management System\n" +
                "COSC 457 — Database Management Systems\n" +
                "Java + Swing + MySQL (JDBC)\n\n" +
                "Logged in as " + account.username + " (" + account.role + ")",
                "About", JOptionPane.INFORMATION_MESSAGE));
        help.add(about);

        mb.add(file);
        mb.add(help);
        return mb;
    }

    private void logout() {
        int answer = JOptionPane.showConfirmDialog(this,
                "Log out of the Sports Store Management System?",
                "Confirm logout",
                JOptionPane.YES_NO_OPTION);
        if (answer != JOptionPane.YES_OPTION) return;
        dispose();
        if (onLogout != null) onLogout.run();
    }
}
