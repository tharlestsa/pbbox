#!/bin/bash

# Instala o pacote point-bbox do repositório GitHub
echo "Instalando o pacote point-bbox..."
pip install git+https://github.com/tharlestsa/point-bbox

# Encontra o caminho de instalação do pacote point-bbox
echo "Procurando o caminho do pacote instalado..."
PACKAGE_LOCATION=$(pip show pbbox | grep Location | awk '{print $2}')

# Verifica se o pacote foi encontrado
if [ -z "$PACKAGE_LOCATION" ]; then
  echo "Erro: Não foi possível encontrar o pacote point-bbox."
  exit 1
fi

# Define o caminho para o script point_bbox.py
SCRIPT_PATH="${PACKAGE_LOCATION}/pbbox/bbox.py"

# Verifica se o arquivo point_bbox.py existe
if [ ! -f "$SCRIPT_PATH" ]; then
  echo "Erro: Não foi possível encontrar o script bbox.py em $SCRIPT_PATH."
  exit 1
fi

# Torna o script executável
echo "Tornando o script executável..."
chmod +x "$SCRIPT_PATH"

# Cria um link simbólico em /usr/bin para o script
echo "Criando o link simbólico em /usr/bin..."
sudo ln -sf "$SCRIPT_PATH" /usr/bin/bbox

# Mensagem de conclusão
echo "Instalação concluída com sucesso! Você pode agora usar o comando 'bbox'."
