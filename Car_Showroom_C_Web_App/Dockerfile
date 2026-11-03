FROM gcc:14
WORKDIR /app
COPY . .
RUN mkdir -p /app/data && gcc server.c -o showroom -std=c11
ENV PORT=10000
EXPOSE 10000
CMD ["./showroom"]
