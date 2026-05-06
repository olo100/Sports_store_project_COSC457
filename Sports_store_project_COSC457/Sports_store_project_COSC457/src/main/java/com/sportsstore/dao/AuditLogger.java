package com.sportsstore.dao;

import com.sportsstore.ui.LoginDialog;

import java.sql.SQLException;

/** Best-effort audit logging for class-demo CRUD changes. */
public final class AuditLogger {
    private static boolean initialized;

    private AuditLogger() {}

    public static void log(LoginDialog.Account account, String action, String tableName, Object recordId) {
        try {
            ensureTable();
            GenericDao.execute(
                    "INSERT INTO APP_AUDIT_LOG (username, role_name, action_name, table_name, record_id) " +
                    "VALUES (?, ?, ?, ?, ?)",
                    account == null ? "unknown" : account.username,
                    account == null ? "unknown" : account.role,
                    action,
                    tableName,
                    recordId == null ? "" : String.valueOf(recordId));
        } catch (SQLException ignored) {
            // Audit logging should never block the main application workflow.
        }
    }

    public static void ensureTable() throws SQLException {
        if (initialized) return;
        GenericDao.execute(
                "CREATE TABLE IF NOT EXISTS APP_AUDIT_LOG (" +
                "audit_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "username VARCHAR(50) NOT NULL, " +
                "role_name VARCHAR(50) NOT NULL, " +
                "action_name VARCHAR(30) NOT NULL, " +
                "table_name VARCHAR(80) NOT NULL, " +
                "record_id VARCHAR(80), " +
                "created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP" +
                ")");
        initialized = true;
    }
}
