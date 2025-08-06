require('dotenv').config();

const express = require('express');
const mongoose = require('mongoose');

const app = express();
const PORT = process.env.PORT || 3000; // Usa porta dinamica per Render
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});

// Middleware per JSON
app.use(express.json());

// Importa e usa le rotte di "note.js"
const noteRouter = require('./routes/note');
app.use("/api/notes", noteRouter); // ✅ Prefisso corretto

// Rotta base
app.get("/", (req, res) => {
  res.json({ message: "API is working" });
});

// Connessione MongoDB tramite variabile d'ambiente
const connectionString = process.env.MONGODB_URI;

mongoose.connect(connectionString)
  .then(() => {
    console.log('✅ MongoDB connected successfully');

    // Avvia il server
    app.listen(PORT, () => {
      console.log(`🚀 Server running on port ${PORT}`);
    });
  })
  .catch(err => {
    console.error('❌ MongoDB connection error:', err);
  });
