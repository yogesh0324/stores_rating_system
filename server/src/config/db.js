import pg from 'pg';
import { config } from './env.js';

const { Pool } = pg;

export const pool = new Pool ({
    host: config.pg.host,
    user: config.pg.user,
    database: config.pg.database,
    password: config.pg.password,
    port: config.pg.port,
    max: config.pg.max,
    idleTimeoutMillis: config.pg.idleTimeoutMillis,
    connectionTimeoutMillis: config.pg.connectionTimeoutMillis,
    ssl: false
})

pool.connect()
    .then(() => console.log('Database connected successfully!!'))
    .catch((err) => {
        console.error('Database connection failed:', err.message);
        process.exit(1);
    })

pool.on('error', (err) => {
    console.error('Unexpected PG error: ', err);
})