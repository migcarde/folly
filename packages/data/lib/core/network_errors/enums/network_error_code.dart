enum NetworkErrorCode {
  // Client Side Errors
  badRequest(400, 'The request was invalid or cannot be served.'),
  unauthorized(401, 'Authentication is required or has failed.'),
  forbidden(403, 'You do not have permission to access this resource.'),
  notFound(404, 'The requested resource could not be found.'),
  conflict(409, 'A conflict occurred (e.g., duplicate entry).'),

  // Database / PostgREST Errors (Supabase)
  pgrst116(406, 'PGRST116: Expected a single row, but found zero or multiple.'),
  uniqueViolation(409, 'A unique constraint was violated in the database.'),

  // Server Side Errors
  internalServerError(500, 'An unexpected server error occurred.'),
  serviceUnavailable(503, 'The server is currently unavailable.'),

  // App Specific
  unknown(0, 'An unknown error occurred.');

  // Fields to store extra data
  final int code;
  final String message;

  const NetworkErrorCode(this.code, this.message);
}
