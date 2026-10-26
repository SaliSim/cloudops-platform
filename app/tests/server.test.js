const request = require("supertest");
const app = require("../src/server");


describe("CloudOps Platform API", () => {
    test("GET / returns information", async () => {
        const response = await request(app).get("/");

        expectCookies(response.statusCode).toBe(200);
        expectCookies(response.body.name).toBe("CloudOps Platform");
        expectCookies(response.body.version).toBeDefined();
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
});