const request = require("supertest");
const app = require("../src/server");


describe("CloudOps Platform API", () => {
    test("GET /returns information", async () => {
        const response = await request(app).get("/");

        expect(response.statusCode).toBe(200);
        expect(response.body.name).toBe("CloudOps Platform");
        expect(response.body.version).toBeDefined();
    });

    test("GET /health returns healthy status", async () => {
        const response = await request(app).get("/health");

        expect(response.statusCode).toBe(200);
        expect(response.body.status).toBe("healthy");
    });
    test("GET /ready returns ready status", async () => {
        const response = await request(app).get("/ready");

        expect(response.statusCode).toBe(200);
        expect(response.body.status).toBe("ready");
    });
    test("GET / api / v1 / status returns operational status", async () => {
        const response = await request(app).get("/api/v1/status");

        expect(response.statusCode).toBe(200);
        expect(response.body.status).toBe("operational");
        expect(response.body.version).toBeDefined();
        expect(response.body.timestamp).toBeDefined();
    });
    test("unknown routes return 404", async () => {
        const response = await request(app).get("/does-not-exist");

        expect(response.statusCode).toBe(404);
        expect(response.body.error).toBe("not_found");
    });
 
test("responses include a request ID", async () => {
  const response = await request(app).get("/health");

  expect(response.statusCode).toBe(200);
  expect(response.headers["x-request-id"]).toBeDefined();
  expect(response.headers["x-request-id"].length).toBeGreaterThan(0);
});

test("preserves a request ID supplied by the client", async () => {
  const requestId = "portfolio-test-123";

  const response = await request(app)
    .get("/health")
    .set("x-request-id", requestId);

  expect(response.headers["x-request-id"]).toBe(requestId);
});

test("unknown routes return a JSON response", async () => {
  const response = await request(app).get("/does-not-exist");

  expect(response.statusCode).toBe(404);
  expect(response.headers["content-type"]).toMatch(/application\/json/);
  expect(response.body.error).toBe("not_found");
});
   
});