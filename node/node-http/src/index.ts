import fastify from 'fastify'
import dotenv from 'dotenv'

const app = fastify({ logger: true })

app.get('/ping', async (request, reply) => {
  return { msg: 'pong' }
})

const loadEnv = () => {
    if (process.env.NODE_ENV === 'development') {
      dotenv.config({ path: '.env.development' })
    } else if (process.env.NODE_ENV === 'production') {
      dotenv.config({ path: '.env.production' })
    }
    dotenv.config({ path: '.env' })
}

const start = async () => {
  try {
    loadEnv()
    const addr = process.env.PORT
    const host = process.env.HOST
    await app.listen(addr, host)
  } catch (err) {
    app.log.error(err)
    process.exit(1)
  }
}
start()
