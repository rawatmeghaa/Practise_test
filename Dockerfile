FROM node:22-alpine AS builder 

WORKDIR /app

COPY package*.json ./

RUN npm ci 

COPY . .

RUN npm run build 

FROM node:22-alpine AS runner

WORKDIR /app

RUN addgroup -S addgroup && adduser -S appuser -G addgroup

RUN chown -R appuser:addgroup /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./package*.json
COPY --from=builder /app/dist ./dist

USER appuser 

EXPOSE 3000

CMD ["node" , "dist/main.js"]