package com.sportsstore;

import com.sportsstore.db.Database;
import com.sportsstore.ui.LoginDialog;
import com.sportsstore.ui.MainFrame;

import javax.swing.*;

/** Application entry point. */
public class App {

    public static void main(String[] args) {
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception ignore) { /* fall back to default */ }

        SwingUtilities.invokeLater(() -> {
            if (!Database.testConnection()) {
                int n = JOptionPane.showConfirmDialog(null,
                        "Could not connect to the database at\n  "
                                + Database.describeTarget() + "\n\n"
                                + "Make sure MySQL is running, the schema is loaded, and that\n"
                                + "db.properties next to the jar has the correct settings.\n\n"
                                + "Continue anyway?",
                        "Database connection failed",
                        JOptionPane.YES_NO_OPTION,
                        JOptionPane.WARNING_MESSAGE);
                if (n != JOptionPane.YES_OPTION) System.exit(1);
            }
            showLogin();
        });
    }

    private static void showLogin() {
        LoginDialog.Account account = LoginDialog.prompt();
        if (account == null) {
            System.exit(0);
        }
        new MainFrame(account, App::showLogin).setVisible(true);
    }
}
