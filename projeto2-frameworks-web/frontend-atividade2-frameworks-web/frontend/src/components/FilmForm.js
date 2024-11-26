import React, { useState } from 'react';

const FilmForm = ({ onSubmit, initialData = {} }) => {
    const [film, setFilm] = useState({
        title: initialData.title || '',
        actor: initialData.actor || '',
        ageRating: initialData.ageRating || '',
        genre: initialData.genre || ''
    });

    const handleChange = (e) => {
        setFilm({ ...film, [e.target.name]: e.target.value });
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        onSubmit(film);
    };

    return (
        <form onSubmit={handleSubmit}>
            <input name="title" value={film.title} onChange={handleChange} placeholder="Title" required />
            <input name="actor" value={film.actor} onChange={handleChange} placeholder="Actor" required />
            <input name="ageRating" value={film.ageRating} onChange={handleChange} placeholder="Age Rating" required />
            <input name="genre" value={film.genre} onChange={handleChange} placeholder="Genre" required />
            <button type="submit">Save</button>
        </form>
    );
};

export default FilmForm;
