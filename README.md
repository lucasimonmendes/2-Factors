# 2-Factors

![Linguagem mais utilizada](https://img.shields.io/github/languages/top/lucasimonmendes/2-Factors)
![Último commit](https://img.shields.io/github/last-commit/lucasimonmendes/2-Factors)
![README bem legal](https://img.shields.io/badge/readme-bem_legal-8A2BE2)

## Descrição

`2-Factors` é um gerador de senhas de autenticação em dois fatores (2FA) que permite adicionar novas chaves de serviço, gerar senhas 2FA com base nessas chaves e listar os serviços disponíveis. O script utiliza GPG para criptografia simétrica e o OATH Toolkit para gerar as senhas 2FA.

## Requisitos

- `gpg` (GNU Privacy Guard): Necessário para criptografia simétrica das chaves secretas dos serviços.
- `oathtool`: Necessário para gerar as senhas 2FA.

## Instalação

Certifique-se de ter o `gpg` e o `oathtool` instalados no seu sistema. Se não estiverem instalados, utilize o gerenciador de pacotes da sua distribuição para instalá-los.

```bash
# No Debian/Ubuntu
sudo apt-get install gpg oathtool

# No Fedora
sudo dnf install gpg oathtool

# No Arch Linux
sudo pacman -S gpg oathtool
```

## Uso

### Sintaxe

```bash
2-Factors.sh [--option] [service]
```

### Opções

- `--new` ou `-n`: Adicionar uma nova chave de serviço.
- `--totp` ou `-t`: Gerar uma senha 2FA para o serviço especificado. A senha é válida por 30 segundos.
- `--list` ou `-l`: Listar os serviços disponíveis.

### Exemplos

1. **Adicionar uma nova chave:**

   ```bash
   ./2-Factors.sh --new
   ```

   Você será solicitado a inserir o nome do serviço e a chave secreta associada.

2. **Gerar uma senha 2FA:**

   ```bash
   ./2-Factors.sh --totp <nome_do_servico>
   ```

   Substitua `<nome_do_servico>` pelo nome do serviço que deseja utilizar.

3. **Listar os serviços disponíveis:**

   ```bash
   ./2-Factors.sh --list
   ```

## Licença

Este projeto é licenciado sob a licença GPLv2.

## Autor

- **Nome:** Lucas Simon
- **Email:** [lucasimonmendes@gmail.com](mailto:lucasimonmendes@gmail.com)

## Changelog

- **04/09/2024** - Versão 1.0
  - Adicionadas as funções `newKey`, `list` e `generate` para gerenciar chaves e gerar senhas 2FA.
