import { fetch } from "undici"
import fastify from "fastify"
import dotenv from "dotenv"

if (process.env.NODE_ENV === "development") {
  dotenv.config({ path: ".env.development" })
} else if (process.env.NODE_ENV === "production") {
  dotenv.config({ path: ".env.production" })
} else {
  dotenv.config({ path: ".env" })
}

const app = fastify({ logger: true })

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
    console.log(err)
    app.log.error(err)
    process.exit(1)
  }
}

const shutdown = () => {
  try {
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
