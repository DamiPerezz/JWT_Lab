FROM python:3.9-slim

WORKDIR /app

COPY app /app  
RUN pip install --no-cache-dir flask pyjwt

EXPOSE 80

CMD ["python", "app.py"]