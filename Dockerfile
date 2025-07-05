# 1. Usar uma imagem base oficial do Python. A versão 'slim' é menor.
FROM python:3.10-slim

# 2. Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# 3. Copiar o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se o requirements.txt não mudar, esta camada não será reconstruída.
COPY requirements.txt .

# 4. Instalar as dependências
# --no-cache-dir: Desabilita o cache do pip para reduzir o tamanho da imagem.
# --upgrade pip: Garante que estamos usando a versão mais recente do pip.
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação para o diretório de trabalho
COPY . .

# 6. Expor a porta em que a aplicação será executada
EXPOSE 8000

# 7. Comando para iniciar a aplicação com Uvicorn
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000" , "--reload"]

