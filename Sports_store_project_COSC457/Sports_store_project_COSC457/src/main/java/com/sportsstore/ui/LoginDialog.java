package com.sportsstore.ui;

import javax.swing.*;
import java.awt.*;
import java.util.LinkedHashMap;
import java.util.Map;

/** Simple demo login for class presentation. */
public class LoginDialog extends JDialog {
    private static final Map<String, Account> ACCOUNTS = new LinkedHashMap<>();
    static {
        ACCOUNTS.put("manager", new Account("manager", "manager123", "Manager"));
        ACCOUNTS.put("employee", new Account("employee", "employee123", "Employee"));
    }

    private final JTextField username = new JTextField("manager", 18);
    private final JPasswordField password = new JPasswordField("manager123", 18);
    private final JLabel message = new JLabel(" ");
    private Account authenticated;

    private LoginDialog() {
        super((Frame) null, "Login - Sports Store", true);
        UiTheme.install();
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setResizable(false);
        buildUi();
        pack();
        setLocationRelativeTo(null);
    }

    public static Account prompt() {
        LoginDialog dialog = new LoginDialog();
        dialog.setVisible(true);
        return dialog.authenticated;
    }

    private void buildUi() {
        JPanel root = new JPanel(new BorderLayout());
        root.setBackground(UiTheme.BACKGROUND);
        root.setBorder(BorderFactory.createEmptyBorder(18, 18, 18, 18));

        JPanel banner = new JPanel(new GridLayout(2, 1, 0, 4));
        banner.setBackground(UiTheme.NAVY);
        banner.setBorder(BorderFactory.createEmptyBorder(18, 20, 18, 20));
        JLabel title = new JLabel("Sports Store Login");
        title.setFont(UiTheme.TITLE);
        title.setForeground(Color.WHITE);
        JLabel subtitle = new JLabel("Use a demo account to open the management system.");
        subtitle.setFont(UiTheme.BODY);
        subtitle.setForeground(new Color(0xD8E6F2));
        banner.add(title);
        banner.add(subtitle);

        JPanel form = UiTheme.whitePanel(new GridBagLayout());
        GridBagConstraints gc = new GridBagConstraints();
        gc.insets = new Insets(8, 8, 8, 8);
        gc.anchor = GridBagConstraints.WEST;

        addField(form, gc, 0, "Username", username);
        addField(form, gc, 1, "Password", password);

        JLabel hint = new JLabel("<html><b>Demo accounts:</b> manager / manager123 &nbsp; | &nbsp; employee / employee123</html>");
        hint.setForeground(UiTheme.MUTED);
        hint.setFont(UiTheme.BODY);
        gc.gridx = 0; gc.gridy = 2; gc.gridwidth = 2; gc.fill = GridBagConstraints.HORIZONTAL;
        form.add(hint, gc);

        message.setForeground(UiTheme.RED);
        message.setFont(UiTheme.BODY_BOLD);
        gc.gridy = 3;
        form.add(message, gc);

        JButton login = UiTheme.button("Login", UiTheme.TEAL, Color.WHITE);
        login.addActionListener(e -> authenticate());
        JButton cancel = UiTheme.button("Cancel", UiTheme.NAVY, Color.WHITE);
        cancel.addActionListener(e -> dispose());

        JPanel buttons = new JPanel(new FlowLayout(FlowLayout.RIGHT, 8, 0));
        buttons.setOpaque(false);
        buttons.add(cancel);
        buttons.add(login);
        gc.gridy = 4;
        form.add(buttons, gc);

        getRootPane().setDefaultButton(login);
        root.add(banner, BorderLayout.NORTH);
        root.add(form, BorderLayout.CENTER);
        setContentPane(root);
    }

    private void addField(JPanel form, GridBagConstraints gc, int row, String labelText, JComponent field) {
        JLabel label = new JLabel(labelText + ":");
        label.setFont(UiTheme.BODY_BOLD);
        label.setForeground(UiTheme.NAVY);
        field.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(UiTheme.BORDER),
                BorderFactory.createEmptyBorder(7, 10, 7, 10)));

        gc.gridx = 0; gc.gridy = row; gc.gridwidth = 1; gc.weightx = 0;
        gc.fill = GridBagConstraints.NONE;
        form.add(label, gc);

        gc.gridx = 1; gc.gridy = row; gc.weightx = 1;
        gc.fill = GridBagConstraints.HORIZONTAL;
        form.add(field, gc);
    }

    private void authenticate() {
        String user = username.getText().trim().toLowerCase();
        String pass = new String(password.getPassword());
        Account account = ACCOUNTS.get(user);
        if (account == null || !account.password.equals(pass)) {
            message.setText("Invalid username or password.");
            return;
        }
        authenticated = account;
        dispose();
    }

    public static class Account {
        public final String username;
        private final String password;
        public final String role;

        Account(String username, String password, String role) {
            this.username = username;
            this.password = password;
            this.role = role;
        }
    }
}
