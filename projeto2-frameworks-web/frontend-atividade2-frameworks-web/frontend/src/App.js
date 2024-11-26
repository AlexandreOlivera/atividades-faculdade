import React, { useEffect, useState } from 'react';
import { getFilms, createFilm, updateFilm, deleteFilm } from './services/filmService';
import FilmForm from './components/FilmForm';
import FilmList from './components/FilmList';

const App = () => {
    const [films, setFilms] = useState([]);
    const [editingFilm, setEditingFilm] = useState(null);

    useEffect(() => {
        getFilms().then(res => setFilms(res.data));
    }, []);

    const handleCreate = (film) => {
        createFilm(film).then(res => setFilms([...films, res.data]));
    };

    const handleUpdate = (film) => {
        updateFilm(editingFilm._id, film).then(res => {
            setFilms(films.map(f => (f._id === res.data._id ? res.data : f)));
            setEditingFilm(null);
        });
    };

    const handleDelete = (id) => {
        deleteFilm(id).then(() => setFilms(films.filter(f => f._id !== id)));
    };

    return (
        <div>
            <h1>Film Management</h1>
            <FilmForm onSubmit={editingFilm ? handleUpdate : handleCreate} initialData={editingFilm} />
            <FilmList films={films} onEdit={setEditingFilm} onDelete={handleDelete} />
        </div>
    );
};

export default App;
