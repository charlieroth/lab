import { fetch } from "undici"
import fastify from "fastify"
import dotenv from "dotenv"
import { Pool } from "pg"

if (process.env.NODE_ENV === "development") {
  dotenv.config({ path: ".env.development" })
} else if (process.env.NODE_ENV === "production") {
  dotenv.config({ path: ".env.production" })
} else {
  dotenv.config({ path: ".env" })
}

const pool = new Pool({
  host: process.env.POSTGRES_HOST,
  port: Number(process.env.POSTGRES_PORT),
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DB,
  ssl: false,
})

const app = fastify({ logger: true })

app.get("/people", async (_, reply) => {
  try {
    const res = await pool.query("SELECT * FROM people;")
    return { data: res.rows }
  } catch (err) {
    reply.statusCode = 400
    return reply
  }
})

app.post<{
  Body: {
    name: string
    age: number
  }
}>("/person", async (req, reply) => {
  try {
    const res = await pool.query(
      `INSERT INTO people(name, age) VALUES ($1, $2) RETURNING *;`,
      [req.body.name, req.body.age]
    )
    return { data: res.rows }
  } catch (err) {
    reply.statusCode = 400
    return reply
  }
})

app.get("/random", async (req, reply) => {
  try {
    const response = await fetch("https://randomuser.me/api/")
    const data = await response.json()
    return { data }
  } catch (err) {
    reply.statusCode = 400
    return reply
  }
})

const start = async () => {
  try {
    await app.listen(process.env.PORT, process.env.HOST)
  } catch (err) {
    pool.end()
    console.log(err)
    app.log.error(err)
    process.exit(1)
  }
}

const shutdown = () => {
  try {
    pool.end()
    app.close()
  } catch (err) {
    console.log(err.message)
  }
}

process.on("SIGINT", shutdown)
process.on("SIGTERM", shutdown)
process.on("uncaughtException", shutdown)
process.on("unhandledRejection", shutdown)

start()
