require('dotenv').config();

const express = require('express');
const mongoose = require('mongoose');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware per JSON
app.use(express.json());

// Connessione MongoDB tramite variabile d'ambiente
const connectionString = process.env.MONGODB_URI;

mongoose.connect(connectionString)
  .then(() => {
    console.log('✅ MongoDB connected successfully');

    // 🔹 Importa e usa le rotte di "note.js"
    const noteRouter = require('./routes/note');
    app.use("/notes", noteRouter);

    // 🔹 Rotta base
    app.get("/", (req, res) => {
      res.json({ message: "API is working" });
    });

    // Avvia il server
    app.listen(PORT, () => {
      console.log(`🚀 Server running at http://localhost:${PORT}`);
    });
  })
  .catch(err => {
    console.error('❌ MongoDB connection error:', err);
  });
