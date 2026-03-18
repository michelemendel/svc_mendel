FROM python:3.9-slim
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
ENV FLASK_APP=dinner.py
CMD ["flask", "run", "--host=0.0.0.0"]
