const { Client } = require('pg'); //required node js package (postgres library)

// Database connection configuration
const config = {
    //we should not be storing this in plain text here
    user: 'postgres',
    host: 'localhost',   // local host is your machine. This assumes we have        out own db copy hosted locally. Hosting a remote dev server would require more work/planning.
    database: 'postgres',   //will change to app name later, but would require recreating db, so is name now.
    password: 'postgres',  // another bad idea
    port: 5432,     //this is the default port for postgres, again bad idea

    //final dockerized app won't have these problems. We will pass this stuff in as env variables'
};

const client = new Client(config);

async function connectToDatabase() {
    try {
        await client.connect();
        console.log('Connected to FinanceFam database successfully!');

        // Example query
        const res = await client.query('SELECT NOW()');
        console.log('Current Time:', res.rows[0]);

    } catch (err) {
        console.error('Error connecting to the database:', err.stack);
    } finally {
        await client.end();
        console.log('Disconnected from the database.');
    }
}

connectToDatabase();

