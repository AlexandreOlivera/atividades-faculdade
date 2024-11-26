import React from 'react';

const FilmList = ({ films, onEdit, onDelete }) => {
    return (
        <ul>
            {films.map(film => (
                <li key={film._id}>
                    {film.title} - {film.actor} ({film.ageRating}, {film.genre})
                    <button onClick={() => onEdit(film)}>Edit</button>
                    <button onClick={() => onDelete(film._id)}>Delete</button>
                </li>
            ))}
        </ul>
    );
};

export default FilmList;
