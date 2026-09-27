FROM python:3.11-slim

WORKDIR /app

# Optimización de ejecución de Python en contenedores
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Instalar dependencias del sistema mínimas si fueran necesarias
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Instalar librerías de Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código del repositorio
COPY . .

# Exponer el puerto de Jupyter
EXPOSE 8888

# Arrancar Jupyter Notebook sin restricciones de localhost y sin pedir token en entorno local
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
