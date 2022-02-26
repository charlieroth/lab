import fastify from 'fastify'

const app = fastify({ logger: true })

app.get('/ping', async (request, reply) => {
  return { msg: 'pong' }
})

const start = async () => {
  try {
    await app.listen(3000)
  } catch (err) {
    fastify.log.error(err)
    process.exit(1)
  }
}
start()
