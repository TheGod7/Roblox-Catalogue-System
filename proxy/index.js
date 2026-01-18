import express from "express";
import cors from "cors";

const app = express();

app.use(
  cors({
    origin: "*",
    methods: ["GET"],
  }),
);

app.use(async (req, res) => {
  try {
    if (req.method !== "GET") {
      return res.status(405).json({ error: "Only GET allowed" });
    }

    const path = req.originalUrl;
    const targetUrl = `https://catalog.roblox.com${path}`;

    const r = await fetch(targetUrl, {
      headers: {
        "User-Agent": "Mozilla/5.0",
        Accept: "application/json",
      },
    });

    const text = await r.text();

    res.status(r.status);
    res.setHeader(
      "Content-Type",
      r.headers.get("content-type") || "application/json",
    );
    res.send(text);
  } catch (err) {
    res.status(500).json({
      error: "Proxy failed",
      detail: String(err),
    });
  }
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Proxy NO transparente en http://localhost:${PORT}`);
});
