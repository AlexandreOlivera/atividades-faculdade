const express = require('express');
const app = express();
const port = 3000;

app.use(express.json());

let alunos = [];

function calcularSituacao(nota1, nota2) {
    const media = (nota1 + nota2) / 2;
    let situacao;

    if (media >= 7) {
        situacao = 'aprovado';
    } else if (media >= 4) {
        situacao = 'recuperação';
    } else {
        situacao = 'reprovado';
    }

    return { media, situacao };
}

function validarNotas(nota1, nota2) {
    return (nota1 >= 0 && nota1 <= 10) && (nota2 >= 0 && nota2 <= 10);
}

app.post('/alunos', (req, res) => {
    const { nome, nota1, nota2 } = req.body;

    if (!validarNotas(nota1, nota2)) {
        return res.status(400).json({ mensagem: 'Informe uma nota válida' });
    }

    const { media, situacao } = calcularSituacao(nota1, nota2);

    const novoAluno = {
        id: alunos.length + 1,
        nome,
        nota1,
        nota2,
        media,
        situacao,
    };

    alunos.push(novoAluno);
    res.status(201).json(novoAluno);
});

app.get('/alunos', (req, res) => {
    res.json(alunos);
});

app.put('/alunos/:id', (req, res) => {
    const { id } = req.params;
    const { nome, nota1, nota2 } = req.body;

    const aluno = alunos.find(a => a.id === parseInt(id));

    if (!aluno) {
        return res.status(404).json({ mensagem: 'Aluno não encontrado' });
    }

    if (!validarNotas(nota1, nota2)) {
        return res.status(400).json({ mensagem: 'Informe uma nota válida' });
    }

    aluno.nome = nome;
    aluno.nota1 = nota1;
    aluno.nota2 = nota2;

    const { media, situacao } = calcularSituacao(nota1, nota2);
    aluno.media = media;
    aluno.situacao = situacao;

    res.json(aluno);
});

app.delete('/alunos/:id', (req, res) => {
    const { id } = req.params;
    const indice = alunos.findIndex(a => a.id === parseInt(id));

    if (indice === -1) {
        return res.status(404).json({ mensagem: 'Aluno não encontrado' });
    }

    alunos.splice(indice, 1);
    res.status(204).send();
});

app.get('/alunos/:id', (req, res) => {
    const { id } = req.params;
    const aluno = alunos.find(a => a.id === parseInt(id));

    if (!aluno) {
        return res.status(404).json({ mensagem: 'Aluno não encontrado' });
    }

    res.json({ nome: aluno.nome, media: aluno.media });
});

app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
});