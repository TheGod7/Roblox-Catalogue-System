import express from "express";
import cors from "cors";

const app = express();

app.use(cors({ origin: "*" }));
app.use(express.json());

app.use(async (req, res) => {
  try {
    const r = await fetch(`https://catalog.roblox.com${req.originalUrl}`, {
      method: req.method,
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
      body: req.method === "GET" ? undefined : JSON.stringify(req.body),
    });

    const text = await r.text();

    res.status(r.status);
    res.setHeader(
      "Content-Type",
      r.headers.get("content-type") || "application/json",
    );
    res.send(text);
  } catch (e) {
    res.status(500).json({ error: String(e) });
  }
});

app.listen(3000, () => {
  console.log("Catalog curl-like proxy running on http://localhost:3000");
});
