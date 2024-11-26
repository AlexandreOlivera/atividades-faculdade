import axios from 'axios';

const API_URL = 'http://localhost:5000/api/films';

export const getFilms = () => axios.get(API_URL);
export const createFilm = (data) => axios.post(API_URL, data);
export const updateFilm = (id, data) => axios.put(`${API_URL}/${id}`, data);
export const deleteFilm = (id) => axios.delete(`${API_URL}/${id}`);
