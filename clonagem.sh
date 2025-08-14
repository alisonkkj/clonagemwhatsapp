const readline = require('readline');
const chalk = require('chalk');
const figlet = require('figlet');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// Título estilo hacker
console.log(chalk.green(figlet.textSync('BLINDADOR', { horizontalLayout: 'full' })));

rl.question(chalk.blue('Coloque o link do grupo aqui: '), (link) => {
    console.log(chalk.yellow(`Iniciando blindagem do grupo: ${link}...\n`));

    // Simulação de processo
    const mensagens = [
        'Verificando permissões...',
        'Detectando erros principais...',
        'Aplicando criptografia...',
        'Bloqueando links suspeitos...',
        'Monitorando usuários...',
        'Atualizando blindagem...',
        'Finalizando configuração...'
    ];

    let count = 0;

    const interval = setInterval(() => {
        if (count >= mensagens.length) {
            clearInterval(interval);
            console.log(chalk.green('\n✅ Grupo blindado com sucesso!'));
            rl.close();
            return;
        }
        // Mensagem piscando estilo hacker
        console.log(chalk.cyan(`[${new Date().toLocaleTimeString()}] ${mensagens[count]}`));
        count++;
    }, 1500);
});










