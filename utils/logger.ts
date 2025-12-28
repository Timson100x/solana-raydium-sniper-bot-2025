import winston from 'winston';
import pino from 'pino';

export const setUpLogger = () => {
  return winston.createLogger({
    transports: [
      new winston.transports.Console({
        format: winston.format.combine(
          winston.format.timestamp(),
          winston.format.colorize(),
          winston.format.printf((info) => `${info.timestamp} ${info.level}: ${info.message}`),
        ),
      }),
      new winston.transports.File({
        filename: 'combined.log',
        level: 'info',
        format: winston.format.combine(
          winston.format.timestamp(),
          winston.format.printf((info) => `${info.timestamp} ${info.level}: ${info.message}`),
        ),
      }),
      new winston.transports.File({
        filename: 'errors.log',
        level: 'error',
        format: winston.format.combine(
          winston.format.timestamp(),
          winston.format.printf((info) => `${info.timestamp} ${info.level}: ${info.message}`),
        ),
      }),
    ],
  });
};

// Export a basic pino logger for use in constants and other modules
const transport = pino.transport({
  targets: [
    {
      level: 'trace',
      target: 'pino-pretty',
      options: {},
    },
  ],
});

export const logger = pino(
  {
    level: 'trace',
    redact: ['poolKeys'],
    serializers: {
      error: pino.stdSerializers.err,
    },
    base: undefined,
  },
  transport,
);
