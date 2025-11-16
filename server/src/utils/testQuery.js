import { pool } from "../config/db.js";

export const testQuery = async () => {
    try {
        const result = await pool.query("SELECT NOW()");
        console.log("Database Time:", result.rows[0]);
    } catch (err) {
        console.error("Test query failed:", err.message);
    }
};
