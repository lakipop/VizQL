import mysql from 'mysql2/promise'

interface SchemaRequest {
  connectionDetails: {
    host: string
    port: number
    database: string
    user: string
    password: string
  }
}

interface SchemaColumn {
  TABLE_NAME: string
  COLUMN_NAME: string
  COLUMN_TYPE: string
  IS_NULLABLE: string
  COLUMN_KEY: string
}

export default defineEventHandler(async (event) => {
  let connection: mysql.Connection | null = null

  try {
    // Parse request body
    const body = await readBody<SchemaRequest>(event)
    const { connectionDetails } = body

    // Validate request
    if (!connectionDetails) {
      throw createError({
        statusCode: 400,
        statusMessage: 'Missing required field: connectionDetails'
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

    console.log('Connected to database for schema fetch:', connectionDetails.database)

    // Query information_schema to get all tables and columns
    const query = `
      SELECT 
        TABLE_NAME,
        COLUMN_NAME,
        COLUMN_TYPE,
        IS_NULLABLE,
        COLUMN_KEY
      FROM information_schema.COLUMNS
      WHERE TABLE_SCHEMA = ?
      ORDER BY TABLE_NAME, ORDINAL_POSITION
    `

    const [rows] = await connection.execute(query, [connectionDetails.database]) as [SchemaColumn[], any]

    // Transform flat list into structured object: { tableName: [column1, column2, ...] }
    const schema: Record<string, string[]> = {}

    for (const row of rows) {
      const tableName = row.TABLE_NAME
      const columnInfo = `${row.COLUMN_NAME} (${row.COLUMN_TYPE})${row.COLUMN_KEY === 'PRI' ? ' 🔑' : ''}`

      if (!schema[tableName]) {
        schema[tableName] = []
      }

      schema[tableName].push(columnInfo)
    }

    console.log('Schema fetched successfully:', Object.keys(schema).length, 'tables')

    // Return structured schema
    return {
      success: true,
      schema,
      tableCount: Object.keys(schema).length
    }
  } catch (error: any) {
    console.error('Schema fetch error:', error)

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
      statusMessage: error.message || 'Schema fetch failed'
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
