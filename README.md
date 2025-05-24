# Fedora Post-Install Script

Este script automatiza a configuração de uma estação de trabalho Fedora, com foco em desenvolvimento, ciência de dados, produtividade e desempenho.

## Objetivo

Configurar rapidamente uma Fedora Workstation, adaptada para um ambiente profissional e produtivo, com foco em:

- Ferramentas para desenvolvedores, ciência de dados, AWS e Azure CLI
- Codecs e drivers multimídia para melhor suporte a vídeo e áudio
- Otimizações no sistema e na interface GNOME
- Aplicativos úteis para GIS, torrent, anotações, edição de imagens, streaming e virtualização
- Instalação de fontes e configuração do terminal (Fira Code)
- Backup automatizado com Timeshift (snapshots agendados)
- Configuração de Bluetooth e rede
- Desativação do swap para SSDs (quando apropriado)
- Instalação do Miniconda e criação de ambiente Python para Data Science

## Como usar

1. **Clone este repositório:**

```bash
git clone https://github.com/limapablo/fedora-postinstall.git
cd fedora-postinstall
```

2. **Execute o script:**

```bash
chmod +x fedora-postinstall.sh
./fedora-postinstall.sh
```

3. **Reinicie o sistema após a conclusão para aplicar todas as alterações.**

## Observações

- O script requer conexão com a internet e privilégios de `sudo`.
- Assume a versão mais recente do Fedora Workstation.
- O Visual Studio Code é instalado como RPM nativo (em vez do Flatpak), garantindo melhor integração e desempenho.
- O Timeshift é configurado com snapshots diários, semanais e mensais para recuperação do sistema.
- O swap é desativado automaticamente em sistemas com SSD, visando melhor desempenho (pode ser revertido).
- Flatpaks úteis para produtividade e mídia são incluídos.
- O DNF é configurado com `assumeyes=True` para evitar prompts durante a execução.
- O Miniconda é instalado de forma silenciosa com configurações padrão.
- Um ambiente Conda chamado `ds` é criado para projetos de Ciência de Dados (Python 3.11).

## Personalização

- Adicione ou remova Flatpaks na seção `flatpak install` do script.
- Ajuste fontes, extensões do GNOME ou configurações do terminal conforme preferir.
- Edite a retenção de snapshots do Timeshift em `/etc/timeshift.json`.

## Aviso

Use este script por sua conta e risco. Faça backup dos seus dados antes de executar. É altamente recomendável revisar o conteúdo do script antes de rodá-lo, garantindo compatibilidade com seu hardware e versão do Fedora.

---

Desenvolvido por Pablo Lima  
