package com.sportsstore.dao;

import com.sportsstore.db.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Thin JDBC helper. Every method opens and closes its own connection so callers
 * never have to worry about resource leaks.
 */
public final class GenericDao {

    private GenericDao() {}

    /** Run a SELECT and return the rows as Object[] arrays. */
    public static List<Object[]> selectAll(String sql, Object... params) throws SQLException {
        try (Connection c = Database.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            bind(ps, params);
            try (ResultSet rs = ps.executeQuery()) {
                ResultSetMetaData md = rs.getMetaData();
                int n = md.getColumnCount();
                List<Object[]> rows = new ArrayList<>();
                while (rs.next()) {
                    Object[] row = new Object[n];
                    for (int i = 0; i < n; i++) row[i] = rs.getObject(i + 1);
                    rows.add(row);
                }
                return rows;
            }
        }
    }

    /** Run a SELECT and return only the column names (in declared order). */
    public static List<String> selectColumns(String sql) throws SQLException {
        try (Connection c = Database.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            ResultSetMetaData md = rs.getMetaData();
            int n = md.getColumnCount();
            List<String> cols = new ArrayList<>(n);
            for (int i = 1; i <= n; i++) cols.add(md.getColumnLabel(i));
            return cols;
        }
    }

    /** Run an INSERT/UPDATE/DELETE. Returns affected rows. */
    public static int execute(String sql, Object... params) throws SQLException {
        try (Connection c = Database.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            bind(ps, params);
            return ps.executeUpdate();
        }
    }

    /** SELECT that returns a single column (used to populate FK dropdowns). */
    public static List<Object[]> selectKeyValue(String sql) throws SQLException {
        return selectAll(sql);
    }

    private static void bind(PreparedStatement ps, Object[] params) throws SQLException {
        if (params == null) return;
        for (int i = 0; i < params.length; i++) {
            ps.setObject(i + 1, params[i]);
        }
    }

    public static List<Object[]> emptyList() { return Collections.emptyList(); }
}
