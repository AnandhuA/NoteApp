const express = require('express');
const app = express();

app.use(express.json());

app.use(express.urlencoded({ extended: true }));
const notes = [];

app.listen(3000, "192.168.44.65", () => {
    console.log('Server is running on port 3000');
});

app.get("/", (req, res) => {
    res.send("hello")
})
app.post("/addNode", (req, res) => {
    const data = {
        "id": req.body.id,
        "title": req.body.title,
        "content": req.body.content
    }
    notes.push(data);
    console.log(data);
    res.status(200).send("Note added successfully");
})

app.get("/getAllNotes", (req, res) => {
    res.send(notes);
})

app.put("/updateNote/:id", (req, res) => { 
    const id = req.params.id ;
    console.log("id : " + id);
    console.log(notes);
    let editedNote = notes.find(note => note.id === id)
    console.log("editedNote : " + editedNote);
  
    const data = {
        "id": req.body.id,
        "title": req.body.title,
        "content": req.body.content
    }
    for (let i = 0; i < notes.length; i++) {
        if (notes[i].id == id) {
            notes[i] = data;
        }
    }
    res.status(200).send("Note updated successfully");
})