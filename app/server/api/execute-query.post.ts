import mysql from 'mysql2/promise'

interface QueryRequest {
  connectionDetails: {
    host: string
    port: number
    database: string
    user: string
    password: string
  }
  sqlQuery: string
}

export default defineEventHandler(async (event) => {
  let connection: mysql.Connection | null = null

  try {
    // Parse request body
    const body = await readBody<QueryRequest>(event)
    const { connectionDetails, sqlQuery } = body

    // Validate request
    if (!connectionDetails || !sqlQuery) {
      throw createError({
        statusCode: 400,
        statusMessage: 'Missing required fields: connectionDetails and sqlQuery'
      })
    }

    // Create database connection
    connection = await mysql.createConnection({
      host: connectionDetails.host,
      port: connectionDetails.port,
      database: connectionDetails.database,
      user: connectionDetails.user,
      password: connectionDetails.password,
      connectTimeout: 10000
    })

    console.log('Connected to database:', connectionDetails.database)

    // Execute query
    const [rows] = await connection.execute(sqlQuery)

    // Return results
    return {
      success: true,
      data: rows,
      rowCount: Array.isArray(rows) ? rows.length : 0
    }
  } catch (error: any) {
    console.error('Query execution error:', error)

    // Handle specific MySQL errors
    if (error.code === 'ECONNREFUSED') {
      throw createError({
        statusCode: 503,
        statusMessage: 'Database connection refused. Is the database running?'
      })
    }

    if (error.code === 'ER_ACCESS_DENIED_ERROR') {
      throw createError({
        statusCode: 401,
        statusMessage: 'Access denied. Check your credentials.'
      })
    }

    if (error.code === 'ER_BAD_DB_ERROR') {
      throw createError({
        statusCode: 404,
        statusMessage: 'Database not found.'
      })
    }

    // Generic error
    throw createError({
      statusCode: 500,
      statusMessage: error.message || 'Query execution failed'
    })
  } finally {
    // Always close the connection
    if (connection) {
      try {
        await connection.end()
        console.log('Database connection closed')
      } catch (closeError) {
        console.error('Error closing connection:', closeError)
      }
    }
  }
})
