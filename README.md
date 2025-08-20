# 🦠 Papa Nurgle's Telegram Bot v2.0

![Nurgle Banner](https://img.shields.io/badge/Nurgle-Bot-green?style=for-the-badge&logo=telegram)
![Ruby](https://img.shields.io/badge/Ruby-3.0+-red?style=for-the-badge&logo=ruby)
![Status](https://img.shields.io/badge/Status-Infectando-yellowgreen?style=for-the-badge)

## 🎭 Sobre o Bot

Bot temático de Nurgle para Telegram, inspirado no universo Warhammer 40k. Este bot oferece uma experiência interativa e gamificada com sistema de infecção, níveis, conquistas e muito mais!

## ✨ Novidades da v2.0

### 🎮 Sistema de Gamificação
- **Sistema de Infecção**: Ganhe pontos de infecção e suba de nível
- **15 Níveis Únicos**: De "Não Infectado" até "Encarnação da Entropia"
- **Conquistas**: Desbloqueie realizações especiais
- **Rankings**: Compare sua devoção com outros seguidores
- **Bênçãos Diárias**: Receba bônus especiais a cada 24h

### 🤖 Recursos Aprimorados
- **Gerador Dinâmico de Saudações**: Milhares de combinações possíveis
- **Trivia com Dificuldade Adaptativa**: Questões ajustadas ao seu nível
- **Sistema de Respostas Contextuais**: O bot responde de forma mais natural
- **Easter Eggs**: Descubra comandos e respostas secretas
- **Conversão de Usuários**: Tente converter outros ao caminho de Nurgle

### 🛡️ Melhorias Técnicas
- **Logging Completo**: Sistema de logs para debug
- **Persistência de Dados**: Suas infecções são salvas
- **Configuração por Variáveis de Ambiente**: Mais seguro
- **Tratamento de Erros**: Bot mais estável e resiliente

## 📋 Pré-requisitos

- Ruby 3.0 ou superior
- Bundler gem
- Token de bot do Telegram (obtenha com @BotFather)

## 🚀 Instalação

### 1. Clone o repositório
```bash
git clone https://github.com/yourusername/papa-nurgle-bot-v2.git
cd papa-nurgle-bot-v2
```

### 2. Instale as dependências
```bash
bundle install
```

### 3. Configure o token do bot
```bash
# Linux/Mac
export NURGLE_BOT_TOKEN='seu_token_aqui'

# Windows
set NURGLE_BOT_TOKEN=seu_token_aqui
```

### 4. (Opcional) Configure seu ID de admin
```bash
export ADMIN_TELEGRAM_ID='seu_user_id'
```

### 5. Execute o bot
```bash
ruby bin/main.rb

# Ou torne executável
chmod +x bin/main.rb
./bin/main.rb
```

## 📱 Comandos Disponíveis

### Comandos Básicos
| Comando | Descrição |
|---------|-----------|
| `/start` | Inicia o bot e registra o usuário |
| `/stop` | Para o bot (infecções são mantidas) |
| `/help` | Lista todos os comandos disponíveis |

### Comandos de Interação
| Comando | Descrição |
|---------|-----------|
| `/greet` | Recebe uma saudação pestilenta única |
| `/trivia` | Aprenda fatos sobre Nurgle (dificuldade adaptativa) |
| `/blessing` | Receba sua bênção diária especial |
| `/plague` | Descubra sua praga pessoal |
| `/garden` | Visite o Jardim de Nurgle |

### Comandos de Status
| Comando | Descrição |
|---------|-----------|
| `/infection` | Veja seu nível de infecção e progresso |
| `/devotion` | Cheque seu nível de devoção |

### Comandos Especiais
| Comando | Descrição |
|---------|-----------|
| `/convert` | Responda a alguém para tentar convertê-lo |
| `/stats` | (Admin) Veja estatísticas do bot |

### 🥚 Easter Eggs
- Digite "7" para uma surpresa
- Mencione outros deuses do Caos
- Mencione "Papa Nurgle" ou "Vovô"

## 📊 Sistema de Níveis

| Nível | Nome | Infecção Necessária |
|-------|------|---------------------|
| 1 | Não Infectado | 0 |
| 2 | Recém Tocado | 10 |
| 3 | Esporo Inicial | 25 |
| 4 | Portador Menor | 50 |
| 5 | Hospedeiro Ativo | 100 |
| 6 | Vetor Pestilento | 175 |
| 7 | Praga Ambulante | 275 |
| 8 | Arauto da Decadência | 400 |
| 9 | Campeão Pútrido | 550 |
| 10 | Escolhido de Nurgle | 750 |
| 11 | Avatar da Pestilência | 1000 |
| 12 | Daemon Menor | 1500 |
| 13 | Príncipe Daemon | 2000 |
| 14 | Favorito de Papa Nurgle | 3000 |
| 15 | Encarnação da Entropia | 5000 |

## 🗂️ Estrutura do Projeto

```
papa-nurgle-bot-v2/
├── bin/
│   └── main.rb              # Arquivo principal
├── lib/
│   ├── bot.rb               # Classe principal do bot
│   ├── config.rb            # Configurações
│   ├── greeting_generator.rb # Gerador de saudações
│   ├── infection_system.rb  # Sistema de gamificação
│   ├── nurgle_responses.rb  # Respostas contextuais
│   └── trivia_manager.rb    # Gerenciador de trivia
├── data/                     # Dados persistentes
│   └── infections.json      # Dados dos usuários
├── logs/                     # Logs do sistema
│   └── bot.log              # Log principal
├── Gemfile                   # Dependências Ruby
├── Gemfile.lock             # Versões fixadas
└── README.md                # Este arquivo
```

## 🔧 Configuração Avançada

### Variáveis de Ambiente

```bash
# Token do bot (obrigatório)
NURGLE_BOT_TOKEN=seu_token_aqui

# ID do administrador (opcional)
ADMIN_TELEGRAM_ID=123456789

# Nível de log (opcional: DEBUG, INFO, WARN, ERROR)
LOG_LEVEL=INFO

# Para webhook (opcional)
WEBHOOK_URL=https://seu-dominio.com/webhook
PORT=8443
```

### Personalização

Você pode personalizar o bot editando os seguintes arquivos:

- `lib/config.rb`: Ajustar configurações gerais
- `lib/greeting_generator.rb`: Adicionar novos templates de saudação
- `lib/nurgle_responses.rb`: Adicionar novas respostas
- `lib/trivia_manager.rb`: Adicionar mais trivias

## 🐛 Troubleshooting

### Bot não conecta
- Verifique se o token está correto
- Confirme conexão com internet
- Verifique se o token não foi revogado

### Comandos não funcionam
- Certifique-se de que os arquivos estão na estrutura correta
- Verifique os logs em `logs/bot.log`
- Execute `bundle install` novamente

### Dados não são salvos
- Verifique permissões na pasta `data/`
- Certifique-se de que o diretório existe

## 🤝 Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Fork o projeto
2. Crie sua feature branch (`git checkout -b feature/NovaFeature`)
3. Commit suas mudanças (`git commit -m 'Add: Nova feature'`)
4. Push para a branch (`git push origin feature/NovaFeature`)
5. Abra um Pull Request

## 📈 Roadmap

- [ ] Sistema de batalhas entre usuários
- [ ] Integração com banco de dados
- [ ] Modo campanha com missões
- [ ] Sistema de itens e equipamentos
- [ ] Integração com API do Warhammer
- [ ] Suporte multi-idioma
- [ ] Dashboard web para estatísticas

## ⚖️ Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## ⚠️ Disclaimer

Este é um projeto fan-made não afiliado com Games Workshop ou o universo Warhammer 40k. Criado apenas para fins educacionais e de entretenimento.

## 📞 Contato

**Desenvolvedor**: Tiago Rahal Aires  
**Email**: rahal.aires@gmail.com  
**GitHub**: [@tiagorahal](https://github.com/tiagorahal)

---

<div align="center">
  
**🦠 Que as bênçãos de Papa Nurgle estejam com você! 🦠**

*"Na decadência, encontramos a verdade. Na pestilência, a salvação."*

</div>
