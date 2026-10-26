const crypto = require("node:crypto");

const express = require("express");

const app = express();

const port = process.env.PORT || 8080;

const version = process.env.APP_VERSION || "local";

app.use(express.json());

app.use((req, res, next) => {
    const requestId = req.get("x-request-id") || crypto.randomUUID();
    const startedAT = Date.now();

    res.setHeader("x-request-id", requestId);

    res.on("finish", () => {
        console.log(
            JSON.stringify({
                severity: "INFO",
                message: "request completed",
                requestId,
                method: req.method,
                path: req.path,
                statusCode: res.statusCode,
                durationMs: Date.now() - startedAT,
            })
        );
    })
    next();
});

app.get("/", (req, res) => {
    res.json({
        name: "CloudOps Platform",
        version,
        message: "Service is running",
    });
});

app.get("/health", (req, res) => {
    res.status(200).json({ status: "healthy" });
});

app.get("/ready", (req, res) => {
    res.status(200).json({ status: "ready" });
});

app.get("/api/v1/status", (req, res) => {
    res.json({
        status: "operational",
        version,
        timestamp: new Date().toISOString(),
    });
});

app.use((req, res) => {
    res.status(404).json({ error: "not_found" });
});


if (require.main === module) {
    app.listen(port, "0.0.0.0", () => {
        console.log(
            JSON.stringify({
                severity: "INFO",
                message: "server started",
                port,
                version,
            })
        );
    });
}

module.exports = app;